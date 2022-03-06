Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9940E4CECD4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiCFRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiCFRwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD949903;
        Sun,  6 Mar 2022 09:51:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt27so27576799ejb.0;
        Sun, 06 Mar 2022 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l//L7ocJGxqmRL5eS8666SYNKXhr7tX6wV7H1PEFO9E=;
        b=oM1vSktxE2Qr655ln7crRO/JCD5alzuN5GehEboD4d3pPEfnfRXPXwtGqHtPmzqC+Q
         AHEVWbibeibbpKr7SoPQTJWdXWME7xXZ2Y0g9GkAiwkBGbYvw1Cwc1bFjkJL75A9IYA7
         gbb6/0SrZEaIF4iq9l4NdHKO7eyWiZa07lbpT4rF+IVeLtcteDs8L/dJZsNJot6TfO3+
         I/sGZxCUV3T754Zr+SB072WVlEKfInG1RuqyR0fa4GMz4Nn7SVQDbssvq3jhSHDUgnOU
         /71LXM5AX+u1FeIITq9zCZ5+gv6MK018+GgSA7If2s7d+o2vpePtQMnbHx2tR8ZWiwdP
         PgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l//L7ocJGxqmRL5eS8666SYNKXhr7tX6wV7H1PEFO9E=;
        b=2e5BGMf4wiDB5SPMb0rhKSVObo6RMIFjjfO91Uw5f7DcqtfVRUqjP5qo65ileS7EJf
         WDUZfk2W1/UMaUcRkKOZU3G5bq/+L+9muQSBKNW9MEGXJni0evgBlK30hWhh9LgXTFoj
         ++y20bK/YD0pdcj2p+7sufa58FR1Rx5jzzk/Q8KncrFD3h8ddpoVOeo2hpcNh7ZrH4Rd
         PbvD00TU6f5x1E7nC9hZsF1DJgEmhN83Y8hFe5TVuKc3lvKqeSM3q1ibz+IG1fMmwhN+
         dreFKOwljYTycJsAubzwmb1AtX8UHCB+0qLZHTIjpfwgm+OjStAdiujGjRfqy2v1TtVc
         ILUQ==
X-Gm-Message-State: AOAM531llO/miJc64G1KVoF23+NJVAd10HDRzShmZIV8TcjH8S4KhBOF
        XLb5q1JHxWt8QOgDNckZdjo=
X-Google-Smtp-Source: ABdhPJx2VALjSdYBrZOfqyUmLmttVyLFzl8u+i6UgxBZg+en7rBj0SWM3EOhinsX10v2bBcLPvv0Lg==
X-Received: by 2002:a17:906:5597:b0:6ce:f3cc:14e8 with SMTP id y23-20020a170906559700b006cef3cc14e8mr6410110ejp.426.1646589087983;
        Sun, 06 Mar 2022 09:51:27 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:27 -0800 (PST)
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
Subject: [PATCH 15/26] usb: gadget: udc-xilinx: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:23 +0100
Message-Id: <20220306175034.3084609-16-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/udc-xilinx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 2907fad04e2c..34b7000f0602 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1136,17 +1136,20 @@ static int xudc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int xudc_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct xusb_ep *ep	= to_xusb_ep(_ep);
-	struct xusb_req *req	= to_xusb_req(_req);
+	struct xusb_req *req	= NULL;
+	struct xusb_req *tmp;
 	struct xusb_udc *udc	= ep->udc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
 	/* Make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->usb_req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->usb_req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->usb_req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

