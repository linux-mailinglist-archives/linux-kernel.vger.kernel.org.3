Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF134D1EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349087AbiCHRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348986AbiCHRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E253B68;
        Tue,  8 Mar 2022 09:19:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so31927368ejb.2;
        Tue, 08 Mar 2022 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fephKwqGahaE5ePrpyTUfZ7vzKqhC09iEtMfdAncdNM=;
        b=bRM/OMuDGEv0AZGOOzGCmNCsSpySNqu07Hft34oEc9A6ak9XMmK+29xqpHDV97GpvA
         6zbYVmumIsOBgZnKtMh6+nvYaWqVcsUUWykf2ErUi5J6RWqEYk5ALbCHPcgq3K9dM25m
         cDhwwdMGrtjPdIWCfavmaPo2986IKJvS1y1Bg4OTJML9wNk7hnOF2hf+Zy55CQHZGnMi
         WOWCMvczodHmb4pi1JqtcqWldbpEJIUiFXKBZsOXYBbKVehmE+5GjDvhFXB2+3bL0z0C
         O4XG2LrZZ17yMk4WfeRr1QGFuct9eYkq0XdaIUzNsdLmjDhbyFOg7wkjUakFPNNOzmje
         520w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fephKwqGahaE5ePrpyTUfZ7vzKqhC09iEtMfdAncdNM=;
        b=5/Wkr7fESjE9VSpIM61L2GEyQn5z4hg5sjAn0mTut5hprYvs1GkDOfQCMEt9Pnz+cP
         B1o5qOLi1CL7GYcafAJWGUDYkww9irNIov9/+YKKhnyhJ5ISJl6l92ixMlqEP9ku//rf
         WIysA9+/Tc1QURkIyg80oVYiBHpf0QrVTGUAZskK8hgGf0M0DyTBJplKCKOtMaOKIeDU
         AEJNjbsAIedDNkOWF2sZ7JpahakpRGar7F796NVaUbQzZvMK25pHkMee+Q3LDiC0lNp5
         HpJgh+MN+eaTkM7eYBV2uGpCAbiUzCbc8n41uEAsZZ0GTAxEHNSXWOIbDmfDQbTbuaxd
         Ds3w==
X-Gm-Message-State: AOAM532okICEXspmjRJg7Md8uVa1lULR5i3iCnzR4G3Ws+VIxVzGKRHu
        vdrMGMrK4zOrF0cIDtzWmlY=
X-Google-Smtp-Source: ABdhPJxByY5nw9jmtNB7IUcf/8bjjy7qzOQPkkkPtk4UKkjYZWHA8u51uU9OkIsMOffHmN06pgZUag==
X-Received: by 2002:a17:907:961b:b0:6d9:acb0:5403 with SMTP id gb27-20020a170907961b00b006d9acb05403mr14001239ejc.568.1646759968956;
        Tue, 08 Mar 2022 09:19:28 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:28 -0800 (PST)
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
Subject: [PATCH v2 18/26] usb: gadget: legacy: remove using list iterator after loop body as a ptr
Date:   Tue,  8 Mar 2022 18:18:10 +0100
Message-Id: <20220308171818.384491-19-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/legacy/hid.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
index 3912cc805f3a..1187ee4f316a 100644
--- a/drivers/usb/gadget/legacy/hid.c
+++ b/drivers/usb/gadget/legacy/hid.c
@@ -134,7 +134,7 @@ static int hid_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget *gadget = cdev->gadget;
 	struct list_head *tmp;
-	struct hidg_func_node *n, *m;
+	struct hidg_func_node *n = NULL, *m, *iter_n;
 	struct f_hid_opts *hid_opts;
 	int status, funcs = 0;
 
@@ -144,18 +144,19 @@ static int hid_bind(struct usb_composite_dev *cdev)
 	if (!funcs)
 		return -ENODEV;
 
-	list_for_each_entry(n, &hidg_func_list, node) {
-		n->fi = usb_get_function_instance("hid");
-		if (IS_ERR(n->fi)) {
-			status = PTR_ERR(n->fi);
+	list_for_each_entry(iter_n, &hidg_func_list, node) {
+		iter_n->fi = usb_get_function_instance("hid");
+		if (IS_ERR(iter_n->fi)) {
+			status = PTR_ERR(iter_n->fi);
+			n = iter_n;
 			goto put;
 		}
-		hid_opts = container_of(n->fi, struct f_hid_opts, func_inst);
-		hid_opts->subclass = n->func->subclass;
-		hid_opts->protocol = n->func->protocol;
-		hid_opts->report_length = n->func->report_length;
-		hid_opts->report_desc_length = n->func->report_desc_length;
-		hid_opts->report_desc = n->func->report_desc;
+		hid_opts = container_of(iter_n->fi, struct f_hid_opts, func_inst);
+		hid_opts->subclass = iter_n->func->subclass;
+		hid_opts->protocol = iter_n->func->protocol;
+		hid_opts->report_length = iter_n->func->report_length;
+		hid_opts->report_desc_length = iter_n->func->report_desc_length;
+		hid_opts->report_desc = iter_n->func->report_desc;
 	}
 
 
-- 
2.25.1

