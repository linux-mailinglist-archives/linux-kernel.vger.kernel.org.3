Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288F4D1EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiCHRVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348921AbiCHRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463A53707;
        Tue,  8 Mar 2022 09:19:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w4so22863337edc.7;
        Tue, 08 Mar 2022 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7/gAw+DbnZtTNdfpuzCiVdL6RMHX2i8psNGo9On2wE=;
        b=lZBLD5iJRHwna6Pu9qZ7/2APxDtkJaKEHwNbE6+HMjiGuMvomc/1zMzNkJChwYwOUC
         wh89YneS2YEvD1/3E6YiYRkJbMfG14PYEDSfnKDOcxnRP86SWcxS+yh4s7WyQE2Mitu1
         5RtmU2GidWXd6f7WiJashE9Qqgssg/o/2ZRHgnj8zz4nFdcijcP2eAfyDFXkg/VziKBp
         fqFqBR0KEsNPf44Sn9hQfNdXuWNfTxuGjgHy8vmo3vjX+y4J4MTqLR7vzKlkakM9kzyh
         AUOXbd9aDkpQYqCJqZ+9+RAw+U9zUkeKnbcGsk+a55lXbgYXhRF0rEFrElYYIkfkmzSO
         Jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7/gAw+DbnZtTNdfpuzCiVdL6RMHX2i8psNGo9On2wE=;
        b=g17PkaMpt9TAdx2L0O3mzOxEf1emtmZgiIHHQJpoVLDbo8n1q6qUBNY70sE7DeJ2NY
         xkV/R84n4Mj5Ce2d7xcXo/7XH9/sfV5oyP/ufIcyGuWoW6n3KHVGO1rCkyjPpF0V9cw5
         373QoDst4MsN1oBC8UoM0W6BO7+qo6/BYpH3Cx/jSmeLaBvEUvh6+QWxhZYoMKwv6rbr
         aLe7hMcV2VZCAYfIR+aAfjZcv7Cx6zxHuEUWIsFq+8NiGffS2aZuSmfu9dj4+9+E0hnc
         6rn9wIuqjLgLKe/vd2AZDJfWNp86gXWQcXrskBvynl4k1jk2dei9eSXgcwl56qMK2zik
         O9Lw==
X-Gm-Message-State: AOAM531qaDBFcffJL6y41oZRcxWqIfeUB2x4lRV103jaUA1aMSkVuCXi
        zW1emPXMKCHBcpahNcWyLP8=
X-Google-Smtp-Source: ABdhPJwKkX7DtmzDeIcS50PuB5Lq/wQhby7A+8VQURHoYiYvl5JNbYQ/SGWLW3UA2emPereAn1aNbw==
X-Received: by 2002:a05:6402:268a:b0:416:7ed0:3f86 with SMTP id w10-20020a056402268a00b004167ed03f86mr589970edd.255.1646759954659;
        Tue, 08 Mar 2022 09:19:14 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:14 -0800 (PST)
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
Subject: [PATCH v2 08/26] usb: gadget: lpc32xx_udc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:00 +0100
Message-Id: <20220308171818.384491-9-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/lpc32xx_udc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index a25d01c89564..6117ae8e7242 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1830,7 +1830,7 @@ static int lpc32xx_ep_queue(struct usb_ep *_ep,
 static int lpc32xx_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct lpc32xx_ep *ep;
-	struct lpc32xx_request *req;
+	struct lpc32xx_request *req = NULL, *iter;
 	unsigned long flags;
 
 	ep = container_of(_ep, struct lpc32xx_ep, ep);
@@ -1840,11 +1840,13 @@ static int lpc32xx_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		req = iter;
+		break;
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&ep->udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

