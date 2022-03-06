Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CD4CECB7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiCFRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiCFRwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024B93E5F8;
        Sun,  6 Mar 2022 09:51:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s1so16932675edd.13;
        Sun, 06 Mar 2022 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f5+1KVl6xG8fB1kYFIuwRtTBn1Y4V5ASbbZ+diDolcU=;
        b=ge0Bt7NZK1tqAmaS2XgbtreVorDpKfDnbik/79y+hzdYQPyOEQN0kNHebGiQ/Mmv7C
         6GLlb/rz9tsv8K0LUXJrDm86ShdR2hWJIq2vK6epM8d0hgYCw+ijpOYEhuBzGyZ2p+xy
         NltSV4qWtiPYvxilTjeTqq/aluaaxdcASdQX+qoZciOj56uXEyN8ft/qKMMUkraYrvq1
         TffadnFKU0tI3X6U8hJvIPZYMhFwfWTGtMpNklzpmRLg/atu+49rIfOWC4rtGlQcjKGE
         60bk8ZP8xjj5ofC6WtjHDZ0PHL/YIyWGtbInNtb1TfdrttpHn7imcV0+PSfRutlAe0BU
         gSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5+1KVl6xG8fB1kYFIuwRtTBn1Y4V5ASbbZ+diDolcU=;
        b=GB6zh1mf/o6zStYN5s2+FnOvni7rAm8yjTlDnQcpF4TseZSd328m4rOsnH8YkL0Mrm
         xCWtrBjrfl37utoUN0a2+D9C/vCHFAxbhFRVJbCbqQ7m4wiQA1B8xON1vPMlKjF0oncU
         pUZssS/lZU0pX/A5h0VIyPqm1KM8RZJ+QVsttFWjCGzDorSpVktfGyy2+1zbDfD+BYC2
         d2Quq4AcccGNe5PRhth9QIg2dcd2H6cqVEZOd6p9soz28uTeGtQU8w7q6tXWM+r4TAGc
         x1LORpbShzIPJ20LvDEHNa4hNweCPWQc7pktS7FGtIJSsIch/yL/GH1JEmkhoeMllnJt
         C9xQ==
X-Gm-Message-State: AOAM533qieX4ftW/AqA4AubgZ/+Z47XNd/S6svCZGJtYNlQZC0rn4K9j
        5s2OFLQV5f8O0Mc2/uIp5pM=
X-Google-Smtp-Source: ABdhPJwsKmgLwmn+m+ySNLhZ6J2/wCVO+QnZ592jatK3OtiS16z+klQADQuM2R4Xb7xzn5cwihOB3A==
X-Received: by 2002:a05:6402:1c02:b0:415:f555:38ba with SMTP id ck2-20020a0564021c0200b00415f55538bamr7566215edb.357.1646589074454;
        Sun, 06 Mar 2022 09:51:14 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:14 -0800 (PST)
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
Subject: [PATCH 04/26] usb: gadget: udc: pxa25x: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:12 +0100
Message-Id: <20220306175034.3084609-5-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index b38747fd3bb0..889ea52bbe0a 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -966,7 +966,8 @@ static void nuke(struct pxa25x_ep *ep, int status)
 static int pxa25x_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct pxa25x_ep	*ep;
-	struct pxa25x_request	*req;
+	struct pxa25x_request	*req = NULL;
+	struct pxa25x_request	*tmp;
 	unsigned long		flags;
 
 	ep = container_of(_ep, struct pxa25x_ep, ep);
@@ -976,11 +977,13 @@ static int pxa25x_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	local_irq_save(flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		local_irq_restore(flags);
 		return -EINVAL;
 	}
-- 
2.25.1

