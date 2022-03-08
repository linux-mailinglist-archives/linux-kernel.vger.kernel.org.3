Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A584D1EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349117AbiCHRWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349003AbiCHRUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B553E0E;
        Tue,  8 Mar 2022 09:19:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h13so13274283ede.5;
        Tue, 08 Mar 2022 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tLXmXSOjUs3IAXSFXQ9uS1yTf2MJG7I5qLldTbEnao=;
        b=ZwQv+ZYzEbmyyGZyL9N4a6ggod4N1RlbBwdslw7vDBQMj/75ezmdGmg4mRX8YSOx1T
         6mih52OI+PHzzaVbIu92wqChc+JDtorksT7ddIhQiEM9qKAJVnH6y55VF4nkpswXg/pK
         jf5esaFh4w5zRIHaWk6VvqUZY9VTjosQyLrl4ra4afLigz0qJ4orV02FGpopf9cMeWKR
         3Dqu6bLnzKf1AgE6XXARBy5mJfpxn9XiYNwjL22Mo5BduOvzkZUMxAE97QN3n/CMfuRs
         6OTDK+Lk9OhThCuG/jFqxw/W2yzBT0EDiSMx/14uiCnPQsRUfHR8hbFtMQuhyP/SBsl8
         9VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tLXmXSOjUs3IAXSFXQ9uS1yTf2MJG7I5qLldTbEnao=;
        b=ZxF4MKYghMx6f19OXdYZvK8joIdbAXV6DH9mWBNULMky1ssq3qdA7J1opKHhN954Az
         5/lV2n/YDcxwbs7dxrsN612PIv2AB9Frg7e0VwGj7QN8cDVzAsX3qTWz6QDsFTQYxXiZ
         bjJb1i3jufNYPpu5rj4zYHQQWLULSvWOt91DKjTkjf+q6BITNaIY9qx+TVBzrhybvrS/
         XvLGS37n/bCuVI/JbjdLIYyF7aMrjUDLmBE8+9kFVx9o+9jb9ZpKVuLmbp3iUDptyuIA
         gA/jPQRC8pwgVikffB7TyFes1jsvJZxiyt7pZmMr9jJSO1N7ElJP/sG6Mpc6WVLt0D7P
         BRQQ==
X-Gm-Message-State: AOAM532haSTvqfE/rOveIw4TDEPYmqr/1cuHjyzBj+zhCb3pAeMd3sTX
        ddLdCJevJYhGrOxvnucIcPQ=
X-Google-Smtp-Source: ABdhPJxiCgTengE/g8GyC8s54Z2vH1A4Pir28u+kldhuED5xvUq3bdnmEm833lpJDcdHZTZxRKPJ4w==
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id n11-20020a05640205cb00b00415e04a5230mr17277809edx.352.1646759973277;
        Tue, 08 Mar 2022 09:19:33 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:32 -0800 (PST)
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
Subject: [PATCH v2 21/26] usb: gadget: composite: remove check of list iterator against head past the loop body
Date:   Tue,  8 Mar 2022 18:18:13 +0100
Message-Id: <20220308171818.384491-22-jakobkoschel@gmail.com>
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
index 9315313108c9..4f7e789c3e07 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1690,6 +1690,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 	struct usb_function		*f = NULL;
+	struct usb_function		*iter;
 	u8				endp;
 
 	if (w_length > USB_COMP_EP0_BUFSIZ) {
@@ -2046,12 +2047,12 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (!cdev->config)
 				break;
 			endp = ((w_index & 0x80) >> 3) | (w_index & 0x0f);
-			list_for_each_entry(f, &cdev->config->functions, list) {
-				if (test_bit(endp, f->endpoints))
+			list_for_each_entry(iter, &cdev->config->functions, list) {
+				if (test_bit(endp, iter->endpoints)) {
+					f = iter;
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

