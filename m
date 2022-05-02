Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E749516B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383467AbiEBHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358666AbiEBHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:30:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CEE183AD;
        Mon,  2 May 2022 00:27:04 -0700 (PDT)
Date:   Mon, 02 May 2022 07:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651476422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UxuM5f2tTJUDrv2jfqsdab0TsuFg0OcMG1oQ4Ohyjk=;
        b=bJlQNwTeQHvmrAyDAwv0D25Bc3GR495DcIHdrffGI+0DIjpqQ/XMRQUuvxPt4k5ugCiVIn
        xXYYNCMMogpfj6mhBq4Kq2/qMMxmMxwomCJXfeKFi5F10fVd3kY1d8h4nybh4FzAUztaLp
        KMaBG4oZ7+SIfculXiDDJ//GsDC124pQWVfOTB+FakRAHyhlfzUdEw8t/4+87dRxAz05UF
        xP3Cz1AwlAW0EaH2UulPFcwGRR1Gk0qfIVXorY9tfa8CV5deUQKsKB3pY05eBk/R+iQ76I
        Hi0lFeKPGWMOpeJ2eEP5Aaf8WOGKA0w7ht+riRqRLhuRNEJlkPKUS4RTw1/aWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651476422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UxuM5f2tTJUDrv2jfqsdab0TsuFg0OcMG1oQ4Ohyjk=;
        b=jaZvf79wgiqrquc/l4YYeJq6F+oXRPhInO4niag0dGpUOU0I7UEc1lYalq7sfkWBFSDr8K
        f6Bl80xP2TbOezDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfperf: Make it correct on 32bit and UP kernels
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202205010106.06xRBR2C-lkp@intel.com>
References: <202205010106.06xRBR2C-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <165147642077.4207.15451806111098153904.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1ff2fb982c52ed6c3478adc944441d6ea065d8fb
Gitweb:        https://git.kernel.org/tip/1ff2fb982c52ed6c3478adc944441d6ea065d8fb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 May 2022 09:01:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 09:19:05 +02:00

x86/aperfperf: Make it correct on 32bit and UP kernels

The utilization of arch_scale_freq_tick() for CPU frequency readouts is
incomplete as it failed to move the function prototype and the define
out of the CONFIG_SMP && CONFIG_X86_64 #ifdef.

Make them unconditionally available.

Fixes: bb6e89df9028 ("x86/aperfmperf: Make parts of the frequency invariance code unconditional")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/202205010106.06xRBR2C-lkp@intel.com
---
 arch/x86/include/asm/topology.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1b2553d..458c891 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -212,9 +212,6 @@ static inline long arch_scale_freq_capacity(int cpu)
 }
 #define arch_scale_freq_capacity arch_scale_freq_capacity
 
-extern void arch_scale_freq_tick(void);
-#define arch_scale_freq_tick arch_scale_freq_tick
-
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
 #else
@@ -222,6 +219,9 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
 #endif
 
+extern void arch_scale_freq_tick(void);
+#define arch_scale_freq_tick arch_scale_freq_tick
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
