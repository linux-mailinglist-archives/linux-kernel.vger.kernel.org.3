Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1F4F384C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376614AbiDELWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbiDEIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1372D1F1;
        Tue,  5 Apr 2022 01:36:56 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG9WWXyVhhSOo6kXkWe1gSa4fNQuqFWCIhRD/9ytHPU=;
        b=BwC9s2QoTENr5bAJFGXWKtEU2lf0FOxoVmcieUTS4HWntOnnPL1r6dYJDEnSKufrUsa6/i
        g5qRZUz+dp0Rs7HPWwWZ4YMwwFmgXpXQvh2QiVZ0pyhCJUzHTlF3IyyGk1QpZeN1jW1W/0
        GIUbzth0JHnr7ivpyHsCBIv8o6JhfHEVkjajlC6YFNP0RIr7iv5pjbzQC4e2STXXSmUg3w
        wlu4VxUh+IxflLwEGfw2PTQIfsfrSoCloBRMyRYvsUx4CHeTTgfULCmk8l+xt3BhLY0DeI
        7rxeKsGYiMHQ9vV2RcjjMjyHBMuozcu6rjDokS+ZN6tiT2QCVHhAUWr1wBnRPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG9WWXyVhhSOo6kXkWe1gSa4fNQuqFWCIhRD/9ytHPU=;
        b=K9khM+T9RGZxKNyZkUwY0vi9SjTvStZqfIYhJVKSEV2oolh3Zinzjq2FFXpWXRgjWeRuEV
        KBwfZonn0/aIRGDw==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpufeatures: Add AMD Fam19h Branch Sampling feature
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-3-eranian@google.com>
References: <20220322221517.2510440-3-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914780346.389.14352309148130614175.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a77d41ac3a0f41c80120ec5b8b08ab284fec950a
Gitweb:        https://git.kernel.org/tip/a77d41ac3a0f41c80120ec5b8b08ab284fec950a
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:36 +02:00

x86/cpufeatures: Add AMD Fam19h Branch Sampling feature

Add a cpu feature for AMD Fam19h Branch Sampling feature as bit
31 of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-3-eranian@google.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643a..0d62afd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
