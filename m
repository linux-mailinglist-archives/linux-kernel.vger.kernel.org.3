Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1414D1EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiCHRVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiCHRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:29 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193753722;
        Tue,  8 Mar 2022 09:19:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so11870017edt.9;
        Tue, 08 Mar 2022 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Xwh55eQSwcaZtIpEuubEa3snJRYfJZKo0U9fl9zdsM=;
        b=kZW6WNMGUGI6UDsR0opMMiH9QjF42kdBFsKGj8pxgNk0fUXJE4VaWpA3y+2BA7jb1d
         f71X0i3Wb+QdCNyIhE+PeCVWIAWd63uiKMLJVpDHdJDnmUljnaL4cW/eCljJ3Ar46gHR
         JGumFuD6ofO0tQPnUTdNU12XPeeh2WedvZ8uaBNqPstdIdFYzk56dxRiEd6Wnw7z1KWG
         oq3rOADg6PFQpq0nYX4ksTx0zy6pmiuxAm6szUZ4zw2j19xIMGdzKvYuTkSJkEzxjusb
         zrJsvZ4llZkUKlbQLt0tmYB2dF1wvc2lNzB5V1LcBLo3w9l8sKSt9nrPyoURXmurKb5V
         5KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Xwh55eQSwcaZtIpEuubEa3snJRYfJZKo0U9fl9zdsM=;
        b=eqxq2IrqCdI68OKkmtgahxEN8gW3khBjMnBsO+xZgeUKKfxGB+RDyn+d5nrlK9WmXu
         V2HcEJc1gRcYXmluAS9dsdHukFDjVqeNX7Euo1eeDvsGk73TRpNy3MwA68k0qid2NJcd
         AoRbMYv/ez/aHdyqiMXS10TdyDUh1ew1aJoGv/3GqnhrR0P+krhtLImJ2pkqGfi1nXxb
         2iJLf0FzNNm287hr2jITT8TJLJKIY3bx847VLwvcnjqzEWtG9tHZzngvLTadQHYK6WDH
         XjhzfvCr6dCnVHbedQTxc/4vp60TwI/FeQG/FWG9+FE3+sGs8/oBD0B9M2+9wh18AJA4
         cybA==
X-Gm-Message-State: AOAM5323np29kEBEyLSJMoNikS/pPFRkwjG6IjI53P3h3EkLFQYVxqHD
        hH7PdxVNxotZa5WcNCJH4U8=
X-Google-Smtp-Source: ABdhPJzn7nm9oRexQ46tTPbyy2OejdijLQSqD+yUfBb/3BUynmQMmnZSwgZZODE6fwhDJK11VmdRhQ==
X-Received: by 2002:a05:6402:491:b0:413:6c2e:bb2c with SMTP id k17-20020a056402049100b004136c2ebb2cmr17355132edv.196.1646759955799;
        Tue, 08 Mar 2022 09:19:15 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:15 -0800 (PST)
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
Subject: [PATCH v2 09/26] usb: gadget: mv_u3d: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:01 +0100
Message-Id: <20220308171818.384491-10-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/mv_u3d_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index a1057ddfbda3..598654a3cb41 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -844,7 +844,7 @@ mv_u3d_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 static int mv_u3d_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct mv_u3d_ep *ep;
-	struct mv_u3d_req *req;
+	struct mv_u3d_req *req = NULL, *iter;
 	struct mv_u3d *u3d;
 	struct mv_u3d_ep_context *ep_context;
 	struct mv_u3d_req *next_req;
@@ -861,11 +861,13 @@ static int mv_u3d_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->u3d->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
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
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

