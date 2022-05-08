Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60151EECE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiEHQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiEHQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB96E0EC;
        Sun,  8 May 2022 09:02:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so16351282wrc.13;
        Sun, 08 May 2022 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUjA3hxYaMj4HNAIAW1BXRoi3/8SbsyN1ZHWbZHr2UU=;
        b=RNz0p96FOH9tfqyHM77KVvxOj+onZhhCgCkxuvtSEfiiclcqUQqSB9DPIGKVCrG4rh
         yUhXWKCXZS1HwOukhoAae2/7C73/6CHoCnBF572JbSPhXUfFUk7ubZ1n0srhNjPzC7Kn
         5Lp2yjiLIm3hye890xt3u3suNQnRrqUM8Ns+PJF5UfnPsX4Jy/tCC01eKTkjZlumtdb1
         fW09uNQv7jGrY51aiANm4xOvF/CiMQZu2bia8xuLbl6+f49p6/rT64AxKSSCY7cVdqri
         d3dETLyc5C3MGVXCzPDbx+Jjv1empm4F6z4a/ZMsFEYtr10mG/is58lybtXtunxxmg1R
         Be3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUjA3hxYaMj4HNAIAW1BXRoi3/8SbsyN1ZHWbZHr2UU=;
        b=bs8ywpizIV6W9NaTKL9gw9fmf3MrQNdjSjdxIgC6w7xEsVcys7Zjpj6J5ZGN7TD0T1
         adp7h1m2rh8uYRvenMLT/LuwytEppueO0GOJoiIaL4yCk6ocOd9AGAdqwndj66LreNrG
         E13+v61hTSA7G6RHuvHp1j/bMrHINkPo7wyF6YqC6/5DbEle1YgiFpdVW/8nIj20dvua
         31qmXONVfjNd7iD/05cXcX8xRJfCs77L7cNWmlellyjUKBHn+LLTINt15u162tYYuxfe
         uV5KYaJCuS4b0QVSKFIDwIEe8HHxFB4zw7J0n2Zmu+9B3A3pMiChL7iUYYBFlYQvWblN
         zXYA==
X-Gm-Message-State: AOAM533G0w4oPqn1Ru3aL0SIHSVAe4lbMoI5kyT3jDeB0iW25V2bcMIl
        QIC9BjoQLOe2Y5o7jOsSRn4=
X-Google-Smtp-Source: ABdhPJyE4xwqMM0Of3uC+0tpCvYpCf89LY9vcRU26ulo4CKdUsNmsift3gRmI9oicGugThdMpiilAQ==
X-Received: by 2002:a5d:594c:0:b0:20a:dff1:6545 with SMTP id e12-20020a5d594c000000b0020adff16545mr10266670wri.211.1652025738799;
        Sun, 08 May 2022 09:02:18 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:18 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        Roman Romanenko <romu4444@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 6/7] HID: uclogic: Add pen support for XP-PEN Star 06
Date:   Sun,  8 May 2022 18:01:45 +0200
Message-Id: <20220508160146.13004-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
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

From: Roman Romanenko <romu4444@gmail.com>

Similar to other UGEE pens, but the IDs were missing.

Signed-off-by: Roman Romanenko <romu4444@gmail.com>
Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index cef51e93e220..2cf09328566a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1260,6 +1260,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G540	0x0075
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640	0x0094
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
 #define USB_DEVICE_ID_UGEE_TABLET_RAINBOW_CV720	0x0055
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index c4ab94d58a0f..c0fe66e50c58 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -521,6 +521,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 7db63bb77158..db838f16282d 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1195,6 +1195,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_G540):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_G640):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_TABLET_RAINBOW_CV720):
 		/* If this is the pen interface */
-- 
2.25.1

