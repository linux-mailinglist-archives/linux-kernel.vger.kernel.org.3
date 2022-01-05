Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8EB485742
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiAER3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiAER33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E03CC061245;
        Wed,  5 Jan 2022 09:29:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so84495851wrd.2;
        Wed, 05 Jan 2022 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EwC0zb6TsDRNr+wrSu8k3dQNGNsYgW/0Ss/SRNaNxkI=;
        b=beLHVYce21VNdAuj3elbE3gbFn4pMqPAHJW8M2rosz4scHjk7UjfvHD5jQ1F93Hu4l
         j06wLMd08kIPtTe1QpVIWMxHnFsznNRvg2bdgYoxylrmaiexGIlQPfBi53kS6DEgeP5L
         SawgGXWPtF8LRHLch0HwxOjFBku6v2s2dbycrBkkCtGhbuate1tFWi4Y3WW1eefafNXd
         hceRZlZ2wosPe2Kson/555K3xwdF2wVXV2QbN9Cs3oDAll9b3e8PrErz0kkd8arAS4AM
         GM2sbqPcZOfenqviqNYtsfWDzZv/RRDRyraaB/AY1hkABJzVwCsAjclAByr6TEw+amcd
         M/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwC0zb6TsDRNr+wrSu8k3dQNGNsYgW/0Ss/SRNaNxkI=;
        b=mCq7OiK/0FdYUlGF/066FVZGbKyDq3oTWr7q184U4XPAH00bwvl2DbUkzLemtuxPLb
         LyZeWEylHGFU54eE+qd7nL6NDiAS8P1SsvLZORfKwVLoG9nsuMxQnvb+NGEZ8HrdgsS8
         Fbui71PN6byYM/xxW2eYOAKhwR6usMA2srDXkToth9Aah+w09Ygr7lW7+i9Q2Vp+8A/H
         dXFAKaoGFV1n+Kv035Te6mwYxwEEkKV1WOJX8GUL/MezqGTes5H2vCVF0XvBrRHfOzku
         Zp4islYpMZcQw0x/5vr9JYfQT8j9TBCToVk/JTBp+QdC4Hh721GOD7vGapoURCSHxb9w
         AVKw==
X-Gm-Message-State: AOAM533JslmdeQ6ClGj4D3QyfVtIO0y6RAofDoCadfqQqK7aewu+hMFg
        rZerIs6coqRinYkX6e3DGvk=
X-Google-Smtp-Source: ABdhPJzVm7MRHTpXf4ZhzddbnhGyfGlLquu07CeyORjwDyd85erInZtVu+WdWELaLPnSXTsxutkJNA==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr1552936wrx.600.1641403767729;
        Wed, 05 Jan 2022 09:29:27 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g6sm43071442wri.67.2022.01.05.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:29:27 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/4] HID: hid-uclogic-params: Invalid parameter check in uclogic_params_huion_init
Date:   Wed,  5 Jan 2022 18:29:14 +0100
Message-Id: <20220105172915.131091-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105172915.131091-1-jose.exposito89@gmail.com>
References: <20220105172915.131091-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on its input parameters, however, the
hdev parameter is used before the check.

Initialize the stack variables after checking the input parameters to
avoid a possible NULL pointer dereference.

Fixes: 9614219e9310e ("HID: uclogic: Extract tablet parameter discovery into a module")
Addresses-Coverity-ID: 1443804 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3a83e2c39b4f..4136837e4d15 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -709,9 +709,9 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				     struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
-	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
-	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+	__u8 bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
@@ -725,6 +725,10 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		goto cleanup;
 	}
 
+	udev = hid_to_usb_dev(hdev);
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
 	/* If it's not a pen interface */
 	if (bInterfaceNumber != 0) {
 		/* TODO: Consider marking the interface invalid */
-- 
2.25.1

