Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7467849633F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380239AbiAUQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379984AbiAUQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:55:17 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F8C061751;
        Fri, 21 Jan 2022 08:55:00 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso12492855otj.8;
        Fri, 21 Jan 2022 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRkMGPYm8YHI9B+ytD+Zs/rtt+wOfDZnupLp3J3rdss=;
        b=jhjODjRCQrcaRbsSvitlKjbN9/O+vC0R6ReJa9+BuXHVqBCBHDFTt+mY+MFSawgicb
         NeWPBaLvhJqg5Zeufmt+ChofbKnT53HI6Sg7oitjtE4PmBRxqRCgnBv2simLL9mkCsjs
         Edyph23cNwnKCtiV/riHxkPR0LxIjVDp/RjEwPtGfooXsrwsMPB5wpXOpY4TTcRlsrbo
         ee3mV5xQHarXvJY42PDZWd6BCTzPC50OCXq4ol7ud0KZwYoFCe4n/CB9ajcqCoYd7pKx
         xnuZZxWntLZ7cLv3seueKql40MqPzWsBObou3hoU/C6EtdaqQwPAmElqYp5MxDJHZEtJ
         Ew/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRkMGPYm8YHI9B+ytD+Zs/rtt+wOfDZnupLp3J3rdss=;
        b=f3wlNHqkL49l9uLuBBe41WdZ+sLmy76ATEozk3x/c8eGBA/ehexSbGqS/DmEpev+4i
         fx5Lik05xoKfPQQGE5R3GPSkfLKH2mEyju2n2bon521qXMTtWF8+vWzhWvSh9gfGj+CY
         Nm2BadHbCPNd5QznlVbLyf8ZyBc/zqdwhUcnLGVZu48MUjFQLLH+a/u3usAFhcjz+14o
         4PDpMK4nkpIVooZ05Atf7k6Pi6XXE6B1NId76Qfe9Iuy+ba52N0+N0QRCOBHNLxb12Ar
         gQ3MPrtKSRsQ4KlPj9WD/eaDv8UODaAPWFCn3xgLw92V5/FV5cwqLeuZUrk53cFrapDw
         klXA==
X-Gm-Message-State: AOAM5339m8Vhibg14GDkAush7rz+ajqCGwTuYrsUuFNDMpM7iFMS0QWN
        JtJX9J2EnXARrZFWa7VwvQU=
X-Google-Smtp-Source: ABdhPJzhEd2XBHo2Fm46jjhKsmeir1zZ+dSho/AoK/PAiPC26SPAPqy1RAFOSzOMiROSRYqePduSmg==
X-Received: by 2002:a05:6830:40c6:: with SMTP id h6mr3264903otu.247.1642784099522;
        Fri, 21 Jan 2022 08:54:59 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:59 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 12/31] media: v4l2-core: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:17 -0300
Message-Id: <20220121165436.30956-13-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/media/v4l2-core/v4l2-flash-led-class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
index e70e128ccc9c..a47ac654c9f4 100644
--- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
+++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
@@ -234,11 +234,11 @@ static int v4l2_flash_s_ctrl(struct v4l2_ctrl *c)
 	case V4L2_CID_FLASH_LED_MODE:
 		switch (c->val) {
 		case V4L2_FLASH_LED_MODE_NONE:
-			led_set_brightness_sync(led_cdev, LED_OFF);
+			led_set_brightness_sync(led_cdev, 0);
 			return led_set_flash_strobe(fled_cdev, false);
 		case V4L2_FLASH_LED_MODE_FLASH:
 			/* Turn the torch LED off */
-			led_set_brightness_sync(led_cdev, LED_OFF);
+			led_set_brightness_sync(led_cdev, 0);
 			if (ctrls[STROBE_SOURCE]) {
 				external_strobe = (ctrls[STROBE_SOURCE]->val ==
 					V4L2_FLASH_STROBE_SOURCE_EXTERNAL);
-- 
2.34.1

