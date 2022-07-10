Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D756CC30
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGJBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGJBbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B315827;
        Sat,  9 Jul 2022 18:31:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w1so3166642qtv.9;
        Sat, 09 Jul 2022 18:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAhACMP8NRjsirEZE+z16gjH7i5C3HZ292R+HFdkx9k=;
        b=mfPbIS613Kx/cMDOmt/B7M1fQAt089SmAgR4QyFzVx1g8bKizX2l2WSeKZj2kMvccB
         hG7vIZCzRX7qw4dYQ3B+KXabhZzB3OwQZz+qv3IFOLEH2uEDYiF5aOU6IYQaKVX71NVB
         ze3O1w4N3mh6mW3FEMHuP5lGfSOehBb9GUsx81BvftHgqsxghX2CsUWltv5q/wLLBBn4
         Jh7xn6+pDlbLUZdHXq9yF4PJNknNBqcJxZElZPkKBAn3fXMBsx35maMM72xhRHDbhgvi
         tDYA6cKLSgA3KpAkZin03L6md3oMLb2YlRrmoXJEEMtILWWoSTmYB3WbNBbEHp2sfvq2
         41cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAhACMP8NRjsirEZE+z16gjH7i5C3HZ292R+HFdkx9k=;
        b=GnQJp1NDsPYls8DMGkz4YlKl5TIGBO+g8dkmM9E6Zwr0c2Ibb1/KG5OWglGNiack8I
         0AGC3SOyGfPmjdu/aXBcUo3rNYkt+Cei/3WtMYcNttem8p3amHv4m8XIj/2gvcWbq1yB
         LytZN978isi0Cz37iChy1sqMkxR72TttIBUcv7wpMJZcgLd2jpfbn6hcuvMOOMsZp33K
         aT8miaVpkv8B2OF4Cw3vZBTmxt6KO16Z1JDGGZ54XolpdhmZlxwpsQ5gu/sdKbBqtLNu
         saoCvw23BrMBT4WtOnBOj+DfRDJ8GtQnjEJ905ntin9qOB1CszpMtIyFiOIolC2+HPmW
         shjg==
X-Gm-Message-State: AJIora9x4ifyyDBZhuImMxvvWvjfswwrWHrmQnklbkaH0hNRmxt0aB0s
        oOqpKSqoG3Vx8Jq2E1pti/o=
X-Google-Smtp-Source: AGRyM1s41+OQyssEKfO4jvSAr4ZuiDzeW3OeWU3FIZD0v31fNCSL5HU1TS0jbbxXm09F3vcM8TI3cw==
X-Received: by 2002:ac8:5e07:0:b0:31e:a826:b3ce with SMTP id h7-20020ac85e07000000b0031ea826b3cemr7572768qtx.214.1657416696010;
        Sat, 09 Jul 2022 18:31:36 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] iio: test: format: follow CONFIG_ naming convention
Date:   Sat,  9 Jul 2022 21:31:07 -0400
Message-Id: <20220710013109.3349104-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220710013109.3349104-1-liambeguin@gmail.com>
References: <20220710013109.3349104-1-liambeguin@gmail.com>
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

The KUnit documentation indicates that all KUnit Kconfig entries must
match CONFIG_<name>_KUNIT_TEST: where <name> is the name of the test
suite. Rename the IIO_TEST_FORMAT configuration accordingly.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/test/Kconfig  | 2 +-
 drivers/iio/test/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 4c66c3f18c34..7dbf51bc4934 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -14,6 +14,6 @@ config IIO_RESCALE_KUNIT_TEST
 	  This takes advantage of ARCH=um to run tests and should be used by
 	  developers to tests their changes to the rescaling logic.
 
-config IIO_TEST_FORMAT
+config IIO_FORMAT_KUNIT_TEST
         bool "Test IIO formatting functions"
         depends on KUNIT=y
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index 880360f8d02c..d76eaf36da82 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,5 +5,5 @@
 
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
-obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
+obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) += iio-test-format.o
 CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
-- 
2.35.1.4.g5d01301f2b86

