Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CA4CD79D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiCDPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiCDPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:23:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADB113A;
        Fri,  4 Mar 2022 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i3uMN0XPCwzCCdJutSxOT0wu27OyMGNYJIeJECgEmYE=; b=aYtGzYmw8n0hqlGzMB/GVKRc1k
        0EUx7uJQPV8vHY0UYk/h/Dl3Dg+B1v2+sZ/pD2d9O5516+8E88oq/iLMFb+HA7CRpXaUouUq0vHzr
        lCXCMP+xWspJSRaqVgpXv/YURR0YI998jQ+0JI6PyuyGv9QwRX1TTUuxvPE9P8Dj3M9Lr7ZVTxZ76
        Ei0UbSwKFAg27eutVG9tJQzaC5sGBTsSPk69dV9hLRs2CwpC1VIumN1B6XvOD0wWnd5REvwq+xLIa
        +SJATIAiRyN0v43H2L4gnpulrBoV8x3E8vmSYVFeEqAB53tCVu1kCEeP7Eq/T/jrM5Uw3AFs51g04
        hMCL9xcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9l4-00FEIm-Sp; Fri, 04 Mar 2022 15:22:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 819D530041D;
        Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6B7102012A030; Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Message-ID: <20220304152135.914397165@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Mar 2022 16:19:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, mathias.nyman@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/3] x86/tsc: Be consistent about use_tsc_delay()
References: <20220304151953.830111479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently loops_per_jiffy is set in tsc_early_init(), but then don't
switch to delay_tsc, with the result that delay_loop is used with
loops_per_jiffy set for delay_tsc.

Then in (late) tsc_init() lpj_fine is set (which is mostly unused) and
after which use_tsc_delay() is finally called.

Move both loops_per_jiffy and use_tsc_delay() into
tsc_enable_sched_clock() which is called the moment tsc_khz is
determined, be it early or late. Keeping the lot consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1487,6 +1487,9 @@ static unsigned long __init get_loops_pe
 
 static void __init tsc_enable_sched_clock(void)
 {
+	loops_per_jiffy = get_loops_per_jiffy();
+	use_tsc_delay();
+
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 	tsc_store_and_check_tsc_adjust(true);
 	cyc2ns_init_boot_cpu();
@@ -1502,8 +1505,6 @@ void __init tsc_early_init(void)
 		return;
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-	loops_per_jiffy = get_loops_per_jiffy();
-
 	tsc_enable_sched_clock();
 }
 
@@ -1537,7 +1538,6 @@ void __init tsc_init(void)
 		enable_sched_clock_irqtime();
 
 	lpj_fine = get_loops_per_jiffy();
-	use_tsc_delay();
 
 	check_system_tsc_reliable();
 


