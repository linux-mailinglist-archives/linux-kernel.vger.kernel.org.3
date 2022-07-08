Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76D756B3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiGHHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiGHHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:52:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB3D7E001
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:52:39 -0700 (PDT)
Date:   Fri, 08 Jul 2022 07:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657266755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1LLp/CpNUuDj3Z7ZCQeeQFI5Z4dqwYlu2ZZ7Ud0I7U=;
        b=wYdl7O1LrL1K74eCFSGTl7xNKYeArw1Z1Urq4J/fBElul+aR8oyAcus4c9oAmOYwkWjhSV
        bXj0yZ8TkQow2RKO+5IrWRA8CKF2v48+Pb+MA/cH65S1lgSt5dAyn5INly8HxOi9RxJCtv
        JjwpLBy8TvLcgm9jDaR+NzWQMZFJfW2OJIKt3DK7e3U03xG3UMW/wUGL59fG6M1csAhTe0
        p1IwUJssd1OmKUJDrPacABQnlPguHV0giHP+c/uDVQRmwvfPP5YbMKJMImx0l7eKC/4FKR
        57LjzVsvfT242wlsoUfImeb1RGG5cXdV05WuHw3h60nvJvYQe5W6Zs2KzeudMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657266755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1LLp/CpNUuDj3Z7ZCQeeQFI5Z4dqwYlu2ZZ7Ud0I7U=;
        b=GsoXb+NK0nWraHvZUOQH97xkWpQ0Fm32CmhRQ6JwpHemdylHsUQnVScDPwah2GnGJD2/Uo
        audwQ+dYIt7NHzCA==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] PCI: hv: Take a const cpumask in
 hv_compose_msi_req_get_cpu()
Cc:     kernel test robot <lkp@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220708004931.1672-1-samuel@sholland.org>
References: <20220708004931.1672-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165726675405.15455.3532014848598500542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9167fd5d5549bcea6d4735a270908da2a3475f3a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9167fd5d5549bcea6d4735a270908da2a3475f3a
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Thu, 07 Jul 2022 19:49:31 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 08 Jul 2022 08:44:15 +01:00

PCI: hv: Take a const cpumask in hv_compose_msi_req_get_cpu()

The cpumask that is passed to this function ultimately comes from
irq_data_get_effective_affinity_mask(), which was recently changed to
return a const cpumask pointer. The first level of functions handling
the affinity mask were updated, but not this helper function.

Fixes: 4d0b8298818b ("genirq: Return a const cpumask from irq_data_get_affinity_mask")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220708004931.1672-1-samuel@sholland.org
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index aebada4..e7c6f66 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1635,7 +1635,7 @@ static u32 hv_compose_msi_req_v1(
  * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
  * by subsequent retarget in hv_irq_unmask().
  */
-static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
+static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 {
 	return cpumask_first_and(affinity, cpu_online_mask);
 }
