Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3287B4CECE8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiCFRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiCFRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:46 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AD54BEB;
        Sun,  6 Mar 2022 09:51:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so18613264ejb.2;
        Sun, 06 Mar 2022 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zn5EzvNdFkkfq9WLeKE8vnjWGv8x8y/sNNvXHm8oKGY=;
        b=CibBxlAmJ+b26tsYTln2yODIK63moPUKBg4ThtwpcCVTkYbiGYvteUI4hjDr/ZILBd
         5V8FzlHyysBxSBVejJif9uF53N50M69JZH8UJP6Nfqjcto+8qkRpKoO3JZL5qhJoVZwu
         QcPM1uprJtw7VigiwDFrt0Hf7EaegTMcXMOAZDSv8wLRZvEXbAsMcxY6kAtL/ghXvPS+
         8FLmhGhVM3JF4DYdGOHF//Eq8X0nnLtbxaqZkpulpa3LFwqQKuWmWncmLfofoU9DOPhe
         0yw62fUb6Bu22Y91COkYc6CEjilGXRxZ6VZVbyPURaNRpBObRNOTcXim5OLmoZ1lm6ww
         B5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zn5EzvNdFkkfq9WLeKE8vnjWGv8x8y/sNNvXHm8oKGY=;
        b=vzA4RIs709JdhazHoELc7nkVF5bG3DF0Xc18RsbeLgCq5jqJRVGfetfITr7tdysd8a
         /25bH6ir5N8sKn7dg70NMeIN3JFBM+f1SLtxxkIN6u3Qdeaj4FEkqeEEVgHneadDXoqN
         6yjO/uEcC1Fb9X8QOf81gp+ddyWfQpyN9+vONNSP4gWd6JyNB/3CkK2d2ogpm1+E0dYX
         Oi14YxlxBs11xdZ/o61+jF9VJnuvMAkJfH7f4hoG9+o0vvp6XrwR9vY4ffVku9KZpey6
         UAzpcETpdSLO7iFmZi/N72w/6o8tWQux4PWu7VMiaG9InKALDQozmjoJWEmSPESb9lEw
         AQZA==
X-Gm-Message-State: AOAM533RqfiN0lKGEYNmmcFQPcKW1ERjizmOaGPJr+/Ch//gMsUyMYSm
        IY0mMn6FLvgyP99neu8cLlQ=
X-Google-Smtp-Source: ABdhPJyEUmbzavFxuxNs5CE9PEv2BMQu0+VKX+xGhrNN14rjmWPymqB7BsY86nqd/5KkzLfH4r9ydA==
X-Received: by 2002:a17:906:4cd2:b0:6c8:7a90:9c7 with SMTP id q18-20020a1709064cd200b006c87a9009c7mr6466344ejt.439.1646589098341;
        Sun, 06 Mar 2022 09:51:38 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:37 -0800 (PST)
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
Subject: [PATCH 23/26] usb: gadget: udc: s3c2410: replace usage of rc to check if a list element was found
Date:   Sun,  6 Mar 2022 18:50:31 +0100
Message-Id: <20220306175034.3084609-24-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/composite.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 26908d012ac8..fa9f4aedf52d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -863,14 +863,14 @@ static int set_config(struct usb_composite_dev *cdev,
 		const struct usb_ctrlrequest *ctrl, unsigned number)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
-	struct usb_configuration *c = NULL;
+	struct usb_configuration *c = NULL, *iter;
 	int			result = -EINVAL;
 	unsigned		power = gadget_is_otg(gadget) ? 8 : 100;
 	int			tmp;
 
 	if (number) {
-		list_for_each_entry(c, &cdev->configs, list) {
-			if (c->bConfigurationValue == number) {
+		list_for_each_entry(iter, &cdev->configs, list) {
+			if (iter->bConfigurationValue == number) {
 				/*
 				 * We disable the FDs of the previous
 				 * configuration only if the new configuration
@@ -878,11 +878,12 @@ static int set_config(struct usb_composite_dev *cdev,
 				 */
 				if (cdev->config)
 					reset_config(cdev);
+				c = iter;
 				result = 0;
 				break;
 			}
 		}
-		if (result < 0)
+		if (!c)
 			goto done;
 	} else { /* Zero configuration value - need to reset the config */
 		if (cdev->config)
-- 
2.25.1

