Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141A5A1883
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiHYSN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiHYSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C2BD28D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fi5a4KAJqfy3ci33ccYmogCkY8ciHV2wHDw8LNbyax8=;
        b=PRUkMFMN+pHOPJdoazbthVBUaT3To4bzQNezLuPVfvffMFenbpXxYrjUJE9wRQ8ecVNVBa
        hnl4MgWmbG8Bz5xNDrcMx/CC2+fEZqLjPLqG1OgADlCPBA3TmAdrXLzlYonJSKTsl5f83W
        5eBOfjXkSWc3VGKpJ9QLXCIpUZPXtKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-Wj4nNSMjNrCftfmxmYpyIQ-1; Thu, 25 Aug 2022 14:12:47 -0400
X-MC-Unique: Wj4nNSMjNrCftfmxmYpyIQ-1
Received: by mail-wm1-f69.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so6251691wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fi5a4KAJqfy3ci33ccYmogCkY8ciHV2wHDw8LNbyax8=;
        b=KDcAFXkoYRIbJK7qGLHTt97GTX0dWU3r0bV0bQYWp5Kfs+xSHhlGYmiJTr8VR+i3Vc
         LlKJsYwehImlWhlnX7PdZ8zQ3W1Ag41nQjGb4JUDhtolG14AbrO/3ugI2JkMkbtPgx7D
         q90zq0J7e3eYm+kk0+uDFL9O1N9QEqpetWCFlLFsVP8AWEl8hPX47/Qhd8U0QPlLA5bo
         zaixYGNyFpge2l5X17kWVOkNCh6XZt6LrK4NgqIhCTe/ykDf4cfmMJnOVL4qiwQnX6PA
         FWVgcSLEWeXnDJhs0rq1cvU75xSS00N/nDpP20FhW5DhXjKzBoIAHvJPaX0BQeEvonus
         S1pA==
X-Gm-Message-State: ACgBeo3WWa6ZVberyJ1qefdnKIJeXEj8x0kCowaG6KCxcwiRDZce5NMX
        G9N/kyOCmpkwXkCT1sroeF0sP9HlivCaoQ5MJQ856IRsMpg1IH6BiIub/EWjj5e4ap9gPJ23Wy6
        tQeSMY0DKon9XP/WDhO6udVt+
X-Received: by 2002:a05:600c:216:b0:3a6:60e1:2726 with SMTP id 22-20020a05600c021600b003a660e12726mr2944892wmi.182.1661451166376;
        Thu, 25 Aug 2022 11:12:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/nJYROvYiQ2IAfhO3CgdBZ6m1FiBVpd031oI0fdbvWUxPIJUgnQVz/WpVzsga42+sehCrlg==
X-Received: by 2002:a05:600c:216:b0:3a6:60e1:2726 with SMTP id 22-20020a05600c021600b003a660e12726mr2944883wmi.182.1661451166173;
        Thu, 25 Aug 2022 11:12:46 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:45 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v3 5/9] lib/test_cpumask: Add for_each_cpu_and(not) tests
Date:   Thu, 25 Aug 2022 19:12:06 +0100
Message-Id: <20220825181210.284283-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recent introduction of for_each_andnot(), add some tests to
ensure for_each_cpu_and(not) results in the same as iterating over the
result of cpumask_and(not)().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/test_cpumask.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index 81b17563fcb3..62d499394d8a 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -29,6 +29,19 @@
 		KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter);	\
 	} while (0)
 
+#define EXPECT_FOR_EACH_CPU_OP_EQ(test, op, mask1, mask2)			\
+	do {									\
+		const cpumask_t *m1 = (mask1);					\
+		const cpumask_t *m2 = (mask2);					\
+		int weight;                                                     \
+		int cpu, iter = 0;						\
+		cpumask_##op(&mask_tmp, m1, m2);                                \
+		weight = cpumask_weight(&mask_tmp);				\
+		for_each_cpu_##op(cpu, mask1, mask2)				\
+			iter++;							\
+		KUNIT_EXPECT_EQ((test), weight, iter);				\
+	} while (0)
+
 #define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
 	do {							\
 		const cpumask_t *m = (mask);			\
@@ -50,6 +63,7 @@
 
 static cpumask_t mask_empty;
 static cpumask_t mask_all;
+static cpumask_t mask_tmp;
 
 static void test_cpumask_weight(struct kunit *test)
 {
@@ -91,10 +105,15 @@ static void test_cpumask_iterators(struct kunit *test)
 	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, &mask_empty, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, &mask_empty, &mask_empty);
 
 	EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, cpu_possible_mask, &mask_empty);
 }
 
 static void test_cpumask_iterators_builtin(struct kunit *test)
-- 
2.31.1

