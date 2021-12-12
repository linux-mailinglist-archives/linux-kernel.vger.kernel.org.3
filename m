Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92B7471C32
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhLLSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhLLSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:21:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEDC061714;
        Sun, 12 Dec 2021 10:21:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so23502571wrg.11;
        Sun, 12 Dec 2021 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZago/8ARatG3utm8XljXJChhKtj8LhL1AlnUCSInjU=;
        b=oZAylirafYKK8RvICQfZctbU2jbcKP7jE1IK3zvcQD07l6Eka47/G19DAak+kK9J60
         dQ2qkdb43EY8+MLmZZ9D+NQnuRcb7nLgxDHipMeUd51LXeppZU3RApP1yl3flxUzcT76
         9k453+kobLszaeOBBtC6pFNwX+f0toGd5dH+1MRddNfEVLoSSxbjl5fTKuQXdzlkT3Gb
         ODRYSztCFaKo/sxCVe47icLSh02ouQBZNXn8orKRlPe92mICNw7bYMeKeEGRjwribbpS
         OnQrTlsLhDU5WBXOAqAHXfdv2vLP70VFyGgSAMigUeuItWGUyc03hTrzfMPrOxw5LEbP
         7LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZago/8ARatG3utm8XljXJChhKtj8LhL1AlnUCSInjU=;
        b=LyTLvO/nnSBd8+KFvL9fINpTNwc/7jiabTuNpYxdaosrxU9naf/EB41EHIewUTq37O
         0BupvjVPSbARQfnInGQr1xv6ivmg9ENXaNMCQktPTcHTUSZtQfhVEYrj0z6JXkIAaT3U
         mQpXlbEjAxAA6uQNv8bxLSwSwd0SgveLOkyMvrZnBXs6LGUEBjYet574I7QR/rgazcVW
         zf4ToW3dlbxxkRq+FbVaCCGjS3U4oCSqk1pvVLrjMTvJyd2UtZgksjYzE4TDk2eGoHAo
         q0Qdr+SMEhKhijtAsQao696dyqI7WFh0Tz4y0cooChBCke7DkFzp3/y1Gq8tu9VLhPPP
         QP7Q==
X-Gm-Message-State: AOAM531JmrnBN96gAOt1zXFkBeeeCZqCsOiryRrHz2PM870c/HQs9rqp
        fHo2DiXhbnj8ji96ra2WCi8=
X-Google-Smtp-Source: ABdhPJwMjKkwPTNI41IsYb7+zTyJZwy/8w2BdNLoik9630y4vfhzxSTOBKAsomAm3vgYUo0+wURK1g==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr11844883wru.665.1639333266389;
        Sun, 12 Dec 2021 10:21:06 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id r62sm4667421wmr.35.2021.12.12.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:21:06 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/2] HID: magicmouse: set device name when it has been personalized
Date:   Sun, 12 Dec 2021 19:20:59 +0100
Message-Id: <20211212182100.40968-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212182100.40968-1-jose.exposito89@gmail.com>
References: <20211212182100.40968-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Apple Magic Trackpad 2 has been connected to a Mac, the name
is automatically personalized showing its owner name. For example:
"José Expósito's Trackpad".

When connected through Bluetooth, the personalized name is reported,
however, when connected through USB the generic name is reported.

Set the device name correctly to ensure the same driver settings are
loaded, whether connected via Bluetooth or USB.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d7687ce70614..e650ade15a7f 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -538,10 +538,18 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 			__set_bit(REL_HWHEEL_HI_RES, input->relbit);
 		}
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
-		/* setting the device name to ensure the same driver settings
-		 * get loaded, whether connected through bluetooth or USB
+		/* If the trackpad has been connected to a Mac, the name is
+		 * automatically personalized, e.g., "José Expósito's Trackpad".
+		 * When connected through Bluetooth, the personalized name is
+		 * reported, however, when connected through USB the generic
+		 * name is reported.
+		 * Set the device name to ensure the same driver settings get
+		 * loaded, whether connected through bluetooth or USB.
 		 */
-		input->name = "Apple Inc. Magic Trackpad 2";
+		if (hdev->vendor == BT_VENDOR_ID_APPLE)
+			input->name = "Apple Inc. Magic Trackpad 2";
+		else /* USB_VENDOR_ID_APPLE */
+			input->name = hdev->name;
 
 		__clear_bit(EV_MSC, input->evbit);
 		__clear_bit(BTN_0, input->keybit);
-- 
2.25.1

