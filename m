Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9158C99F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiHHNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243399AbiHHNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:41:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320ACDAB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:41:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so9442965edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fO7ABEO5Xwrjp6kqGJO7f/Lr8ytP4yra3ZRgOSAJwuE=;
        b=IDMydXOMV8BhAY9EQ88FYUw71eo/73SBhhfqCGwqwoYtiHrn/662diBR4pxc8Mid3R
         QGab26vfZSgdCnEc/Ulgd1s8eQ2aEw3D5/A8/4wIk65mwel98l+yA9RpJ4Cfi1x7e/uf
         dEJPKSoVDTAl+1kSViPtSYZFPG2GYn2dvtQvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fO7ABEO5Xwrjp6kqGJO7f/Lr8ytP4yra3ZRgOSAJwuE=;
        b=H0vEcEraDccnCkxIMDsnG+b7XfTox3CUtaKfg/hCkmhT7NTepuScESOZtwxnI7iE2d
         tSfZRym17Sr/Ju/m1Sci16iKstv/QvB4Q41jQSx09VK0jhpcpg3iFeowtqUkoY/SPm+A
         0MwSeHmFMj0zpZxY12S4cqykjM7YFkD8za2cm+gD+HH08p5cGnqtOfFcFk0NyJ+Sv986
         VTiwBz/JitH121effCKriMF+RWIrQJsFbacYmvUghYyL25sqPnxMmVwulSEOby/nwqWE
         jw4vnM2vyU3+rHehb6tmfYk/EdeyXL4D+CDogxs/eCNTckBPUm7gZdeiCKoJ9AfcSWbq
         sjPw==
X-Gm-Message-State: ACgBeo06VXnD/wsuosO+1knIxXWpx2y004d7leu1bgzduubhtzTFDcQZ
        OKTNQyE2WIumBbCwaGQ10NAybw==
X-Google-Smtp-Source: AA6agR4tZp5W1HHDIk6HvKvNF0aFthlxPiCWHTjPciOa+s/cF6TTh0OLEdX/3kUmRQ9zu4uInjle/A==
X-Received: by 2002:a05:6402:189:b0:437:8a8a:d08a with SMTP id r9-20020a056402018900b004378a8ad08amr17660344edv.241.1659966068810;
        Mon, 08 Aug 2022 06:41:08 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:af25:6fc1:a55d:28d2])
        by smtp.gmail.com with ESMTPSA id gj6-20020a170907740600b0072b31307a79sm5081681ejc.60.2022.08.08.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:41:08 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
Date:   Mon,  8 Aug 2022 15:41:06 +0200
Message-Id: <20220808134106.70100-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is using a different InterfaceProtocol than the one set in
the original quirk.

Fixes: 95f03d973478 ("media: uvcvideo: Limit power line control for Quanta cameras")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---

This was fixed on the last version of the patchset. Unfortunately I did
checked that it was the version merged :(.

It is too late to land it in this version?


 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..6556158a8888 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2740,7 +2740,7 @@ static const struct usb_device_id uvc_ids[] = {
 	  .idProduct		= 0x4034,
 	  .bInterfaceClass	= USB_CLASS_VIDEO,
 	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
+	  .bInterfaceProtocol	= 1,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* LogiLink Wireless Webcam */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-- 
2.37.1.559.g78731f0fdb-goog

