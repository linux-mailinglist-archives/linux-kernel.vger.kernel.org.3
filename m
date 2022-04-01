Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF74EF8E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiDAR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349930AbiDAR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:26:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C8C1CAF37
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:24:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so7291933ejd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWq0Bx0LmZDm5Y8w65sfJx2cyjtA0fBP46ee9Dab/58=;
        b=j/YGux/o+fdqdyDLwRmwRwmlBTZpZiXgkjdsgKhLSEiVumFYY1jH3R/mPf1YYpf/hp
         PvJ2rdIuKUiAjpYhbMXM6066bu2+lmI7v6SqAdvlYJYaAsQBqUGAjCgzXI6uuQbgMwyG
         NH2rcmnudgDUUnlqwyBvhd5PWE9JmWt57T0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWq0Bx0LmZDm5Y8w65sfJx2cyjtA0fBP46ee9Dab/58=;
        b=zn3IL8gZemoIN7tkMeA9AOBeUTtmNUyROHewDigp70+Lv6EtAjv6AXQB5eHzoC6XBy
         XJb2Su6bZ8tG903VD4893ANSHliL05ex3u7WAkYL33zVfqIHIatajXCgajfTRNxCYVxy
         ZqNSulUVxLx3AB7j32BiU42K9LX/bfyCB+qtSMsgvvl/TsHbXC++gL6eszxGN43AM9/j
         nxZPCXS+BK3/zK1ict0/KL+sr3ha987IgdJXtJ2LjzWIPDVsBJrjvPg0LLv25T2pI5FG
         IPNt8Sz7Q1+UA1qgppHnEBpSehl8OH5lcTfaWCarkUQzyN7kU3OvPKrtoVGhqW0uahGi
         iQjA==
X-Gm-Message-State: AOAM531MFTIUMNQd0nPvS4d8WOSyF/qdp+PazMu27ndWHeJiim8v24e5
        16lBy49Wgx/HSIw5lenrZpKkzQUraFOwYg==
X-Google-Smtp-Source: ABdhPJyyFztYNNuqM4TEc43tO1QzdDwFobKPY9KqlGoAGUMMiOJmd9L+/q+DxaZaQ6rovKhI0YfQvA==
X-Received: by 2002:a17:906:7056:b0:6d6:dd99:f2a4 with SMTP id r22-20020a170906705600b006d6dd99f2a4mr713879ejj.43.1648833880632;
        Fri, 01 Apr 2022 10:24:40 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm1230475ejd.118.2022.04.01.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:24:40 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/2] media: uvc: Undup use uvv-endpoint_max_bpi code
Date:   Fri,  1 Apr 2022 19:24:37 +0200
Message-Id: <20220401172437.625645-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220401172437.625645-1-ribalda@chromium.org>
References: <20220401172437.625645-1-ribalda@chromium.org>
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

Replace manual decoding of psize in uvc_parse_streaming(), with the code
from uvc_endpoint_max_bpi(). It also handles usb3 devices.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 4 +---
 drivers/media/usb/uvc/uvc_video.c  | 3 +--
 drivers/media/usb/uvc/uvcvideo.h   | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index dda0f0aa78b8..977566aa2c89 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1009,9 +1009,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 				streaming->header.bEndpointAddress);
 		if (ep == NULL)
 			continue;
-
-		psize = le16_to_cpu(ep->desc.wMaxPacketSize);
-		psize = (psize & 0x07ff) * (1 + ((psize >> 11) & 3));
+		psize = uvc_endpoint_max_bpi(dev->udev, ep);
 		if (psize > streaming->maxpsize)
 			streaming->maxpsize = psize;
 	}
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a2dcfeaaac1b..9dc0a5dba158 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1756,8 +1756,7 @@ static void uvc_video_stop_transfer(struct uvc_streaming *stream,
 /*
  * Compute the maximum number of bytes per interval for an endpoint.
  */
-static unsigned int uvc_endpoint_max_bpi(struct usb_device *dev,
-					 struct usb_host_endpoint *ep)
+u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep)
 {
 	u16 psize;
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 143230b3275b..28eb337a6cfb 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -911,6 +911,7 @@ void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 u32 uvc_fraction_to_interval(u32 numerator, u32 denominator);
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);
+u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep);
 
 /* Quirks support */
 void uvc_video_decode_isight(struct uvc_urb *uvc_urb,
-- 
2.35.1.1094.g7c7d902a7c-goog

