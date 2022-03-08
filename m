Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A54D1ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiCHRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348975AbiCHRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5F19C07;
        Tue,  8 Mar 2022 09:19:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx21so40743456ejb.13;
        Tue, 08 Mar 2022 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9K0gcdyqyJc1QtOxbnGCoxSlcO9DFr3Tv4OE16b7cHs=;
        b=KsliqEO2BmgRd/JUjeCagekkSlvlnEeYkzi1XuFTJZc312pDytb0eYxrKEMnvYkH1X
         5nRdaQnkab7c0r9kP8bCinM8AHhLYb4+jR2HSoBumHjNWHbVvPuXA3dQY1GNc0NsDgxz
         2r1PahOgdidTf4Mldm1VVfZBp0GNjXWkNdvep/m2da0y4mNRBFmcbVXJNAuEWfYuYp9P
         Xu2xsoYrJrp9Dcbqv14oZvUZTO6nz7cVXz3Fky5Mt3NvcuKOrvEwcMOXl1Poc0ct0AIB
         laB6aMGnzn/9HFgXkbVf1jJMY0CNHl4+h9NIIx9GVtkjjzf33RDEHgtbaF/4XaJol/nj
         /peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9K0gcdyqyJc1QtOxbnGCoxSlcO9DFr3Tv4OE16b7cHs=;
        b=J14wVZY/rDAc1q/qyejGtVXze5bB+V+9npGDlsS7lKzbCPR0Lf78PoHXK7DufoyY5R
         iDYEcE2lxf1jUrSpMDhz98hIRm9Qo2ilvbd7VH8EyqJJF72qXQRQGHjgnu0/Mux9GkJG
         oJXGs022w8FFfYD7rnMyvdr9gajl9pjlIen3mjRyCXNpRJw8dLqZH9jAnciONCRJWp4j
         VGZ2Aip3E0EJxbA4Kyeu/pLMt3ZEgWXa0mR6XMEd/jXUeKB/liqA8EP5u/rIFf44hLs2
         u+3NaPaIMr7EmlQd1c2D1SgAWbd3UdgDFA/luVG1nbNQN8324l+Y0hv9lCEsLOwwvyCx
         b57g==
X-Gm-Message-State: AOAM531JyshlifBdXCTR8R8rxw2Ixk/0S0lCQ7+sbGLGjxWZIzLPQwjk
        zQd2GgHpDmZAT7xCMqcOrmw=
X-Google-Smtp-Source: ABdhPJzROPf0on8GO23L49XUIf01Xp7An6s1Bg7AFDWIE/J91fVVH3cYCteWptRh8cz08W/V4nh/LQ==
X-Received: by 2002:a17:907:168a:b0:6da:9167:47dc with SMTP id hc10-20020a170907168a00b006da916747dcmr14227765ejc.126.1646759979025;
        Tue, 08 Mar 2022 09:19:39 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:38 -0800 (PST)
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
Subject: [PATCH v2 25/26] usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:17 +0100
Message-Id: <20220308171818.384491-26-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index a2d956af42a2..35aec8e7fc73 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -751,7 +751,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -763,13 +763,14 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 	spin_lock(&dum->lock);
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			_req->status = -ECONNRESET;
-			retval = 0;
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		list_del_init(&iter->queue);
+		_req->status = -ECONNRESET;
+		req = iter;
+		retval = 0;
+		break;
 	}
 	spin_unlock(&dum->lock);
 
-- 
2.25.1

