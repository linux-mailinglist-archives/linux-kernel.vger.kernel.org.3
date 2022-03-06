Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D74CECDE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiCFRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiCFRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624BB5DA46;
        Sun,  6 Mar 2022 09:51:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qt6so27421502ejb.11;
        Sun, 06 Mar 2022 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mabw6oo0UExXVw3UKbG1p1cOpksqyZA3+XNF2Z0ESy0=;
        b=Sj5WgvjVNGKGioDvkwEfdSxzknyIiisqz6LNams662IbPPPpzFVO3pBtK1+GOAO37l
         OFiGhAWIjmz1Tf717cO1p9miIL+PB3rp4alrNokui1CGX3/nJ/36VUxfv+X4C4DfO8Wp
         hgkYVde0YzBh0ru4Rz4yvU5h7rmYF0+CRyMpcpfWuYEmLdofFcD77E7I1gAxRti5bFt9
         WHm1Dz6hdklJQ8/AdPB9OZqS3VmIafvIpx6vJvPYafq5/08ywEqI5uPyMZ0YKk1Bsnwv
         M1jEUfDOI5I6rIaHI0pTLAbeni4JtGGS9o1LRIfwO4LwryhsPyoM8AkyK3SAGLaoTS+j
         8wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mabw6oo0UExXVw3UKbG1p1cOpksqyZA3+XNF2Z0ESy0=;
        b=SESvHTF9K4EXfJWrWqxdofXGd+bNsQyrBbY17LOlOzKSsZErz4IblOseOHqpesKBTR
         aQSvjcnHNPEG/UDcOay+XklpoVH7Y07F84mJBDyEyJa/xeTqJTYEVHWk7HUw2a7OGto0
         5TsNwWPAtV9hSAzLCFzbvp0q4GWvHNeXKCVLlRh8oA2HG+Q/drJf8RxbrFpp3VOLZwvs
         n7CmjHYi8leyV9aNZQpY6VnCBMPmA7wZzDAhQDXxcTmwOLfCPEbrZygf8+5KWbrMXDl7
         D+QX5Q25DNVWGNPtua64XOkKGECMYoJI9yRiRV7tTorHVMgftjAamMz17rWNk+ej7J4U
         ZNCw==
X-Gm-Message-State: AOAM530Q10UVgVgHJ66r8XMAMl/IGRz8bJ/+oKuUmCvwVz0EXmzIH3k6
        6TLrugBr3DM7ByC+xw44nPs=
X-Google-Smtp-Source: ABdhPJwHiCsF874nALTnLvOsZlmaSBwgAGtg0Nx9+1Eu9B5wfvuj0173uoVehKdX38U4l5Kw3rikUQ==
X-Received: by 2002:a17:907:a40f:b0:6d7:9f56:b511 with SMTP id sg15-20020a170907a40f00b006d79f56b511mr6476006ejc.674.1646589099630;
        Sun, 06 Mar 2022 09:51:39 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:39 -0800 (PST)
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
Subject: [PATCH 24/26] usb: gadget: udc: core: replace usage of rc to check if a list element was found
Date:   Sun,  6 Mar 2022 18:50:32 +0100
Message-Id: <20220306175034.3084609-25-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

This removes the need to check the rc value to determine if the
break/goto was hit and can be made more obvious
by checking if the variable was set within the list traversal loop.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 568534a0d17c..d3c269ce3851 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1528,7 +1528,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 
 int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = NULL;
+	struct usb_udc		*udc = NULL, *tmp;
 	int			ret = -ENODEV;
 
 	if (!driver || !driver->bind || !driver->setup)
@@ -1536,10 +1536,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 
 	mutex_lock(&udc_lock);
 	if (driver->udc_name) {
-		list_for_each_entry(udc, &udc_list, list) {
-			ret = strcmp(driver->udc_name, dev_name(&udc->dev));
-			if (!ret)
+		list_for_each_entry(tmp, &udc_list, list) {
+			ret = strcmp(driver->udc_name, dev_name(&tmp->dev));
+			if (!ret) {
+				udc = tmp;
 				break;
+			}
 		}
 		if (ret)
 			ret = -ENODEV;
@@ -1548,10 +1550,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 		else
 			goto found;
 	} else {
-		list_for_each_entry(udc, &udc_list, list) {
+		list_for_each_entry(tmp, &udc_list, list) {
 			/* For now we take the first one */
-			if (!udc->driver)
+			if (!tmp->driver) {
+				udc = tmp;
 				goto found;
+			}
 		}
 	}
 
-- 
2.25.1

