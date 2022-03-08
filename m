Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D54D1EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346989AbiCHRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbiCHRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E9541AC;
        Tue,  8 Mar 2022 09:19:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so40814643ejb.4;
        Tue, 08 Mar 2022 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGvztHQgMCmpi1WqEUxl2BM0vU36m9yBUx2ET9/vf+0=;
        b=YyrXukfMZwnEEZrPAwnqcHzxASANGmibqZoi/p2nngxd92F83KKYuhPvflo1n7UjZ/
         ce79fBag3W+VLCbRaMz2UfupvxNw6V5dwuRHtgFIAyGBakgm3YNqPDvDnAoL8Mhccamq
         dsEQWyykl7Ze0+Tgy3DxSjxvraHDf9PzeGMiU+y2yihQWx3vkNtOEjUhI0gqFxnHqcqx
         05Y1huktCi5BqrKAiaBtMnVyRKwDkJNtWgFNxGLGFsdLPr8Uy0uFU6cwI9Xd3uI5sRGn
         CEkqG8+A799Re+i75Xi8rUdTGS2TMSRlANNSmycqyufFEw12xKqCjePBc1akYMKxt55q
         qESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGvztHQgMCmpi1WqEUxl2BM0vU36m9yBUx2ET9/vf+0=;
        b=gfmrwf0QhuAwSYHtfrmbCOtOAYMnzZhh89tFTmCy8jk3Os0+qeSXi/HsOUeAL0uHX/
         8t5Unynqf98WmzAL02dsaKiETn5e8Zh4Mu2iDvuMdA/dWE1jzJ1KeORK2qDQRNyHTdNy
         BQ00yUKJwHKcAg2Cx+ys0bxASuAgpGBkcSaQh+ej0aomieC+OCxKfuf0jw7c68bI6ZLx
         5EPUvMJkeV+yq1noKAGLv75AnRmQVfYdH6XaxNn+9gjnIlqEA6SpZlMk+uQDDYh840ot
         kQiuSX4bcMAgAdWp1veOv36C61rs8fu6uPfyqxVSoDzoWvtzN9JusPR2NgTHJqxLQeca
         YwhA==
X-Gm-Message-State: AOAM5306RTTssOTmlUOUbGl7cIVpZk+y+FbmaBj7XFYlFw5NGTDRtGVO
        9a8h4Xcip6hLg4gCbE+wMJ8=
X-Google-Smtp-Source: ABdhPJxqTg0GziD1cdaKhTgOaoQ1oh4ah0h7WtaZ2oq/YqBiCtz55nU1fdk6ICxaN/CpfIvCnfEA9Q==
X-Received: by 2002:a17:906:6a81:b0:6da:d7e5:4fa with SMTP id p1-20020a1709066a8100b006dad7e504famr13910360ejr.223.1646759970436;
        Tue, 08 Mar 2022 09:19:30 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:30 -0800 (PST)
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
Subject: [PATCH v2 19/26] usb: gadget: udc: max3420_udc: remove using list iterator after loop body as a ptr
Date:   Tue,  8 Mar 2022 18:18:11 +0100
Message-Id: <20220308171818.384491-20-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/max3420_udc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index d2a2b20cc1ad..ac8a46bc1057 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1044,22 +1044,26 @@ static int max3420_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 
 static int max3420_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct max3420_req *t, *req = to_max3420_req(_req);
+	struct max3420_req *t = NULL;
+	struct max3420_req *req = to_max3420_req(_req);
+	struct max3420_req *iter;
 	struct max3420_ep *ep = to_max3420_ep(_ep);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ep->lock, flags);
 
 	/* Pluck the descriptor from queue */
-	list_for_each_entry(t, &ep->queue, queue)
-		if (t == req) {
-			list_del_init(&req->queue);
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (iter != req)
+			continue;
+		list_del_init(&req->queue);
+		t = iter;
+		break;
+	}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
 
-	if (t == req)
+	if (t)
 		max3420_req_done(req, -ECONNRESET);
 
 	return 0;
-- 
2.25.1

