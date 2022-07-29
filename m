Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B4584C47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiG2HBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiG2HBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:01:40 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467121F2E7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:01:39 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2E4B4302C2D;
        Fri, 29 Jul 2022 09:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659078093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkZvhTljDkGb52uJmlQoon5W3jFZ8oxGweLeMELnqoE=;
        b=ZMQkVIoXQOJk8Y93zuFIa0n2qIroQmr+imRwGxGnln0iMh0WotiSDe69Pnhnx9ayWvU5MN
        aHSsL7VoWEI7IvB6fKO5UrULKGDuESLPUAppfWF28npyux+Epf3em5Wx/u5MX0qDxSO7G/
        iW6NWsoXStp/w338zafz7Lz400rR2m6Xs1zRPW2AAdtXdBEfa5RlXJXzlGUSnTs7v2Ou76
        9MgTTO1pWHLmldVkKckv7CsVbGTI0T1WMQHfoRdSOLqHZcxisU6cOb1RC5XMWPvVjc3dEV
        SRRTCXkATH6S/lBgjKGcXNbEk8xmysva30fkXGjJRpgrgn3h6Z0xqveYkk+8fg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 2/5] cpumask: add UP optimised for_each_*_cpu versions
Date:   Fri, 29 Jul 2022 09:01:19 +0200
Message-Id: <b95d5417530736770f2322640245c120d13cc07f.1659077534.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659077534.git.sander@svanheule.net>
References: <cover.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, the following loops will always run over a mask
that contains one enabled CPU (cpu0):
    - for_each_possible_cpu
    - for_each_online_cpu
    - for_each_present_cpu

Provide uniprocessor-specific macros for these loops, that always run
exactly once, instead of just relying on for_each_cpu() to provide this
optimisation.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Acked-by: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
Changes since v4:
    - Move patch forward in series
    - Add Yury's Acked-by

 include/linux/cpumask.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..533612770bc0 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -811,9 +811,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 /* First bits of cpu_bit_bitmap are in fact unset. */
 #define cpu_none_mask to_cpumask(cpu_bit_bitmap[0])
 
+#if NR_CPUS == 1
+/* Uniprocessor: the possible/online/present masks are always "1" */
+#define for_each_possible_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
+#define for_each_online_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
+#define for_each_present_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
+#else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
 #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
+#endif
 
 /* Wrappers for arch boot code to manipulate normally-constant masks */
 void init_cpu_present(const struct cpumask *src);
-- 
2.37.1

