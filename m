Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B14CECBB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiCFRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiCFRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB033EAB9;
        Sun,  6 Mar 2022 09:51:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so27354035ejc.9;
        Sun, 06 Mar 2022 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPCpnczupXrz9W1UzaA2UvvdLj0jWSqGpTMR1qrezRc=;
        b=j0EMQvl8+2JFYZUlgE872rr/CHUfMBvkLmRRjeP8Jd18PjclIYFaz3q0Hk2HglOYSp
         3tzyraqyo58yj3TBOuPP+CDiHYWcnSXC8pjo+upKsHSHGR3dBP6YQAac1CYPzpfR/CMY
         rNN5DyivS5cRKxfcmQwocdfcaESomgqDEkgLvMQywvwPJwpOyYYiNa/pdtz63CImBQaa
         l5CcytKrEbmYRgJdXHBXV8EXrm2rXkJRgqFeol0Y/L/pby3/roOv67HGcOnPZzQZLvSO
         XU/m6ksEQTRpm92iVrJHO0Fppic44cQuJS3yHPgjU4s9Xdsmg7oikUkO5y6SvEsl6t/R
         0E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPCpnczupXrz9W1UzaA2UvvdLj0jWSqGpTMR1qrezRc=;
        b=wzOuhORXfg9cIUAcBDdMioPYXcvD6hTj245LPpxvX2cGSXzPyEVWly4enLyDkSjuXJ
         kq0pmYQ2K3/eRE1uFIOXOMyYSZXLc91bZBVoJ0d7RkS3I4E54ERqG+iQUECCxG3a+Vpo
         TCcLix3ehnJzOjVIAcxGN/LM2noCqEGffYxTS23jLvjfA6xVDvg9YB4iET3wkiyMRnQ8
         aqOFeqZ2HQL3Zg1ctXwO5nALkjSnST9a0f2QBIwUeSlWtTuj+XoJcdZ/168LW29POk53
         GAcTPQo9S8lQtpO5Hl5mTygF/c4z0ukHL2cgOGRhOU4T6eA7AJ7t31c1NJzdO084LwSd
         QI5w==
X-Gm-Message-State: AOAM5338fKcoCy/mOrLIO1/XlCmMry2wtekJDnvqBqFEl6qiKfqkQlPO
        Evqf+HaNdb739BSihVprtd0=
X-Google-Smtp-Source: ABdhPJwCMo5cFS528QF7M7+g4FlKjpTer/lx3c1HJe3wVyPnxmbURlL20mxjfogl83/wbhAGgklMGA==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr6779637ejc.330.1646589075664;
        Sun, 06 Mar 2022 09:51:15 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:15 -0800 (PST)
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
Subject: [PATCH 05/26] usb: gadget: udc: at91: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:13 +0100
Message-Id: <20220306175034.3084609-6-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/at91_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 9040a0561466..3578b061a3ee 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -704,7 +704,7 @@ static int at91_ep_queue(struct usb_ep *_ep,
 static int at91_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct at91_ep		*ep;
-	struct at91_request	*req;
+	struct at91_request	*req = NULL, *tmp;
 	unsigned long		flags;
 	struct at91_udc		*udc;
 
@@ -717,11 +717,13 @@ static int at91_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

