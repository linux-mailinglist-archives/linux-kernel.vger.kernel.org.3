Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609C4E60EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiCXJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiCXJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:14:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D31EAF6;
        Thu, 24 Mar 2022 02:13:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so2076313pjb.0;
        Thu, 24 Mar 2022 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDwJhNPPovvMd4s4VPtOOMfUgLwXcP92Fnid9f10OUQ=;
        b=QWKO53cbloQr0kJSm1pnVU/ykOj8qZb6JK1oUYS6fNHEg6nM1kBx8FI58vRUSBm4Bs
         h9TUl1zaALn4DH5cdEfemV/pG2+e134e6Nq5OlaC3CREyO2SkVEkTFJTllhGYizEY02L
         dC3bp6sxrAv1SifHd+uW/84cyqsV8aaZH2i/K/uWgr23biOtyknkIZxaA65ZhEUKT8Al
         68BUgjSFl9pPfBlqH75FfQCsoB4+O4w3I03teL5wsDP5RvIiXx1013luRmmKB8p+noM8
         jAhLMo8JL7tu19bI8FoR8MconZupDRueICRjGnsUroDc7DR141UiA7/aPwyjV0gXk3FQ
         kocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDwJhNPPovvMd4s4VPtOOMfUgLwXcP92Fnid9f10OUQ=;
        b=MsVz02Rvtk5SPYwKplFFdzFLyvmFUIMyDx//6wDMnnfm7c42MFwaPppWYNBC4zlh42
         XQO/PHUunUz2Iv5qbc7LkMtM93OWRhY/x55AMpC2bJ7Kyk9WymloosH4zO3H3guXLZIg
         c4haiEWyIRd8v53jksYS6oZwBAXn57FQ1Pah34QeMJR9ofckS0/ZXK9lCz918uZ2hmWs
         Cad31JJYS/zLjLS1HwWXp04HJDzgRhVTVXXiEQ3ZpfF9afBIqccQUiY34wphQoXfOdDe
         bKNseM39ojP3jOK//JI9GQNFLCFakJSYlQipfs6/ca3XtaJIHP6+SWDzNvCAjXnmBReE
         FmyA==
X-Gm-Message-State: AOAM530zNZFTk4W0F+0m+wG/uOBe/a7e4/vmo8WTgzAKiZW/zAa5taVy
        xYshioNCSGZmR0JyTFzcfrM=
X-Google-Smtp-Source: ABdhPJzqJO/ny+038CiybGwdwhU2DqE2yf9CXypTOgPHAJ6GF5KS9CRcoaebyeHdHBUjL/Ku/io0NA==
X-Received: by 2002:a17:90a:3e4e:b0:1c6:586a:4d6a with SMTP id t14-20020a17090a3e4e00b001c6586a4d6amr17183627pjm.214.1648113201806;
        Thu, 24 Mar 2022 02:13:21 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.52])
        by smtp.gmail.com with ESMTPSA id nu16-20020a17090b1b1000b001c77c6a391csm5731611pjb.26.2022.03.24.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:13:21 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: uvc_video: fix bit overflow in uvc_probe_video
Date:   Thu, 24 Mar 2022 17:13:08 +0800
Message-Id: <20220324091308.44799-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

probe->dwMaxPayloadTransferSize is a 32bit value, but bandwidth is 16bit. This
may lead to a bit overflow.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/usb/uvc/uvc_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..cc4878373aa7 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -383,7 +383,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
 	struct uvc_streaming_control *probe)
 {
 	struct uvc_streaming_control probe_min, probe_max;
-	u16 bandwidth;
+	u32 bandwidth;
 	unsigned int i;
 	int ret;
 
@@ -422,7 +422,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
 			break;
 
 		bandwidth = probe->dwMaxPayloadTransferSize;
-		if (bandwidth <= stream->maxpsize)
+		if (bandwidth <= (u32)stream->maxpsize)
 			break;
 
 		if (stream->dev->quirks & UVC_QUIRK_PROBE_MINMAX) {
-- 
2.25.1

