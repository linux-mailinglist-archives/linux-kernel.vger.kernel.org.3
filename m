Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5945930BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiHOOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiHOOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A724092;
        Mon, 15 Aug 2022 07:30:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e27so4566001wra.11;
        Mon, 15 Aug 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hXEApsgmJM0YpgsYBqtez7wZ8rBpB7fQbxI7//Qi7zM=;
        b=ipmvXLXs+gv35tXJ4yKTdE2Z2xOhShZghngxXyTsHmM+8q5/m6LviejTioEurJGPv1
         gbfv5c1CozHLnSr2RxI5BXxotwbwac4CgspDPSTfltuqKzkZT1U3PmoHpYL0ifWJUaYN
         MMJyvWta1YF57Pw1D4fyyMTMFgL8cvaCqW4zu44dbtbeLnuhjcp/mJo34Xvzp8Yn8vX7
         cq+0RpLUEyYDUSWzQWUw5kY1siDJRRdxH67JHOad/IPv0dW0vlCZZWmyOmJcs+TrQoXZ
         2cUa9dmyRkJJvj+2z3+DG5bWWMEiEquv3rqNPF1EIp2JL6Iav0jbFteuIwPKhPeKVura
         yivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hXEApsgmJM0YpgsYBqtez7wZ8rBpB7fQbxI7//Qi7zM=;
        b=dqVtVeb3W37H9dRUPMc3AZ/AB01EdG6FOzgaLMtLeHSAzdXriqA273joCBFVCiENwk
         THazB9OKm0fMJ9p/hVeK39r+R8GDS952D/OAKmeXn5fS1/E3+hSDi/Wa47WM6Uq9hlHh
         8Gsebew9pstr/kDvVH0dvuwyLsIt4Ng4ZAz7PrLaVRv1bOf6BWOnj9gfZ8Z59ju0Nddn
         rOS60d+0LEG6VrytKs5ZBLBMSqswtKhX8XnQIdwDWSbCiChgIXHhtAfFcWDiAVjO0ogf
         65tR/kQX27suJcz5Zxnlkqv9YoBB1+jnmtyRSCgNs3qF6AbJ45nX6yAETl00hLI6PU4a
         qdmw==
X-Gm-Message-State: ACgBeo2rFAUPWFuTADLRB2lPF5G13dDjzyVXK3asqLCvHC7JxYozROZ1
        EW8C5vELAGQVngpO/yduZ1Bljt2zDvGV7A==
X-Google-Smtp-Source: AA6agR7gG1EVzjFVMD8itiN0eb7Q87uXr5BvAgTHg1FxPoH/NghPsOaKxX4UORJ6Xau+cVJ/oFAWaQ==
X-Received: by 2002:a05:6000:1b92:b0:220:7d86:2e30 with SMTP id r18-20020a0560001b9200b002207d862e30mr9195405wru.530.1660573803913;
        Mon, 15 Aug 2022 07:30:03 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:03 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: [PATCH v4 1/8] HID: uclogic: KUnit best practices and naming conventions
Date:   Mon, 15 Aug 2022 16:29:49 +0200
Message-Id: <20220815142956.19180-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815142956.19180-1-jose.exposito89@gmail.com>
References: <20220815142956.19180-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KUnit documentation [1] suggests allowing build tests as a module.

In addition, it is recommended [2] to use snake case names for
kunit_suite and test cases.

Change the Kconfig entry from bool to tristate and stick to the naming
conventions to avoid style issues with future tests.

Link: https://docs.kernel.org/dev-tools/kunit/style.html#test-kconfig-entries  [1]
Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html  [2]
Acked-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/Kconfig                  |  2 +-
 drivers/hid/Makefile                 |  3 ++-
 drivers/hid/hid-uclogic-rdesc-test.c | 22 +++++++++++-----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ce92830b5d1..36a17958493f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1307,7 +1307,7 @@ config HID_MCP2221
 	will be called hid-mcp2221.ko.
 
 config HID_KUNIT_TEST
-	bool "KUnit tests for HID" if !KUNIT_ALL_TESTS
+	tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
 	depends on HID_UCLOGIC
 	default KUNIT_ALL_TESTS
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index b0bef8098139..82d8fd97d96c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -144,8 +144,9 @@ obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
 obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_SENSOR)	+= hid-sensor-custom.o
 
-obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-rdesc.o \
+hid-uclogic-test-objs		:= hid-uclogic-rdesc.o \
 				   hid-uclogic-rdesc-test.o
+obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-test.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
index ebebffef5f8a..3971a0854c3e 100644
--- a/drivers/hid/hid-uclogic-rdesc-test.c
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -97,7 +97,7 @@ static const __u8 template_params_none[] = {
 
 static struct uclogic_template_case uclogic_template_cases[] = {
 	{
-		.name = "Empty template",
+		.name = "empty_template",
 		.template = template_empty,
 		.template_size = sizeof(template_empty),
 		.param_list = params_pen_all,
@@ -105,7 +105,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = template_empty,
 	},
 	{
-		.name = "Template smaller than the placeholder",
+		.name = "template_smaller_than_the_placeholder",
 		.template = template_small,
 		.template_size = sizeof(template_small),
 		.param_list = params_pen_all,
@@ -113,7 +113,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = template_small,
 	},
 	{
-		.name = "No placeholder",
+		.name = "no_placeholder",
 		.template = template_no_ph,
 		.template_size = sizeof(template_no_ph),
 		.param_list = params_pen_all,
@@ -121,7 +121,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = template_no_ph,
 	},
 	{
-		.name = "Pen placeholder at the end, without ID",
+		.name = "pen_placeholder_at_the_end_without_id",
 		.template = template_pen_ph_end,
 		.template_size = sizeof(template_pen_ph_end),
 		.param_list = params_pen_all,
@@ -129,7 +129,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = template_pen_ph_end,
 	},
 	{
-		.name = "Frame button placeholder at the end, without ID",
+		.name = "frame_button_placeholder_at_the_end_without_id",
 		.template = template_btn_ph_end,
 		.template_size = sizeof(template_btn_ph_end),
 		.param_list = params_frame_all,
@@ -137,7 +137,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = template_btn_ph_end,
 	},
 	{
-		.name = "All params present in the pen template",
+		.name = "all_params_present_in_the_pen_template",
 		.template = template_pen_all_params,
 		.template_size = sizeof(template_pen_all_params),
 		.param_list = params_pen_all,
@@ -145,7 +145,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = expected_pen_all_params,
 	},
 	{
-		.name = "All params present in the frame template",
+		.name = "all_params_present_in_the_frame_template",
 		.template = template_frame_all_params,
 		.template_size = sizeof(template_frame_all_params),
 		.param_list = params_frame_all,
@@ -153,7 +153,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = expected_frame_all_params,
 	},
 	{
-		.name = "Some params present in the pen template (complete param list)",
+		.name = "some_params_present_in_the_pen_template_with_complete_param_list",
 		.template = template_pen_some_params,
 		.template_size = sizeof(template_pen_some_params),
 		.param_list = params_pen_all,
@@ -161,7 +161,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = expected_pen_some_params,
 	},
 	{
-		.name = "Some params present in the pen template (incomplete param list)",
+		.name = "some_params_present_in_the_pen_template_with_incomplete_param_list",
 		.template = template_pen_some_params,
 		.template_size = sizeof(template_pen_some_params),
 		.param_list = params_pen_some,
@@ -169,7 +169,7 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.expected = expected_pen_some_params,
 	},
 	{
-		.name = "No params present in the template",
+		.name = "no_params_present_in_the_template",
 		.template = template_params_none,
 		.template_size = sizeof(template_params_none),
 		.param_list = params_pen_some,
@@ -208,7 +208,7 @@ static struct kunit_case hid_uclogic_rdesc_test_cases[] = {
 };
 
 static struct kunit_suite hid_uclogic_rdesc_test_suite = {
-	.name = "hid-uclogic-rdesc-test",
+	.name = "hid_uclogic_rdesc_test",
 	.test_cases = hid_uclogic_rdesc_test_cases,
 };
 
-- 
2.25.1

