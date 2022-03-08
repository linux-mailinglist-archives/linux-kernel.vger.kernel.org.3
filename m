Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4C4D1EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348966AbiCHRVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348950AbiCHRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108554188;
        Tue,  8 Mar 2022 09:19:28 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d10so40741770eje.10;
        Tue, 08 Mar 2022 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dCBmFHyxMjKmIC0BzCXvYVTfa0KQ4RHK39a2T0M4mE=;
        b=Bb/qUdXLbI2rwxQQMu/NXlm53haClXaykwRIg8u9pDWFTx/EcM0B/6sLJeI2nRNw5m
         fkuS1QUg3euOCPRq6PgACL9W9TEMqDbVO+F/9HNXGb17eKcDOhbQ40Lvb5vUDYlGYxND
         CMDN/8o6vG0zGVgVV8jJdsCjZn4yhrAHze5oqXR9DZjrPZM17pMTmlVTHUgppCwlcCtz
         74FFMi68L8NEgU0Eqks7Z88FYfr4TWzIpJmPlTIZ0hmHllhV8IXEGv7pxjo9cGKSVWrN
         LF4fFpbg3EDbb9DdijKNsh64aBRfjMWkPK1D8C5EF42ocBvIFabVs7XrKp2N6LojEQ1L
         vByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dCBmFHyxMjKmIC0BzCXvYVTfa0KQ4RHK39a2T0M4mE=;
        b=NlI3cW13+gB0OaTVRdtD+qxo2TwYS+GKPxJLZaHEMsmfre1DkkesrwDGfLqqdxQUP8
         nxT/RE9lo08SOXQyRUpKN+r6BWnGyNB1rKjXmBaCbEINzu/9a8ufKiPpkjYyU2MI4Til
         icnsXNHrAzk73Batv3jpQZrXA7lhVgML8FbUtHLig5117otJnVxQB2hY/QqXx84ZMYSC
         Yth2BDXfTlSrDtLVBNdjr6VAf7yBPhG0muJNZZ55O31FQSPlBaoatXgFTdaB0rbIfHgJ
         zwxvdh2Qi3GaBjR85NY6fGYnjA08ZMuHvfDY2zyuEQ1UyPzBjS7jHi2eRYAhsbtDGhQT
         Nacw==
X-Gm-Message-State: AOAM532rg18ho2iR8OU4ti1TtKfpGlkg6C5ijgvw/C1+nyxR1cawBHua
        UzneGtXiHTY5SJ3tYhKJkDs=
X-Google-Smtp-Source: ABdhPJyuvZYmtYBOzs6KBwHbp9aTbm0jKyEeELbbNjtuD1H+7NenLtfzjI2i6hyHwvrqjcNNgcDS/A==
X-Received: by 2002:a17:906:b893:b0:6da:ab5e:ea34 with SMTP id hb19-20020a170906b89300b006daab5eea34mr14196897ejb.657.1646759967292;
        Tue, 08 Mar 2022 09:19:27 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:26 -0800 (PST)
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
Subject: [PATCH v2 17/26] usb: gadget: configfs: remove using list iterator after loop body as a ptr
Date:   Tue,  8 Mar 2022 18:18:09 +0100
Message-Id: <20220308171818.384491-18-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/configfs.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index d4a678c0806e..1fb837d9271e 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -418,7 +418,7 @@ static int config_usb_cfg_link(
 
 	struct usb_function_instance *fi =
 			to_usb_function_instance(usb_func_ci);
-	struct usb_function_instance *a_fi;
+	struct usb_function_instance *a_fi = NULL, *iter;
 	struct usb_function *f;
 	int ret;
 
@@ -428,11 +428,13 @@ static int config_usb_cfg_link(
 	 * from another gadget or a random directory.
 	 * Also a function instance can only be linked once.
 	 */
-	list_for_each_entry(a_fi, &gi->available_func, cfs_list) {
-		if (a_fi == fi)
-			break;
+	list_for_each_entry(iter, &gi->available_func, cfs_list) {
+		if (iter != fi)
+			continue;
+		a_fi = iter;
+		break;
 	}
-	if (a_fi != fi) {
+	if (!a_fi) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -882,15 +884,17 @@ static int os_desc_link(struct config_item *os_desc_ci,
 	struct gadget_info *gi = os_desc_item_to_gadget_info(os_desc_ci);
 	struct usb_composite_dev *cdev = &gi->cdev;
 	struct config_usb_cfg *c_target = to_config_usb_cfg(usb_cfg_ci);
-	struct usb_configuration *c;
+	struct usb_configuration *c = NULL, *iter;
 	int ret;
 
 	mutex_lock(&gi->lock);
-	list_for_each_entry(c, &cdev->configs, list) {
-		if (c == &c_target->c)
-			break;
+	list_for_each_entry(iter, &cdev->configs, list) {
+		if (iter != &c_target->c)
+			continue;
+		c = iter;
+		break;
 	}
-	if (c != &c_target->c) {
+	if (!c) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

