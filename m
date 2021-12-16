Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E5477C36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhLPTIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbhLPTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9FC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE9C161F3F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124C8C36AE7;
        Thu, 16 Dec 2021 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681695;
        bh=eqkT2Xb9WpfHKciFfIgbcxLqfxAgeRWZBTenSV8dEP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqBksZBZlBo03KDe/WvBLC4Jsa4fTLblT2mvRqhQGQ26KnU5ojhmUS93NvEPOp6cr
         rdI5GpTSflnV3bJNOixDabSLf6HM4aA10koAMm3S96QypOCOf/9pdSItAaztMqPZms
         CAA/BykTuK3dPTgQJmBI9uOqw+t1WW24EO6xm2360WecT8tcWekLJ2oFYnl3uuRdag
         as7G89f6/DOI/MHzTbQAeRgQWW16YevBFTGw8VpQJvItvDtdzPb2pIalPiRkFXyG9F
         59MI+YTXAhFLkZwfFpw0y4ROur9sIwV6RwCpRrV3G1fHvACuxUGpFNpfVJrRvAlOYv
         HOKQ7+uINnzmQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] spmi: spmi-pmic-arb: fix irq_set_type race condition
Date:   Thu, 16 Dec 2021 11:08:12 -0800
Message-Id: <20211216190812.1574801-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211216190812.1574801-1-sboyd@kernel.org>
References: <20211216190812.1574801-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <quic_collinsd@quicinc.com>

The qpnpint_irq_set_type() callback function configures the type
(edge vs level) and polarity (high, low, or both) of a particular
PMIC interrupt within a given peripheral.  To do this, it reads
the three consecutive IRQ configuration registers, modifies the
specified IRQ bit within the register values, and finally writes
the three modified register values back to the PMIC.  While a
spinlock is used to provide mutual exclusion on the SPMI bus
during the register read and write calls, there is no locking
around the overall read, modify, write sequence.  This opens up
the possibility of a race condition if two tasks set the type of
a PMIC IRQ within the same peripheral simultaneously.

When the race condition is encountered, both tasks will read the
old value of the registers and IRQ bits set by one of the tasks
will be dropped upon the register write of the other task.  This
then leads to PMIC IRQs being enabled with an incorrect type and
polarity configured.  Such misconfiguration can lead to an IRQ
storm that overwhelms the system and causes it to crash.

This race condition and IRQ storm have been observed when using
a pair of pm8941-pwrkey devices to handle PMK8350 pwrkey and
resin interrupts.  The independent devices probe asynchronously
in parallel and can simultaneously request and configure PMIC
IRQs in the same PMIC peripheral.

For a good case, the IRQ configuration calls end up serialized
due to timing deltas and the register read/write sequence looks
like this:

1. pwrkey probe: SPMI  read(0x1311): 0x00, 0x00, 0x00
2. pwrkey probe: SPMI write(0x1311): 0x80, 0x80, 0x80
3. resin probe:  SPMI  read(0x1311): 0x80, 0x80, 0x80
4. resin probe:  SPMI write(0x1311): 0xC0, 0xC0, 0xC0

The final register states after both devices have requested and
enabled their respective IRQs is thus:

0x1311: 0xC0
0x1312: 0xC0
0x1313: 0xC0
0x1314: 0x00
0x1315: 0xC0

For a bad case, the IRQ configuration calls end up occurring
simultaneously and the race condition is encountered.  The
register read/write sequence then looks like this:

1. pwrkey probe: SPMI  read(0x1311): 0x00, 0x00, 0x00
2. resin probe:  SPMI  read(0x1311): 0x00, 0x00, 0x00
3. pwrkey probe: SPMI write(0x1311): 0x80, 0x80, 0x80
4. resin probe:  SPMI write(0x1311): 0x40, 0x40, 0x40

In this case, the final register states after both devices have
requested and enabled their respective IRQs is thus:

0x1311: 0x40
0x1312: 0x40
0x1313: 0x40
0x1314: 0x00
0x1315: 0xC0

This corresponds to the resin IRQ being configured for both
rising and falling edges, as expected.  However, the pwrkey IRQ
is misconfigured as level type with both polarity high and low
set to disabled.  The PMIC IRQ triggering hardware treats this
particular register configuration as if level low triggering is
enabled.

The raw pwrkey IRQ signal is low when the power key is not being
pressed.  Thus, the pwrkey IRQ begins firing continuously in an
IRQ storm.

Fix the race condition by holding the spmi-pmic-arb spinlock for
the duration of the read, modify, write sequence performed in the
qpnpint_irq_set_type() function.  Split the pmic_arb_read_cmd()
and pmic_arb_write_cmd() functions each into three parts so that
hardware register IO is decoupled from spinlock locking.  This
allows a new function pmic_arb_masked_write() to be added which
locks the spinlock and then calls register IO functions to
perform SPMI read and write commands in a single atomic
operation.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Link: https://lore.kernel.org/r/20211118034719.28971-1-quic_collinsd@quicinc.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 176 ++++++++++++++++++++++++++++-------
 1 file changed, 140 insertions(+), 36 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index e397c2532c8d..2113be40b5a9 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -334,24 +334,20 @@ static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 	return pmic_arb->ver_ops->non_data_cmd(ctrl, opc, sid);
 }
 
-static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
-			     u16 addr, u8 *buf, size_t len)
+static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 sid,
+				 u16 addr, size_t len, u32 *cmd, u32 *offset)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
-	unsigned long flags;
 	u8 bc = len - 1;
-	u32 cmd;
 	int rc;
-	u32 offset;
 
 	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
 				       PMIC_ARB_CHANNEL_OBS);
 	if (rc < 0)
 		return rc;
 
-	offset = rc;
+	*offset = rc;
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
-		dev_err(&ctrl->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
+		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
 			PMIC_ARB_MAX_TRANS_BYTES, len);
 		return  -EINVAL;
 	}
@@ -366,14 +362,24 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
-	cmd = pmic_arb->ver_ops->fmt_cmd(opc, sid, addr, bc);
+	*cmd = pmic_arb->ver_ops->fmt_cmd(opc, sid, addr, bc);
+
+	return 0;
+}
+
+static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
+				      u32 offset, u8 sid, u16 addr, u8 *buf,
+				      size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	u8 bc = len - 1;
+	int rc;
 
-	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
 	pmic_arb_set_rd_cmd(pmic_arb, offset + PMIC_ARB_CMD, cmd);
 	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->rd_base, sid, addr,
 				    PMIC_ARB_CHANNEL_OBS);
 	if (rc)
-		goto done;
+		return rc;
 
 	pmic_arb_read_data(pmic_arb, buf, offset + PMIC_ARB_RDATA0,
 		     min_t(u8, bc, 3));
@@ -381,30 +387,44 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	if (bc > 3)
 		pmic_arb_read_data(pmic_arb, buf + 4, offset + PMIC_ARB_RDATA1,
 					bc - 4);
+	return 0;
+}
 
-done:
+static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			     u16 addr, u8 *buf, size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	unsigned long flags;
+	u32 cmd, offset;
+	int rc;
+
+	rc = pmic_arb_fmt_read_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+				   &offset);
+	if (rc)
+		return rc;
+
+	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
+	rc = pmic_arb_read_cmd_unlocked(ctrl, cmd, offset, sid, addr, buf, len);
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
+
 	return rc;
 }
 
-static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
-			u16 addr, const u8 *buf, size_t len)
+static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc,
+				  u8 sid, u16 addr, size_t len, u32 *cmd,
+				  u32 *offset)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
-	unsigned long flags;
 	u8 bc = len - 1;
-	u32 cmd;
 	int rc;
-	u32 offset;
 
 	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
 					PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
 		return rc;
 
-	offset = rc;
+	*offset = rc;
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
-		dev_err(&ctrl->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
+		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
 			PMIC_ARB_MAX_TRANS_BYTES, len);
 		return  -EINVAL;
 	}
@@ -421,10 +441,19 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
-	cmd = pmic_arb->ver_ops->fmt_cmd(opc, sid, addr, bc);
+	*cmd = pmic_arb->ver_ops->fmt_cmd(opc, sid, addr, bc);
+
+	return 0;
+}
+
+static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
+				      u32 offset, u8 sid, u16 addr,
+				      const u8 *buf, size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	u8 bc = len - 1;
 
 	/* Write data to FIFOs */
-	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
 	pmic_arb_write_data(pmic_arb, buf, offset + PMIC_ARB_WDATA0,
 				min_t(u8, bc, 3));
 	if (bc > 3)
@@ -433,8 +462,62 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 
 	/* Start the transaction */
 	pmic_arb_base_write(pmic_arb, offset + PMIC_ARB_CMD, cmd);
-	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, sid, addr,
-				    PMIC_ARB_CHANNEL_RW);
+	return pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, sid, addr,
+				      PMIC_ARB_CHANNEL_RW);
+}
+
+static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			      u16 addr, const u8 *buf, size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	unsigned long flags;
+	u32 cmd, offset;
+	int rc;
+
+	rc = pmic_arb_fmt_write_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+				    &offset);
+	if (rc)
+		return rc;
+
+	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
+	rc = pmic_arb_write_cmd_unlocked(ctrl, cmd, offset, sid, addr, buf,
+					 len);
+	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
+
+	return rc;
+}
+
+static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
+				 const u8 *buf, const u8 *mask, size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	u32 read_cmd, read_offset, write_cmd, write_offset;
+	u8 temp[PMIC_ARB_MAX_TRANS_BYTES];
+	unsigned long flags;
+	int rc, i;
+
+	rc = pmic_arb_fmt_read_cmd(pmic_arb, SPMI_CMD_EXT_READL, sid, addr, len,
+				   &read_cmd, &read_offset);
+	if (rc)
+		return rc;
+
+	rc = pmic_arb_fmt_write_cmd(pmic_arb, SPMI_CMD_EXT_WRITEL, sid, addr,
+				    len, &write_cmd, &write_offset);
+	if (rc)
+		return rc;
+
+	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
+	rc = pmic_arb_read_cmd_unlocked(ctrl, read_cmd, read_offset, sid, addr,
+					temp, len);
+	if (rc)
+		goto done;
+
+	for (i = 0; i < len; i++)
+		temp[i] = (temp[i] & ~mask[i]) | (buf[i] & mask[i]);
+
+	rc = pmic_arb_write_cmd_unlocked(ctrl, write_cmd, write_offset, sid,
+					 addr, temp, len);
+done:
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
 
 	return rc;
@@ -483,6 +566,23 @@ static void qpnpint_spmi_read(struct irq_data *d, u8 reg, void *buf, size_t len)
 				    d->irq);
 }
 
+static int qpnpint_spmi_masked_write(struct irq_data *d, u8 reg,
+				     const void *buf, const void *mask,
+				     size_t len)
+{
+	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	u8 sid = hwirq_to_sid(d->hwirq);
+	u8 per = hwirq_to_per(d->hwirq);
+	int rc;
+
+	rc = pmic_arb_masked_write(pmic_arb->spmic, sid, (per << 8) + reg, buf,
+				   mask, len);
+	if (rc)
+		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
+				    d->irq, rc);
+	return rc;
+}
+
 static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 {
 	u16 ppid = pmic_arb->apid_data[apid].ppid;
@@ -601,18 +701,18 @@ static void qpnpint_irq_unmask(struct irq_data *d)
 
 static int qpnpint_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct spmi_pmic_arb_qpnpint_type type;
+	struct spmi_pmic_arb_qpnpint_type type = {0};
+	struct spmi_pmic_arb_qpnpint_type mask;
 	irq_flow_handler_t flow_handler;
-	u8 irq = hwirq_to_irq(d->hwirq);
-
-	qpnpint_spmi_read(d, QPNPINT_REG_SET_TYPE, &type, sizeof(type));
+	u8 irq_bit = BIT(hwirq_to_irq(d->hwirq));
+	int rc;
 
 	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
-		type.type |= BIT(irq);
+		type.type = irq_bit;
 		if (flow_type & IRQF_TRIGGER_RISING)
-			type.polarity_high |= BIT(irq);
+			type.polarity_high = irq_bit;
 		if (flow_type & IRQF_TRIGGER_FALLING)
-			type.polarity_low  |= BIT(irq);
+			type.polarity_low = irq_bit;
 
 		flow_handler = handle_edge_irq;
 	} else {
@@ -620,19 +720,23 @@ static int qpnpint_irq_set_type(struct irq_data *d, unsigned int flow_type)
 		    (flow_type & (IRQF_TRIGGER_LOW)))
 			return -EINVAL;
 
-		type.type &= ~BIT(irq); /* level trig */
 		if (flow_type & IRQF_TRIGGER_HIGH)
-			type.polarity_high |= BIT(irq);
+			type.polarity_high = irq_bit;
 		else
-			type.polarity_low  |= BIT(irq);
+			type.polarity_low = irq_bit;
 
 		flow_handler = handle_level_irq;
 	}
 
-	qpnpint_spmi_write(d, QPNPINT_REG_SET_TYPE, &type, sizeof(type));
+	mask.type = irq_bit;
+	mask.polarity_high = irq_bit;
+	mask.polarity_low = irq_bit;
+
+	rc = qpnpint_spmi_masked_write(d, QPNPINT_REG_SET_TYPE, &type, &mask,
+				       sizeof(type));
 	irq_set_handler_locked(d, flow_handler);
 
-	return 0;
+	return rc;
 }
 
 static int qpnpint_irq_set_wake(struct irq_data *d, unsigned int on)
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

