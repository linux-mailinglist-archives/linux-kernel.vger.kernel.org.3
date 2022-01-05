Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0383F48573E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiAER30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiAER3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E405C061245;
        Wed,  5 Jan 2022 09:29:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so3710647wme.4;
        Wed, 05 Jan 2022 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76j/vBihwnF+1b+6Vi7Z9v34SJGyorcIi5qbktRYn7M=;
        b=PAiO7xpn9cR7fCzoh02uoNu36k52dnHGWus+w9e1kg0BKjaLo7XMfT7m5jv7Vo0yOi
         bCZIMCWQ5KKv4HuNuI/jTaI3jt/C2eKTuvh2YnpM1sO2FAI/LIMCA2S3pWHU6DkJlv6W
         3vLph53A9mVICKhb5zw3IA9806wY+zORKlPH0Tx4xP+W8QbTWCa/CvFnmiGljjKrtivF
         NBmrHTPVinfq2oZKPDi6kT3et5vq62LiEcV5Ty82Nn627VgiVbLTvTKHwz7+5Zh4a6f+
         vsSY3db0oZW3ufUAaYjFl3qxL7MLKdY8TyKvaEL+xPkCH05VaCyBDQYC7//lZChVXx8+
         fAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76j/vBihwnF+1b+6Vi7Z9v34SJGyorcIi5qbktRYn7M=;
        b=7lFdVKHGpgydTeg1QVkLq6X2YUmtJKQ8eyqkTLjAJyJXAvZ2OMVTe0XmwoLxOQ4nEQ
         HNaf92gp5DqDAq5XeID/iKblQEpyzk5zgsw6waHXWQ5E9Hu5/Ann/3GvLxJq//f7hcex
         +8OmDn9G8qmt6NQiw22wxrbzNnnHECn/JS5tI6yhMHT3XBnmaIKwZicm0Zc4znOqz9gR
         xlws2EM8cd+jAdcq3/kRx+Te1Y9A1lLLFAe6Ia8iPxon4dlvlcOyXz0u9t28h13z8OY0
         d23ylfdSNh01UYOLPy8uU/lC+a+CaPPJB/kIH+rzm5MveG4wsARybRvEclKfQXLjwoY2
         OPaQ==
X-Gm-Message-State: AOAM533cl8n1NnVhBxoSNq46UOrlyucCF8AJveJn/NPUtMvNHgIfDdNl
        eL2mhYK3FBHA0UX4tPMjqYY=
X-Google-Smtp-Source: ABdhPJxpJk51idyGNT2hPNI07YNoQmi5SEQ2ysX1wo3u1Q7fD5HPriWyw04A1WGVm7cTWAzToPKomA==
X-Received: by 2002:a1c:a747:: with SMTP id q68mr2491100wme.98.1641403763651;
        Wed, 05 Jan 2022 09:29:23 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g6sm43071442wri.67.2022.01.05.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:29:23 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/4] HID: hid-uclogic-params: Invalid parameter check in uclogic_params_init
Date:   Wed,  5 Jan 2022 18:29:12 +0100
Message-Id: <20220105172915.131091-2-jose.exposito89@gmail.com>
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
Addresses-Coverity-ID: 1443831 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index adff1bd68d9f..3c10b858cf74 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -834,10 +834,10 @@ int uclogic_params_init(struct uclogic_params *params,
 			struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
-	__u8  bNumInterfaces = udev->config->desc.bNumInterfaces;
-	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
-	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_device *udev;
+	__u8  bNumInterfaces;
+	struct usb_interface *iface;
+	__u8 bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
@@ -848,6 +848,11 @@ int uclogic_params_init(struct uclogic_params *params,
 		goto cleanup;
 	}
 
+	udev = hid_to_usb_dev(hdev);
+	bNumInterfaces = udev->config->desc.bNumInterfaces;
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
 	/*
 	 * Set replacement report descriptor if the original matches the
 	 * specified size. Otherwise keep interface unchanged.
-- 
2.25.1

