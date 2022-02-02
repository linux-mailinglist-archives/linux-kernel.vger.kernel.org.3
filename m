Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE44A78DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbiBBTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBBTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:45:24 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1BC061714;
        Wed,  2 Feb 2022 11:45:24 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id e20so571351qvu.7;
        Wed, 02 Feb 2022 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvZjFpyIkbMZ/ze0qgMESQH0VN7MsTwLvLVU0S1wAiQ=;
        b=ZjZZWUpbJ4YlRq/+yUqkwRremL1orcOhbUOfoJdo7VKeZOMKKWQ3Eqcb0mTxCFyyf+
         /dSoFi0zX1Rx1vZqWcFPY9e/e0ev9Q6dFxZU3xdLqx+sa2JPG6kQBkZPLzIn7PlU7TDK
         4VsQgIf7xkNz39RjWwKafCd9nrKUbF+X/wbCP2vGJca07c/ATZ+vkPk7ri0s7Oge2a4Z
         bSiqTc6Zg0KlzAdDZW5jUyvXthTFS+B/Rng63lb2hsNOonWe0hxBEb21/pZRR7TUUdIs
         T64s5Fff6ypHmpevHkE2zfZQu3w6i8eWoTTJ2B20fvlW93RubBS+JdvUCvJ2+xh2uGOf
         eqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvZjFpyIkbMZ/ze0qgMESQH0VN7MsTwLvLVU0S1wAiQ=;
        b=O/Em12WM07dvlNxgAa6aLyGLEJU/dPwlHSpcO2/FXri9urrfttQ3tx0YAsYSyFrST4
         o69B7dJBXQ0B5BGh/L2dBGdy9fFqCpo13ygXCI4Nv6urrvG7TFpMMhEeNngZh2Q6yTr/
         rfwiBThKtmSDhad+sbLtiFuv04aHD7CYBu/ctW2gCWYSoA8oGYnotOQMjBm1ddch5vYn
         9NH93+7eVN+NHreWCrjSNWb8rtuRQDYQJXXFxid8gdRYCGvSS1SiOklrisqitlYbRuhU
         cETxFhgFEHSXelUv7Q+wR3aGwlc07Fdz31Thklmiq/Ub94beJ+ZGf+c88iVa/dFD45lm
         OSzQ==
X-Gm-Message-State: AOAM531znMMkDkI7BGzwuWGqvxPtQzm4EAInbrfOUNY39zAm29pdm9Gn
        AhCRLCAUiNH89eiuypf9ATUt5CEO8F4=
X-Google-Smtp-Source: ABdhPJxMlYPNb3Wz/7Db4weEwB61I8vPWSanIMN61TUGOJytV74HXU2jDPn145Ge8efptHJNV1J6Dg==
X-Received: by 2002:ad4:5bae:: with SMTP id 14mr27585672qvq.69.1643831123186;
        Wed, 02 Feb 2022 11:45:23 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id y16sm1907888qta.11.2022.02.02.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:45:22 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: config option - print pass message at same level as fail
Date:   Wed,  2 Feb 2022 13:45:13 -0600
Message-Id: <20220202194513.2840070-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Printing the devicetree unittest pass message for each passed test
creates much console verbosity.  The existing pass messages are
printed at loglevel KERN_DEBUG so they will not print by default.

The test community expects either a pass or a fail message for each
test in a test suite.  The messages are typically post-processed to
report pass/fail results.

The pass messages can currently be reported by enabling KERN_DEBUG
loglevel for the console, but this also results in other additional
messages.  Create OF_UNITTEST_SHOW_PASS to enable printing the pass
messages at the same loglevel as the fail messages.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/Kconfig    | 10 ++++++++++
 drivers/of/unittest.c |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..6ad05df4f7d4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -25,6 +25,16 @@ config OF_UNITTEST
 
 	  If unsure, say N here, but this option is safe to enable.
 
+config OF_UNITTEST_SHOW_PASS
+	bool "Device Tree runtime unit tests, report each pass"
+	depends on OF_UNITTEST
+	help
+	  The messages reporting an individual test pass are normally
+	  printed at loglevel KERN_DEBUG.  Enable this option to print
+	  the PASS messages at the same loglevel as the FAIL messages.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_ALL_DTBS
 	bool "Build all Device Tree Blobs"
 	depends on COMPILE_TEST
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 70992103c07d..efcec1c6c895 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -44,7 +44,10 @@ static struct unittest_results {
 		pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
 	} else { \
 		unittest_results.passed++; \
-		pr_debug("pass %s():%i\n", __func__, __LINE__); \
+		if (IS_ENABLED(CONFIG_OF_UNITTEST_SHOW_PASS)) \
+			pr_err("pass %s():%i\n", __func__, __LINE__); \
+		else \
+			pr_debug("pass %s():%i\n", __func__, __LINE__); \
 	} \
 	failed; \
 })
-- 
Frank Rowand <frank.rowand@sony.com>

