Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E82496CD4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiAVPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiAVPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193FC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 07:47:26 -0800 (PST)
Date:   Sat, 22 Jan 2022 15:47:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642866443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7LYtWjnmOWm9O6Tp/rKPOU/6hdKUmLFGLwf0O/U5pY=;
        b=GwMIQz4W1MtWLwZxFoKXbUBvl8CUMnoVb8VvygIbGeB2vzaXRlEMkS5J5fhgoGqnS1tz4S
        QNp+1Iq704lxkb5Uuo7QPC9Y+Wf1qfJhwQMLYkStHcazLgc3SusF5lPSCN7YhFN/vCvhei
        ewr3anyauUtffBo2MgfpBO4U22yl5z+XkEXyAyks9FcLlwgTqRE2s/19VXvp7Jq8qPCKAn
        /WZ3X6tSt6ywmsH2hHYRQqIXDQ7dhT0hspzi42RDeFbWAdiZMDkRyubM6Amsnzi+fXQX+P
        ra3ta4pXYFAT2T13sXQ+xlHlqVppYbyqJr3Ghq/r0sD9Nc0zBJZ7x4vpvegLRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642866443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7LYtWjnmOWm9O6Tp/rKPOU/6hdKUmLFGLwf0O/U5pY=;
        b=at+AKb0iyaUjpXB1b8pH/h9sD5nCRtxFaaRbJDEsR7mtJ9CAxLUL0bfisBbYDxr+HaZaNZ
        SwJtzaGb8jnEaxAA==
From:   "irqchip-bot for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Fix build for !SMP
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220122151614.133766-1-ardb@kernel.org>
References: <20220122151614.133766-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <164286644146.16921.176569436183181304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     16436f70abeebb29cd99444e27b310755806c1fa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/16436f70abeebb29cd99444e27b310755806c1fa
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sat, 22 Jan 2022 16:16:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 22 Jan 2022 15:42:49 

irqchip/gic-v3-its: Fix build for !SMP

Commit 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state
lifetime") added a reference to cpus_booted_once_mask, which does not
exist on !SMP builds, breaking the build for such configurations.

Given the intent of the check, short circuit it to always pass.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220122151614.133766-1-ardb@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ee83eb3..7b8f1ec 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5241,7 +5241,8 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 
 out:
 	/* Last CPU being brought up gets to issue the cleanup */
-	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
 		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
 
 	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
