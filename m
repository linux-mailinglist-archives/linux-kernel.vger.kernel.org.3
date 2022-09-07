Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329845B0C16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIGSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiIGSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:03:59 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61FBFEAB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:03:35 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id m3so4706094pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 11:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EMPyjqZNQFKH7JAAQQ2UarnAosN3Mpwh5MkwYVw+8yI=;
        b=z79hEG59N6PSzyPa+y9RO3P0gM4Vx5hQxcIuMDvRzMBLWwUtBBsKR3ArOQ9jszAzN8
         iEpGus3kBSq0pTTrpN3F2IAB0VbjBYxqHCPtP15rB9VxLtJ16r0GqW8AEWOuczzfVP/Y
         lJ0D3vZxsHmL8ziV/QIqsbn48f7KPnFjCPqvNFO7uVlBaUSL0hAYnzvlcwMyPAjQRx3T
         J/GGyl1IYsMRXtWYJTU3dZAk7UykvknIfy32ulAKFlvSmy3yM7q2Ff/dU1K0YIQKTTDu
         1tnPv+2NDf8tQflw1D+ZrV4HIrFno2fdNRqDwP3wOBbPqqu538tZd2px+Z94hwpEY4iX
         ZVOA==
X-Gm-Message-State: ACgBeo3JK1isqmWbVSdgX2xwOR3/lnNL5ZCoYsZrW0MJ0wIT2jNOtVkq
        LT6fF/VN3aSLOYgWwwbtG+ljmghKWA0=
X-Google-Smtp-Source: AA6agR7jbFLnz6HzGt6HEM4TpsZD/i1FNKBtqPUN0wcI6qCqYYgNVKR3apF1i976mf3sVR1McWoP5g==
X-Received: by 2002:a17:902:e78e:b0:175:5313:2a46 with SMTP id cp14-20020a170902e78e00b0017553132a46mr4980912plb.53.1662573815122;
        Wed, 07 Sep 2022 11:03:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:899e:cff7:8f51:a7ba])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b0016f85feae65sm12691518plg.87.2022.09.07.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:03:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] lib: Improve the is_signed_type() kunit test
Date:   Wed,  7 Sep 2022 11:03:29 -0700
Message-Id: <20220907180329.3825417-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the definition of is_signed_type() has been moved from
<linux/overflow.h> to <linux/compiler.h>, include the latter header file
instead of the former. Additionally, add a test for the type 'char'.

Cc: Isabella Basso <isabbasso@riseup.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib/is_signed_type_kunit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/is_signed_type_kunit.c b/lib/is_signed_type_kunit.c
index f2eedb1f0935..207207522925 100644
--- a/lib/is_signed_type_kunit.c
+++ b/lib/is_signed_type_kunit.c
@@ -5,7 +5,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
-#include <linux/overflow.h>
+#include <linux/compiler.h>
 
 enum unsigned_enum {
 	constant_a = 3,
@@ -21,6 +21,11 @@ static void is_signed_type_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, is_signed_type(bool), false);
 	KUNIT_EXPECT_EQ(test, is_signed_type(signed char), true);
 	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned char), false);
+#ifdef __CHAR_UNSIGNED__
+	KUNIT_EXPECT_EQ(test, is_signed_type(char), false);
+#else
+	KUNIT_EXPECT_EQ(test, is_signed_type(char), true);
+#endif
 	KUNIT_EXPECT_EQ(test, is_signed_type(int), true);
 	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned int), false);
 	KUNIT_EXPECT_EQ(test, is_signed_type(long), true);
