Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA24CECE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiCFRx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiCFRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F053EF30;
        Sun,  6 Mar 2022 09:51:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bi12so14345023ejb.3;
        Sun, 06 Mar 2022 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcQZB6Ou2DJOpmDHHbEeLT9eVra9fyNzoo1Isgk0YuU=;
        b=G31UKxrXM0ceKXWQOtiF6wqKmSQfZ83nhi589fq6DGgiMF0n9ZjeLl0ryCQoijQWhZ
         ap6sQT6lAHkedMcbN/K/WLzVuF5S3JxkLhxnN/YkzZ4roTQRGmRChY7WvCci8/UfjCKP
         xMqmv80JZZBQkj0D9FhL/nsjA063Bb+aL4M640Cn0TEwlzFBDWJnmHUcIb1Qv3FN65VB
         CS93zKq4467GNhU81fFb5IqDD6iCQjONnEJL9MPiP/EDQR7YNz1O9vrRlhUGY+qCLvi7
         xrDlfLPQCjAR4ijT1aianHXk5XNVJTmO5oIU336kyiGQPheymeOqJjBFcJHQxxgO1BPz
         0mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcQZB6Ou2DJOpmDHHbEeLT9eVra9fyNzoo1Isgk0YuU=;
        b=TrNI0CQVImFV1iFpgjNCrSG6yjRHbQujyGuSeWZGSx1Hi5CElJkVyg4kGj4G5lTtFc
         rGeOuL3nh3+9Kbp6qMkQzQhVr+Pi3J6QzxdjgqNzbvj5eMndeQmTKzw/FVxeOfo6rDoN
         5T1D82Wu+J3Hc+71Lf8mScNWSyr+WVcRdlDLqByDrH8Cp/ADwexXd+SkfJsCd3tmSX0p
         PfzRPOaen+Q8XJVMV27NrGlz5gYImu8StjxvuMyeaFfM4wG7lr1mR91aACcZQbmRPLbw
         uRey46S5FofKotwuO27lkOOOgJH4dzFeMfOUmbrNjbWREVAF4L5aWQJFPGoy7QD/5e4P
         gNTg==
X-Gm-Message-State: AOAM532NJ7Q7kQPQQDVmmgM67NcpMg3KXWjw7ZgfTJD0+ZaPcDyKJvv7
        k/ueJBwAtyjoiw1VnxnVHYA=
X-Google-Smtp-Source: ABdhPJzIYgztiVm79b+tYLDse5ioBPvmL8FWLZSMdXXTiwy7PDaN42gD7M5HGDOIE0iwmdYSgsWvtw==
X-Received: by 2002:a17:907:1c20:b0:6da:8a7f:657 with SMTP id nc32-20020a1709071c2000b006da8a7f0657mr6640896ejc.730.1646589102253;
        Sun, 06 Mar 2022 09:51:42 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:41 -0800 (PST)
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
Subject: [PATCH 26/26] usb: gadget: udc: s3c2410: replace usage of rc to check if a list element was found
Date:   Sun,  6 Mar 2022 18:50:34 +0100
Message-Id: <20220306175034.3084609-27-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/s3c2410_udc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index e3931da24277..fe6ecb0d16d1 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1265,7 +1265,7 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct s3c2410_ep	*ep = to_s3c2410_ep(_ep);
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct s3c2410_request	*req = NULL;
+	struct s3c2410_request	*req = NULL, *tmp;
 
 	dprintk(DEBUG_VERBOSE, "%s(%p,%p)\n", __func__, _ep, _req);
 
@@ -1277,16 +1277,17 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			list_del_init(&tmp->queue);
 			_req->status = -ECONNRESET;
+			req = tmp;
 			retval = 0;
 			break;
 		}
 	}
 
-	if (retval == 0) {
+	if (req) {
 		dprintk(DEBUG_VERBOSE,
 			"dequeued req %p from %s, len %d buf %p\n",
 			req, _ep->name, _req->length, _req->buf);
-- 
2.25.1

