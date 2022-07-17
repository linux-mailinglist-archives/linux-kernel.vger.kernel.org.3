Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67675776BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiGQOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGQOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F32DEF;
        Sun, 17 Jul 2022 07:43:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f2so13515378wrr.6;
        Sun, 17 Jul 2022 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LM0lgQs2BA1X3p/kw499UJ/iLAvQnGCmtoBS9FDHPxY=;
        b=cFM43fkyj8iTvUYNU8VmF4oJsJWrobp09MEUk5vA8lZI/hzJP0m5zcufHDk2MbRt4z
         b/M84mcuJc27iitT4XDubfvPSApPZ8dm7Fn7h9LufZZDJcR+aAZ8AXENyqpZ5hb79QAL
         5fZ6OGXBgTBdqowdrFvRJRXo6QDrfS8VAbFzyzxbI7+u2h2eicPoXTb/ViWEM6KACUho
         tyqbI7acXfpihqgODtoT5zipuGCrZzhESRRpM8SyTi8+4C375BGqzIykLHK0c5qHmGH+
         yeAxQ21Rnusr8K0a5yIEOOogCXw0ORyI1Vgncq+CulYDyslA76awYn/yvXBAYsm6CYWk
         i62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LM0lgQs2BA1X3p/kw499UJ/iLAvQnGCmtoBS9FDHPxY=;
        b=62o4Fyjk8Nbkv4wk0li6IWp4IaeL7XcMSxushyguJEFqwkp54k7AoVtySS3sW0mKsX
         l/khR5A+HA8/bfS+B36n2ByAuqwwmQLTKC47P35VkJ4pbBPbwDY7YH0MiMj6+KC2Oopb
         TxEdKRwMwF+WwpJu0FHvX9KCSKElGdmfFaEn/+tzxSsI7R2+GrZoqO7WvKHLN9PN6PVY
         uEwT45yz/bgYdyFBm7MTR/jvvmrapl+8wZOu/yKglJB0habgpNmVN1fgsny5Ubiye33J
         HJ97ZS/SPWUMrCdTVfk/IFEsyGqr+KJjAGbuLvthFOWKRn7PFYDncc8XcVEbGqQyiJgA
         TZLg==
X-Gm-Message-State: AJIora+bMCK0BGntMmMnVC2EVRLCiSOocqwVXFTyPwi8n+Jv+NAxPwRA
        4d7RjYI8cARGwm0z4fRMT94nBiGh3yBMFw==
X-Google-Smtp-Source: AGRyM1ty2yw20Y/EIbS0zt0GrcOpmgcAT0co7Lbx8vjUa7EFqWpUV5YQtnnvvDFIHtSGjUG7QY7Ylw==
X-Received: by 2002:adf:f1d1:0:b0:21d:7f88:d638 with SMTP id z17-20020adff1d1000000b0021d7f88d638mr19545964wro.586.1658069022975;
        Sun, 17 Jul 2022 07:43:42 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm8432001wrp.25.2022.07.17.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:43:42 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 7/7] HID: uclogic: Add support for XP-PEN Deco Pro S
Date:   Sun, 17 Jul 2022 16:43:33 +0200
Message-Id: <20220717144333.251190-8-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220717144333.251190-1-jose.exposito89@gmail.com>
References: <20220717144333.251190-1-jose.exposito89@gmail.com>
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

The XP-PEN Deco Pro S is a UGEE v2 device with a frame with 8 buttons,
a bitmap dial and a mouse. Its pen has 2 buttons, supports tilt and
pressure.

All the pieces to support it are already in place. Add its ID in order
to support the device.

The required Wireshark traces were captured by Jouke Witteveen.
For more information check [1].

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/738  [1]
Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 139910034c17..ee6d27a5dd1c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1279,6 +1279,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 47a17375c7fc..6fcdb141acec 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -523,6 +523,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
 	{ }
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index f25c483b794b..2407e927d1bf 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1583,6 +1583,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		break;
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S):
 		rc = uclogic_params_ugee_v2_init(&p, hdev);
 		if (rc != 0)
 			goto cleanup;
-- 
2.25.1

