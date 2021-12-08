Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC046D1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhLHLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhLHLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:21:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FEC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:17:50 -0800 (PST)
Date:   Wed, 08 Dec 2021 11:17:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638962267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMwppfy3UrX3I8KBgIwGLLb7q2RxDCKASFaODWEM+fk=;
        b=uZ2V7lO+9iS64OpzDE7r+QH5Uz+mSh5Tw8xW0KEBcXcZfiKqzPu84/iZQd9Utt8l5e43Tx
        OBfNji574WdT8SBco8K7QKASqQEhFk4iS/uAlRLKtbJ6AV0fDwxce7WW/hLdYCsalesgR7
        EBAgbGm6o7orsP6SMS48ZBx0l3aTAsd3NYbWot8g4WYnelQCzhqfmkYbVCosDQ/h4qjBZX
        604VLXPahd+cnN8b0JuvDUT78ceHRpHCXEMQ4vclCPjjx2hZKtS/NWP1WD7a/2LPDmTlM2
        7m4PxNdTt7vqY3Z+MkNx+E0PjttY0YaQEI2PT20GPJSKt5E1aiaySgVBAwMrNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638962267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMwppfy3UrX3I8KBgIwGLLb7q2RxDCKASFaODWEM+fk=;
        b=m0bmpNVUA+sCYc5dpVvYd4JcegdiD/9Uy+ytFZLuRN+bn9jPbe+7vbF9qcvFX0wMEDX/iQ
        oiXvkIMF9fhAXACQ==
From:   "irqchip-bot for Wudi Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/irq-gic-v3-its.c: Force
 synchronisation when issuing INVALL
Cc:     Wudi Wang <wangwudi@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
References: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163896226662.11128.5243807165796268082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     b383a42ca523ce54bcbd63f7c8f3cf974abc9b9a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b383a42ca523ce54bcbd63f7c8f3cf974abc9b9a
Author:        Wudi Wang <wangwudi@hisilicon.com>
AuthorDate:    Wed, 08 Dec 2021 09:54:29 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 08 Dec 2021 11:13:18 

irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

INVALL CMD specifies that the ITS must ensure any caching associated with
the interrupt collection defined by ICID is consistent with the LPI
configuration tables held in memory for all Redistributors. SYNC is
required to ensure that INVALL is executed.

Currently, LPI configuration data may be inconsistent with that in the
memory within a short period of time after the INVALL command is executed.

Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")
Link: https://lore.kernel.org/r/20211208015429.5007-1-zhangshaokun@hisilicon.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d..0cb584d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -742,7 +742,7 @@ static struct its_collection *its_build_invall_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return NULL;
+	return desc->its_invall_cmd.col;
 }
 
 static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
