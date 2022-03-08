Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C314D1EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbiCHRVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348971AbiCHRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063853737;
        Tue,  8 Mar 2022 09:19:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d10so40740882eje.10;
        Tue, 08 Mar 2022 09:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBzUtejltuzioaBCpVkGKHSZS4YToJ0S8QSwWuTUsrA=;
        b=DS7uJaFqIcQLB59SzyS0eyDR+ZdfUSHmj1oWTQZ1VhQnZjri4p4CU444NxHEUdqBNl
         fzkjX60ppLKPVbMr6RtDLmz/ATtTQ8jicqYEsWJ7yhzJkSkWTT/V+Er+IHbeW/vDaSGF
         2UNLPa+ksVub7Ze9jwpe9cdlPv4FRW0K2mgGlZI079XObPOY+Li12mR7SsSV4jaJl4P4
         Lq5aIWxu1d4iJcXuquxYohpRfHgyOwXlOC4sXTKMdhXD6aktEtX+0fOeFlJeXZz0JfpG
         z1OFUT36WxiGon7Ud+UXMKzprB/IYNg18w37lW409ovU1axqlFAYPsuLBcv0/BcWOuK0
         +zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBzUtejltuzioaBCpVkGKHSZS4YToJ0S8QSwWuTUsrA=;
        b=jK0JuAz0cF7Ks05gLWRl50mip3rdo7QX4hi5AvcJF0fIIVX2tWSPT9LHYpvTdmyS0j
         KMGufYxyiwm+NZMIlvmbb6696uOJ1QGmcBSMw8KB6NmxXouW13WCEZL3aSlnRFhTGj77
         jYAa6vYcui4Er6EPz0lh0v6RFyxji+NIPoN0T60HQil+FySvtYdz37Ywq1OvE//geDQM
         S9xU5l5RkQLOQKB5OCTyQ/5ohTg4YnKqOaPaMZiop2Kw6NxoogHBoVGT9WROYp6VOV3/
         5DHhhMlzVlA1nDNC78rAe8znyew28BPh8NSsMi/X8zD4SEjFSkdDr7jjC7Le6CZcXmiz
         QrXA==
X-Gm-Message-State: AOAM5329OkB68s4NF3K7JHz4I1nokEa+nEU5TpPjRBfN/RmPo9oudP8J
        5CMQ+UQMuGcWXywOHpbz94k=
X-Google-Smtp-Source: ABdhPJxP6O4XCst4o8tZ/QgBmL/GTjneslG5zm6PvJtE7Y0RINKU24/J4DqJLulT0771j9xeXRDqCw==
X-Received: by 2002:a17:907:6e07:b0:6da:9722:8796 with SMTP id sd7-20020a1709076e0700b006da97228796mr13637953ejc.610.1646759958727;
        Tue, 08 Mar 2022 09:19:18 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:18 -0800 (PST)
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
Subject: [PATCH v2 11/26] usb: gadget: net2272: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:03 +0100
Message-Id: <20220308171818.384491-12-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/net2272.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 7c38057dcb4a..6a8884632273 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -926,7 +926,7 @@ static int
 net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct net2272_ep *ep;
-	struct net2272_request *req;
+	struct net2272_request *req = NULL, *iter;
 	unsigned long flags;
 	int stopped;
 
@@ -939,11 +939,13 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	ep->stopped = 1;
 
 	/* make sure it's still queued on this endpoint */
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
 		ep->stopped = stopped;
 		spin_unlock_irqrestore(&ep->dev->lock, flags);
 		return -EINVAL;
@@ -954,7 +956,6 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		dev_dbg(ep->dev->dev, "unlink (%s) pio\n", _ep->name);
 		net2272_done(ep, req, -ECONNRESET);
 	}
-	req = NULL;
 	ep->stopped = stopped;
 
 	spin_unlock_irqrestore(&ep->dev->lock, flags);
-- 
2.25.1

