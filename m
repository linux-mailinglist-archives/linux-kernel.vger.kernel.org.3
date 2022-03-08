Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C14D1EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiCHRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348915AbiCHRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A546C1EAF3;
        Tue,  8 Mar 2022 09:19:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt27so40907349ejb.0;
        Tue, 08 Mar 2022 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSwIYlrd4/uGvEtywTYOBSlI+/oM9Fdz2FSLOBGr2xA=;
        b=f82f42+N57pRAxK1PdtQfQj4EV2Dzh/MPG09nXy5zlY3XeI8nGy3r/XtVaZj5y814j
         I5RvcOiX9K4B0XHWrUqgSN5f+YN0AjRt9mlGOh2nm+Bvn1huEJmDo73cUitnPi6JgaAW
         sC2OR6jfGz7nids6AhjVhKJujGkL9BC+lDe9XfI9vwt4hN7YMuweP3wzPm8+wKsyeVyy
         1OMAclsJJ1Tyoai3wW4RO0MI/Pn2aEIcrAkszGcuGuAGDmDu93YRnaTYuS2FLhxklcD5
         SW4vUri6GNI2s48km3COIeUf7ysS4UuEdMsGgXnrJZgZagTqAbh0+AwXgRkp9H1+U/5n
         7mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSwIYlrd4/uGvEtywTYOBSlI+/oM9Fdz2FSLOBGr2xA=;
        b=NQDFNgLSCcMFxaty/LqayHgo42WWTPcHV1gsXSrGgVzlCflrgkjrKgaE2cIBEt2c5u
         Nzuou0QjtNVXry+FOrUvcm8U4fnxZV5UZZ+uX0ZiZakAMNwmiD8cRjkAbW+21DsXRa+Z
         UtnXCvn8QV+XhpG16Mz2CxM/qzemzKUpcEr21QoX+EGW62p20vATTlGNbkcbXpN7DyFl
         zsrOH3AfA5oVgpr+y/x/xZB1w/4g0zFd6aFNfrtUdWzr6g2pcrfP3hNW0e2Hbe7xywUd
         JssFP9hmVKLh8YJWAL/O44WkHPuoX/YRhRK3KGEuRHcYfjE/q2QiPXQHcda7qaQ/Mu84
         a85w==
X-Gm-Message-State: AOAM533Qhs954xJxQwgy/w3dRVPI8KtA9kpOfz3PjKcOFo1uEKPQ6tYk
        zUP80hZ5yWea0Nw2jR8hsR4=
X-Google-Smtp-Source: ABdhPJz9UfcDXea/5nQy+QRuBiqox5fM+PeNxCdRGj/ib2TEEALtD9dGo+U/+vlvR7k4ZgR0twFgnA==
X-Received: by 2002:a17:906:c10b:b0:6da:a190:edb0 with SMTP id do11-20020a170906c10b00b006daa190edb0mr13847639ejc.512.1646759953551;
        Tue, 08 Mar 2022 09:19:13 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:13 -0800 (PST)
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
Subject: [PATCH v2 07/26] usb: gadget: udc: gr_udc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:59 +0100
Message-Id: <20220308171818.384491-8-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/gr_udc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 4b35739d3695..22096f8505de 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1690,7 +1690,7 @@ static int gr_queue_ext(struct usb_ep *_ep, struct usb_request *_req,
 /* Dequeue JUST ONE request */
 static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct gr_request *req;
+	struct gr_request *req = NULL, *iter;
 	struct gr_ep *ep;
 	struct gr_udc *dev;
 	int ret = 0;
@@ -1710,11 +1710,13 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&dev->lock, flags);
 
 	/* Make sure it's actually queued on this endpoint */
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
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

