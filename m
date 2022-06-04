Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD153D803
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiFDRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiFDRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:16:18 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDA286D4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:16:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 075EA2E2938;
        Sat,  4 Jun 2022 19:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654362971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmyaFQVp9aEpKb+oKQXkJfXH9xvYY1MiNgw55GvfXww=;
        b=pUIveiGWzRZte8JuDbyM2ORSh0Kmi3hAwOlQkeetVK6iOYPU2t9vhdoW593X229yyhBlKg
        to/yhjn49TGAIXI6AFcksajLK1YMlacmpIyK2o2f+JPYW0QZWbJ/OL2ldkDwAoo40fLzG+
        664494gWmYXdGiQxm8VOFqjCVw+p1ssz3oaFCtonw59fJXJ2TZ1cqPHn5Qvn2dVxb7h18s
        xHmRqL+FY9HVMUXf7FQQqfNtCRev0IvRDWi0jLykUmpI9gc7OJfMKyhtgvNDsCVxDKUMU9
        jOOqWvUXyZAeeCviE1l6BCgr6+MS8/nUAvh87Ev80SkcgEXFHZGPul0tY/Xcmg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 3/4] cpumask: Add UP optimised for_each_*_cpu versions
Date:   Sat,  4 Jun 2022 19:15:58 +0200
Message-Id: <c32bb74a4bdfe0a1074084229771d592f251a6c9.1654362935.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654362935.git.sander@svanheule.net>
References: <cover.1654362935.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
exactly once.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/linux/cpumask.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d6add0e29ef4..7ccddbc27ac3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -731,9 +731,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
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
2.36.1

