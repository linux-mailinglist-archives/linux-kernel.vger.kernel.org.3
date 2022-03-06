Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C752F4CECD2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiCFRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCFRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3F3ED12;
        Sun,  6 Mar 2022 09:51:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gb39so27430065ejc.1;
        Sun, 06 Mar 2022 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NFdMMV5Ey1yhbuTg2uQcwCqlUE+qS+Y12f/YYOvaHuM=;
        b=fh1SkZYAm3ePAk1Mtk/gHZqOd7f/fC7MnFMjF30YjRSDV/IwHeJr2wNdsG35DduIWD
         pDxUyNzCjL70TJv8k10SJhRlFYWBTCB0e3zzb1YdODkL3j0k8O7+oT6Ws8Hi3DxlF9t1
         PIPFKk0s5NWyLqKrvHBGrWL/jsIT9KMTJNZPVlq5H5DBcuMDGju7U+rlnXh5YdSmeaSe
         xWoq2DLDsaPRnXyz9AOcJVwr6DSdN950NFV2Ja6H9sc6M6hhFy/vuvGO40qV309/UfnL
         KIhmXk865a67Qt0EjSsUcOf5g6cRyJqrxq5zQ9xOrNr6FoupVGqGZMWaSVchOV0yG2K6
         k/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFdMMV5Ey1yhbuTg2uQcwCqlUE+qS+Y12f/YYOvaHuM=;
        b=tDlIiwFAEqQEWIIlUXLn6YCiLrK7kM10a6ZMSP0AUFgUcf61YvN/nxFmGT8TRxJ8+S
         2G3vOlGnkk9qhOwzJgX3RCyVyLSXqTDOTdmQN2ZF6iCE5cl+4PYNHaTpG21lkqLtbXMA
         pmcQJmL8+wQIXBJhB9uOH+6VRSB99C7grc1gQlcEekrOLqwVk9tFn1A9Jre+IsDTbitM
         ZFv1zzmzvbCCRC5vOZpX4X6YkHS89ur3chiXSg0/pD7W9WeM4zLiw6M4YPuSK36GbAXT
         lul1bj/PudnG21fki4HR6l+RmEv6Ska9MUi+g6s67yiKtbBnGnUD6tkRA1ZUFYl2A1uR
         6nbQ==
X-Gm-Message-State: AOAM533nMEtF+b4JazdPoINQt6lpxbb+y8wyuy5tesNQ7KUaAzWMRoYc
        2wWa/WET2cEUjjs146o35Xg=
X-Google-Smtp-Source: ABdhPJzJfVGmbCFueAPzln30rBhgT6WIXJ/8qm/UOPNvqiSVEtSUCZ7gxek+/A6tjkBYJF+NnHKbSg==
X-Received: by 2002:a17:907:3e94:b0:6d1:d64e:3141 with SMTP id hs20-20020a1709073e9400b006d1d64e3141mr6130918ejc.213.1646589084422;
        Sun, 06 Mar 2022 09:51:24 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:24 -0800 (PST)
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
Subject: [PATCH 12/26] usb: gadget: udc: net2280: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:20 +0100
Message-Id: <20220306175034.3084609-13-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/net2280.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 16e7d2db6411..dbf5592dbcf0 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1240,7 +1240,8 @@ static void nuke(struct net2280_ep *ep)
 static int net2280_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct net2280_ep	*ep;
-	struct net2280_request	*req;
+	struct net2280_request	*req = NULL;
+	struct net2280_request	*tmp;
 	unsigned long		flags;
 	u32			dmactl;
 	int			stopped;
@@ -1266,11 +1267,13 @@ static int net2280_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	}
 
 	/* make sure it's still queued on this endpoint */
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
 		ep->stopped = stopped;
 		spin_unlock_irqrestore(&ep->dev->lock, flags);
 		ep_dbg(ep->dev, "%s: Request mismatch\n", __func__);
-- 
2.25.1

