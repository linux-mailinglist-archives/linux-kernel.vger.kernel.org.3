Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F24D1EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiCHRV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiCHRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5CD5372D;
        Tue,  8 Mar 2022 09:19:19 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x5so25369090edd.11;
        Tue, 08 Mar 2022 09:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8sypLoqqUrLokDZ1BzWM/CJRguZ5x0Xpk1JVIhPD+M=;
        b=pzSWzeP0NZJI7823NFDxQfOeimyrLNPWnRxdQ0Q2zZpkwOJ2LxfVRP5kT/iVQkXkYP
         dJC4nMDHXqSVGosla1Mygiwl7sLIVTX+tGGNMRgeaGdvxUb4tOps1vVtEdMn+yGZ7YKQ
         jDCm8s401NwC61bRAOzIUso1sQKSPcOxyWze258ctr5oCmD0PKM4gxwvCVD+k2fs7fmQ
         m//ugy4ckRAT3cxsT4QFESj5lnwUzcFTm3YUaaFdd2sFxPjh+saGaDRbsfCnslazbefa
         5PZa+CtTM7BwjhCTfWHlwIZKTaBay2BrcgsioorxDbFOPWApXR9ErdQukCMbUsrY7lA/
         3RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8sypLoqqUrLokDZ1BzWM/CJRguZ5x0Xpk1JVIhPD+M=;
        b=MiZeOifNf0lUCoJnAZXwJgNA5SexvFYargHLkd2mPwItTHc3PPfCVOqGZz4cRwK/M+
         fGviOGxFGDf+VKPII6sniJxZe9LNtkkYMX2xSzT6qEcDg/2Q6SDqCUbCJuQNND32F38D
         ROvlBwj9aao0MnSz8HFWAs55XgE6BIU8oZwOgaqsiespKeKGQ5CsrT7KIIoVqOunuSko
         bGSkRkppZ9vWCDovOll9xVuMnA0mREJIO8t7aHAo5NhZBBGuTGEyKi5nw3jhfHYE1Mae
         bCLxWZ0Iq16WetND4i3Re6WHVas+/KQKGyQ7MKbV5VQldD8kbqEu3XuF+MhZOxDYgnNl
         VPgQ==
X-Gm-Message-State: AOAM531AKtN9OV7iRJ2NwfdkKkZJDSzLSaEY8kAdBR0eADUuR+NPKxF4
        qY3eAopSZzTtgNRVxNt43Hc=
X-Google-Smtp-Source: ABdhPJya6Jg7Xf6nO/bt1TDUmz8xwHdfXlH0dr4/PEoFUpTykApNyQsj86pewvESMbIv/HizWDLnHg==
X-Received: by 2002:a05:6402:d0d:b0:416:1d69:f23b with SMTP id eb13-20020a0564020d0d00b004161d69f23bmr17205986edb.141.1646759957318;
        Tue, 08 Mar 2022 09:19:17 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:16 -0800 (PST)
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
Subject: [PATCH v2 10/26] usb: gadget: udc: mv_udc_core: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:02 +0100
Message-Id: <20220308171818.384491-11-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/mv_udc_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b6d34dda028b..fdb17d86cd65 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -771,7 +771,7 @@ static void mv_prime_ep(struct mv_ep *ep, struct mv_req *req)
 static int mv_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct mv_ep *ep = container_of(_ep, struct mv_ep, ep);
-	struct mv_req *req;
+	struct mv_req *req = NULL, *iter;
 	struct mv_udc *udc = ep->udc;
 	unsigned long flags;
 	int stopped, ret = 0;
@@ -793,11 +793,13 @@ static int mv_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	writel(epctrlx, &udc->op_regs->epctrlx[ep->ep_num]);
 
 	/* make sure it's actually queued on this endpoint */
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

