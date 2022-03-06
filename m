Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417554CECCD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiCFRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiCFRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335923F303;
        Sun,  6 Mar 2022 09:51:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so27430111ejc.1;
        Sun, 06 Mar 2022 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rmkemrzx/JOj9Lp0lV6gklfrqlH7Nd+08eNmWTNXfaw=;
        b=RlPKuH/Q+b8lka1W/roXH6bVEoeOC0bFjtLQEoAl8bsVUuIKYQGhe5XH6YVOMIIBlu
         KNz9hBp9oD3qgQuOz1N7sUcuagtV7Gvm1AK7Elk+B/ulRqejs2wIhgHkuLHVjHYUwmp/
         FObh52tssEQFnYJF5WPC4V/t68ErcDZi6rZIBj2MPg7H5/PFbcFD8+rlnRk4cvzyljhO
         EyeC6NgWX5A90N3mrKet6OzTPQJ7Jmw/NZ6B+okQ2ERKP1Jqwj3Rv2m1QfgLBMw7lweG
         ml54H7twz9SkOneS3urr2iTAmcFFuIFa854zkoHpN3rpON7M7nW/J/EtnIEuYja9ToPz
         q5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rmkemrzx/JOj9Lp0lV6gklfrqlH7Nd+08eNmWTNXfaw=;
        b=JJJYIONoK4LJfb2YGPgEz4LV8EB+DPvfuBEA63r41yqje2lUexRBHQl5N5igS9tVw2
         fWudWSMuUQIAipJDxttEXbUzzFDXrpiQaKNpuzPb1sq1D0Q+AdWmRGtwnr+1prr4GQrI
         bSt9qhtSE4tL8htZpgXHN/gDBxwlQ1K0zZDJ9TaZrb/8FV/izT5XTJL16rWHYMISQNZg
         8TeqZy3LaJv1XoILLQT7UY8ynw9b1TKlwhO1Fg1zHjfvGOPyz8i2e4IryfPVxrr/9ki+
         13borVIgVHBwRV9ewXHcOMh0ECWMHSuqRgdZ3dmlP2KchxLErLR5h3Oi9n6OJCgnlAD4
         urCw==
X-Gm-Message-State: AOAM531wO7c+65QI0/RkuxvWUCjoJsRB89oBqowwpODOhiumRinFgG3z
        2yYNOkpxgWw0bZMlzqjMd38=
X-Google-Smtp-Source: ABdhPJyMA6ISo3GDhlEbHcpWhfyLwjDly+XGmCjMcbI3GH4w07Qtpq7UHDdo5QM7xnm715DMHBaHmw==
X-Received: by 2002:a17:906:16cc:b0:6ce:e607:ff02 with SMTP id t12-20020a17090616cc00b006cee607ff02mr6230706ejd.418.1646589085648;
        Sun, 06 Mar 2022 09:51:25 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:25 -0800 (PST)
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
Subject: [PATCH 13/26] usb: gadget: omap_udc: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:21 +0100
Message-Id: <20220306175034.3084609-14-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/omap_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 494da00398d7..e48a89baf44e 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -1003,7 +1003,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 static int omap_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct omap_ep	*ep = container_of(_ep, struct omap_ep, ep);
-	struct omap_req	*req;
+	struct omap_req	*req = NULL, *tmp;
 	unsigned long	flags;
 
 	if (!_ep || !_req)
@@ -1012,11 +1012,13 @@ static int omap_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
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

