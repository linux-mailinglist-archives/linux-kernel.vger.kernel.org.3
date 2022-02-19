Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBA4BC78C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiBSKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241921AbiBSKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4BAE62;
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so18432701wra.12;
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEWzXMtuGzMkDcqaB1V0tGQg8NpDODlOL3GISXxAo/U=;
        b=T6lhxSOpT2g7y87hz2Ymz69XBEMNZ+olzbc/UOxPFI5VurkJ3DmFG7MXVRfUdNIewJ
         OzPOwFKLy7TWPJXFOkblCbut4Rn4JaSidBX/AqMTgIzDTeBDHKhGOGvzxpy4wEMoKONW
         7KUpvuRx+LU5cbolQurQgv7I/DX5K9jiqR2xIZ/UylO6YeB3rTuHcW0QX3oWQQG4gDFh
         dEFfwWVMDZ9qmFsuL2mVSULaeJkUxPLNkP4LuITbDXl+c7Upq18oymhx5rMBk3znmzhD
         NI3VEfKqHmjFw3kH2g7FpWGcEau3XzFxfU9m16pLik1X+CNVYZ/iT2X+y4emffDMcbb9
         Iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEWzXMtuGzMkDcqaB1V0tGQg8NpDODlOL3GISXxAo/U=;
        b=qEHsPEuNH3D8c2WfpFSnX70nKvG33N2WbURFNiSG65IHzUXG45AMuUY6rhHAZjMgbH
         l+8XC4HE62QBsaDqyrqRHvRCWkcRbSsWer+Jl6HRyKwboa+BBVqR+8fc3xMowyQeM4sn
         MYfW9+KbIMkHr5TQRT9ZvzuKAyZto20oNmBbGNflfWmZr+1M76/uG4OylsUpYg69/ick
         WA4SAoOloU8uRdSUaLHgJVzzKCrXMfgYVTSTCWkzbYYA+7p+awNSl9loaVkyacP/COdd
         koB7mUfRnrodP8SG2INs7qY56urbU6WNffQRccIMEQVvs0jV3eaFLcFmPfHIf8q1Kcc3
         oO+g==
X-Gm-Message-State: AOAM5333Tj6tyj09OZ6UCslBouZNO9wvk5PXuE7DgTOroqoJY1wztddk
        oc6YIBEBm5lDfNhOOSxoii7pNygsgo8=
X-Google-Smtp-Source: ABdhPJyDtkWP6eaIk72guhujcGe8UvUGRi5F5yo0/HaEyvEueuK1Dc/EnVW+YtQx3cwPDKOSyvFs4A==
X-Received: by 2002:adf:f38b:0:b0:1e6:2961:99b2 with SMTP id m11-20020adff38b000000b001e6296199b2mr8781766wro.700.1645264933652;
        Sat, 19 Feb 2022 02:02:13 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:13 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 5/9] HID: uclogic: Use different constants for frame report IDs
Date:   Sat, 19 Feb 2022 11:01:53 +0100
Message-Id: <20220219100157.41920-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219100157.41920-1-jose.exposito89@gmail.com>
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
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

Allow to set the report ID in UCLOGIC_RDESC_FRAME_BYTES instead of
using a hardcoded value.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 6e5bef39417e..66aa83f67ccc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -654,13 +654,14 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 /*
  * Expand to the contents of a generic buttonpad report descriptor.
  *
+ * @_id:	The report ID to use.
  * @_size:	Size of the report to pad to, including report ID, bytes.
  */
-#define UCLOGIC_RDESC_BUTTONPAD_BYTES(_size) \
+#define UCLOGIC_RDESC_BUTTONPAD_BYTES(_id, _size) \
 	0x05, 0x01,     /*  Usage Page (Desktop),               */ \
 	0x09, 0x07,     /*  Usage (Keypad),                     */ \
 	0xA1, 0x01,     /*  Collection (Application),           */ \
-	0x85, 0xF7,     /*      Report ID (247),                */ \
+	0x85, (_id),    /*      Report ID (_id),                */ \
 	0x14,           /*      Logical Minimum (0),            */ \
 	0x25, 0x01,     /*      Logical Maximum (1),            */ \
 	0x75, 0x01,     /*      Report Size (1),                */ \
@@ -699,14 +700,14 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 
 /* Fixed report descriptor for (tweaked) v1 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v1_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(8)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(UCLOGIC_RDESC_BUTTONPAD_V1_ID, 8)
 };
 const size_t uclogic_rdesc_buttonpad_v1_size =
 			sizeof(uclogic_rdesc_buttonpad_v1_arr);
 
 /* Fixed report descriptor for (tweaked) v2 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v2_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(12)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(UCLOGIC_RDESC_BUTTONPAD_V2_ID, 12)
 };
 const size_t uclogic_rdesc_buttonpad_v2_size =
 			sizeof(uclogic_rdesc_buttonpad_v2_arr);
-- 
2.25.1

