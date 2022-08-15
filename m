Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD725930C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiHOOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiHOOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB0248C0;
        Mon, 15 Aug 2022 07:30:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so6158773wrn.4;
        Mon, 15 Aug 2022 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ap7GqyMuCh9a8meEeM9i/c24fMUejNJyKTIvsoAZZXI=;
        b=U83mxDNAW6l9ChGVGk8tQfNuo5k7h8sDbglfw/HLxUemAfXKUVmrKmib7YHCCKC2vJ
         F8FD65QPktZ7RrUgViPYJNiKLVPWX/lU0mkeQ5gtgrzHdywpRr7t2Qc43mukCBMFVlL1
         h3t4vuMTWoO1GOFkjJD1UWmcAFbShjJyfIMgueEgz36/i9Niw8zgv4JqndyX/Lus1Tjo
         8R9Cpwwuwv/VDqe+0oSpbitWOx2mzdbt2Ev1OhJ0dULIFjBBGmSrzNDa+BgldsySbmEn
         tD4/pFOHN60eqcMpvJBFXE9uMcaGxZfOJT7CzgCqFisT0iFFezaACYlNK83+1j0LmZps
         ea0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ap7GqyMuCh9a8meEeM9i/c24fMUejNJyKTIvsoAZZXI=;
        b=Wq6MWg6kT4Wvk47rtSy8BrGSkU7NvzIq9i7yP8jKo2WAifhZuf+14BoldP8K3BHSiU
         ATLxnASsfbRDJmzjToGiewRDrNK/DUGOS2I6lkZrintBPpxlJkUS2BAu5DLNzhdcE/GL
         uHlQZ956Z5vDnCpDNHuEErOXexdY6tP9W/UEi01vbDCivv2uftnZx3Q0fNXzadVTzt8U
         xajKUV4zLGkvYRBB86eV1ao9cDSZTAs5GIX4wVzn4DHNEEORJKfXtuby8dgmUNeeLwwa
         Gndi5G6sDsSXJjGXgBkSZh/7eHu6GneiOXUkCkz6QtPWbPaxDM6hrnHTeBeYKmkVahcU
         Vh9Q==
X-Gm-Message-State: ACgBeo3xZCAwOdzk2TdaQ4IrYF2WtbrtnMwNYfqbjLTqW4w3nS5Qk5rG
        ZBCJMfWHSw4sJhf7uzVL33A=
X-Google-Smtp-Source: AA6agR7l6TyW+I2EIFhFT9LI0PtAjjqt+xAqlAX0hpWGtlruBKqxMO+6WGpeiMz2hhHUNfr8C+mLkQ==
X-Received: by 2002:a5d:4201:0:b0:21d:7b63:1b43 with SMTP id n1-20020a5d4201000000b0021d7b631b43mr8566620wrq.225.1660573808884;
        Mon, 15 Aug 2022 07:30:08 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:08 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 6/8] HID: uclogic: Add support for UGEE v2 mouse frames
Date:   Mon, 15 Aug 2022 16:29:54 +0200
Message-Id: <20220815142956.19180-7-jose.exposito89@gmail.com>
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
index 950615f95abc..648abda13a73 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1189,6 +1189,28 @@ static int uclogic_params_ugee_v2_init_frame_dial(struct uclogic_params *p,
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
+	return rc;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1232,6 +1254,15 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	iface = to_usb_interface(hdev->dev.parent);
 	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
+	if (bInterfaceNumber == 0) {
+		rc = uclogic_params_ugee_v2_init_frame_mouse(&p);
+		if (rc)
+			goto cleanup;
+
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

