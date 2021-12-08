Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1F46CF37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhLHIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhLHIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:41:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:38:17 -0800 (PST)
Date:   Wed, 08 Dec 2021 08:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638952695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGnzxE0TUgGOkAxi1j1ux7ILSzYtkGv6YIp43Mzz+DI=;
        b=brU2tYw+yHP04vZv0Enl2afl5/EfZzDdZAQbWOjZV7XVZeo5mgmnOfxO+fL8U/d9mKJz4z
        iSdZV6JtXGauTo4lT7MnpVu9y0sblKlVHs0xO88fvFbd9kGyK4pYxQ1aGBwj+Pnbgm0UB6
        sjYvJsvA04iMKbV/TDWqHS75Sqocp2jW0h26Jpiiygn+bVl96ZNwBnk1bMR8dgr+B2qSZ3
        VAIX20FZrTG+GOLs7b0MqaFNviAVG+XLqlS3fjyHNWWnWUGce1hySsgMK3ld3hymyERFbY
        uucvQiccg2dNG4QqHG1pWy4sMWUVydP5g9Ngfk90KXc8NZSxIRRFHU3BHEPOYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638952695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGnzxE0TUgGOkAxi1j1ux7ILSzYtkGv6YIp43Mzz+DI=;
        b=FUtEJBqy6o1aAlcyNXcWUc/+JTABs3fmzC8jUNnAEK3tx9ncWeECmOqSPM08es82zqHqET
        kOvKpVEpwj5JqbAw==
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
Message-ID: <163895269409.11128.10234033289375981938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     d094b4332232c88d07d9884a9c32fec259984351
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d094b4332232c88d07d9884a9c32fec259984351
Author:        Wudi Wang <wangwudi@hisilicon.com>
AuthorDate:    Wed, 08 Dec 2021 09:54:29 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 08 Dec 2021 08:34:09 

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
Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")
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
