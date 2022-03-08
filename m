Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46954D1ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349126AbiCHRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348978AbiCHRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDD5419A;
        Tue,  8 Mar 2022 09:19:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q17so25426443edd.4;
        Tue, 08 Mar 2022 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9SG1/Vum4zcALdcRrS/dZdkcV9xg98RrAHqRdSRgAY=;
        b=JofGUORGmECmPMRyfeCgpacdZGtX8kTCkXo1V9bqn0kmDI7cVnjjfrga0H5AcMGLTx
         3+KEsNvj9PwC5EhLqCWMlFkoNLtz12sZezQDxC4mGa3GqGqAexEYowu8u5/dY3CKZG7M
         OqkQmiuT/vz4LD9Dak0Vu7gJKjbf90cJXK7hfwLBigxL6sP/O4ZD4WsxgkMOavQ3I+MW
         r69d7ujJy48OXAAQ7f9vIGu3HKUynY9irfc4+11KDQziuecxQHBvcOOgzYYJHd97qlQO
         ZwIs6nfSLBFV3f4XPag+WOejrgaDNhYl54YqPoilSOmRvzZCx9Fh53IUCuCokeJGOklI
         x5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9SG1/Vum4zcALdcRrS/dZdkcV9xg98RrAHqRdSRgAY=;
        b=I64fz82NZXSjNvhK6x1HUQwvNM0kMXG97yDfxhrnRpjiKRZz9N6tRXMj8fbSmf/iKN
         H/Efm13Zo0fM4SHbMpnUxh0p9c58VECVGPTMYoAsMp/XoMUNsjnoQca7SOgKcJ/V0fMg
         88Alo3LWP4WvxkUFuGv1F2RUqG4DBqu/+iXcnFyIRnLderuMdkFNEzXFSqdQryWD7aFk
         RkAiBI6GE4CaVf0HxkXy+uDfRq1PBAlJOB1vYUT1ZjQAhJQme2eXqxngwaunJKvElIwM
         WgfWa6b8Uex1yEmJisEoyxZ+54Cu/VVi0Nr567cYjWnhO96/xSjPhhjxG8mKJrC1egHS
         QeNA==
X-Gm-Message-State: AOAM532SnERl79GUVf6cNakeVwrlHgPdnyaitlS1g/yAUrKJODkwQayz
        D2qMRmiE5ArUDtgeCw/CApA=
X-Google-Smtp-Source: ABdhPJz7WrPed4Zkw2qQCJmozmz22m6kuxxosC22Wx+1shmn5iDSCzwUJUMWXp/gC7tn4lZcajwKaw==
X-Received: by 2002:a05:6402:5189:b0:416:63fe:fc6d with SMTP id q9-20020a056402518900b0041663fefc6dmr6718640edd.120.1646759976213;
        Tue, 08 Mar 2022 09:19:36 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:35 -0800 (PST)
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
Subject: [PATCH v2 23/26] usb: gadget: composite: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:15 +0100
Message-Id: <20220308171818.384491-24-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/composite.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 4f7e789c3e07..2eaeaae96759 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -863,24 +863,25 @@ static int set_config(struct usb_composite_dev *cdev,
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
-				/*
-				 * We disable the FDs of the previous
-				 * configuration only if the new configuration
-				 * is a valid one
-				 */
-				if (cdev->config)
-					reset_config(cdev);
-				result = 0;
-				break;
-			}
+		list_for_each_entry(iter, &cdev->configs, list) {
+			if (iter->bConfigurationValue != number)
+				continue;
+			/*
+			 * We disable the FDs of the previous
+			 * configuration only if the new configuration
+			 * is a valid one
+			 */
+			if (cdev->config)
+				reset_config(cdev);
+			c = iter;
+			result = 0;
+			break;
 		}
 		if (result < 0)
 			goto done;
-- 
2.25.1

