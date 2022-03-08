Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F54D1EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiCHRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiCHRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9B53B76;
        Tue,  8 Mar 2022 09:19:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so27680032ejb.3;
        Tue, 08 Mar 2022 09:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIp5MlXygySPCwO7mdoHIhdgzDhIp7fZD6S7LhPAPYQ=;
        b=WlNGKUPak1CvnPMtyNgNi2hWe8vUySX3SFUz0MyTpUDSLIpJ3OXgXlHe5Z1opA92YF
         xXAAHkz8XTizVzSD0t1S26O3Sfk/aV7F2fGP/YMUxOdylQjf+MpRz9OgNgz9QOjAuHcA
         u4WsKLMoKmjOJ5ObJpVPRRAhDxICwxssyIvje4f5+I6GYkRoUAWDamD+ZAvAmXuAdNmg
         qAX3AHnvXyq5C8B9+4jLXMjdGcDSSHhXAJxekiGbM1vfdW2TnlBf3o5M91Bg1POzmYjh
         lFFDfc+bdmvWomVlY0cXSAPO8iyPyqQwhjvQBJw2OTQ3MfrxV2pWHcixqALu0MaHvnPY
         Gy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIp5MlXygySPCwO7mdoHIhdgzDhIp7fZD6S7LhPAPYQ=;
        b=mvxAaTNrh295U0aC6vTOEEhFQZowqNXfTeleX+mz0nDXncdyVuEHbBCDI1vne0yqKV
         oDHRl3v0w+x4iQrzhMyoJMwYNM6ONbaGDGuhkNN8BF5CWnwVK2lsgrjM7MhDvSwUIIhz
         WBp7mhXid9q8fjjIOcPd8ejANaBCZLSUnxaHchczXtafkqURZYRs/0f68Zp208jCbyNh
         2Qt3ixnnQkUuvj0EROYq0twcPHORQOkONw6e2i08TxhHI1XCFCXMGM5apPNu/AvV3Mjg
         ZvDdLMmOZQgV2/WelT2CY90+FtY22eDDDgPGOmMA4d4qqnKAnqs7SoBDbw5QFDXjdDkI
         CYqg==
X-Gm-Message-State: AOAM5336Xn/Vx2ki2xBW06kq9JWEJnTZAmBJUuZ26m+msCMXhA4CfN6L
        cIa5sEohvshvYqIl7Wr2NDc=
X-Google-Smtp-Source: ABdhPJwtX9Kqt5JbkWYPOZX7P2BCkV6Jk3TMjuPgoWOEpjqEJdNmLZBNuWS/ViFn1NpkTkKxghLTHw==
X-Received: by 2002:a17:907:2d11:b0:6da:924b:748f with SMTP id gs17-20020a1709072d1100b006da924b748fmr13877030ejc.584.1646759971897;
        Tue, 08 Mar 2022 09:19:31 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:31 -0800 (PST)
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
Subject: [PATCH v2 20/26] usb: gadget: tegra-xudc: remove using list iterator after loop body as a ptr
Date:   Tue,  8 Mar 2022 18:18:12 +0100
Message-Id: <20220308171818.384491-21-jakobkoschel@gmail.com>
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

If the list does not contain the expected element, the value of
list_for_each_entry() iterator will not point to a valid structure.
To avoid type confusion in such case, the list iterator
scope will be limited to list_for_each_entry() loop.

In preparation to limiting scope of a list iterator to the list traversal
loop, use a dedicated pointer to point to the found element [1].
Determining if an element was found is then simply checking if
the pointer is != NULL instead of using the potentially bogus pointer.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 43f1b0d461c1..1ad616d81c96 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1413,18 +1413,20 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
 			struct tegra_xudc_request *req)
 {
 	struct tegra_xudc *xudc = ep->xudc;
-	struct tegra_xudc_request *r;
+	struct tegra_xudc_request *r = NULL, *iter;
 	struct tegra_xudc_trb *deq_trb;
 	bool busy, kick_queue = false;
 	int ret = 0;
 
 	/* Make sure the request is actually queued to this endpoint. */
-	list_for_each_entry(r, &ep->queue, list) {
-		if (r == req)
-			break;
+	list_for_each_entry(iter, &ep->queue, list) {
+		if (iter != req)
+			continue;
+		r = iter;
+		break;
 	}
 
-	if (r != req)
+	if (!r)
 		return -EINVAL;
 
 	/* Request hasn't been queued in the transfer ring yet. */
-- 
2.25.1

