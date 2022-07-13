Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92801572D54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiGMFco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiGMFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:31:06 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D879BA58E4;
        Tue, 12 Jul 2022 22:29:43 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 5E0AB16C4;
        Wed, 13 Jul 2022 08:31:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 5E0AB16C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690289;
        bh=n0UYMJA4c61I8XbWDiUPzKG7qhzI+vK46N6KQLIsBoA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RReg+9OfKv9l5p0LpLEhcjCpXIsBlymbsUb2htr5wXuKYBuCVXh1PemRmLUP+/RXm
         6RaHvDug11K1v9Of/x9ufx/IviOCU7JJYpxyiOcI+lKczlQq4ufVeJaS5+o820TlbU
         OhkwuOH+49ITt40SQiUvdYR9oQoI5pH1PUKsR5Kw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 12/23] ata: libahci: Extend port-cmd flags set with port capabilities
Date:   Wed, 13 Jul 2022 08:29:05 +0300
Message-ID: <20220713052917.27036-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently not all of the Port-specific capabilities listed in the
PORT_CMD-enumeration. Let's extend that set with the Cold Presence
Detection and Mechanical Presence Switch attached to the Port flags [1] so
to closeup the set of the platform-specific port-capabilities flags.  Note
these flags are supposed to be set by the platform firmware if there is
one. Alternatively as we are about to do they can be set by means of the
OF properties.

While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
comment there. In accordance with [2] that IRQ flag is supposed to
indicate the state of the signal coming from the Mechanical Presence
Switch.

[1] Serial ATA AHCI 1.3.1 Specification, p.27
[2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v4:
- Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)

Changelog v5:
- Add a comment regarding the PORT_CMD_CAP enum entity purpose. (@Damien)
---
 drivers/ata/ahci.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7d834deefeb9..27cab4e909a5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -138,7 +138,7 @@ enum {
 	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
 
 	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
 	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
 	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
 	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
@@ -166,6 +166,8 @@ enum {
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
+	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
+	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
 	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
@@ -181,6 +183,10 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	/* PORT_CMD capabilities mask */
+	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
+				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
+
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
-- 
2.35.1

