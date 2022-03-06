Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57264CECD9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiCFRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiCFRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:34 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E503EF30;
        Sun,  6 Mar 2022 09:51:32 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so27459368ejc.7;
        Sun, 06 Mar 2022 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lnsjgc8gTgQJKHb5cwbwqNyvDuf7SwnwUQTslH8JIg=;
        b=NUkgQni0X1/qeySbGiP7hm5BAvV+9Q/VvDRnNz4MWc5wa3HELzvzA64dM+BsUqK2f1
         KX/cn1d2QSgwIJPbSU0DlmE7K/JjGfn/iTnhaeV62PSkYCUDFTFyzK+T9Sm6wMG57UEl
         teGnJjgldP1mdgxErJt4Pqyrxy3rPHJHFEu/nMaV7O6bFwOsEJeWhSbakTMq+cKXGYuF
         Yy4sjs9dFPKXsz3F06+/1QVHwbCFcwKB9Sll9WH9EX9MzsEYCHC5BWeEt8HvVO+zhKY1
         Yz5klNdlUO+Ro1IKWhLjVytM+9mpAZ4Y4/+eJlATFBOg0G+vCkNX7NundYOR2Hzx5Jym
         lIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lnsjgc8gTgQJKHb5cwbwqNyvDuf7SwnwUQTslH8JIg=;
        b=itSZMnnsDQ/w0DCHFasaEoF2gBGEZu1qJrNDFEy4O7ZLLtb2CLg/kaWiMGCyxSeyQP
         xvdk6gAnwXErHrvM3B11IixOJYLS9CJ0iQCVSWYq5bN80waRYCT7b9l72ltO0AQLMk/p
         6HNfHNEBK8fKzWQ4SW1I5ExNzBsnG4M+m14OmAq5TxkSocUP5z38rZNWCXTKk8KVNnyz
         dS1pquEADBltrOnAtPQ+ggKTFSAqaP0wJbHCXmjHZ/W0Y8cbdTWg+cJhjw1KaZOP5B62
         oFisi6zfpXgXcsIwRoDfSxrffan7tOctXT2dOw63pNzlY+3z93bzvdbag1jzANj4lAnq
         CG8Q==
X-Gm-Message-State: AOAM531m1nuCPK99L6X4ws8EftTOBfJL9LPQgOkRhs47DLZmOqVhM1E2
        FfhD4su7MjZnSNmC99afJ4M=
X-Google-Smtp-Source: ABdhPJxu6+Bb8dW2HuL99DdSI+RhF569LcaEu/oMldym/QqqyufCsU3wFtLHvfoB1DJzp/giTDNjbw==
X-Received: by 2002:a17:907:62a1:b0:6da:7952:d4d2 with SMTP id nd33-20020a17090762a100b006da7952d4d2mr6359621ejc.260.1646589090480;
        Sun, 06 Mar 2022 09:51:30 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:30 -0800 (PST)
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
Subject: [PATCH 17/26] usb: gadget: configfs: remove using list iterator after loop body as a ptr
Date:   Sun,  6 Mar 2022 18:50:25 +0100
Message-Id: <20220306175034.3084609-18-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/configfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index d4a678c0806e..938cd43e74c6 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -418,7 +418,7 @@ static int config_usb_cfg_link(
 
 	struct usb_function_instance *fi =
 			to_usb_function_instance(usb_func_ci);
-	struct usb_function_instance *a_fi;
+	struct usb_function_instance *a_fi = NULL, *tmp;
 	struct usb_function *f;
 	int ret;
 
@@ -428,11 +428,13 @@ static int config_usb_cfg_link(
 	 * from another gadget or a random directory.
 	 * Also a function instance can only be linked once.
 	 */
-	list_for_each_entry(a_fi, &gi->available_func, cfs_list) {
-		if (a_fi == fi)
+	list_for_each_entry(tmp, &gi->available_func, cfs_list) {
+		if (tmp == fi) {
+			a_fi = tmp;
 			break;
+		}
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
+	struct usb_configuration *c = NULL, *tmp;
 	int ret;
 
 	mutex_lock(&gi->lock);
-	list_for_each_entry(c, &cdev->configs, list) {
-		if (c == &c_target->c)
+	list_for_each_entry(tmp, &cdev->configs, list) {
+		if (tmp == &c_target->c) {
+			c = tmp;
 			break;
+		}
 	}
-	if (c != &c_target->c) {
+	if (!c) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

