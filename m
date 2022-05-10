Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607B522059
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347514AbiEJQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347263AbiEJPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5527CF4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:14 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h3so13813820qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2IJO+Pa5M9voLAKUXr0ktIZBj7JUQbqvUsJEPx3GJM=;
        b=c3IN7lMAFbv4sEP6laSQRowTvSX+G5HVSYHppf0FixY2y1TOg935HHtOG7mdR4VDoe
         LQ69xKtAOxfnp4jdc3DXQEgPRlFnpm00mdslKhj6m28OSLFLu9jG5au941IQtcxYX9TQ
         LhiZpqUmNAvT00BdJohSd3u1bbdaE5Qh+pz80eMMUhg7p6IuxcdGsDdMY3jG2dRCpBRt
         up0C87zFbVNdmfiE5nx6LZJOpflQEsJdkh86x0JFWLqfBZTWAa3OYqW+AanRLvD2B0BC
         5N6Hb4J4B1CLqpldSIQVLKJNnVaehyw4jy1VsGrSBIyXrUm1jSbs+db1MZSetK+1f9zS
         A30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2IJO+Pa5M9voLAKUXr0ktIZBj7JUQbqvUsJEPx3GJM=;
        b=0QH68RvxuyjdFimXMyhWDT+efAXL1dTJRpXorKAWfNq8lIg1F4AosERw6qQv8kquqW
         NQVNn+7GVLvWoCYmJBSTLoGX1xHzlLT7vakSGxn62A6ATcDni6lIq7ffwMubwDFaMnRQ
         zsWn0XhCgqn58GcJhE6XIUOqCTh4S2qxOzbTCvSVHLSOU/Lh2tTQukKSUxdPLEj1K2TS
         T1lDiP+yKC0xs7FS7A6Iq+7ljVWviRfJzAT4B4juAHu8A8D4jFo2kCK4GNLyuCwNzTyB
         pIQnDm9v6v2t8d+LdTHquNaR4EMaYEScD2EEn21q57FyiTASBSY0NrpDC37FUgXha9rT
         pr0Q==
X-Gm-Message-State: AOAM5338ixKM7DFcV7KSnICGae5eQnOnFHE/z7mdvPghksV5UvtkTky1
        R/gG/43CpaXInadEpxgIcIaD05Oc09/K4g==
X-Google-Smtp-Source: ABdhPJz52r13mAcgDBQf1ACM0hZ/J0vco7XnwEomdirN9ZWSxVJnzg675wnJR4aV7S74ZqzB7KnbjA==
X-Received: by 2002:ac8:7fd1:0:b0:2f3:dddb:4206 with SMTP id b17-20020ac87fd1000000b002f3dddb4206mr7333570qtk.11.1652197693544;
        Tue, 10 May 2022 08:48:13 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id z7-20020ac875c7000000b002f39b99f6b5sm9242338qtq.79.2022.05.10.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:13 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org
Subject: [PATCH 14/22] x86: smp: use cpumask_weight_eq() in remove_siblinginfo
Date:   Tue, 10 May 2022 08:47:42 -0700
Message-Id: <20220510154750.212913-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_weight_eq() is more efficient because it may stop traversing
cpumask depending on condition.

CC: Balbir Singh <sblbir@amazon.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Huang Rui <ray.huang@amd.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Paul E. McKenney <paulmck@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tim Chen <tim.c.chen@linux.intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7d948f79ef31..74ca98b3ab2a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1621,7 +1621,7 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
-		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
+		if (cpumask_weight_eq(topology_sibling_cpumask(sibling), 1))
 			cpu_data(sibling).smt_active = false;
 	}
 
-- 
2.32.0

