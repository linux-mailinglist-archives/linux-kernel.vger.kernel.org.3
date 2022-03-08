Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068174D1EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiCHRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbiCHRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18E53720;
        Tue,  8 Mar 2022 09:19:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qa43so40691594ejc.12;
        Tue, 08 Mar 2022 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DV/4uUkufHdigictOlTI0wPqj6AP/gAmirkywlppX9w=;
        b=R8ehEfpBbpb8D/RDxqYFEbDZpSJlJ34xGqApi+5PiMot+aaln0rnNVyyMpwDKc35HS
         xLKLKMqfhb36/qmIqHSpicU2bVGOtUuf8fdi0XjoRHfL+fHQVyf153yQYzXwt2pE0bk3
         1CoXoiN/SlIYYSLqZT7rkgVxV9Xx0IW+63M94wYfmr+6wYaBO9UgZxBbyju6tOv6WLcG
         SEaQC2HCFUeyPe3r2xTtcAnF+ISDQskzF0TT8Ur8xwScacndqA3uO3MfRm5Gd3Jp5fAV
         BO5zTlXswnx+0NrAKlVIRfsQd/7+Z0zJFfw+FrRSkpLSeZo16/MRgakrERc3wHvI6dvQ
         8j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DV/4uUkufHdigictOlTI0wPqj6AP/gAmirkywlppX9w=;
        b=XG/ek/XxwHSbX/7eui8PPzVDY6vMRC77BWT4vNvEzrZwuXaQ7AupQtvmNmr1usqzdz
         lwvQJS3MjMdZQVivVtmsSss+Mqb1p4OomfbUGoU6tnG8EbpiFHO5tkMtszVJ3blWQjWh
         HnDj8ERCxWSzvRJWslQddhnJiarRB8fgX0KwgSBpffFna4eQXM8/bX4YXHY+6UFjN+3N
         TMZgcTz0zVd+RT7S2Ytym0zoN8vl+TFg2m7Hxdb6wZoNVzXXKI4G9NIEmc28jKIl3RNW
         M0RGvxIODB7AoCMES+bhe2W6H99xaisqUGoM/VvFCeeYrt42piceolOPUJbIG4INKX34
         sFtg==
X-Gm-Message-State: AOAM533Vw3huapdIM0O2IgAnRs0Zei95TyHig0r4ykMrLqYQmOgyGR5w
        PTZsBO6Bzp/epTJnF/VR8C3gNkY+hxgbgXDb
X-Google-Smtp-Source: ABdhPJwEuBXuz53kqWJHuQd3HmWtXely2TzTrKv4yIHdO3BWD6+cVLl+4HEDbGKJXKGwITyH30fw5g==
X-Received: by 2002:a17:906:1656:b0:6cf:571c:f91d with SMTP id n22-20020a170906165600b006cf571cf91dmr14296621ejd.377.1646759952463;
        Tue, 08 Mar 2022 09:19:12 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:12 -0800 (PST)
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
Subject: [PATCH v2 06/26] usb: gadget: goku_udc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:58 +0100
Message-Id: <20220308171818.384491-7-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/goku_udc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 3757a772a55e..bdc56b24b5c9 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -809,7 +809,7 @@ static void nuke(struct goku_ep *ep, int status)
 /* dequeue JUST ONE request */
 static int goku_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
-	struct goku_request	*req;
+	struct goku_request	*req = NULL, *iter;
 	struct goku_ep		*ep;
 	struct goku_udc		*dev;
 	unsigned long		flags;
@@ -833,11 +833,13 @@ static int goku_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&dev->lock, flags);
 
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
 		spin_unlock_irqrestore (&dev->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

