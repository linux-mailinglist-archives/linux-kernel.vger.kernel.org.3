Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD24CECC3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiCFRw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiCFRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63283ED05;
        Sun,  6 Mar 2022 09:51:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so27492254ejb.4;
        Sun, 06 Mar 2022 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MEN8BkVwGONO6rf4oHEkv2XnGVYH4Y2hOyHB5gTgdc=;
        b=Lb6bciygqlIU9k8Og7P0lKRcEwndfuccYEAwLF0g5QHqH+NRevi1EaoIFKgRzLK4X8
         NBQZvnfouGvDLv8lezrBxCOWJlkspHv0xdda4CexewXs4zu9l694VKE72HlAm7n3Xyv/
         /4D9/AbmQUt7G0bAhDNJ3q13hGsn60qTe/Ur+yZxrbV2/CX/WHc6vvCM+W4ve5lGQgk7
         ivpc3cnTt6ltzX2FaTIBFhyaJrZ2YxGg9eqYVcPs8eybPVatlrVTXcdLrY6Hl2xuT/n4
         5E+1mnXyvt6PZowXxwrXwAyspgz4YlLzsqrjrAwoqIorYHvV2Xuk6kOHkJr/zsJ5Q86E
         h+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MEN8BkVwGONO6rf4oHEkv2XnGVYH4Y2hOyHB5gTgdc=;
        b=eyuWTIXuGZLAadR/97jaLGJMlgxh4DYu4YRX7LMRc5us42GC7FY10jv9ruIMoG/7UV
         WHpTnmZgBATvixzQSNQt7u4SYoifqtVDGorEoEqtAm34opBtHqD3Fl78SpsPnu5ROr3K
         Q3iHwtTgiZPSMmWFWXdO7nMUv0uqZjwgGdbzLuuVOHrvJTe2YqV2rIWuEsDRrHqbqaoR
         L2izdTCViycGRyLyP5j0ipChIhkFrBaPLmHx5Tfo4GT8B7hs73wxPWePqsb5OEzD0zj9
         FfzSs8Zb6xCRfKFjqxP7QAY/q9GTDPl8Mm483tD6kJDtebp6W3a/o84XYOVjCpa12pjq
         wGRg==
X-Gm-Message-State: AOAM531dWioTcOdTW0jI1oJx2uWXmZygCG/zpX45RlFG2tg9/G8Ju3jp
        OK9dIg4HMI1vW4xi5744p+s=
X-Google-Smtp-Source: ABdhPJzFuOz9Hj1XbpoGODW4cdhLhOjtj/glXonjgnix14QuEnG2iIifoF5PBF8a22LS7/Qr7eHlRg==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr6692389ejp.142.1646589079445;
        Sun, 06 Mar 2022 09:51:19 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:19 -0800 (PST)
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
Subject: [PATCH 08/26] usb: gadget: lpc32xx_udc: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:16 +0100
Message-Id: <20220306175034.3084609-9-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/lpc32xx_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index a25d01c89564..fbb235b1f23f 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1830,7 +1830,7 @@ static int lpc32xx_ep_queue(struct usb_ep *_ep,
 static int lpc32xx_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct lpc32xx_ep *ep;
-	struct lpc32xx_request *req;
+	struct lpc32xx_request *req = NULL, *tmp;
 	unsigned long flags;
 
 	ep = container_of(_ep, struct lpc32xx_ep, ep);
@@ -1840,11 +1840,13 @@ static int lpc32xx_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
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
 		spin_unlock_irqrestore(&ep->udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

