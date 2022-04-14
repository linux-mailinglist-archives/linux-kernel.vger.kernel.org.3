Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E65500BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiDNLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiDNLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:12:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B078118A;
        Thu, 14 Apr 2022 04:09:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso5746941wml.1;
        Thu, 14 Apr 2022 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VPdWlC5lQxtIDojBOmXDijOL+J6H2I/qPY01pdxxCU=;
        b=B9EZNEvWfnSgYiKm2pYkH+B0GkyXDmOadMYvoufkbt/WGAPIM0IgQkzD7xgL7m9qQ1
         OboLsB0Q/xkqEh+11ca+T98KRJlxkj5WJgQIUUhm56t2M1uGhBFpI7/te4KAHJrUplSg
         MO09jx8wm3AsysS5qtxa3wV84JcD+rsGe8/Zs86FwAnPjNukXjRiSwnv6SnU4uzoaChK
         3l+d1kl0+JS4zH7LwhKGTiGtdmiAWfiM4ObLo5U5nOF2YTWl0LaC6obooPc41ErFJNZt
         C8lReJa86lcBRZo/J6O6IwXUwuwVHjrxFK+bU2vNTaROPBRjdq2lFhxDBkwOGJ6/NAVS
         pg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VPdWlC5lQxtIDojBOmXDijOL+J6H2I/qPY01pdxxCU=;
        b=ZlBUyDhJ5+eJEYnficI9nZ7/S77vbtyLsRDPnU76JFDq4AC2YKonL671SI71S96FFP
         quKSVZQ3f+Yf3rvNjpoQ/ThKw9DrTQbtat0x8kSjbPwIos03ArlDFnIoo3AiOnqLVx0K
         y8a5aP7RHufPuxmVVlrXQb6Y4XOEpCDP1i7G0rLicSNuVbUPSGzGvpX3ed0YY/MWVauM
         Gk1qEMFEDTlaqVPWfdH/cgI6URRdzIm3mbtz6R4aTtlzSfc/B45QfSm/l2SOa7MkO19x
         rfvj3hsv+8eMbTHlmu7DfsnFyeJWmZiYy9TIBzkyhQoocN24845rE0RjL/7u4LPAwBB1
         LJvA==
X-Gm-Message-State: AOAM5333woa4cHuOlJM88yw/cl1iqD1q6A5GTLOyrIIAxevVpbkXR0DY
        T1oS1O24SJIH6QAH+a7oLbE=
X-Google-Smtp-Source: ABdhPJz9OECA6Jnk5BjeyoGYro/YlaFuri49rE99Elu+5ph4M5m0IuO81LKNi5YctfA3hn3zGZAlOg==
X-Received: by 2002:a05:600c:4ecb:b0:38e:d223:b0b4 with SMTP id g11-20020a05600c4ecb00b0038ed223b0b4mr2623518wmq.92.1649934596513;
        Thu, 14 Apr 2022 04:09:56 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm1694504wri.35.2022.04.14.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:09:56 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 4/4] HID: uclogic: Add support for Huion Q620M
Date:   Thu, 14 Apr 2022 13:09:36 +0200
Message-Id: <20220414110936.146378-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414110936.146378-1-jose.exposito89@gmail.com>
References: <20220414110936.146378-1-jose.exposito89@gmail.com>
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

From: Nikolai Kondrashov <spbnick@gmail.com>

The Huion Q620M tablet needs a v2 frame dial.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 20 +++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 50 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  | 10 +++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3ac45e7572a0..09c332c6a412 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -777,6 +777,23 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			p.frame_list[1].touch_ring_max = 12;
 			p.frame_list[1].touch_ring_flip_at = 6;
 
+			/* Create v2 frame dial parameters */
+			rc = uclogic_params_frame_init_with_desc(
+					&p.frame_list[2],
+					uclogic_rdesc_v2_frame_dial_arr,
+					uclogic_rdesc_v2_frame_dial_size,
+					UCLOGIC_RDESC_V2_FRAME_DIAL_ID);
+			if (rc != 0) {
+				hid_err(hdev,
+					"failed creating v2 frame dial parameters: %d\n",
+					rc);
+				goto cleanup;
+			}
+			p.frame_list[2].suffix = "Dial";
+			p.frame_list[2].dev_id_byte =
+				UCLOGIC_RDESC_V2_FRAME_DIAL_DEV_ID_BYTE;
+			p.frame_list[2].bitmap_dial_byte = 5;
+
 			/*
 			 * Link button and touch ring subreports from pen
 			 * reports
@@ -787,6 +804,9 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			p.pen.subreport_list[1].value = 0xf0;
 			p.pen.subreport_list[1].id =
 				UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID;
+			p.pen.subreport_list[2].value = 0xf1;
+			p.pen.subreport_list[2].id =
+				UCLOGIC_RDESC_V2_FRAME_DIAL_ID;
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index d64b607dce5d..dd792160fe7e 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -761,6 +761,56 @@ const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[] = {
 const size_t uclogic_rdesc_v2_frame_touch_ring_size =
 			sizeof(uclogic_rdesc_v2_frame_touch_ring_arr);
 
+/* Fixed report descriptor for (tweaked) v2 frame dial reports */
+const __u8 uclogic_rdesc_v2_frame_dial_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x07,         /*  Usage (Keypad),                     */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, UCLOGIC_RDESC_V2_FRAME_DIAL_ID,
+			    /*      Report ID (DIAL_ID),            */
+	0x14,               /*      Logical Minimum (0),            */
+	0x05, 0x0D,         /*      Usage Page (Digitizer),         */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
+	0xA0,               /*      Collection (Physical),          */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x05, 0x09,         /*          Usage Page (Button),        */
+	0x09, 0x01,         /*          Usage (01h),                */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x06,         /*          Report Count (6),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x05, 0x0D,         /*          Usage Page (Digitizer),     */
+	0x0A, 0xFF, 0xFF,   /*          Usage (FFFFh),              */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x38,         /*          Usage (Wheel),              */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x15, 0xFF,         /*          Logical Minimum (-1),       */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x81, 0x06,         /*          Input (Variable, Relative), */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x2E,         /*          Report Count (46),          */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+const size_t uclogic_rdesc_v2_frame_dial_size =
+			sizeof(uclogic_rdesc_v2_frame_dial_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index f15a9d8a946b..2ab6b7d5f5af 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -141,6 +141,16 @@ extern const size_t uclogic_rdesc_v2_frame_touch_ring_size;
 /* Device ID byte offset in v2 frame touch ring reports */
 #define UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_DEV_ID_BYTE	0x4
 
+/* Report ID for tweaked v2 frame dial reports */
+#define UCLOGIC_RDESC_V2_FRAME_DIAL_ID 0xf9
+
+/* Fixed report descriptor for (tweaked) v2 frame dial reports */
+extern const __u8 uclogic_rdesc_v2_frame_dial_arr[];
+extern const size_t uclogic_rdesc_v2_frame_dial_size;
+
+/* Device ID byte offset in v2 frame dial reports */
+#define UCLOGIC_RDESC_V2_FRAME_DIAL_DEV_ID_BYTE	0x4
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

