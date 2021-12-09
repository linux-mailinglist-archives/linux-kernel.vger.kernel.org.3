Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883746E568
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhLIJZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:25:26 -0500
Received: from foss.arm.com ([217.140.110.172]:52226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231508AbhLIJZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:25:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145741474;
        Thu,  9 Dec 2021 01:21:52 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 496A93F73B;
        Thu,  9 Dec 2021 01:21:51 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Justin He <justin.he@arm.com>
Subject: [PATCH] mailbox: pcc: Handle all PCC subtypes correctly in pcc_mbox_irq
Date:   Thu,  9 Dec 2021 09:21:46 +0000
Message-Id: <20211209092146.620024-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC
subspaces(type 3/4)") enabled the type3/4 of PCCT, but the change in
pcc_mbox_irq breaks the other PCC subtypes.

The kernel reports a warning on an Ampere eMag server

-->8
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc4 #127
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
 Call trace:
  dump_backtrace+0x0/0x200
  show_stack+0x20/0x30
  dump_stack_lvl+0x68/0x84
  dump_stack+0x18/0x34
  __report_bad_irq+0x54/0x17c
  note_interrupt+0x330/0x428
  handle_irq_event_percpu+0x90/0x98
  handle_irq_event+0x4c/0x148
  handle_fasteoi_irq+0xc4/0x188
  generic_handle_domain_irq+0x44/0x68
  gic_handle_irq+0x84/0x2ec
  call_on_irq_stack+0x28/0x34
  do_interrupt_handler+0x88/0x90
  el1_interrupt+0x48/0xb0
  el1h_64_irq_handler+0x18/0x28
  el1h_64_irq+0x7c/0x80
---

The main reason for that is the command complete register is read as 0
if the GAS register doesn't exist for the same which is the case for
PCC subtypes 0-2. Fix it by checking for non-zero value before masking
with the status flag and checking for command completion.

Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Reported-by: Justin He <justin.he@arm.com>
Tested-by: Justin He <justin.he@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index e0a1ab3861f0..ed18936b8ce6 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -241,9 +241,11 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	val &= pchan->cmd_complete.status_mask;
-	if (!val)
-		return IRQ_NONE;
+	if (val) { /* Ensure GAS exists and value is non-zero */
+		val &= pchan->cmd_complete.status_mask;
+		if (!val)
+			return IRQ_NONE;
+	}
 
 	ret = pcc_chan_reg_read(&pchan->error, &val);
 	if (ret)
-- 
2.25.1

