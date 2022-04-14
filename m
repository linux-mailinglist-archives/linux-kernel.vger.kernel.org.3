Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290C500B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiDNKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiDNKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52876E07
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc2so9172523ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqSU6uGvzefM7JqsLVkp47vheVpreBM8RRaia816jV8=;
        b=EPhy7/ZQXKLEPglQ9Yf7BZJg6s4m0VoAeydJ8uetqwmPJkMPW0qIKvJPGEozN6rXhh
         zyuuilCGrBMBf1ixfkTEA8b+SX2c6ibg0Aykjpl2XN6xMCR9U08O3IjiEN07Zp3+meGl
         d5b1N6r5ThgRE1pjcSjhXhKVdazk9hncQrFUMCeBhNPQ62DCSQr2kfeZqKMRmRSuaCgS
         Rkz3lg2wlheg88U7MRcNRhUWfpnQpmzBuvpoZoME7oa+rwU6Q1wlkNtOmLd2BZMWl2f2
         uZ8ITrN4hNmdwW2KxCr8Hq02Tnn6cJ/fOhKutv/9mIFXg9RaMnphybn8JOqn5ZZhpach
         thWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqSU6uGvzefM7JqsLVkp47vheVpreBM8RRaia816jV8=;
        b=6sHtYKsl/PhUDopJ12MlfJHf/0zeKalU7ag8QyO0w/Q7mTwdoxa4lZIeEw6GW+rO9F
         G25iI5V+5IMHgKtRZTKfOonu+GRnpO6O1jAkNHEPPa5XhERc6hOIe6prZmY/Z6Y1N1RS
         Zft8Ms8BxpQ3be2nGWBXwEKuAHl+J+5m4BxDuxxRgZloVIeiGij2FbJRf+7KJCUA+/yF
         nmH2kOCTOeMKkGMG6EygGSq+FG6Pqh6tbEtsnkhZ8XGQNM0ZdgS8JVxJVgjXB2SgmhJ+
         MiDkBEflWGnD0h6ukousWpLB0EIePZ0Qsp2j0svTA+YT4N4dQuQ/THDYx30nJNyER5wI
         98Uw==
X-Gm-Message-State: AOAM532/lmGXMig+hGNeVZfj2CpUNP4BQvUic2wcNets7Px7YyCPsWd2
        xnRcHoNc5eNIlokWzeCYFak=
X-Google-Smtp-Source: ABdhPJwsbeir2WfwtRfQ2AKmGoQyu5tVJfNVyMmQ69tQEtA+fV69250Ivp0T1qS4N5lXuXJN5/oxoQ==
X-Received: by 2002:a17:906:b107:b0:6e0:a25a:af6e with SMTP id u7-20020a170906b10700b006e0a25aaf6emr1755104ejy.359.1649933031568;
        Thu, 14 Apr 2022 03:43:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/8] staging: r8188eu: always log firmware info
Date:   Thu, 14 Apr 2022 12:43:21 +0200
Message-Id: <20220414104323.6152-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
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

The local static variable log_version prevents logging the firmware
information more than once, e.g. when the device is unplugged and
plugged again. That is not necessary and complicates the code. Remove
it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index cbc4980bd938..64963507a346 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -239,7 +239,6 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	struct rt_firmware_hdr *fwhdr = NULL;
 	u8 *fw_data;
 	u32 fw_size;
-	static int log_version;
 
 	if (!dvobj->firmware.data)
 		ret = load_firmware(&dvobj->firmware, device);
@@ -253,10 +252,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	if (!log_version++)
-		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-			le16_to_cpu(fwhdr->signature));
+	pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+		DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+		le16_to_cpu(fwhdr->signature));
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
-- 
2.35.1

