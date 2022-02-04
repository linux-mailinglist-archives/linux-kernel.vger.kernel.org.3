Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92B4AA118
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiBDUUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiBDUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:20:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD4CC061741
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:20:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso141319pjt.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZuOJxErdx75B/XhX4U4+Jmre2nmp1Aql4lPGNRbh74=;
        b=m44UmiZNIzXcaNlxVsUNeCt11Rnd6XDmmWnZlPfuePWHe9i4X2OKyxylOLPFaVeQTQ
         GVKU2pFVrIGIvBnBq/JmRwCNG3tLeiH0wvEJeRKjX4IWkVuGwOxw55Lewyp4+Wp/85SP
         RyoB4r9/7gS1YxT0S3SlmLN9Iqve51rnPI91o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZuOJxErdx75B/XhX4U4+Jmre2nmp1Aql4lPGNRbh74=;
        b=BXfwaSBYNALoYKta2yMJftBfQNgFVcTxzlDVFSgtfpEpT08QH9N0r2UTqmUYG3STDT
         j5VvUeBaacBz5TSrDX9Tz8eLnhgFhRR3w4LW7rWDKkqb4nmcAZIBB+zyS7Ed7NvthQSZ
         uc4xpTpsyZrwSFFuobxHAaN+FR4a7u3K9Rng507wAs6S8w/bs9saFGJNGAg3dTMOkupF
         aXS/oA3kS+DmiI+0iarH5dTZuLe5CPfDgV+U7tDVJEuDmLVU6cbVWAIKGnSLsoaiZT3n
         otsIJ9IRRKamG1mXSRKKqXNjD8/b7AqJYt1cP9fxB7uIuNYHOCjROcgxAxpi3n0LhlBs
         JhIw==
X-Gm-Message-State: AOAM530LW11sCF0GTClCmq5nRkhlbSZeZX3IiVHRObCKXab/VsM5SNQ4
        k0LAY15V/w2uhw642mEZuh6Ouw==
X-Google-Smtp-Source: ABdhPJxQ8ZCRvr4IQgSkocLn59rOK1y0Ck/eM+WqyNBRC6bb6AVM4Yk+ZuuKu16eRAdso434rpNETg==
X-Received: by 2002:a17:902:c155:: with SMTP id 21mr1708641plj.31.1644006028610;
        Fri, 04 Feb 2022 12:20:28 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ba2:dd59:3b59:18bc])
        by smtp.gmail.com with ESMTPSA id q17sm3385561pfk.108.2022.02.04.12.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:20:28 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5/5] HID: google: modify HID device groups of eel
Date:   Fri,  4 Feb 2022 12:20:21 -0800
Message-Id: <20220204202021.895426-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204202021.895426-1-swboyd@chromium.org>
References: <20220204202021.895426-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>

If HID_GROUP of eel is set to HID_GROUP_GENERIC, Whiskers Tablet Mode
Switch of eel hammer will not be detected by system because the
hid-vivaldi driver probes the device. When it is set to
HID_GROUP_VIVALDI, system will detect Whiskers Tablet Mode Switch
successfully and also support the vivaldi keyboard layout.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
[swboyd@chromium.org: Expand on commit text]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index e3dd26ddbd43..8ed75bb0878f 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -636,7 +636,7 @@ static void hammer_remove(struct hid_device *hdev)
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+	{ HID_DEVICE(BUS_USB, HID_GROUP_VIVALDI,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
-- 
https://chromeos.dev

