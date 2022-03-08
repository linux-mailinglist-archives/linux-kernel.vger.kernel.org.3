Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CB4D1EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiCHRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348947AbiCHRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019C53B46;
        Tue,  8 Mar 2022 09:19:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c20so6975882edr.8;
        Tue, 08 Mar 2022 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiQ4puCFE77hcY5XsHWeEmKJVjDUyRyfQhSidRFLY4Y=;
        b=l0epHchFHciZJxsva8RSY8pNQ3WDGf/eZd1iy9Mq/XLOv+t96W3/QtX9vtGfgB/dCB
         W6w+V023vcKsjpn3UUO3VAIHmSgwpNv1jD9KR7BYD4H3KvRijf8TdUUrkFCxE8tkxKfD
         Cwd/q8dKe/y2W3MESJbRiaKly6OMLZsCDHV6i1KoUgEnuicD9SGghZFPZpS3QaNCgTpH
         eKQkvJyjAp+x4y+XrAPXRrooT94BRIM8gpw2W/CZtE/K8poXB2+5RWW5SHGPpV41DZAT
         hZZOxOywa4ggoLqriGpFYAIRvIAIVrPl9TzToEDd6c9EYGJOnjHj2m3vwhZTU1qdlbLp
         UgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiQ4puCFE77hcY5XsHWeEmKJVjDUyRyfQhSidRFLY4Y=;
        b=o7zmSAehNbj5sj5rUqsJHO7P/KwkAH6mcMnJaYpq1HTWytstboIYqwl/PoCj9C1DCX
         +lvoAc7ipb5H33XVvVbEQinecLNrod/fdgp+1U8/rwcIu71WYXTlNZSiZppJGSjVJ2Rn
         0NlHnNjcou/omODk21wjkztnMCLZN89FmD9OnoOB39t4CdDewye3I5rzexyscDTRstfY
         HkMagGcL+w8tuNDtNU7KwHHxZqHsL3OoXjo1FbfdxORVh1HanXpbPImGgMqzSUGf7LMz
         PACGbmMC00rqLdwUb7QlT2pn+Pi9lZ4p88+H4ZAKOJMKqfqEZzE0zg8oVJ0ItMkpRDo/
         oMng==
X-Gm-Message-State: AOAM532mzrq+v8K3BwXfXIxw2soLeUGYJkcmP0ILhVkETrnYl1nqETdo
        R2HwtFXNYYwMNPK98F3ZAG4=
X-Google-Smtp-Source: ABdhPJxY1GhaUsaCfE9od8zH2PGgh7xkgQrxbcExL3lAvQP4sM7TRLEFzzpGkqPP2VhjcBhAGqohbw==
X-Received: by 2002:a05:6402:37a:b0:415:9501:e112 with SMTP id s26-20020a056402037a00b004159501e112mr17432359edw.402.1646759949139;
        Tue, 08 Mar 2022 09:19:09 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:08 -0800 (PST)
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
Subject: [PATCH v2 03/26] usb: gadget: udc: atmel: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:55 +0100
Message-Id: <20220308171818.384491-4-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/atmel_usba_udc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2b893bceea45..ae2bfbac603e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -860,7 +860,8 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct usba_ep *ep = to_usba_ep(_ep);
 	struct usba_udc *udc = ep->udc;
-	struct usba_request *req;
+	struct usba_request *req = NULL;
+	struct usba_request *iter;
 	unsigned long flags;
 	u32 status;
 
@@ -869,12 +870,14 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	spin_lock_irqsave(&udc->lock, flags);
 
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
 		spin_unlock_irqrestore(&udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

