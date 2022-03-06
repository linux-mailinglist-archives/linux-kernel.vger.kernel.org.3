Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81C4CECE3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiCFRxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiCFRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA864090E;
        Sun,  6 Mar 2022 09:51:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt27so27577422ejb.0;
        Sun, 06 Mar 2022 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nL7RfWQJUoD4Uxzup8Ya34s2l2dL8vEBMEWVZsq5Ao=;
        b=S+XeJpGyyiU19cam3cKA+JBLCqcrL6ui9Npkw6EC9KPEfYQ3WAQ9Ct1vo8chBsN8yb
         iU1XEJbGYEuq1O0PlZ+KNAjNzRCWvLpBSTW3N6IzbNLQNd1OTNHbgZxxilk5uGbl+nqs
         ZLIbP8a0H8nnMjKCFWGkAWVBc4EfGmYEySJFOR1wAeIrrv+lhqaJu29S/bkVLqWAqgTi
         6cw3qo+RLDDRmgnSbQhj5bUYjGPkBOhCmGdQUKY9nNZCl29i1jmSvwfPhKg6yB1K5RWi
         wdqJgU0G/ENcI3zYGRCT5z45pJBXnuEauCfZvtJ65//xFdxg2yYvJx2cA1BNHJFXZABs
         qxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nL7RfWQJUoD4Uxzup8Ya34s2l2dL8vEBMEWVZsq5Ao=;
        b=UEkIfmIJdMmRxXevBK+6WpugHZ8x8zQL3H2sUS3Stsi75GsrglZVH1FAhCyfVKhrFy
         oNYFCe2Q6YDAot63fdDsSwmKoEaHE+aU9uhjEEyZBzAFdQRC3x1dNF+mhX6mNIyTbsCN
         E1BBMoOQsDsWz2VwQLPNcCKrqy+RRlBKRrtA+WWGviVfWNsPW+REAmOEwZhkQXC8H+iV
         UvfNofkh2YLYV+bdVv/4gLUwT6zCUMqqyUJ+hcjW+rOfcjTn1QZ56Tf95SMPfz9adfJd
         d8eJkhQhfNIm4OGZm2EmcVe0Nqm29++HcQ0OLw33Bmb4y8+7FFTCIuknytCHYKnRp2Fl
         7h6A==
X-Gm-Message-State: AOAM530EsoBW8mIhqae3XxSswoPeOw0j2STS+MHP1RnI/Z1HkD5Xnl61
        FLq/NvXOawlp5Gfy6R/Pun0=
X-Google-Smtp-Source: ABdhPJxOmOH2jyWx2isFpTEsJYGn2fFofs/tdGmKq2C/AcUm2ZFI8lfEcJptT7RCZHzFu4wV6Pi1lA==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr6271973ejn.278.1646589100841;
        Sun, 06 Mar 2022 09:51:40 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:40 -0800 (PST)
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
Subject: [PATCH 25/26] usb: gadget: dummy_hcd: replace usage of rc to check if a list element was found
Date:   Sun,  6 Mar 2022 18:50:33 +0100
Message-Id: <20220306175034.3084609-26-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

This removes the need to check the rc value to determine if the
break/goto was hit and can be made more obvious
by checking if the variable was set within the list traversal loop.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index a2d956af42a2..f21944707707 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -751,7 +751,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *tmp;
 
 	if (!_ep || !_req)
 		return retval;
@@ -763,17 +763,18 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 	spin_lock(&dum->lock);
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			list_del_init(&tmp->queue);
 			_req->status = -ECONNRESET;
+			req = tmp;
 			retval = 0;
 			break;
 		}
 	}
 	spin_unlock(&dum->lock);
 
-	if (retval == 0) {
+	if (req) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
-- 
2.25.1

