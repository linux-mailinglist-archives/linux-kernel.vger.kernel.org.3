Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24634CECDD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiCFRx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiCFRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F893EAAE;
        Sun,  6 Mar 2022 09:51:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr20so27420130ejc.6;
        Sun, 06 Mar 2022 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+21SkvZ1V0/Yykwt/4suhWYPa8wNy+dkzerfqHH80FU=;
        b=j0sbbeSivVNug0gFNVXL4njiYWbwx0G/t8XpNp2ot9fBGkc/MpuppbR6dq76oV9h34
         U4a9R5oAGigRltG4E2uk8LVf3Sr/Q+H5IItb3nj/xqIqPylZABLpRab8JloSPrOBLPYP
         SbwwnVfEaJOGR7jQcCi5VoarY+iDvxeAEpSZFoxf9vwuViVIpJj5i14UBiphGs7tq6Q/
         hIGFu9Goy9U9LBhAz6XYA1tQ+WhrjiEZugaELer4pLcWgtHB1TJuyRV7paYGxGpcPILJ
         3GwHXCcRDLlh8APdGthGD+mSejgQPfWUjBFv8SMHNb9JxUziDQunYUTisCu0PpEENUjq
         2Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+21SkvZ1V0/Yykwt/4suhWYPa8wNy+dkzerfqHH80FU=;
        b=Ll75Yf9Q4Nz8/OOlErr6/42+5giFPnkpdwcQNLb3PmGwm3BlTKaMaIKLi49TXo36GH
         D05mbx1MCzqFfiNKx17G1GxOhqEhoC5AxOdhhDD1rs0y7kCtJR3UfTnprSNjyQwHAZ0v
         ZssKknnHM+5AFx6keZjyrel0OwF4m9Yfj3HQeU+5hDumnlIB1lXYlzeje4jAQgXMgsX3
         KGRtoR77VAbfUa1TXvvLxN+J3+vcllaRqT5mTmxICfcrPlsjJdKST9jQi+i14wLA0wGe
         gxYFsXVTBo/RJLOYqzh4NtXVorp8XWGeICj0tUY5xp9DMul8mQG8tQTRnsTx30KPOACt
         z+oA==
X-Gm-Message-State: AOAM533Y8I8SDf9hQA4BHvfQ/P0ivmyLwbE5pDxtnE/8wQ+ODFz8bLv+
        U7qM8k5MeqKVOqg0kfS4aJ8=
X-Google-Smtp-Source: ABdhPJz+IRqxea7CTn4M8DREljvADWarmfOp1KMJjR26UN4FAa8Qc8zIgRSmkU15EdtUT+rM96ZaXg==
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id o24-20020a17090608d800b006d2131dbe51mr6483746eje.564.1646589093126;
        Sun, 06 Mar 2022 09:51:33 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:32 -0800 (PST)
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
Subject: [PATCH 19/26] usb: gadget: udc: max3420_udc: remove using list iterator after loop body as a ptr
Date:   Sun,  6 Mar 2022 18:50:27 +0100
Message-Id: <20220306175034.3084609-20-jakobkoschel@gmail.com>
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

If the list does not contain the expected element, the value of
list_for_each_entry() iterator will not point to a valid structure.
To avoid type confusion in such case, the list iterator
scope will be limited to list_for_each_entry() loop.

In preparation to limiting scope of a list iterator to the list traversal
loop, use a dedicated pointer to point to the found element [1].
Determining if an element was found is then simply checking if
the pointer is != NULL instead of using the potentially bogus pointer.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/max3420_udc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index d2a2b20cc1ad..d1b010b5f4a0 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1044,22 +1044,25 @@ static int max3420_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 
 static int max3420_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct max3420_req *t, *req = to_max3420_req(_req);
+	struct max3420_req *t = NULL;
+	struct max3420_req *req = to_max3420_req(_req);
+	struct max3420_req *tmp;
 	struct max3420_ep *ep = to_max3420_ep(_ep);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ep->lock, flags);
 
 	/* Pluck the descriptor from queue */
-	list_for_each_entry(t, &ep->queue, queue)
-		if (t == req) {
+	list_for_each_entry(tmp, &ep->queue, queue)
+		if (tmp == req) {
 			list_del_init(&req->queue);
+			t = tmp;
 			break;
 		}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
 
-	if (t == req)
+	if (t)
 		max3420_req_done(req, -ECONNRESET);
 
 	return 0;
-- 
2.25.1

