Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBFB56D0A0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGJRvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGJRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:51:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7210567;
        Sun, 10 Jul 2022 10:51:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so1883816wmn.4;
        Sun, 10 Jul 2022 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LM0lgQs2BA1X3p/kw499UJ/iLAvQnGCmtoBS9FDHPxY=;
        b=lo2l0PgvxQxbYd2mQgwa2NkpndJIo7EKOegUz1Xmt0owzzlJ/olqe2krrVdtXGJ3BS
         Hit/wHtcKJdVen6CXKniGMGi3jGgx+Vge7kVpkaBVpyBIpMz8iee0Sdp3hKmG7lAFXbm
         GWFwNhf5rR2RyTrAymXs0/yue0liGAEUFM/oirrTI2h0ykLkpf4pbaq5zf7wTrbwSOxz
         GNSAnT1iY/y8RJLQlMJ+3oVzEWoxd/WXRQkEaNVjhI3BCobthx3wnXN+nOWnncltSWIA
         74VH16xrMMfCvqcFHVmS8YfHjNvKZ/4akINzVgFA0KrqY4hJr1pvZbyHWiUkeNuymBZs
         WCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LM0lgQs2BA1X3p/kw499UJ/iLAvQnGCmtoBS9FDHPxY=;
        b=XIXN5U+MyHIfbChtk3zy6piTMqJUURoShi3stnEXKvqrlaNaHC36u31nNxb9I3T/dC
         K8gQi0Ai9c33s2co+RKMV5DSI9l3LTrqkEUOyL9HgJgjVoJOdECQgMgKeiXui1r5fUPQ
         qCc9ZYWfk5kNRyG68grkR2XxEh+tXUuSznOwd3Y7lQSVcwzdV2zMEAjkf7XhVMoWzXW/
         RlpJREuw77vqP3gtLDced8tWoAnJj5pYX4gdlLUw9KK/Z90v/vUxaFEEPYK6O31c3iGm
         TbR+nrpXksTruomM4yhL4uuX3QlfGbP4VLNjt0+5PEr4EmGTBjAepyst+1J1KmzYpoh1
         OMmA==
X-Gm-Message-State: AJIora8NRGOQRCudDcaYCPZ5jRETukNNrnlTjlNre5UqRd+23gvIaJrP
        CdHvoM5707K5dnCOEiQdVq4=
X-Google-Smtp-Source: AGRyM1vRfps/UepazEIQj1F2fk4dQsmKmLb/bm8B2bn00oAhsyxuQDmC8MfSrw0o5JfDzWMUiHl2JA==
X-Received: by 2002:a05:600c:1e8e:b0:3a2:c1b4:922c with SMTP id be14-20020a05600c1e8e00b003a2c1b4922cmr11723550wmb.24.1657475473560;
        Sun, 10 Jul 2022 10:51:13 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id l23-20020a1ced17000000b003a03ae64f57sm4523495wmh.8.2022.07.10.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:51:13 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 7/7] HID: uclogic: Add support for XP-PEN Deco Pro S
Date:   Sun, 10 Jul 2022 19:50:43 +0200
Message-Id: <20220710175043.192901-8-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710175043.192901-1-jose.exposito89@gmail.com>
References: <20220710175043.192901-1-jose.exposito89@gmail.com>
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

