Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505FF4B1B36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiBKBZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:25:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiBKBZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:25:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10841120
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r19so13465163pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZuOJxErdx75B/XhX4U4+Jmre2nmp1Aql4lPGNRbh74=;
        b=VliQtmeNRreHnJ4KOoPLej8TJe2SSjJXrSBlQetG7lAR2mEZ1qBxoSCXlP4ZaqhHxo
         wSnGnSpczuEKkn4z17cjiXz23kUqrVr4yaaqMmpO6fhXtM9DknZnM0o11q7JKewOH2Nr
         W+l+YslgeGH+I71ZaRKNyrXDZ9vIeQRo+jufo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZuOJxErdx75B/XhX4U4+Jmre2nmp1Aql4lPGNRbh74=;
        b=ke7Ryp7GiGCFF3FJiA7uIqKbclt8J5Ukoq5iFeQ0oXk9+ckXq/qnYfY//XzmGLipaG
         SZGt0ZnU0OMKna7hB0nt+NXVFu2qeVQ/0CESMGMpVjvm7sZXXTZLsOU6a2zQ5HvoQv6F
         XjoPM6x9LkLbc3aX7iCzTy6bd7cuoxHILSzNhiip7bcUKhjU0nO5j3JNUdnOTB1UL0oT
         wnx829NPMDS/efviv6HolK+W2JC1VekFSZYdk/9+mUfVHk/q5UX9nNYXkWwnONYZRqv7
         9PxiFE92sWn0Zogk4EfahewlSm75sObLLIMyZ5RUgsyhiTbcK8NECAnuj+MXiBW/YhEi
         pg3g==
X-Gm-Message-State: AOAM531T0RyHaoN/NL80pRdJa7xBFskbKxTAscE12aaNBnaVXh8Ba+Et
        jJHV5+EPwO7/LUArxHBvcLxyBg==
X-Google-Smtp-Source: ABdhPJxjCv8q/G7jdRRU0IxR1TvXLuWiCtzk7gJfa7sfjOqZHLb9PlMAsIQDud5O/vpcFwX5pNnMmA==
X-Received: by 2002:a05:6a00:198a:: with SMTP id d10mr10300323pfl.2.1644542717195;
        Thu, 10 Feb 2022 17:25:17 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:fb9d:6747:c0b4:f7ee])
        by smtp.gmail.com with ESMTPSA id m13sm23260146pfh.197.2022.02.10.17.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:25:16 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 4/4] HID: google: modify HID device groups of eel
Date:   Thu, 10 Feb 2022 17:25:10 -0800
Message-Id: <20220211012510.1198155-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211012510.1198155-1-swboyd@chromium.org>
References: <20220211012510.1198155-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

