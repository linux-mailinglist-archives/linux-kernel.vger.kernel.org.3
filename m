Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB464CECC6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiCFRwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiCFRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A283EF1C;
        Sun,  6 Mar 2022 09:51:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a8so27438255ejc.8;
        Sun, 06 Mar 2022 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYi/beh9rJs36gpPBNet1E5ZiL+QvpMPfNd9I4oRK5I=;
        b=a7pFL7YgsXz5wRHcetRqppCUPSvnDurx+UuP/B5/03SGZ5AQCyjn7XWWlWI19c6N79
         CCP6tlA3zxpmJMqH7LzugOBnbDYoAJ+aY6nvHPgoeGN7fLOYjBPjNluFqtOmoK0rZZvH
         UsN+qPAoeHTnolilx3Ag7LIAE8J+fCjE779jHRAK8hqYqYzbVHcCXBDu5sKuEUDZo+27
         M0W5nAKnGvg2BQMz7eMBvgaN0I9cXDLDcuN2/Mh2vd4KFE5OtOWmQNDxNmpiUSlxZ1t/
         3rlp1m/EbL9gj5VtzGwTbtywjw3KkRNwQHO0sWs7xBCUL/wprcoEJoVdHcyRZ/6KOkXP
         Y92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYi/beh9rJs36gpPBNet1E5ZiL+QvpMPfNd9I4oRK5I=;
        b=s6FrBzDLEQN8LTWzn8W42CwAcd2IGsDM/J5alPOpzuIke08oP0tjufy/SjoNlWS96T
         56n0ckzAUBX9f6DTx9D7v7a7z6aXQc2Uvp8xO5XVDpKJAxjsi8A6P6wZheNn0fUxBSsP
         Q5FH/ZAd10G41VlTgIsJIjJI5LIt2I/VBe94DFHGudMEq607QQcaYmcvZ4w5woJQrJYs
         aH7HM6Im3fUSQECpegD3yvL0nQzFRNRjF1cMwp3xzRI069xdA8nA69nNpxBnH8wwPXXc
         aR8kC9GRzkCwMknIiB00J/+CLCl9tPsx+disntJ/uOPmxSLHjDPsNnGbWdeYwENPkfjy
         zQFA==
X-Gm-Message-State: AOAM531yN5cqcoSm7EyzbiKiV/pl+GhQLV3jGm2sD9mpQ3LI19Y3OnH2
        rWWADXY6p9fErbVi/CRFqnM=
X-Google-Smtp-Source: ABdhPJyY+AsNP0zi56hP3Xjcd93Gh9olWpCas99mAx7qP67Dy550ZiJkzvNPQMQdredYm0hGz4HOqw==
X-Received: by 2002:a17:907:7f05:b0:6d9:89e1:3032 with SMTP id qf5-20020a1709077f0500b006d989e13032mr6260495ejc.320.1646589081967;
        Sun, 06 Mar 2022 09:51:21 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:21 -0800 (PST)
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
Subject: [PATCH 10/26] usb: gadget: udc: mv_udc_core: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:18 +0100
Message-Id: <20220306175034.3084609-11-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/mv_udc_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b6d34dda028b..67d935d29cb6 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -771,7 +771,7 @@ static void mv_prime_ep(struct mv_ep *ep, struct mv_req *req)
 static int mv_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct mv_ep *ep = container_of(_ep, struct mv_ep, ep);
-	struct mv_req *req;
+	struct mv_req *req = NULL, *tmp;
 	struct mv_udc *udc = ep->udc;
 	unsigned long flags;
 	int stopped, ret = 0;
@@ -793,11 +793,13 @@ static int mv_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	writel(epctrlx, &udc->op_regs->epctrlx[ep->ep_num]);
 
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
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

