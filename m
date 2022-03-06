Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41264CECB8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiCFRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiCFRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96C3E5DD;
        Sun,  6 Mar 2022 09:51:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x5so16955578edd.11;
        Sun, 06 Mar 2022 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utzkgFEY4qR62mpmuTqoKbVS/KHHWuTcrin4SG2ItLk=;
        b=dU8nCpPNeMYUssBxZy7S6AHFLVFKJLYOyJzP1aq7xOE0VDG28AJJQ4JnLwQlNXqMm5
         0qqGBMSzlynThyYX6cLA2RUxJlqqAuvN4A7h5IHBf94FQzjMPnFY4SExqC+ybFGf0hXu
         jvqhC7ayw1jDIC8E7/KUazqmDvKZ9vxQft3xCKFz71dq9+OxJDaUHAM/uMiH5S+mArgP
         HiozY5edfBGQuDs0YA3hGbuJau3xKxv3V2pJ8qIFss8Ri4cTc7Nc80bKKEQSjy84bCae
         8/ZjkTAA5zedjZVlMwVx0GOWBPcZycTn9XrrZnoTBN49WMk8MYd9jcerjP9+dG7L80xb
         OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utzkgFEY4qR62mpmuTqoKbVS/KHHWuTcrin4SG2ItLk=;
        b=Pt21ktcwjkMUsR9opUw2S+DdnJ2xJc9+y/2lSEwG4Ef0Nd4ABQJGhtpEt3YWv/VZJj
         cC/1BTtkSZxQBSRJFlk7PxwW+ZaVZ3P+MIOnIFsG7u/mra7kS6kz/+usy5avUephkty7
         H2lfQ6ao3QEjYKWOgMQW7MtwfH1EpK/tjIUHJagoFICHqzpZHLN8aByDh4DZsXFxFWLU
         Uu8ljUaWW51apP3ESwrYm6vLARkvs7Ckl1tL/6nD2qDKGQ+RcA0MVYn3H9R/QwpZCiBV
         E3Og1JHi5YMgcde4n5MjgcP1j52lk5isu06FD1msKEUbe6ZFFwX38OzzHIzZAtRNjpU8
         7BYA==
X-Gm-Message-State: AOAM531TypMy2YwVa//crvLuVpmmdrOumhPRVWip/lzIMVK+23vIFhYx
        HZyPefUq2fevKxS3OvEk8fVRDUb9kOO8s1ch
X-Google-Smtp-Source: ABdhPJyBvRe3Tm9Y4tGFrpfzQTpJdOxekhWPpbWfaYPc0+SljeyEqAFJc0JOS0vMfYEm10QkLA/0Eg==
X-Received: by 2002:a50:8708:0:b0:416:765:c4c4 with SMTP id i8-20020a508708000000b004160765c4c4mr7513658edb.245.1646589071949;
        Sun, 06 Mar 2022 09:51:11 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:11 -0800 (PST)
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
Subject: [PATCH 02/26] usb: gadget: bdc: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:10 +0100
Message-Id: <20220306175034.3084609-3-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index 8e2f20b12519..829e96791d0a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1757,6 +1757,7 @@ static int bdc_gadget_ep_dequeue(struct usb_ep *_ep,
 				  struct usb_request *_req)
 {
 	struct bdc_req *req;
+	struct bdc_req *tmp;
 	unsigned long flags;
 	struct bdc_ep *ep;
 	struct bdc *bdc;
@@ -1771,12 +1772,16 @@ static int bdc_gadget_ep_dequeue(struct usb_ep *_ep,
 	dev_dbg(bdc->dev, "%s ep:%s req:%p\n", __func__, ep->name, req);
 	bdc_dbg_bd_list(bdc, ep);
 	spin_lock_irqsave(&bdc->lock, flags);
+
+	req = NULL;
 	/* make sure it's still queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->usb_req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->usb_req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->usb_req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&bdc->lock, flags);
 		dev_err(bdc->dev, "usb_req !=req n");
 		return -EINVAL;
-- 
2.25.1

