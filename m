Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6356CC2F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGJBbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGJBbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236015A21;
        Sat,  9 Jul 2022 18:31:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y22so532127qki.7;
        Sat, 09 Jul 2022 18:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+RUA8QatinY3k/ikkS0kUMcoOi6M3AlFiU1N+5j9MI=;
        b=lSv4WQ8HlrpD3fVbm2Yhta7lhAIa3r+j6LUNquuxXWx2DuXhRxAZQvSqg/m50VHKQC
         EW2osXIdWeE0MtrdWqzVDzrQjkrGeyYPyCKgzZYNiqJBwp6Sx22neu2OghHSswDtN1TS
         ZKTRrW6SDlcsPxo6Wxu68ICDQMwwau5BO3t1uZy8sRpiyPyBOpr+2Jq37ihO6ak4mohw
         yF257n4+LPPgDq42Ny5XWkqHaeO3Aj9oDHOGZnHYb+nTg5Ew6EAjOwuAnlVT0YnOteKq
         Pd1Qxtbb6XTFAnVRrGC125EkJuzp5ZYO+yodyR0vrujo9vuLRLbZEwww/xGvmLDWxq2Y
         A8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+RUA8QatinY3k/ikkS0kUMcoOi6M3AlFiU1N+5j9MI=;
        b=T0ltGjJKE+ZMumigFn8d9AZIzM0COGXTq/hofB5XTPDEXKLIObvTjeeiIIYalVJFLM
         oXpMlV6/oXu1ThlidzChB2VZ0qbNumz0FojyvkTdo/RXLW1/uHAtDE7LvRyGz+ok86gv
         kOAdIZaorpd05iu0jZsJpTpHpyazPl4GkGwiT8YsJhxA6sO/aHAOfQjbjLon5ePvzjrW
         uqrUP3HWcP7Zr+qGT6npF78ZReQYo4rTxcB8prsA0eHOJ2gwdk7d1gdcjxiWP9iMvYtR
         w3v4lpF1zeY7UaZfdT6YRFYPoM5GdLI2+iKNrE3HDNlZLaQdp84GlGAdVVyenBBw7P/u
         bsMA==
X-Gm-Message-State: AJIora8FUZQfcuSPuEzeOfKBxIXnrL/+QZVxTkGpIbvJ5qrED99BA1cV
        t9viL0y9F1y2GIpJKMDgtNU=
X-Google-Smtp-Source: AGRyM1vS5JUfU8T3Ux084nZAemZhx6XwdCnyFbQzlb424f0DwOZriBhvMfpqBHpAZWiHp+aa7w0wBg==
X-Received: by 2002:a37:9241:0:b0:6b5:738c:be25 with SMTP id u62-20020a379241000000b006b5738cbe25mr3094264qkd.178.1657416698628;
        Sat, 09 Jul 2022 18:31:38 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:38 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] iio: test: rework Kconfig to support modules
Date:   Sat,  9 Jul 2022 21:31:09 -0400
Message-Id: <20220710013109.3349104-6-liambeguin@gmail.com>
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

Rework the IIO test Kconfig to support building KUnit tests as modules.
This lets users execute tests at runtime in addition to the usual
tools/testing/kunit/kunit.py script.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/test/Kconfig | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 7dbf51bc4934..82924727b2cc 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -5,15 +5,25 @@
 
 # Keep in alphabetical order
 config IIO_RESCALE_KUNIT_TEST
-	bool "Test IIO rescale conversion functions"
-	depends on KUNIT=y && IIO_RESCALE=y
+	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT && IIO_RESCALE
 	default KUNIT_ALL_TESTS
 	help
-	  If you want to run tests on the iio-rescale code say Y here.
+	  build unit tests for the iio-rescale code.
 
-	  This takes advantage of ARCH=um to run tests and should be used by
-	  developers to tests their changes to the rescaling logic.
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
 
 config IIO_FORMAT_KUNIT_TEST
-        bool "Test IIO formatting functions"
-        depends on KUNIT=y
+	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO formatting functions.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
-- 
2.35.1.4.g5d01301f2b86

