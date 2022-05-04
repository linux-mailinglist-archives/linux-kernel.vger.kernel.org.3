Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B85192C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbiEDA26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244676AbiEDA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:28:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573CB101D3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:25:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x22so9714803qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2Rvi2fYjCUZ2fnH709+1VRnkklGH3OfPRUgCz8KlGY=;
        b=g51Ue/s5rS5LLtj4OEQPwT7d494kHpWcGbxGHxE981zyTogl4UOv74UfawU0k4oCqW
         9HCYKSJi+8ywrRxtyJo1CGXrJhNCB8P+rFKRAWALSMOcO0B0fxKd4+8No0qRMXFd/6Zs
         vQ7DomBoVP/+VmjvAMeGpOYeuEKcxvYv92dPSFm5FPLxwbScd8La5FO8UiVLhn0sjqyn
         Lu51rk8SACDzvOxxHLHZ3d2QpUSSamZQPo8K0YLZR1hIE+RuTg6mcnfajAbCTVG5fX1S
         KCF9UkahWu+IV3M0YKr3UmUGkW8aE1Mp956rRUkAG+uqWHxrRWMIcO3MQx/lKcw9hFm7
         /fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2Rvi2fYjCUZ2fnH709+1VRnkklGH3OfPRUgCz8KlGY=;
        b=BVpwFFj2NvjCKoClpVfMq9NsymYV6jARVFd6xGT1mCHA3vQ3SOInR2NZ6O8/nLkSrM
         6hSZCtur503pOxQOINtBJXKeyWi4haktH+Lh2Vx3DYHZM3clfGuqEgHeF+Nd0E3CJu0x
         0kIdV9Jz3SX5QW8B9AluafoW/W3VZLO2jQIfaeMi7tWem5QrqfZpweWSTNPS3aVAr2hk
         YguNO2n/PlWTgzIYNVf0eOD7AnJU6zVwJNBIgwlkUzNXOfvALm+INZu15Y16ElCGo35O
         FlF4xHOEa9p4RRxG6zN3n06mg31lbPIsntIj4zDc8gOFjvnAip6cWdX7RseoobaAn2+a
         kCGA==
X-Gm-Message-State: AOAM533SKSK57fLAkKOawJ81ss7Ll8YeojyRzUvhEpTg7ycUB4gZUYL2
        +Q83iLp7HM/FgI4x62omOpCqwk3BUniAiQ==
X-Google-Smtp-Source: ABdhPJyyjndUav0nHPLHbvWv9sEmjBBeh4RCNWvs91dbqR/94MA255Ej35UXNwSKxVOTtD0x4Y8l+g==
X-Received: by 2002:ac8:5950:0:b0:2f3:9101:e0d4 with SMTP id 16-20020ac85950000000b002f39101e0d4mr17583041qtz.613.1651623921516;
        Tue, 03 May 2022 17:25:21 -0700 (PDT)
Received: from localhost.localdomain ([66.63.167.151])
        by smtp.gmail.com with ESMTPSA id e188-20020a37b5c5000000b0069fc13ce225sm5966358qkf.86.2022.05.03.17.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 17:25:16 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Forest Crossman <cyrozap@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Don't get sample rate for MCT Trigger 5 USB-to-HDMI
Date:   Tue,  3 May 2022 19:24:44 -0500
Message-Id: <20220504002444.114011-2-cyrozap@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device doesn't support reading the sample rate, so we need to apply
this quirk to avoid a 15-second delay waiting for three timeouts.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ab9f3da49941..fbbe59054c3f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1822,6 +1822,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x06f8, 0xd002, /* Hercules DJ Console (Macintosh Edition) */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x0711, 0x5800, /* MCT Trigger 5 USB-to-HDMI */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x074d, 0x3553, /* Outlaw RR2150 (Micronas UAC3553B) */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x08bb, 0x2702, /* LineX FM Transmitter */
-- 
2.36.0

