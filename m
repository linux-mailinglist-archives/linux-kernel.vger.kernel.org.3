Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9F4CECDB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiCFRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiCFRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12F3EAA6;
        Sun,  6 Mar 2022 09:51:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so27438916ejc.8;
        Sun, 06 Mar 2022 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLBHYSaeD3eFzFQMOP5a1mgmC2xAZpNxSDfQ1U/Maqg=;
        b=X6Eiym0FGEc/Yg2lPaH7lAvq2l4n8uQyMYgQ5bQFCommhQHJy9m6qmVkseS5uNsqMa
         3XfEX9CxwQPRbg2B4OkXWeqfC7zqF5m78NCSd6NpT+c0W+3XsV2A4zqZWtnfzw+o46L+
         PQ49OmX4AzP1O3Iz8a9ZJT4XQMPamNRj2g/Ef5EBA6kID9Ng5/kokaZMVIe1DzZX/4EI
         yLdpMu0W/WHGXEJv8ENoQpSG8aP5IV6cLpD/43UTgj7uEEfkMu0dXApbWPPYr8gDSLQQ
         i2MN5eGCC6DH5OOnoS7wM8RaSYkXz9t1e+x5zSsP7L95PQJE0hDH8eqLZD8fh+3ZObWO
         luKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLBHYSaeD3eFzFQMOP5a1mgmC2xAZpNxSDfQ1U/Maqg=;
        b=H6RNt3La/xOeBgSb/sMJhgZShbmB/PrNpdZHB8FSDds80Cp+ufO/KHtWrkDWJ5yjCt
         39Sv0hZkK+9jUkVAbM5HCOe1AOAynTLCzW45OkXgy5ZoFkqZDbadX4Kh50SWYNAjCJ+M
         v53R29riuQ6ZwL0k+hW/6+dkpFNFiVCcOxlXth18/2uZQGZkCMPFDTr6VZ4EK0paOpv1
         OcIGtB7yddUy2Cx1IxR4Vzfsfsut/2mYCILodNN7O9l4jZSSviI2wQbs7QDLZXJv85p+
         MR0lljdiEPERP/3sHKxWqW+Mh/bjAVnYoeW5v+T4qZlO8ZMAXrCdAH4uxNENbkGqoAWm
         Edag==
X-Gm-Message-State: AOAM530MdnkOuWTryXpu7jWW3ECtLZL0D/iFK6LtaSdDLYPNQaA8YjB3
        5zgD9UCtCp/IJZKo0N58pRQ=
X-Google-Smtp-Source: ABdhPJxDxPmdry9ej5ZNQ7R5EE2walSLSRO7ED+xafi0SIp4n09749RDjSh2oQFkuaZp+MS22p83FQ==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr6562556ejb.237.1646589095739;
        Sun, 06 Mar 2022 09:51:35 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:35 -0800 (PST)
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
Subject: [PATCH 21/26] usb: gadget: composite: remove check of list iterator against head past the loop body
Date:   Sun,  6 Mar 2022 18:50:29 +0100
Message-Id: <20220306175034.3084609-22-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limiting the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/composite.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 9315313108c9..26908d012ac8 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1690,6 +1690,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 	struct usb_function		*f = NULL;
+	struct usb_function		*tmp;
 	u8				endp;
 
 	if (w_length > USB_COMP_EP0_BUFSIZ) {
@@ -2046,12 +2047,12 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (!cdev->config)
 				break;
 			endp = ((w_index & 0x80) >> 3) | (w_index & 0x0f);
-			list_for_each_entry(f, &cdev->config->functions, list) {
-				if (test_bit(endp, f->endpoints))
+			list_for_each_entry(tmp, &cdev->config->functions, list) {
+				if (test_bit(endp, tmp->endpoints)) {
+					f = tmp;
 					break;
+				}
 			}
-			if (&f->list == &cdev->config->functions)
-				f = NULL;
 			break;
 		}
 try_fun_setup:
-- 
2.25.1

