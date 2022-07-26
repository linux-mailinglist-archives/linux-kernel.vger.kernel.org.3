Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D25581798
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiGZQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGZQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E8C1B7AE;
        Tue, 26 Jul 2022 09:39:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso5907973wma.4;
        Tue, 26 Jul 2022 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXEApsgmJM0YpgsYBqtez7wZ8rBpB7fQbxI7//Qi7zM=;
        b=pzyuZgS9hLSBrjIwbJCuGmzQLFiu98GS/JhugEwU7Mb/HFyVI1sUaMBTRkNTG40mA+
         M+L/c/JznqhvlV040T3V3IL9qaeFzs5Htmwn8eO/FgF12HiunLutAon3qnub0aYtCG5F
         Zwi2KrvMLycqBdgFN2LUfM61mLFWgjebA4NrBJwBCYbS1VeePDzYn/mPJ+zwxgiiz47v
         ov92lGsoS8BOeQ8uERJ5FpUhk2J7WYOOrrWgcHEsNEwnC0fmZKSlTsPGUOT6ZgJ0isk8
         4a0XPGtIMDzLNHqFc+rK9Sr1hhi+1M53/m9/qxkBjGdA9WMUXc7iUGWso8M4ox851V4Y
         HXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXEApsgmJM0YpgsYBqtez7wZ8rBpB7fQbxI7//Qi7zM=;
        b=u8XyF1eguXt1vZu8nCRr+7Jl/HgVNze/hIT/U75/IQjYcThczb0gilMpRmXqMUBpU/
         6gqrzlHQ9dq2iyR11h/beRQp9OrflIOs2V0lYSSERREOjHmRaZfkM579iTA95xzJDY/A
         nPxTsgRVy+jgjY2SBFZRS9LjHvM3n+j3pvusqvqscAilcS2NVJLKG9xLZbLsn1pZurbG
         5otlYm6dfqQ3f6292eBSdShnCX1glOlpBEC+u03e0CwqLLSVwXJJdSS4dXnA7qyYLP4T
         vFzbL0ulnhW047FoFsDdYfkoCX4B+XTcX0sXcwB++WWF9JiiArHFxDPhxLAbieG6J7p8
         //rw==
X-Gm-Message-State: AJIora+kg/kctOT3uk2pU9P/Qz2qVqnAYNE8DQ/zcR9z4GNptC/CS4oO
        DQGTHPgtw30bzeDrcu1zoOI=
X-Google-Smtp-Source: AGRyM1sDQpxNtT0yJRx9G59BhhfBTYrEF3wVrr5+ethi9f5ON17VU04U2YbpgWwGm5RHuo8FtO9x6A==
X-Received: by 2002:a05:600c:a47:b0:39e:f953:84e2 with SMTP id c7-20020a05600c0a4700b0039ef95384e2mr39771wmq.202.1658853571248;
        Tue, 26 Jul 2022 09:39:31 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:30 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: [PATCH v3 1/7] HID: uclogic: KUnit best practices and naming conventions
Date:   Tue, 26 Jul 2022 18:39:20 +0200
Message-Id: <20220726163926.10549-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726163926.10549-1-jose.exposito89@gmail.com>
References: <20220726163926.10549-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

