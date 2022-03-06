Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172B64CECBD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiCFRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiCFRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793B3EB98;
        Sun,  6 Mar 2022 09:51:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g3so4774748edu.1;
        Sun, 06 Mar 2022 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2FhH0yga+1ZprCyQ8mgWVZmrZ4lYY4UAJgQ5E8IQzc=;
        b=E+Qu6ocw4n+hihu8xQkn9TyfRI6EjpCzNlRGG7PUu4KiFLnoJ36WHQfqSeqZTkvsR2
         FmxTx3vplf2nc3NObwZ+fLkYSAiXjjCJwXFqRkrdnHGJFEVWzHtAuFr/pWnInOMEAauh
         qp/DmG1rDmJldugEceQ1svH1aW2YjpB07YO6VarNMVb9cLipU6a8bvC7mAUxpW6H6rMc
         BF0PiBJ9DnkWShnWGNxeRVGVXLPHxIDhzDgM5KyRZZTWuI20A87byFbdeYVnf3ZiSnTp
         WYuvCRH68lQWANBZrUNsjedpXd5sv1SGjSmYYBk7IaNPLbQ6/xioA9m2tkVhnBYDgbaE
         ZX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2FhH0yga+1ZprCyQ8mgWVZmrZ4lYY4UAJgQ5E8IQzc=;
        b=UT61dBkv6BwNlH7QvR33QT3LdljJZqt3ASH9qQ0NLLFE44wFCzQWehunjUXznrV0MF
         aUwL7pWVO6Pl92NLFv7kZPFvy/szXwaoXCjfw78rV/c8n09cJ5C0z4nZmDr7r+WQ8g6o
         nK0DU8/KRUAQdxNY9vlaphy/Zu+xZdf9W91A70BjEFc7s0ZY6fqLGN+ceKOby7kp9OR0
         RtCl1ugX9SL3Mp24J0zCVm6LqfgLyaRwUpc4mPwZ61GfC59B/NtABqGE+jTeqtQUqhW7
         fnd2Eu6f70NeXM8XCWmSIjrtHACIe37BIKqhpgZfJZ2JeXJiviQiMjj+GprwFYWh3mPj
         xo+w==
X-Gm-Message-State: AOAM532weCQqBoalKRbrHk73a6Dkxut3GylSrDBDB/cwPzi7CrO6S1vi
        k8o6yDcce/yRAD4i+OH/Big=
X-Google-Smtp-Source: ABdhPJxBACPTk45fBGxLU2gQWl32g17pMRNIekQbZ7gghrWUnArd8SeXplL2CSP3jmthRQTNkokIHA==
X-Received: by 2002:a05:6402:1e94:b0:416:44fa:ef49 with SMTP id f20-20020a0564021e9400b0041644faef49mr1862665edf.0.1646589076847;
        Sun, 06 Mar 2022 09:51:16 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:16 -0800 (PST)
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
Subject: [PATCH 06/26] usb: gadget: goku_udc: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:14 +0100
Message-Id: <20220306175034.3084609-7-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/goku_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 3757a772a55e..62153e964655 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -809,7 +809,7 @@ static void nuke(struct goku_ep *ep, int status)
 /* dequeue JUST ONE request */
 static int goku_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct goku_request	*req;
+	struct goku_request	*req = NULL, *tmp;
 	struct goku_ep		*ep;
 	struct goku_udc		*dev;
 	unsigned long		flags;
@@ -833,11 +833,13 @@ static int goku_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&dev->lock, flags);
 
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
 		spin_unlock_irqrestore (&dev->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

