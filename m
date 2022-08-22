Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2045159C056
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiHVNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiHVNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:18:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DA32071
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:17:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id vw19so7478382ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RJWgbhnetMUZfyM+6mbC5WR3l/QmeL2C9e6LCezHs8s=;
        b=nEZxKvECnqaTacdetsPvCMLjEzMvzkaws4tpiuI3hSGvDeMW/Z8BeFaxSFYuH5rzZy
         VTtnGO/hu+Kj8UxFUaKUJBj7DiQw+plUm8miZ/m1FTDt0nH3O4ejvACvedKR8khFwXvU
         Jy0i92dmLpB6vvQP6MDvasUvdn1zF+YfRSwP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RJWgbhnetMUZfyM+6mbC5WR3l/QmeL2C9e6LCezHs8s=;
        b=aJ2f6kXivfZL/gMyOj9J499Id1k6m+OmE102r/c1OfxNxhTh2rqlqRReMo+Q0VFeWN
         fjyEbJu1+vZBIbAcSgvObU54lfGXS52h28+QI/4glo0yKyLtX1HX2Tk9B0FKm1pg0YZa
         /nv7/wq0nofXSi3KZ2yyg68DfAFPAYeV2VKUjVGC0Ztx0vJRjb+r9myytm3thCYtb69c
         23Jg+/3zo43ZjUeYH4yBb5zklHMuhYsp/S3BTZtfDfLRgnhy15upxO2Nykn1o5yxOnFN
         +uGnvlNSSFLtYlngHPKi/XJ+XIJxXrw/CtYxgJswxHslBpw5U+VYc6QpszHD5qlx5R99
         7tSg==
X-Gm-Message-State: ACgBeo0+C7C6/swmVV1oUen6+Czivbkpo5XhSAS5NRtMW8F1Sc8wAqPb
        J46pYtqzKxtd8aEq3QOSIV7xPQ==
X-Google-Smtp-Source: AA6agR5XwKKVgTOQ165d7kv54mlk+T5p7ggV9lJhMetTNmnUiUMrmTa0+gfNTPMNwA3/LVQAyyLAww==
X-Received: by 2002:a17:907:2cd4:b0:73c:9fa8:3ddc with SMTP id hg20-20020a1709072cd400b0073c9fa83ddcmr10642455ejc.40.1661174277183;
        Mon, 22 Aug 2022 06:17:57 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:31ed:bb21:563b:e10c])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0073c10031dc9sm4363211ejc.80.2022.08.22.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:17:56 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
Date:   Mon, 22 Aug 2022 15:17:54 +0200
Message-Id: <20220822131754.102393-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quanta 0408:4034 camera implements UVC 1.5, and thus sets
bInterfaceProtocol to UVC_PC_PROTOCOL_15. Commit 95f03d973478 ("media:
uvcvideo: Limit power line control for Quanta cameras") added a quirk
for the device that incorrectly specified the UVC 1.0 protocol,
rendering the quirk inoperative. Fix it.

Fixes: 95f03d973478 ("media: uvcvideo: Limit power line control for Quanta cameras")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---

Mauro, could you queue this patch for v6.0?

Thanks!

 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..d509a4a2f08e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2740,7 +2740,7 @@ static const struct usb_device_id uvc_ids[] = {
 	  .idProduct		= 0x4034,
 	  .bInterfaceClass	= USB_CLASS_VIDEO,
 	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* LogiLink Wireless Webcam */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-- 
2.37.1.595.g718a3a8f04-goog

