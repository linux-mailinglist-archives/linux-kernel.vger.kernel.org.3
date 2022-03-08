Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1614D1EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbiCHRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiCHRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7754182;
        Tue,  8 Mar 2022 09:19:27 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qt6so40750895ejb.11;
        Tue, 08 Mar 2022 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUQEfJ5ZyqNSxudWIneiwonLdZGLhD66gLNXujXNkd0=;
        b=e87KtjYpoNsPCzLOIfYAyMDd/So++VJyylS8RdS1RRJzLuwu7o4BtMGOZbLoBldbHz
         N7FnyIBi6zl5w/GWkNSankQUwGqwHJNPgOpk30+IW3nNST+8DZvRqkN1MF6ZpZgmB9Vo
         UEb/n6ESITLzMxCtjhkTX70+6TYpzvtwhJREeW63BpRRqAnMBx+dW0bIEUaiYLrI4H6/
         9eR8p92+Fou6PoMTYOPzM+XH55UkHXR5l0sB2QRQh/SIv3mGDnyDl+6DnAAn0hOMFvpb
         2dpdK+JSq1RIO4nmPd/6CTbSp/+NMnocsbpRCZgNzUg3r92b3L76ZOv7dsRboP4Bhc7v
         D0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUQEfJ5ZyqNSxudWIneiwonLdZGLhD66gLNXujXNkd0=;
        b=v3dlXAhI/kqlSRxaM087RUb58roY4vzunGQ8RcdKMqtek2TwZ2dY4Fj5sIXqVxZgHJ
         kyosCw5vlHMRn/vkedlwyzNl3WWY/Ppq2geyuD4kwhQZ9qvft2xiX958sZSzE/GRB3sB
         rlvh5UPPbuCHBbzB9e1DqndWEVtU9iOQLUZq7CPRilm7e19bMQo2rXYm26Lgn3SdK09C
         aJzawBoAh47nKaL00TZyivkNL9lWCTBu9oBKIW0cLja/kzJu4dr1EoVy59VQ+jGQo4H8
         FcVghuGBFrrPSCehx8A3lhWZrbsZ5jEwLWn7rVz9LECUanTC62vS9Q0hT62UhROir0/N
         tHRw==
X-Gm-Message-State: AOAM531yAIogFZ+INAnvBFzOR4BpjZY8ndWTJN+68cD/nIToxz1kC84M
        1YU6PqJr8BIq8DtxkXPqdkQ=
X-Google-Smtp-Source: ABdhPJz+PlyR0JPgtg3UxzSVkWCXAEbjloQHheDZopV7MNYQRXqYrxL4cAYKpfPsc8xd0W6WR6aB6Q==
X-Received: by 2002:a17:906:dc10:b0:6da:f383:86ed with SMTP id yy16-20020a170906dc1000b006daf38386edmr14048197ejb.391.1646759965847;
        Tue, 08 Mar 2022 09:19:25 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:25 -0800 (PST)
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
Subject: [PATCH v2 16/26] usb: gadget: aspeed: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:08 +0100
Message-Id: <20220308171818.384491-17-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 917892ca8753..b5252880b389 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -466,19 +466,21 @@ static int ast_vhub_epn_dequeue(struct usb_ep* u_ep, struct usb_request *u_req)
 {
 	struct ast_vhub_ep *ep = to_ast_ep(u_ep);
 	struct ast_vhub *vhub = ep->vhub;
-	struct ast_vhub_req *req;
+	struct ast_vhub_req *req = NULL, *iter;
 	unsigned long flags;
 	int rc = -EINVAL;
 
 	spin_lock_irqsave(&vhub->lock, flags);
 
 	/* Make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
-		if (&req->req == u_req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != u_req)
+			continue;
+		req = iter;
+		break;
 	}
 
-	if (&req->req == u_req) {
+	if (req) {
 		EPVDBG(ep, "dequeue req @%p active=%d\n",
 		       req, req->active);
 		if (req->active)
-- 
2.25.1

