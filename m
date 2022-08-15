Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F905930C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiHOOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiHOOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405323BE9;
        Mon, 15 Aug 2022 07:30:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so9308599wrp.0;
        Mon, 15 Aug 2022 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bRXt4bW44m9/UkTOv2HejE0QpMPchFfmA0YLq1fgjpk=;
        b=orG6YehBCcf6F/FyXIAUhX+NBrAuEgBIn63FFDCQI/a/xg8UbUa4BThx4Dy1y1Vqdg
         cZQ7MlTdsDUE8VeuUpAaRzJOwm+3K/XWpiQ9gDCE8/QY/6eyI0ZnZVVq7lXIxkpUuDCG
         liSCliT2Dv60f/ZcR8E+5+aaRTDZD3Xk2hoLdeBax3WgtKVSuA7PjBHhSwgaTMeZmOLr
         yuHmhMdWUaZZVo83xmVoVt/Zp8aKjlGkNZ+jQqX0OHvivq6slluBQBAU2Ge+YU3M6ICJ
         Np7fCzkhLgsnF0RE2PnNDS5eaqKlPAm2fxDhaxHCNSAb6cObvXU+qdXtFBbBjDsnt3qq
         ZhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bRXt4bW44m9/UkTOv2HejE0QpMPchFfmA0YLq1fgjpk=;
        b=2ivRczWhpiwWTd4ukkUq67/USqxDDOoQSuzh0KwjtGTr/QX4czOHQc2UEXSR/6fnY9
         gnct+1cJHuN0fc7/Kew8hO1iHRF38CbHh1PDKwH6xzm3xcBkivqUghPLCeDLg+HKKSQU
         JTgA6xp6ri3t0TavaaMQkNqpT3SAVzKWsF9C1Q3vAYoo/f+Q/aZp/itcxydMMep2VIq4
         2fjOTUuoYlgWVmK3IreDtPH2GzgiTWEjYfW+F1D9vq8xTveacmP0dVefstBJTeyNksnU
         SKHZoKUIObIYxVYJUW/KkQGKY8iVIV/0/7xWWOB0YA8tg/Bena0LtEayzohSHsQ/bC3C
         fegQ==
X-Gm-Message-State: ACgBeo3LW/DCBNKLKDYxm2jmYuho6YT43mACMyfpAbVoV+Cll5WnP6/T
        ydy7AsKP2ghTRQNs6n5hgZQ=
X-Google-Smtp-Source: AA6agR7bznPAIkBiJbUmrv8LNcombZBhfEcR2A5GH7DR2SdI51B80RrYlFizeUHKZN/q1tKWrq+/Cg==
X-Received: by 2002:a5d:5343:0:b0:220:6203:ed4a with SMTP id t3-20020a5d5343000000b002206203ed4amr8528635wrv.146.1660573809911;
        Mon, 15 Aug 2022 07:30:09 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:09 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 7/8] HID: uclogic: Add support for XP-PEN Deco Pro S
Date:   Mon, 15 Aug 2022 16:29:55 +0200
Message-Id: <20220815142956.19180-8-jose.exposito89@gmail.com>
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
index 0fb720a96399..ecf1468404b3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1280,6 +1280,7 @@
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
index 648abda13a73..60ed94981a55 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1582,6 +1582,8 @@ int uclogic_params_init(struct uclogic_params *params,
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

