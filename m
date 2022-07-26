Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC758179C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiGZQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiGZQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF81F2C7;
        Tue, 26 Jul 2022 09:39:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so2001817wrr.10;
        Tue, 26 Jul 2022 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+BAN7M1HC05Z4HkOihV5c+UgskV/YNKoHpBc21cwSo=;
        b=gPuOT/SzaUk0EKVh7BlZmkPF6TxVkLlsIbsaQSMGgwnCDyq7iE9fJUrLAww7yy2nRc
         x8236RjJe0Wyb302KldwAtOMKa7PiN3S0aNbzSob/q/YmltCFElFC/FjaeZxg95trSMQ
         xE9n2lDS3eBCqp5adiv1h+RRwT0Ju7PqjuKmQHi+8LpeiV3F42eUvvoE1eX9CWlJ+mgQ
         H7fTxNHzWZTQLsQ2nApZ55pdE1moVHjrIzzlQmFz6K/y+uNu3H5NXXzkCmaZloCTzOU3
         3mhUHhacp9E9RrnRnWJxY9zSj85YpLEsNrb24n4hoOa1crAPHLVKOoAAZhqsgLNjMPmH
         9LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+BAN7M1HC05Z4HkOihV5c+UgskV/YNKoHpBc21cwSo=;
        b=EWtPLrXgU4gnMELtL0/lY5T53on5g/n3ySecdiFpNUpLilEGBup0KVch8af3QGhms7
         BY35eojFwpp9vcd9wQ5bbJuTJszH7nqGE3Wr9apU+043tVw4zsSDtKTsUDEr1y4yU8VO
         NC+XCRJ+g1ZMw+55NxUAOWU7QmzmRNAGRxPkWhvPvIYETWuKijWJhU03qSoUi5T/qDT3
         2+grIGBn7CyL9usqtGj2rq/IUFJO2xZV0O5heNPWfRCBuRQEv27iC1D6Ibv9axXm/eDf
         CFK1wEo03Exy3X4c43P2BsH3OFE9uH+oYdGBfviq8X3X7ea74Z6KwZGf10kgtBCgmfmy
         NQuA==
X-Gm-Message-State: AJIora+CEmjXY1Hmw9+F4W7Tzzy+RZZM16xeN97ahQ+QpNBxWZwWxFZy
        VsMKl5jq77OzlFAm3mO3Gow=
X-Google-Smtp-Source: AGRyM1uX6ITgGv1yB6gLFynv8AQvQULewq5y5lJdJ0ME5zEUZ8v4rIYh5AxLeCJyXpl6DOhCbhMWHQ==
X-Received: by 2002:adf:ec0a:0:b0:21e:8882:6a2d with SMTP id x10-20020adfec0a000000b0021e88826a2dmr7472405wrn.355.1658853576188;
        Tue, 26 Jul 2022 09:39:36 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:35 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 6/7] HID: uclogic: Add support for UGEE v2 mouse frames
Date:   Tue, 26 Jul 2022 18:39:25 +0200
Message-Id: <20220726163926.10549-7-jose.exposito89@gmail.com>
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

Add the required HID descriptors and the initialization function for
UGEE v2 frames with a mouse in the frame.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 31 +++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 34 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 ++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 8ac7caeda535..797eeb443c18 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1188,6 +1188,31 @@ static int uclogic_params_ugee_v2_init_frame_dial(struct uclogic_params *p,
 	return 0;
 }
 
+/**
+ * uclogic_params_ugee_v2_init_frame_mouse() - initialize a UGEE v2 frame with a
+ * mouse.
+ * @p:			Parameters to fill in, cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
+{
+	int rc = 0;
+
+	if (!p)
+		return -EINVAL;
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[1],
+						 uclogic_rdesc_ugee_v2_frame_mouse_template_arr,
+						 uclogic_rdesc_ugee_v2_frame_mouse_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1231,6 +1256,12 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	iface = to_usb_interface(hdev->dev.parent);
 	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
+	if (bInterfaceNumber == 0) {
+		uclogic_params_ugee_v2_init_frame_mouse(&p);
+		goto output;
+	}
+
 	if (bInterfaceNumber != 2) {
 		uclogic_params_init_invalid(&p);
 		goto output;
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 22429df693fc..fb9ca69f72c2 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1001,6 +1001,40 @@ const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[] = {
 const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size =
 			sizeof(uclogic_rdesc_ugee_v2_frame_dial_template_arr);
 
+/* Fixed report descriptor template for UGEE v2 frame reports (mouse) */
+const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x02,         /*  Usage (Mouse),                          */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, 0x01,         /*      Report ID (1),                      */
+	0x05, 0x01,         /*      Usage Page (Pointer),               */
+	0xA0,               /*      Collection (Physical),              */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x05, 0x09,         /*          Usage Page (Button),            */
+	0x19, 0x01,         /*          Usage Minimum (01h),            */
+	0x29, 0x02,         /*          Usage Maximum (02h),            */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x06,         /*          Report Count (6),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x01,         /*          Usage Page (Generic Desktop),   */
+	0x09, 0x30,         /*          Usage (X),                      */
+	0x09, 0x31,         /*          Usage (Y),                      */
+	0x75, 0x10,         /*          Report Size (16),               */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x16, 0x00, 0x80,   /*          Logical Minimum (-32768),       */
+	0x26, 0xFF, 0x7F,   /*          Logical Maximum (32767),        */
+	0x81, 0x06,         /*          Input (Variable, Relative),     */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0xC0,               /*      End Collection,                     */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_frame_mouse_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 1a2d658bad3a..0502a0656496 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -173,6 +173,10 @@ extern const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size;
 extern const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size;
 
+/* Fixed report descriptor template for UGEE v2 frame reports (mouse) */
+extern const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

