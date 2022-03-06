Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A744CECB6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiCFRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiCFRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DD3E5F8;
        Sun,  6 Mar 2022 09:51:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q17so16993050edd.4;
        Sun, 06 Mar 2022 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KJD2l59oR//tzv+KJB1jDWKlj1X2HYA5Vg/4RaHEkw=;
        b=bBSm7yrpuQf8NvR6Jd/pLFdEMSIO7nfqIM/HE+oSKBSzDjP8vaLy/jZMNJO0bjaSIj
         9SOY9dwJ6PpmVGaav7JdR7rHAOQR0YkkZtMUtdpL5JgfSYQ2jwIagkClD9qWEPpIfaSz
         BZCjY3e3bY/5lp0AzacTV1aDCfQv0gigptseu48FWFW4wwk4htsM2KXZFle29LzS1/pS
         Vo/qCx27Xp5s0SqrWZrUUHLXedIE12dPb8OvwR7rA/eNiB1dwkjeo4+2gsWn001EUK5p
         BiAAFXh2FyjJb0cEb/ClAc6En4lszQQlsz3QqHLomEJQwAYg0TnEqajspa82TKgJ6/xd
         ugKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KJD2l59oR//tzv+KJB1jDWKlj1X2HYA5Vg/4RaHEkw=;
        b=2fnpA2oaUJgrghAxmfH1fepj0PJ0aJ3dn1qpRjPaRV8WhboizXZ6OpWtcJEffEKZgQ
         70HxWC11WDEo05tpOhGJl9/QSGI34i6Su4jMVOO+G1T2BkbCwGpHtRfA3d/poqb2IjYZ
         90bzSIKfQd6+0ZxvlZ+ctT6Ym+79Zyh6lD8RWvChHrAcaPRA6fAsAaLmIFoK4cTMUnkl
         KvS3k9HORAfH2gNtj8EYBfhQUd4MMOffdUDLKZ6+8usgth4bNQJrRPcDqISVBvyZKFfY
         PLOE+ortLgG9V5tBFIymEsWl9v8ogGrm83RZLqeO21P48HKBDno8xX6p8sM81XP3r1ux
         SX5A==
X-Gm-Message-State: AOAM533RU8lxF9aD6FFkFCpM1OQHtDtPZS7fG1tHDXeEPzjNi8DYUCg0
        W3gWuKOW9n12FANPQdvRqjw=
X-Google-Smtp-Source: ABdhPJzEwgTN+VhtiuAhGsjzB8Kjx0sKauMjB7e9IheDHqWCwiWA3p97ekn80zm0aTMLnAInrootsQ==
X-Received: by 2002:aa7:c551:0:b0:415:a2d0:71a6 with SMTP id s17-20020aa7c551000000b00415a2d071a6mr7615805edr.143.1646589073156;
        Sun, 06 Mar 2022 09:51:13 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:12 -0800 (PST)
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
Subject: [PATCH 03/26] usb: gadget: udc: atmel: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:11 +0100
Message-Id: <20220306175034.3084609-4-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/atmel_usba_udc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2b893bceea45..8e393e14f137 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -860,7 +860,8 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct usba_ep *ep = to_usba_ep(_ep);
 	struct usba_udc *udc = ep->udc;
-	struct usba_request *req;
+	struct usba_request *req = NULL;
+	struct usba_request *tmp;
 	unsigned long flags;
 	u32 status;
 
@@ -869,12 +870,14 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	spin_lock_irqsave(&udc->lock, flags);
 
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
 		spin_unlock_irqrestore(&udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

