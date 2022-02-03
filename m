Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CA4A8F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbiBCVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBCVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:12:02 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E6C061714;
        Thu,  3 Feb 2022 13:12:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c189so3119462qkg.11;
        Thu, 03 Feb 2022 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCGfu39SAn94Spe1rejvxkF6/fHOWGBQOJK2sA0wSGw=;
        b=HZf2L+2H3xNRJIC+kL2xGYTSkWZAYaUFRyea/C++NaFTMrpSO5CKcJoybFfm6DV0Ou
         QrprL76uTjlpOPLhTPdQbIInvoOkwQ0lzNLvJc669LSmAFV3j/mugouJtoyelrozffN0
         KK5IgoQewroFELhycppMkad9qdaTD8HctE4ZocIQoRLDvQNo0WT0r813eP+uRtShBv70
         dEYCBsQ34jalpmZHgQBt0v+y2joF5nyIOGrJG43Gfgonylczx5ASS3Ox7UHRkLJ3f4I3
         WFluCtJT0s79zK19Yvlv8IzOdP2eWDHnbw9WpiycXFwn1/MUQeLvsT0vTOXfBF3s7GOL
         obFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCGfu39SAn94Spe1rejvxkF6/fHOWGBQOJK2sA0wSGw=;
        b=ughVn17pNLfzTSZyxJCvIqVV79t3nNq2QauUyxhajHy3V87vgjo6/5C1HYWVYmrhKH
         Gl0fxb+C7pU3QOnZtOByMY4CcLl3iahFWgn548ChpEoiY6yQ1aFM6oQ2+Yz+sagIgVfS
         lS0vhflnz/r+ETEzi2q4/vS4KGxg18ACfR4Qb2LzZSOkFaYbLrEH9WoVWjb1V8AsVcqt
         IXyAqSGqUY6cDAFxgiBZBrwihaRQ3ULXUD8Nnv05Yyom45grQGGnc1f7vVuEQ2PdURqw
         thL7N2Sg7Nnqjm2V03g9+SzZ4t3iLj1VEhPJHv9TgJlFodyd/9FFURO6oFHsCc5Gjuxa
         1tAw==
X-Gm-Message-State: AOAM533tKLDp3u+XV0tmxDEnwwDs21w8BKiRBn0YcZsZ3gxJW11WclDv
        N8e5hd4s0nQ36L3mDMbHeoZX9Prkfj4=
X-Google-Smtp-Source: ABdhPJyZRT7O2oCLVSveP2mr+mdo6IGj1neUVZjOOcr+/1UgneTdnK4Fok78ZNVVBa2rQFjVeI4i8A==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr24653124qkk.417.1643922720920;
        Thu, 03 Feb 2022 13:12:00 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id r2sm23716qta.15.2022.02.03.13.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:12:00 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: print pass messages at same loglevel as fail
Date:   Thu,  3 Feb 2022 15:11:50 -0600
Message-Id: <20220203211150.2912192-1-frowand.list@gmail.com>
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

Change default to print the pass messages at the same loglevel as
the fail messages.

The test community expects either a pass or a fail message for each
test in a test suite.  The messages are typically post-processed to
report pass/fail results.

Suppressing printing the pass message for each individual test is
available via the kernel command line parameter unittest.hide_pass.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/of/unittest.c                           | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..045455f9b7e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5997,6 +5997,10 @@
 			Note that genuine overcurrent events won't be
 			reported either.
 
+	unittest.hide_pass
+			Disable printing individual drivers/of/unittest test
+			pass messages.
+
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 70992103c07d..2cfbdc6b29ac 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/hashtable.h>
 #include <linux/libfdt.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
@@ -32,6 +33,19 @@
 
 #include "of_private.h"
 
+MODULE_LICENSE("GPL v2");
+static bool hide_pass;
+
+static int __init hide_pass_setup(char *str)
+{
+	hide_pass = true;
+	return 0;
+}
+
+early_param("hide_pass", hide_pass_setup);
+module_param(hide_pass, bool, 0);
+MODULE_PARM_DESC(hide_pass, "Disable printing individual of unittest pass messages");
+
 static struct unittest_results {
 	int passed;
 	int failed;
@@ -44,7 +58,8 @@ static struct unittest_results {
 		pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
 	} else { \
 		unittest_results.passed++; \
-		pr_debug("pass %s():%i\n", __func__, __LINE__); \
+		if (!hide_pass) \
+			pr_err("pass %s():%i\n", __func__, __LINE__); \
 	} \
 	failed; \
 })
-- 
Frank Rowand <frank.rowand@sony.com>

