Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53ED500885
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiDNImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiDNIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215165162
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so8676928ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKr6+nokaP5roHlN/q4ijMaD9NBWjAMlhiHPQJ7ZvGk=;
        b=oniU/Uq3TeyE1RRKqecnWnMSlfxvLzAYhLrtXrsQi/DbEJVioabJ68fJ2fzEAONfv3
         PTXE5o7eZtavasDpjuVTRgMYiIZpJXZw9fxA0pj6VxY/1+ZzSrYTGi0n9KnS484YReGC
         VYzLKA4w48x2iRhJAbiI8zOq5Xj3fYPoxJsz54bx3LiuJAxzIGT3U0i/9pADtcUxs9AZ
         +yu3p+XsitFpkVf/42TCGBtTWUrOdBUd6QsNK+dKakZNr+Vl1a+HSvQiUQWzx2v2AFfQ
         o+gdFAJd8lFQKksN8onibvaSN65QbQWy1AQzNBkq0p1fRf/FabGKIq6Q8xfJ1ZZ0FW6I
         xeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKr6+nokaP5roHlN/q4ijMaD9NBWjAMlhiHPQJ7ZvGk=;
        b=Rx3BiqEyFHiQM9nl2y2njIWCgoOrT+E6QCbqRlcXMqQxb6GjI07JxQennqps/pREge
         nCEezMNJTAIe3mN6zMCyfSrtSABoMYiYKEGTt9yVfVfjQ82rxsjprH6blG6VZztiFlPa
         5/QLUH6qJb2Hpm9qMOXBOInIVmveTxV8N6u8cfb+3su5k73KPOjm71P4qBKnPzCeCUs2
         elQlH4vCFQR7VHX8ztNZpkc5jbjo3LwYY/CiVhD+m/wDEthXZT0fBCj0W525d5FGDp9g
         a2uxe6cQ4ErwtXTuurQM4AZkRL+EQM3EH9MJGJEbQosw62baPaWlKV2ONnj/kXr7geZE
         976g==
X-Gm-Message-State: AOAM531OMLcqaWhri8ByeuC3K83gEUZ0CaOvN44MhxIQXSVlUvG3eMoE
        sftHIfhzFQjCA2VRMioz2rcXT0/+xVw=
X-Google-Smtp-Source: ABdhPJy5szr413gn7qjTFI6nqX63l6W0BasX2s06CfKfEkZH3jn5PKE+Z7W4opnLFE/sl6D9g15jqA==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id hq37-20020a1709073f2500b006b05e9a0083mr1451660ejc.659.1649925554546;
        Thu, 14 Apr 2022 01:39:14 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: check firmware header existence before access
Date:   Thu, 14 Apr 2022 10:38:53 +0200
Message-Id: <20220414083853.3422-8-straube.linux@gmail.com>
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

We should access the fields of fwhdr only if the check for firmware
header existence is true. Move the affected code into the if block
that checks firmware header existence.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Do we need the IS_FW_HEADER_EXIST(fwhdr) check at all?
The header _does_ exist in rtl8188eufw.bin and it's very
unlikely that it ever changes _and_ the header will be
removed.

 drivers/staging/r8188eu/core/rtw_fw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 64963507a346..c58bce1a1856 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -249,14 +249,13 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fw_data = dvobj->firmware.data;
 	fw_size = dvobj->firmware.size;
 
-	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-		DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
-		le16_to_cpu(fwhdr->signature));
-
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
+		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+			le16_to_cpu(fwhdr->signature));
+
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
 		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
-- 
2.35.1

