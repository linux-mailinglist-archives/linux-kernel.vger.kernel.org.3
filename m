Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E0519B95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiEDJ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347139AbiEDJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:27:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F297C25588;
        Wed,  4 May 2022 02:23:26 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCr57As/F1D1GMOOsBnOm34lXvRi/2Awdnv2aHw9C90=;
        b=PrB1qik3+Kvvp4+C7jg8KSCK06Ngs3K1Bb4YWJf38VYLrvUGQVrshC5fe88d4x+UpR84Nk
        2Z1jsAOF6qTt5tm/qleOoPkZ3WoznLsR/JYgagRxED2rO5cdGePv8Xj4kaNQEaRXTWVa+2
        2mMEmVcb2IieTk7WCeo1NBqI2q9BZuYxrgPCvYEZ9ukiiPZyGnDLo/ncHfsxcQ4xUrrY6a
        l05AlMbSePxce9Iu8s13Sd4GMOSLyUkLg5uwS95pGHg8YTGsTt727Up/T9NbWzD+TYnrFb
        KNa0BsSe7/cR7zs4F/68meaGrlbHSrHmpoNjA+Gk37gPWAyUipITmkYsNAXoTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCr57As/F1D1GMOOsBnOm34lXvRi/2Awdnv2aHw9C90=;
        b=TigEsgmew1ZTuO7JwoefahZCkJcOCkA0NRFgSIfk75aP1UKHgzm4AeGH4tahkB3RD8PTol
        /6M1R3RvGorjsgAw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/msr: Add PerfCntrGlobal* registers
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccdc0d8f75bd519848731b5c64d924f5a0619a573=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ccdc0d8f75bd519848731b5c64d924f5a0619a573=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165165620446.4207.5734722623404646306.tip-bot2@tip-bot2>
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

Commit-ID:     089be16d5992dd0bc6df15ef12042fd1023ded9a
Gitweb:        https://git.kernel.org/tip/089be16d5992dd0bc6df15ef12042fd1023ded9a
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:18:26 +02:00

x86/msr: Add PerfCntrGlobal* registers

Add MSR definitions that will be used to enable the new AMD
Performance Monitoring Version 2 (PerfMonV2) features. These
include:

  * Performance Counter Global Control (PerfCntrGlobalCtl)
  * Performance Counter Global Status (PerfCntrGlobalStatus)
  * Performance Counter Global Status Clear (PerfCntrGlobalStatusClr)

The new Performance Counter Global Control and Status MSRs
provide an interface for enabling or disabling multiple
counters at the same time and for testing overflow without
probing the individual registers for each PMC.

The availability of these registers is indicated through the
PerfMonV2 feature bit of CPUID leaf 0x80000022 EAX.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/cdc0d8f75bd519848731b5c64d924f5a0619a573.1650515382.git.sandipan.das@amd.com
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8179ea3..58a44dc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -524,6 +524,11 @@
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
 
+/* AMD Performance Counter Global Status and Control MSRs */
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
