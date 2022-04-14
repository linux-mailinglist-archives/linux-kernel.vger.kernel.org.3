Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F84500BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiDNLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbiDNLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:12:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380507EA37;
        Thu, 14 Apr 2022 04:09:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so2844388wmp.3;
        Thu, 14 Apr 2022 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCCZ1FY3Lpmshe9dS61q5VGkiGnsl0sutuD0GJvrltw=;
        b=b2dzbqWrC3V7gFDtlATpXR3PG9E39X4yfbHAhAxj+34FIomoflNtxXwAWDCbTr5gf7
         VoAMHXzONNQYmUa+5A78q0ZxzWn7Wp06r7ctdTEGZ1hnAlXQi0FlYmvLbVdKM9ShtnnQ
         xxuqnQN35jUW2gvAUgNnNTwecYMfJfw0wNJcsH8MNfcN568rYGy6Wq/XZCXvreFWDZM1
         2Nb8+gPGKFOajLcCGH2J4KTZCjR1d/JK+F2ErJrqHvz/60sy3gD9lg+gg3nDvnN2WLVR
         tftdq03luZAoW+NQFDEJ5wihoWidSEQuUJjeqMc+OhQUp2gBzW/CYKXaU+6YSwP9rVxO
         p2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCCZ1FY3Lpmshe9dS61q5VGkiGnsl0sutuD0GJvrltw=;
        b=S/zdwJBUOFa7i9Eg5nIfvBbolmYNY2G10BcWvzJ7FukBcPJZHT+hLZKDWTqn5kHnL7
         h1oL8RBRsRpFSNKQtwr0MVJoXvRjG+auPqpx32/QW2FfTV7XAHVlVYvoFk2jdbgfNbd4
         SrATH5k2fhMyfpGBdKvnV2xsDG8BM3s9gUUFYM0JoLeU7osYsgAmycZhAb9We4GtYPar
         EqXKGkin/GCgGvKoPAcsfjxeZAcSIB1fCYo5j9gf4erw9yO7FvF47Rm0bZbZQC5Ntrkm
         HamFsiz/sTl59reaMUfWFxDpMBgntc0zSohCn6SVQLWPOmSnYjtGW2Dn5RTfDeCXeblG
         m82A==
X-Gm-Message-State: AOAM530hn/+aFjnSfycCup1fuwUUTJSO7zfqIEfHJgftHFy1EjlywNus
        n5EpDbRYA33tUan/Wos/PhA=
X-Google-Smtp-Source: ABdhPJyPkXSWfn7dSmsQvRoMvYDuL9tPA1m5972MkMxkTuigrw2WPECmylLsB+jTLbG/1tKuFfuEcg==
X-Received: by 2002:a05:600c:4f0c:b0:38c:bdf5:2232 with SMTP id l12-20020a05600c4f0c00b0038cbdf52232mr3186323wmq.90.1649934594713;
        Thu, 14 Apr 2022 04:09:54 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b0020787751295sm1694504wri.35.2022.04.14.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:09:54 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 3/4] HID: uclogic: Add support for bitmap dials
Date:   Thu, 14 Apr 2022 13:09:35 +0200
Message-Id: <20220414110936.146378-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414110936.146378-1-jose.exposito89@gmail.com>
References: <20220414110936.146378-1-jose.exposito89@gmail.com>
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

From: Nikolai Kondrashov <spbnick@gmail.com>

A bitmap dial sends reports with a dedicated bit per direction: 1 means
clockwise rotation, 2 means counterclockwise, as opposed to the normal
1 and -1 values.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   |  6 ++++++
 drivers/hid/hid-uclogic-params.h | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 96f3fb8c492c..627f1d0c52f2 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -382,6 +382,12 @@ static int uclogic_raw_event_frame(
 		}
 	}
 
+	/* If need to, and can, transform the bitmap dial reports */
+	if (frame->bitmap_dial_byte > 0 && frame->bitmap_dial_byte < size) {
+		if (data[frame->bitmap_dial_byte] == 2)
+			data[frame->bitmap_dial_byte] = -1;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 78965e683d20..e5ccc558abc3 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -153,6 +153,13 @@ struct uclogic_params_frame {
 	 * Zero if no reversal should be done.
 	 */
 	__s8 touch_ring_flip_at;
+	/*
+	 * Offset of the bitmap dial byte, in the report. Zero if not present.
+	 * Only valid if "id" is not zero. A bitmap dial sends reports with a
+	 * dedicated bit per direction: 1 means clockwise rotation, 2 means
+	 * counterclockwise, as opposed to the normal 1 and -1.
+	 */
+	unsigned int bitmap_dial_byte;
 };
 
 /*
@@ -230,6 +237,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	"\t\t.touch_ring_byte = %u\n"       \
 	"\t\t.touch_ring_max = %hhd\n"      \
 	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t\t.bitmap_dial_byte = %u\n"      \
 	"\t},\n"                            \
 	"\t{\n"                             \
 	"\t\t.desc_ptr = %p\n"              \
@@ -241,6 +249,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	"\t\t.touch_ring_byte = %u\n"       \
 	"\t\t.touch_ring_max = %hhd\n"      \
 	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t\t.bitmap_dial_byte = %u\n"      \
 	"\t},\n"                            \
 	"\t{\n"                             \
 	"\t\t.desc_ptr = %p\n"              \
@@ -252,6 +261,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	"\t\t.touch_ring_byte = %u\n"       \
 	"\t\t.touch_ring_max = %hhd\n"      \
 	"\t\t.touch_ring_flip_at = %hhd\n"  \
+	"\t\t.bitmap_dial_byte = %u\n"      \
 	"\t},\n"                            \
 	"}\n"
 
@@ -281,6 +291,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	(_params)->frame_list[0].touch_ring_byte,                   \
 	(_params)->frame_list[0].touch_ring_max,                    \
 	(_params)->frame_list[0].touch_ring_flip_at,                \
+	(_params)->frame_list[0].bitmap_dial_byte,                  \
 	(_params)->frame_list[1].desc_ptr,                          \
 	(_params)->frame_list[1].desc_size,                         \
 	(_params)->frame_list[1].id,                                \
@@ -290,6 +301,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	(_params)->frame_list[1].touch_ring_byte,                   \
 	(_params)->frame_list[1].touch_ring_max,                    \
 	(_params)->frame_list[1].touch_ring_flip_at,                \
+	(_params)->frame_list[1].bitmap_dial_byte,                  \
 	(_params)->frame_list[2].desc_ptr,                          \
 	(_params)->frame_list[2].desc_size,                         \
 	(_params)->frame_list[2].id,                                \
@@ -298,7 +310,8 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	(_params)->frame_list[2].dev_id_byte,                       \
 	(_params)->frame_list[2].touch_ring_byte,                   \
 	(_params)->frame_list[2].touch_ring_max,                    \
-	(_params)->frame_list[2].touch_ring_flip_at
+	(_params)->frame_list[2].touch_ring_flip_at,                \
+	(_params)->frame_list[2].bitmap_dial_byte
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

