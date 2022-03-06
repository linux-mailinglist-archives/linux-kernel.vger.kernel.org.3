Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE754CECE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiCFRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiCFRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C09506EB;
        Sun,  6 Mar 2022 09:51:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f8so16968780edf.10;
        Sun, 06 Mar 2022 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIKVutnxEysZ3U/cjNJKuYZZfTcEA1ZCqcm3z1Xao3w=;
        b=UleLf2dhL9Szmy2LjLz9bQqE+eNX2Zqw8wroyzAwLb/VV9+tWkFka18JPNNO1s1AXs
         8gmaSD4orpEcgiczNCZ+hkuaGoXWwNDuHxJp/amJ99N8sAoP8ml+d3VaZlzE55iNF16J
         OoDGdQy/Zkcdg1F2ApRIppgjy+m75qOdYe61TgDqqoHQ6L7C9QeX1c1gnlQJq3SFM/6F
         4kJxaUj0F4CArnHBoWYnzTv9xAPyBgny/nTEeAdzjl8o9IZ9lX6BpmI0VoaLoL4K+BAs
         bvgCqC0VPqnQgTQ7DjesQ8Guh+OBWAyUDOKGHZaflTumfX1XlIpD2kKoFoHLG12Res+Q
         WPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIKVutnxEysZ3U/cjNJKuYZZfTcEA1ZCqcm3z1Xao3w=;
        b=PSgqFgilViN1o4tiAOmLYPoQ8ASTcTYfYwgb8hUf02Q7Pe+WAb3+zJsEPreT9AUzdh
         ZJOoxTHd9a6lTj6Gp9lSN9x080+kiAlL+ol3g0FtLguJ0m3/gIaCjgmi9XkVfPlzCp5p
         c1R9qjsYmfq3g94xxfScIDVgZ5VzbLT+Eu6abJ/gN8aVvih1KP0TNp/8vS+Nmvg27HGL
         37smw0iJ1AVHpzhm/Kng+o6qOPVH5fCRzMhFHJ9b33ybLeTSi+Y50zPMrSUJxJzCiVo9
         csQqNbS0tZpFr3jlejlZKfbeTK/XXI29Zgsbq1UFYwX3z6DizpAx+txSkmw7KyDcCZI4
         Othg==
X-Gm-Message-State: AOAM533mImQO5hgZedez5a+thcnKCqGNk0kCpgWiKqXJzzlhMc7+E6Zd
        Q3jAdwkuQXpc1ALV+cAPVBg=
X-Google-Smtp-Source: ABdhPJw9Wrru6dPfApYi1EfgKhejBh/FB2r353EJTeD8/6lapCo8eTErkF1EzwyH+mwoYjOGCEWRSw==
X-Received: by 2002:a05:6402:442:b0:416:14b7:4d55 with SMTP id p2-20020a056402044200b0041614b74d55mr7575292edw.183.1646589089229;
        Sun, 06 Mar 2022 09:51:29 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:28 -0800 (PST)
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
Subject: [PATCH 16/26] usb: gadget: aspeed: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:24 +0100
Message-Id: <20220306175034.3084609-17-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 917892ca8753..82b54b6a052b 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -466,19 +466,21 @@ static int ast_vhub_epn_dequeue(struct usb_ep* u_ep, struct usb_request *u_req)
 {
 	struct ast_vhub_ep *ep = to_ast_ep(u_ep);
 	struct ast_vhub *vhub = ep->vhub;
-	struct ast_vhub_req *req;
+	struct ast_vhub_req *req = NULL, *tmp;
 	unsigned long flags;
 	int rc = -EINVAL;
 
 	spin_lock_irqsave(&vhub->lock, flags);
 
 	/* Make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
-		if (&req->req == u_req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == u_req) {
+			req = tmp;
 			break;
+		}
 	}
 
-	if (&req->req == u_req) {
+	if (req) {
 		EPVDBG(ep, "dequeue req @%p active=%d\n",
 		       req, req->active);
 		if (req->active)
-- 
2.25.1

