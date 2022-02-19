Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AFC4BC783
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiBSKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiBSKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500FA195;
        Sat, 19 Feb 2022 02:02:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k1so18480375wrd.8;
        Sat, 19 Feb 2022 02:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+knIrKk+Y9Xw92x9dcrEHWonrnULiyFs1HfK/Dzs88=;
        b=AU838J+kCinEFPJ7ney/lcajB7RH4SV0dxXKP2Qz9LmikLXP32/PUIAHGpnQZHYNNR
         CaATYRM3a7C3IETf4uOdVRLPX5Yb/22uY/udhINlofTJOuB5P+c4Q3NIak8lcXacYlfK
         nMgbFxro997ev63iliuM6qnMN8ls/KQfioddvYsnQWQ1TwINfBW8nFz/JFhmyqjqmywa
         BAkmWzYv3gvLWNa5+/oQgZY0ySfGM2DaLk8JT4uMb2kRJ2kqbpY8S0qy9B8k26u7dT38
         4vrs6SbkDlcT3eHcZu38I+yo7a3vh6P2njQQBpmnuXuzgjxYYR9LuN/w2Zr3E/qf65FC
         4tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+knIrKk+Y9Xw92x9dcrEHWonrnULiyFs1HfK/Dzs88=;
        b=R7FOcGswBKPwLMYfIbNsDuWb8Fw/tb6k/vur71SmfGUXylAiY5E0pLlSx4nJKyh0js
         BOjgrN+HHeY5ULsFyh3qV574vPFhZee0frAgyoNIwqVZTxYMiOTdkglDPYQ7vxNQNRK5
         Ijoyy64Kn51MPEiB+yNFXbcaG6TCCeEGEpJr6+QLmki2TiNjsZm/GWeHUhYpg4lQl2JZ
         gbIoxd3u2TbmsJ3+BsvM3cDD+GGKV0kqsl/lgCP6jYYRvzpFz4oTWfMwsaHwrNXWCzuZ
         ehyutPidDETvc8yU2NygcTB7QZdk4/0OKZp+cT+i7ESMnPgLRFw8F3ulUTQdIZ07aRw3
         e8Jw==
X-Gm-Message-State: AOAM531ufKxq1grL0yf7bh56okPxWaTnFxxvaxMucNNc8WeePVAv8heO
        ErZhJ4nHcq2YhoROGYzaEFA=
X-Google-Smtp-Source: ABdhPJxvt6J8MSJnPVy1GVDVmkTeuhBjHqjobveFWXVh/X0ZsAq8TvBd2+tPgUyr3b7uUXPJG7Jz+A==
X-Received: by 2002:adf:f1d2:0:b0:1e4:aef2:76a8 with SMTP id z18-20020adff1d2000000b001e4aef276a8mr8647909wro.445.1645264932745;
        Sat, 19 Feb 2022 02:02:12 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 4/9] HID: uclogic: Specify total report size to buttonpad macro
Date:   Sat, 19 Feb 2022 11:01:52 +0100
Message-Id: <20220219100157.41920-5-jose.exposito89@gmail.com>
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

Simplify the UCLOGIC_RDESC_BUTTONPAD_BYTES macro by passing as param
the size of the report to pad to in bytes.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index ec16355d200b..6e5bef39417e 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -654,10 +654,9 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 /*
  * Expand to the contents of a generic buttonpad report descriptor.
  *
- * @_padding:	Padding from the end of button bits at bit 44, until
- *		the end of the report, in bits.
+ * @_size:	Size of the report to pad to, including report ID, bytes.
  */
-#define UCLOGIC_RDESC_BUTTONPAD_BYTES(_padding) \
+#define UCLOGIC_RDESC_BUTTONPAD_BYTES(_size) \
 	0x05, 0x01,     /*  Usage Page (Desktop),               */ \
 	0x09, 0x07,     /*  Usage (Keypad),                     */ \
 	0xA1, 0x01,     /*  Collection (Application),           */ \
@@ -692,21 +691,22 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 	0x29, 0x03,     /*          Usage Maximum (03h),        */ \
 	0x95, 0x03,     /*          Report Count (3),           */ \
 	0x81, 0x02,     /*          Input (Variable),           */ \
-	0x95, _padding, /*          Report Count (_padding),    */ \
+	0x95, ((_size) * 8 - 45),                                  \
+			/*          Report Count (padding),     */ \
 	0x81, 0x01,     /*          Input (Constant),           */ \
 	0xC0,           /*      End Collection,                 */ \
 	0xC0            /*  End Collection                      */
 
 /* Fixed report descriptor for (tweaked) v1 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v1_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(19)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(8)
 };
 const size_t uclogic_rdesc_buttonpad_v1_size =
 			sizeof(uclogic_rdesc_buttonpad_v1_arr);
 
 /* Fixed report descriptor for (tweaked) v2 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v2_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(51)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(12)
 };
 const size_t uclogic_rdesc_buttonpad_v2_size =
 			sizeof(uclogic_rdesc_buttonpad_v2_arr);
-- 
2.25.1

