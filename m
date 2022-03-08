Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B714D1EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349119AbiCHRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347264AbiCHRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E554181;
        Tue,  8 Mar 2022 09:19:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so40699793ejc.1;
        Tue, 08 Mar 2022 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQwhyeIJaS4gMMq4l8hfR9wNOecju8wIT5izOR26pg0=;
        b=BWdxPDq2ZGBk8E3khwO51OqDkZJNaD6HU3ZxJ5Qp4fAvWOdBGGpbwdk2CV+xsBdNnF
         Ugwrz4wTDHSN0yyyTHPDU8/vaZiAqIR+Ul89aVxUH0Zjq8OVsVOApy+ozsZ6qANKW/dl
         Gzw1Bv2FzODw0eQNRuST41XG2QbkzHga0EFWjhOhiIjVbHEM+Xr9WbH/anVxY4qvb/w5
         UsNjZ5qTyyhg/TxxezbZhKzv+QarI/2PJz6mAH9fGi4ZCQ0SBsPNmGICRDSkNpZDcIBz
         j+UNQB91oDJurEXFz+Ex6uTynCvWPTUlfWjqTDg9PzVHD00fcIuqmzasc2hlMUIBGXIp
         48Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQwhyeIJaS4gMMq4l8hfR9wNOecju8wIT5izOR26pg0=;
        b=LvMUpZuU7sVBAE3n6AcoErPMDDajeZDAfJZauasOmWbnGhcOh/mY66xOlgP9FZ8Mlg
         t1nbVBGg9X8BT3mKFpEPXlEqfQoyNNTbwVg5aD1bcMChQKOyuP83XiKCNk2tpl+247Sl
         Hpv/h5vCy1ze4uuJvTPiS8AD+z66RC9cdV8xlZbzaaafnD8LJP5vcIWeABAlFG2vuTI+
         KFCObThaa6FClVMWQXVTvpEZf2R+CaI0deFM+YqLQLmgyfLDtf769jd/+rLvtfSBp0i4
         t6wpdOmHZJ9TbNDJD5kmucD4yENe34EHm65CDPByO83Ws3YZcqn1AU9QBGrHwFP7HFW8
         HADw==
X-Gm-Message-State: AOAM532mBX9Xy6z1rTFiX1lVz0OinerrztDVajaqdYlDz+J0XyFPL1zW
        S+OYhRvH229h+lG0Plk4rRM=
X-Google-Smtp-Source: ABdhPJwRoyguc37yxeKFidsAA1N5VJnbQ14wYHVgwTkFcutCYNMVZVL1aLsRJOpQLSCZ0bA2rg2U/g==
X-Received: by 2002:a17:907:3e94:b0:6d1:d64e:3141 with SMTP id hs20-20020a1709073e9400b006d1d64e3141mr13580383ejc.213.1646759964460;
        Tue, 08 Mar 2022 09:19:24 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:24 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH v2 15/26] usb: gadget: udc-xilinx: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:07 +0100
Message-Id: <20220308171818.384491-16-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308171818.384491-1-jakobkoschel@gmail.com>
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
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

If the list representing the request queue does not contain the expected
request, the value of the list_for_each_entry() iterator will not point
to a valid structure. To avoid type confusion in such case, the list
iterator scope will be limited to the list_for_each_entry() loop.

In preparation to limiting scope of the list iterator to the list traversal
loop, use a dedicated pointer to point to the found request object [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 2907fad04e2c..428c755cf2e1 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1136,17 +1136,20 @@ static int xudc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int xudc_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct xusb_ep *ep	= to_xusb_ep(_ep);
-	struct xusb_req *req	= to_xusb_req(_req);
+	struct xusb_req *req	= NULL;
+	struct xusb_req *iter;
 	struct xusb_udc *udc	= ep->udc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
 	/* Make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->usb_req == _req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->usb_req != _req)
+			continue;
+		req = iter;
+		break;
 	}
-	if (&req->usb_req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

