Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5094D1EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiCHRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiCHRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAE53734;
        Tue,  8 Mar 2022 09:19:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qa43so40692680ejc.12;
        Tue, 08 Mar 2022 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HJBUWhz/z+yBIrs52yUQQJ33J6nMXIA1Dz3yTWuABU=;
        b=IZQCllcOhtivjRo00b2pdzZT1W1c9bLZrrhcqB6v9pBeI0JoJnJI6tN/Fm3HrUJMXK
         toBezpDJIY7dT0ixx4jlVSct6prrJrxoRlYjYPcveF4Qzi4Sm6jk+uJiIDKempwEi6v8
         6IweS5QMDulsYYOcygMq9u5QWMWzy/Zd1XvYlGnftuCWOKnJItF182wm35/lZB9f3RTA
         6CImUU7Wejii4psfBf623MONv+qSBsbM/TqfCP6HI0zWwgzOp0ZFNO/rAn60kx6ZF8YI
         qOR53Lf98kAw1z3U0by6WNUXloxZwTpUSSMDIYlP35zSlSdlOfwt/xUv/em+4MYEIRYq
         WlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HJBUWhz/z+yBIrs52yUQQJ33J6nMXIA1Dz3yTWuABU=;
        b=qTjeXelkKHcOHW8y0CGHRLY0pwZ/+kf8FWbfaVOD7JysIXTbJu6l/r7R+kkLOLQflq
         wA6GbYF4ZWTgr6s7Fp/Pn7N3mLOdvcSfJWNAnCjm9AaKtvF/WCS7+hggJ+imM3zxJU7G
         Oa7VozVFlY14tziSHxTeSq9up1kDFpr/kzREQzwZcXGwYVql3NufiK2Sby6rvGSQhToi
         YHZecmj5xIfyW9ZyV8J6ZlqWUgFGVQ72QKPMEtNXycjiBMGzle/yYSAxv4q3Ff2OeB7d
         Hfpp0WX0JTPJ8h91tOMLN1w6eehgPWL9KgpML5xuSFn/u1Y0+pux9dLBJQGtOxPXcvwk
         7vpQ==
X-Gm-Message-State: AOAM532Ml+y0l0r2z1lsk3thgyYD9ALMf2OZZG/BPRXezlv/XXYOR00d
        oY0HfkWSQqocm7BHVF2hvO6I7AyETCNUew==
X-Google-Smtp-Source: ABdhPJwxySYfIab31wVLTlBFHM59OFhBbDQYZ1H5XMGhoT32J5qfAoS4xgO3IxB6fBIWkcjHofpmUQ==
X-Received: by 2002:a17:906:c20f:b0:6db:b5e:b129 with SMTP id d15-20020a170906c20f00b006db0b5eb129mr11985182ejz.552.1646759963047;
        Tue, 08 Mar 2022 09:19:23 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:22 -0800 (PST)
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
Subject: [PATCH v2 14/26] usb: gadget: s3c-hsudc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:06 +0100
Message-Id: <20220308171818.384491-15-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/s3c-hsudc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 89f1f8c9f02e..bf803e013458 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -877,7 +877,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct s3c_hsudc_ep *hsep = our_ep(_ep);
 	struct s3c_hsudc *hsudc = hsep->dev;
-	struct s3c_hsudc_req *hsreq;
+	struct s3c_hsudc_req *hsreq = NULL, *iter;
 	unsigned long flags;
 
 	hsep = our_ep(_ep);
@@ -886,11 +886,13 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	spin_lock_irqsave(&hsudc->lock, flags);
 
-	list_for_each_entry(hsreq, &hsep->queue, queue) {
-		if (&hsreq->req == _req)
-			break;
+	list_for_each_entry(iter, &hsep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		hsreq = iter;
+		break;
 	}
-	if (&hsreq->req != _req) {
+	if (!hsreq) {
 		spin_unlock_irqrestore(&hsudc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

