Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C936159747A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiHQQtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiHQQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:49:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467BA326C4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:49:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k9-20020aa79729000000b0052d4dd3e2aeso5223761pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=V3NBUo76d+nSkiXzGrnX3CxBe6y+rnd620DH//raoE8=;
        b=hvogyBn0sSM54fuD8N0P/mxmPgFGNdUD6dNtW+ddHvFycjAhLdzROp4c1SZIpbo00z
         Kz6clBm2pqns1I1DKHD+KMSjjsDxKCTd/E7a9Pp9VTs40VWfCBroMPJWfiY5R4nx+ZNR
         JBFWQeHXTVZDKgX2gTYjMG3D8HevTocU0/AY7hun/hd3JNdXm/RAsTtOJK3PvvGparZ8
         mWBhyd+S11HN3qwTyjJNWS8kfhBfifgjx7KOVyZeT7gW1lMgH6lq9p2SLkl6WjVJEu+j
         SniOzJ60Oj9hXd16HZffDezHHroI1UR7TA8rGTDpQaUmmzK1PoUb4Mr2yky0NwPzIs6f
         GnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=V3NBUo76d+nSkiXzGrnX3CxBe6y+rnd620DH//raoE8=;
        b=A7Dzs6EM1ol3qL5sXVaeHgHG2tJ/dsGcL6oql4PpgWPkfkLnawoSJuO1D4bBDYXVTJ
         dILwoSMts5d/eROOhTUGJea03SzImH37vedWQNPRHhnF8wqy3vl3pec4vstAjUIt1Y9J
         nf9OVf5wBRPZF5aroD2/QYRsX+yoM4a0osJlWJfCHm3OJ69uAla73Yg1VkiCEBj8gPRb
         eT8HuP5yUfjEISvW4Ie7EJ8wFwye1MniVjeWRx11SKw5WIl3MlfD693efy/0Ki72flc3
         BH6S5a2kasd8ugYybPpE+KRwokq+DxRmPl4AtvM7rCWwbR7N18YbxLpTUbOvibW4BY9e
         wBQg==
X-Gm-Message-State: ACgBeo1Ol4ykLbaswaj22cPM+GQUKzZvyogRtO/lsPgOuZYBypcSLvDP
        pmEkIP4tGIH/Em4BrSr9cX3G/zuEkW/7LXU=
X-Google-Smtp-Source: AA6agR5Bxevt9UGS9B1lT/22JmsWAqFZG0tVJOO5Kx0X0PD4ZUtiOiYSH2h2a/pzbdQu5l4BVzdSh+aGx1IMECdm
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:aa7:9f02:0:b0:52d:6ae1:d631 with SMTP
 id g2-20020aa79f02000000b0052d6ae1d631mr26893608pfr.41.1660754943688; Wed, 17
 Aug 2022 09:49:03 -0700 (PDT)
Date:   Wed, 17 Aug 2022 09:48:50 -0700
In-Reply-To: <20220817164851.3574140-1-joefradley@google.com>
Message-Id: <20220817164851.3574140-3-joefradley@google.com>
Mime-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH 2/2] kunit: no longer call module_info(test, "Y") for kunit modules
From:   Joe Fradley <joefradley@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Joe Fradley <joefradley@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because KUnit test execution is not a guarantee with the kunit.enable
parameter we want to be careful to only taint the kernel only if an
actual test runs. Calling module_info(test, "Y") for every KUnit module
automatically causes the kernel to be tainted upon module load. Therefore,
we're removing this call and relying on the KUnit framework to taint the
kernel or not.

Signed-off-by: Joe Fradley <joefradley@google.com>
---
 include/kunit/test.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c958855681cc..f23d3954aa17 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -251,7 +251,6 @@ static inline int kunit_run_all_tests(void)
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
 #define __kunit_test_suites(unique_array, ...)				       \
-	MODULE_INFO(test, "Y");						       \
 	static struct kunit_suite *unique_array[]			       \
 	__aligned(sizeof(struct kunit_suite *))				       \
 	__used __section(".kunit_test_suites") = { __VA_ARGS__ }
-- 
2.37.1.595.g718a3a8f04-goog

