Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37874CECE2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiCFRxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiCFRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADC3EF35;
        Sun,  6 Mar 2022 09:51:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x5so16956339edd.11;
        Sun, 06 Mar 2022 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3NmIv2lxSwyciO5fMF4SzE6/Z1J/5GfYbZbUZ0NpkQ=;
        b=GloWxkEKoUd1n3zcMloIVrOvLZBuvCZEyIWCJYqYe8TaK774kpfNhEyp6TgDKNPmGS
         VkP4epagNT//AJdlnorqgF8WrOeoyJwLIdmPDefytnlMJ4eTXNmY31TFDYpTNRkUzIpQ
         Ni/a6TyP8Lgnt+DB1NE7UcmKmGVTRaq269eEuazVe9aRVf01aZkftAHuE2+oo95/RjT1
         xkpnhRhork+4bL9MP2QRYXzI2qpjJor5GdFEWo+rT/5R8UJIo5s4rrugIXMu0QsLhnvd
         j6HeoWbk1FJXOzkjmPljO2HjeXA7OFH+HQkJXd3fRyB+5biM4HEzwX0yxbrMsLNOboCx
         BZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3NmIv2lxSwyciO5fMF4SzE6/Z1J/5GfYbZbUZ0NpkQ=;
        b=DeRzDLyrvNUbq1EuDCV0vTHNCQdu0jogs1xkU1RDfBEb7j/17CG0yqFHBJ/ZI5DG5b
         TXfLXvubjy/vsniG2uE6hRIsA2DuDJ2m6t+LANPZMMAkxZRCfsQ0XwizUDWeEvwwUVBV
         SaY+AckxwliHU9fOI1pIPitu8iXDGZnG7dZJQrLbz/utWwkSp2cKAlluzTIbGinge0EX
         wWk/I6ttU4UElPsEkThhFtsyZjPx88eGiN+Fz+o18TPvdvqC9H6c6C/W39gcldFOAzo4
         75J+qby9juoo7QGTwP9MBDGbgY2v0zQagGAn33uZaVxE3kNZKY8A0bhb2EoxR6OZi6BT
         avqA==
X-Gm-Message-State: AOAM531ajKv9h9jpV/koAg5dScYTwsQEvYPmhsCpCw2Xh/m+DS8u5kBt
        xDuFToj7R8X1k9FowQLQ+lQ=
X-Google-Smtp-Source: ABdhPJwrlyOl/C5mF6YI5RoCgIA4G9pTJYIaIywNTdmGCl2pJCordfAtGGDq+i/IJSpT/Y3ql53nXg==
X-Received: by 2002:aa7:cb09:0:b0:413:2be4:c9fa with SMTP id s9-20020aa7cb09000000b004132be4c9famr7771105edt.106.1646589094457;
        Sun, 06 Mar 2022 09:51:34 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:34 -0800 (PST)
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
Subject: [PATCH 20/26] usb: gadget: tegra-xudc: remove using list iterator after loop body as a ptr
Date:   Sun,  6 Mar 2022 18:50:28 +0100
Message-Id: <20220306175034.3084609-21-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/tegra-xudc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 43f1b0d461c1..7c39d8a9e49d 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1413,18 +1413,20 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
 			struct tegra_xudc_request *req)
 {
 	struct tegra_xudc *xudc = ep->xudc;
-	struct tegra_xudc_request *r;
+	struct tegra_xudc_request *r = NULL, *tmp;
 	struct tegra_xudc_trb *deq_trb;
 	bool busy, kick_queue = false;
 	int ret = 0;
 
 	/* Make sure the request is actually queued to this endpoint. */
-	list_for_each_entry(r, &ep->queue, list) {
-		if (r == req)
+	list_for_each_entry(tmp, &ep->queue, list) {
+		if (tmp == req) {
+			r = tmp;
 			break;
+		}
 	}
 
-	if (r != req)
+	if (!r)
 		return -EINVAL;
 
 	/* Request hasn't been queued in the transfer ring yet. */
-- 
2.25.1

