Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1E53C033
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiFBVEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbiFBVEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:04:42 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B7735260
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:04:41 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id CA7D92E19A9;
        Thu,  2 Jun 2022 23:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654203876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFZErQoe8ZlF0OjWg65tXnT3I6llghGKYUzn30c9kfg=;
        b=1/aKNVrzxd2vONtqJF3vP2mISEf+qR8ATq+lcQK3V9mVqcO8bMg8VosuZanJpdHuIqPKVR
        w6sMHR8UGO3lsyCdJg1QQuVp1cOXySGJU3yY51swvpwKiQJmYMgAHHEo0wnYKkwwvzTBoc
        K/tB2HP9LHz74sLhdaLhqv4hcRIQjOxAhd6Obv9EDx5EB097S4b8NgjkeETDvuwP3fcOUv
        +w/MX30lcsgg+wxMjK/PD1jzvCiuHML1ORSKmZ+7oiC6UtUj+P6DSjUgoXY1kuVRp0LzPY
        dcGmifcsMZuD1syUDbwhVRrmxNzzYHiLzMXByijECbfxy+6sV1+9w6etMGySdQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 2/2] cpumask: Add UP optimised for_each_*_cpu loops
Date:   Thu,  2 Jun 2022 23:04:20 +0200
Message-Id: <a4986bd3a692a35953111a5ad20a2ec55be8670a.1654201862.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654201862.git.sander@svanheule.net>
References: <cover.1654201862.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
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
index ce8c7b27f6c9..8af37cd603e3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -806,9 +806,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
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

