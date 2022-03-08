Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5528B4D1E94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiCHRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348956AbiCHRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AA53E29;
        Tue,  8 Mar 2022 09:19:12 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so40605536ejc.9;
        Tue, 08 Mar 2022 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqEmTO3TB/BaMOOEvwW8TYss8zdrlc684GqD43um0jA=;
        b=MknBCaYjNSx5FjYohsB3V90sOa3skz8+dy14c7CqGtA0tEwwZ5wvIXZCgeqE/IX3oB
         kA7xE3rPUlO7N5R6W+PkqTISltnbRLdNlbIjMLt6VdsIja2Q44JuObhb5z6Nv2YEbxg1
         XzntsZkh2QKOsh209A5T2OmhgGhg8ClpEzGT4uW7aRkrQYhl2b5yWNRaCmP51EWmBr3e
         kgeNKfjGIiP2ghbFMrBymVM7L3Xuk4ARC1aOlEPSHM5v7mEuTHP2KAHcik1lxoo9z+p7
         dCFMFv3VNf4xBHyWAPZAJAPV6BpbEefpFvnEmU3Zi1x/yrKnYm52EB+EqaERzOUkqKXz
         YH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqEmTO3TB/BaMOOEvwW8TYss8zdrlc684GqD43um0jA=;
        b=usDZ637vQNIvLuKBBmW+SiKyBbi+MyjWsM3GCBR1AF9JBJOSILNHXLs0AWreIf8NRu
         2cZrdkrl2LQGBrdyLGQnRd+OJAqAVQz0+W247dedg32OV3arml61RjF9GBvuxF4vnPJs
         UNPm28Whtv2eF/s++rZUYL/8QkesAzbiApmE2A4LbVCuEDzRTGP/goq7D/aMYOp4OgVw
         UVkuUDuzS2tPOaqQ8MXDH1sR/ryNGnSdwXkiWVAabyFQgQUZE/PHKlYN2iGS/Dxp2W7k
         1RHNlxBzYJt8eqIqoGd/H3Mc2aSwG5mQhTfk84xeTwxx0cL+sBK3ozH67etpMvi2hWjP
         3lbA==
X-Gm-Message-State: AOAM531wdTbPHfL7QOuMLRfxvLBpHQwSOOu9z9T1MmOHYth52HeKkwc0
        vJlnVmyS8fCrjlUXi/D+vKM=
X-Google-Smtp-Source: ABdhPJxgM4gBfD97zrZlv2Pm7LeoIlsoIGLLsBJYwEZqxJ/VlYoDNnA7PvugfvnWnpvIYyhnapSYBw==
X-Received: by 2002:a17:907:6d0e:b0:6d7:c85:5bf5 with SMTP id sa14-20020a1709076d0e00b006d70c855bf5mr14212710ejc.31.1646759951355;
        Tue, 08 Mar 2022 09:19:11 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:11 -0800 (PST)
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
Subject: [PATCH v2 05/26] usb: gadget: udc: at91: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:57 +0100
Message-Id: <20220308171818.384491-6-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/at91_udc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 9040a0561466..728987280373 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -704,7 +704,7 @@ static int at91_ep_queue(struct usb_ep *_ep,
 static int at91_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct at91_ep		*ep;
-	struct at91_request	*req;
+	struct at91_request	*req = NULL, *iter;
 	unsigned long		flags;
 	struct at91_udc		*udc;
 
@@ -717,11 +717,13 @@ static int at91_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
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

