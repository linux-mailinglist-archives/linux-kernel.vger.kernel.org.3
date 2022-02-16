Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C64B9203
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiBPUAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:00:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiBPT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:59:53 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3E225D3C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x4so2820247plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKkiGODEySwn5Ud6cwmFKt9S5uiVPYEjk/1FwzY1D7M=;
        b=FbCQhqCgY7+53halAemFJqR+/yEcT2gQBP93JU9UC8PAh275Z04yeP2cnPk8Byycoa
         /6zwqH/8Dl7HBUIlAHe1l1LWGmjjWLR4OXWCNR8gwqRgFZXOvrZ0JahDSAUi2NXaAJf3
         UKiz/7cjikcMEKRvFhkHpKC42JAbLsbQvj5zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKkiGODEySwn5Ud6cwmFKt9S5uiVPYEjk/1FwzY1D7M=;
        b=JteN8Z3Lym1fw1sOTrcWH3pOdZgYhJFp4hR0jy/wHstSJf2epURMGkS8U9g57QBLLy
         9sMPb13uiUfl5xLCgUw8SA4T9w1GmAv6VX47el1euCxnlh5yWzgZa+ffOA/Jl2OJtwzG
         gy2kirWc6iEF8XqUhuKt6TUfaldcWcQYWyVqWFr8zO1+rJsCDi+zzYNLn3ly3yDcvcEy
         AEgQPTmuDaPw8xmV2D3tHbaA/RjCWsqAkqUh/mJ+6tA/lHH77xHcPSFMULCgpofNz/sY
         8vpj69N/S0eej3wD520+WvJhw6M658ztsc777PhunJdhPVpwN/9bACiwao/ydbRDV2bv
         tElw==
X-Gm-Message-State: AOAM533c6igDf+RrwCpe20m/8UCABEl2qPJNUee/NocNgNlFU9vwB5mo
        FEhe/Gg1nGlWT393cag2IKyqDqfWnAFMOA==
X-Google-Smtp-Source: ABdhPJwjYxlN7gSR+7kFrYETcwqEK3eVK6gnPbD8ydzhwRC3qOldpUKOhhtBXZcjj79BjVyZBXsn2w==
X-Received: by 2002:a17:902:b116:b0:14f:460d:bf42 with SMTP id q22-20020a170902b11600b0014f460dbf42mr4195532plr.108.1645041580606;
        Wed, 16 Feb 2022 11:59:40 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5f39:68a1:3c2b:3486])
        by smtp.gmail.com with ESMTPSA id u16sm6078840pgh.54.2022.02.16.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:59:40 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v4 4/4] HID: google: modify HID device groups of eel
Date:   Wed, 16 Feb 2022 11:59:01 -0800
Message-Id: <20220216195901.1326924-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220216195901.1326924-1-swboyd@chromium.org>
References: <20220216195901.1326924-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Tested-by: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
[swboyd@chromium.org: Expand on commit text]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index f8e6dccf6ed8..8c4881796a0c 100644
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

