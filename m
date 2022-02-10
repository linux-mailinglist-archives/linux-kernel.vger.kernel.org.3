Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA74B15D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiBJTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:05:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbiBJTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64C100C;
        Thu, 10 Feb 2022 11:04:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n8so4036947wmk.3;
        Thu, 10 Feb 2022 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXd3/jskGjTWmhBRtSHB5dWP3UeubOqYdsG1HEGhcGc=;
        b=cfYxogM1ADU/8WqEwxEoGdZv2gw+K4ObDr4bcWIUG4nvDWNsN9+KkS0/zqA3xl9VX5
         KVI5DRyEAsJ4NdT3joax/BEjoQxgM4IPnToqRwUPwekQ9sZsZmNelks0Q2BhRiV5Jnvj
         9hDWObpS+ZR7xYwvjK1JS67WFbN5sgjysoeamTzVLXUKzqR8wez2hM8l7GBxoPH16NNy
         K+syjQgsSr+pcHeW0a/NYZlxWXfAMRe+KC1nLIPTgRmmqg5+1HkZUsyYIusWJBKqg6Lh
         dh8ZeLupqu+e6+OVKeFiMqnAhHos9kmNtHrN+9CC+BDyIDRdOndBvCkARqWrGj+tJ5DV
         TYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXd3/jskGjTWmhBRtSHB5dWP3UeubOqYdsG1HEGhcGc=;
        b=YhHQKgYe7Ki+iRY1kG3IEF4J6pBbKgisxq92VYOAUGKRtFoxlO5PoZHmlY7UjwDiFg
         yvRvvK1tVHk14BGaiB628oM7ZqqVEzCz7wrutwZrPR32nV+DmeeOlpVTyfdQ5TMjyzd9
         tLVLDKMnKhmGDWZ65fpfwmUtyJ7/gc9zTtuEzSTieC0m7+uf+5YP8qn+0oRNqDiAT1tI
         iBb1WidB5gGFYnJHJ+pl4EAKlCiAcBPq3hvO3Mf2cZ4+964TjUPgmRIuFsisn+8cB0X9
         jJ9RkFJorhbL5Um0eJRTKwO2Xxi5ZG0pGZhw4AVjhtHCjYq+i1cW7kSOt/sUOZ/nQEL6
         fsgA==
X-Gm-Message-State: AOAM532T63eT/dqBVySO7TNVBIVds5jAQdmv0VA1f1vZFnK5CcjU3Iga
        fvCN4tBuHqepbsNHTrsrwsA=
X-Google-Smtp-Source: ABdhPJwUqnA/XWrFtrJomP5/5yYmCObWzQszd8Tx6uhGEvVICKqtOvigtMqUfxuzXM9g95L9/quYPg==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr3244793wmj.146.1644519892785;
        Thu, 10 Feb 2022 11:04:52 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:52 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/7] HID: uclogic: Support Huion 13th frame button
Date:   Thu, 10 Feb 2022 20:04:33 +0100
Message-Id: <20220210190437.50152-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
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

Support reporting 13th frame button for Huion tablets. This supports
reporting the button in the center of the dial for Huion HS610.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 2607cbdf8ff2..ec16355d200b 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -689,8 +689,8 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 	0xA0,           /*      Collection (Physical),          */ \
 	0x05, 0x09,     /*          Usage Page (Button),        */ \
 	0x19, 0x01,     /*          Usage Minimum (01h),        */ \
-	0x29, 0x02,     /*          Usage Maximum (02h),        */ \
-	0x95, 0x02,     /*          Report Count (2),           */ \
+	0x29, 0x03,     /*          Usage Maximum (03h),        */ \
+	0x95, 0x03,     /*          Report Count (3),           */ \
 	0x81, 0x02,     /*          Input (Variable),           */ \
 	0x95, _padding, /*          Report Count (_padding),    */ \
 	0x81, 0x01,     /*          Input (Constant),           */ \
@@ -699,14 +699,14 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 
 /* Fixed report descriptor for (tweaked) v1 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v1_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(20)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(19)
 };
 const size_t uclogic_rdesc_buttonpad_v1_size =
 			sizeof(uclogic_rdesc_buttonpad_v1_arr);
 
 /* Fixed report descriptor for (tweaked) v2 buttonpad reports */
 const __u8 uclogic_rdesc_buttonpad_v2_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(52)
+	UCLOGIC_RDESC_BUTTONPAD_BYTES(51)
 };
 const size_t uclogic_rdesc_buttonpad_v2_size =
 			sizeof(uclogic_rdesc_buttonpad_v2_arr);
-- 
2.25.1

