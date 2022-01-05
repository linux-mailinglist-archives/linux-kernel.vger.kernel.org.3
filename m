Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6A485745
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbiAER3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbiAER31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F822C061245;
        Wed,  5 Jan 2022 09:29:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o3so26318392wrh.10;
        Wed, 05 Jan 2022 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mislRvWvSm9MQvo2DuLYAbpGhpBV7rP9idLOw8BlRh8=;
        b=YjLV5zr+sk+iKrzT+BMdnFUDzjG1220eB/Gwlw3ZqLLy29PS2ZqGUzKAA1C5Koh5FD
         55sY3m3A2mMh7oIm+0xGml8Yf5AJ2tv2OLvovLmMDDJL0YIBKkekpJvV5Cpqzsl1JbSh
         +okK/xrORSlJap7SRWIGLCQO0WQiC7/y7tt6WQOPSKGsLSATZpZWo0BYdFoMHvRy+GW1
         VkqJccxoukFnj6KTV9osNdiEJBse8kJ7fJB+CldKLTspO8bhJPyu8RkuDvwsqBeQskjd
         WByu2oT7U3kLJa1bIl4XW+PRFWNwGsq7q3dJhM1e6/2enpF/8x6s01etN43jOGQWeHro
         Ohqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mislRvWvSm9MQvo2DuLYAbpGhpBV7rP9idLOw8BlRh8=;
        b=CE+ZkOfyqlItLnH3Y1EQ/tCFZ4JkMIlm81D9Rfz/Nmh/Mz4BIrNSqsr+vh3WOBH8/b
         e7SC4Pt/nTjw/6ZFdVShVvmba0W0qqKVIPQj8QQX0qttrcqpGH8CKMNKxLH1Q62uBFIi
         qLGpGhHKlfeFE1yqNfKzG/72ijzlg8wQwlgxs39EhKbQ2+A/RO1/PmifpdXjhpqLT/cm
         qrvW5Ze4u5LlWKC8JwdWlhgrAPlNrO1leFxej266vpUY8OjLTVvgp57hxTR4/OjRKER6
         6srrpR2RNgdDZ+ruLnWHwfyF7heBayvAcXA4EX56U7UuSWbgQphp4ouKjp3KWEDhfWL9
         hs9Q==
X-Gm-Message-State: AOAM530i4LCPqEOHBN9XMDZLCv61ArLfYOtb8jZwHEA39k1bHiet2C3B
        WtEzybELvdj355spn7+MHGQ=
X-Google-Smtp-Source: ABdhPJzY2mjFA2TSoOhJs8T8YWWy17fDTaWlr4dngcV+O5iSK3tVuF/LEU13Rv/7jzFrehQzhZ+83A==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr46391357wrp.687.1641403765287;
        Wed, 05 Jan 2022 09:29:25 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g6sm43071442wri.67.2022.01.05.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:29:24 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/4] HID: hid-uclogic-params: Invalid parameter check in uclogic_params_get_str_desc
Date:   Wed,  5 Jan 2022 18:29:13 +0100
Message-Id: <20220105172915.131091-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105172915.131091-1-jose.exposito89@gmail.com>
References: <20220105172915.131091-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on the hdev input parameters, however, it
is used before the check.

Initialize the udev variable after the sanity check to avoid a
possible NULL pointer dereference.

Fixes: 9614219e9310e ("HID: uclogic: Extract tablet parameter discovery into a module")
Addresses-Coverity-ID: 1443827 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3c10b858cf74..3a83e2c39b4f 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -66,7 +66,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 					__u8 idx, size_t len)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
+	struct usb_device *udev;
 	__u8 *buf = NULL;
 
 	/* Check arguments */
@@ -75,6 +75,8 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 		goto cleanup;
 	}
 
+	udev = hid_to_usb_dev(hdev);
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
-- 
2.25.1

