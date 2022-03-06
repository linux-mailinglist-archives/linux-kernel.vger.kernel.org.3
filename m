Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C974CECC0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiCFRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiCFRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75F3EAA4;
        Sun,  6 Mar 2022 09:51:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q17so16993183edd.4;
        Sun, 06 Mar 2022 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L208aYUAvmFOwTViVL6XBF7RZqXvYjdGwfAretzWmg4=;
        b=IoYTvM2bWygIsX2CvCBMpVLCoYblVVcewWXibtWmNz44ymmV4bvoTn/B+T3Fw0PXpY
         ZiEF0kClQwdsKnOI8e64l7Zo0lscHSHjYhb6gMs9p0swbveDIt3qNcVM3QXFCn6NOaV+
         FgNPitHO9r+cc0yXIbslu//pRFY4lLdI4Am9mMkcco36GDh53Z+MP38UFKnF2x7/tV1A
         P6n5UNfiRxPO8wR9F0mygdvQv3/t+NA+nGUDOPpNDtm69Bj3twUZzISJZL8bgJk+zNhs
         4ctk2Wq6IBvOQ5u2QoKHl8q003AXfsnT9bD8osXHsrevQiDVd10ckj1tARDEgQpuvmBr
         Ui5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L208aYUAvmFOwTViVL6XBF7RZqXvYjdGwfAretzWmg4=;
        b=UbLCw/ovFWoXjczjbULZTEUOhE5d4aJdd8VJmCXdGk6Fg7YK9Fz/mttILGbOmJrhhn
         eZGAe1lDt5xX3gO2oJ5UgBAGN8rmu6rhUdBQEed4T4rkgL3iS+Y9GTXVMvYmPwJSs23K
         79CEZc8J2txJ82ZT0gLSyva6KZKpck11aYkPrpVQxhkoad4GM1/pi5lSpPAuC+kWPg7+
         sKkZP6+gRTJUE31IgUoPoTrxqamPf49QOWSeVtpRLO9kpcoPtpZL+MKUUcCFDcWNGult
         ZS0yjuNRC/xSZkmZcfgkYP0uBJY0typCe7k3KGPFzJ+/3IBdTWWyMh3ib+hkEX1qIAyG
         wIHQ==
X-Gm-Message-State: AOAM531xCeR/BWXNe4uxMYjPjsEhJHy13dYE0CVEBGXO4V1s3ZiJjdVv
        lHZnOuAE++NEBQ0NOIP6xhc=
X-Google-Smtp-Source: ABdhPJzD47Zne4IS1X9b9Z2sK1bFOiRvhA0Sie6iMQ7R1415e4lDmSgo2DW52B9gVPgcbIvo7OjAgQ==
X-Received: by 2002:a50:d80d:0:b0:416:1093:9a8d with SMTP id o13-20020a50d80d000000b0041610939a8dmr7905877edj.28.1646589078150;
        Sun, 06 Mar 2022 09:51:18 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:17 -0800 (PST)
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
Subject: [PATCH 07/26] usb: gadget: udc: gr_udc: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:15 +0100
Message-Id: <20220306175034.3084609-8-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220306175034.3084609-1-jakobkoschel@gmail.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/gr_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 4b35739d3695..9a940c8f1664 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1690,7 +1690,7 @@ static int gr_queue_ext(struct usb_ep *_ep, struct usb_request *_req,
 /* Dequeue JUST ONE request */
 static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct gr_request *req;
+	struct gr_request *req = NULL, *tmp;
 	struct gr_ep *ep;
 	struct gr_udc *dev;
 	int ret = 0;
@@ -1710,11 +1710,13 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&dev->lock, flags);
 
 	/* Make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

