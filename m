Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1C500888
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiDNIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiDNIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489265156
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so8687291ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gsZkfzMYeP6pd9u0lclNFF+p8O0+cqjChmSOXbRt/s=;
        b=a6JNmB/1Y+0744TawNZF7bHnULrgn0WJoR9vfTcNGTJQOStR5EnKZmlkcsHvICtUb3
         Dc/FcQcL9QW7r4HEYNO6vWtDunogH09b/LARrvb0VjRrONenywo9QLYDcRrjxG4q+H+Z
         wSBTZ1cfW7NAjgSq4w+6yblSTTG9FzaxDAd49U4ljUeBmx4qI88gvnFZ8/g99O3L3m/O
         4qBxCv1xAD4Zs+H4yV+sqY/9HFvEhLOMxVDQXAi9O5hobFNICMt4SOrNB+zSkat6XuOj
         X13VVLVTKtdz10i4MQ02n9a6q+mOxlS9vGF4lShaaK0pk37ckV8P0Bb10ZtegPkReaAw
         Svrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gsZkfzMYeP6pd9u0lclNFF+p8O0+cqjChmSOXbRt/s=;
        b=QHpRuRdLGOmvZjtWS/5lz2yvMiDKmBwPX6OKESRqo/g1fgcqf3on62Rb+c5OIqpODx
         xj2ZCdb+nwo4YhRX7Jf6GYJRsw8PQxng9UkaZHWLeQR1aIp1RnqdNDC7nsU9suKJf7aD
         65rgHFuQvqXebnv3kCy6u1w1J0CzqMec2sdsAeMjjlcHCEY29VoSrw7fznYd5458E/47
         jng59ORWdlPX2XTmBUO5AOB9VvFcIIli0LX+tYEji0yya5qI5CYBW+DcQvGEs2MfR/tg
         DzLwPJdTvqAeyT3D4OhIAlRsiCRX5SEQ4uQKJXK7S5V4fzAHRi4x156Lt2jmhmxC5evr
         ld6g==
X-Gm-Message-State: AOAM532KBDlxr0XGXswj4b4VriNWEgOIa+LWvqD1tQy0yoT3738ylUDq
        xhSWSrCbX/NH1bVoW6E8aXk=
X-Google-Smtp-Source: ABdhPJwDrsDJJ3+KXOfLLIl/Cc68yJARYtkYEORg3Cdb6DIX9ZWWzFyfC4dqP7JkhkyTVTAAxtapvQ==
X-Received: by 2002:a17:907:6ea7:b0:6df:c5a2:89ca with SMTP id sh39-20020a1709076ea700b006dfc5a289camr1395445ejc.18.1649925551946;
        Thu, 14 Apr 2022 01:39:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: use sizeof instead of hardcoded firmware header size
Date:   Thu, 14 Apr 2022 10:38:50 +0200
Message-Id: <20220414083853.3422-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414083853.3422-1-straube.linux@gmail.com>
References: <20220414083853.3422-1-straube.linux@gmail.com>
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

Use sizeof() instead of hardcoding the firmware header size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 3da52a1ba23c..94526064f29b 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -263,9 +263,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		/*  Shift 32 bytes for FW header */
-		fw_data = fw_data + 32;
-		fw_size = fw_size - 32;
+		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
+		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
-- 
2.35.1

