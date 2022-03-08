Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CA4D1ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348962AbiCHRW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349016AbiCHRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0F50040;
        Tue,  8 Mar 2022 09:19:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m12so391173edc.12;
        Tue, 08 Mar 2022 09:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4vXPVmGTGf3aM5gfb7e+nenL3OxJPCKkBovWpiUsBc=;
        b=W3Rr+kQiOf7U/zNXKiIybgGxag2KDpokpz3hlzoDsrPnAoo7mSwYsX7FVlpHauDt1D
         U/U+aXwyG6LbcsGI7sS971Xky8MR5TJ9OvXnOCFi2gyPj2i6o/+a5oKfzN8A6KEbSDqX
         kwNgoQIltfQqgAmeU40FhKHt3vXGsizsHJIVobm3XraAP6z9uwlwPwGzTJMSy6TIBLHm
         XrzwrVinH1FLSJExs9eP9NqnLfa3TUamaGQN2T9BpN0itABrjntHycBirIqtZpxmYJf7
         QUNdoNEZ3A+z1UOPu2laXXrqD3fE1bj4lB9pEGTE4/YhHtRsuskK4amFL7kf8cd6yd0C
         DXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4vXPVmGTGf3aM5gfb7e+nenL3OxJPCKkBovWpiUsBc=;
        b=XMi1RC6MEfLfR4FMBzwPfSOkjHggob2WtwqyDfRz9KSAHJTd/lLOjbGLhwmGceuwx6
         cu5bH/5k7SbmGpxOlyXvbkD+3DV9DAn9bxWvnhJe6Dm1VFJADSpUx+YxlN87+hhQ35wy
         KBFGfUr6xRATrtz3EDv/E8Q26If2yZnMd5UutUAnTDr97/oXRDqUwDC8lY8AF53vBIer
         BbofVJP0tP9eSeNsmDJu6P+iTxsosEZ1uW5Atj6auLHkcVLiffjWiKOEiDUzpVUNChiN
         rCDYOtUNkMAviGsH+/OoDaQhmNLwRcHhET9m5VZtfsb5K4eT98XDNW9Ove742ouPl/Zz
         cL0A==
X-Gm-Message-State: AOAM531QhCJKfy8EmvGyDNIFw7TcPOybX6PuChmKR75rnvi7XYNZxywY
        Fo6QmDNES9Y8Ss5oZnji34g=
X-Google-Smtp-Source: ABdhPJxMQ0hlgL52WO6E1BZ4eLdJ/9lm/sh5VABLlk+17MAzErX+vHN8ZSGVSD+UI9O2z+wIwkhTjQ==
X-Received: by 2002:a50:9fa6:0:b0:415:fd95:6afa with SMTP id c35-20020a509fa6000000b00415fd956afamr17187529edf.200.1646759977655;
        Tue, 08 Mar 2022 09:19:37 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:37 -0800 (PST)
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
Subject: [PATCH v2 24/26] usb: gadget: udc: core: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:16 +0100
Message-Id: <20220308171818.384491-25-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 568534a0d17c..02735b463bb4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1528,7 +1528,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 
 int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = NULL;
+	struct usb_udc		*udc = NULL, *iter;
 	int			ret = -ENODEV;
 
 	if (!driver || !driver->bind || !driver->setup)
@@ -1536,10 +1536,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 
 	mutex_lock(&udc_lock);
 	if (driver->udc_name) {
-		list_for_each_entry(udc, &udc_list, list) {
-			ret = strcmp(driver->udc_name, dev_name(&udc->dev));
-			if (!ret)
-				break;
+		list_for_each_entry(iter, &udc_list, list) {
+			ret = strcmp(driver->udc_name, dev_name(&iter->dev));
+			if (ret)
+				continue;
+			udc = iter;
+			break;
 		}
 		if (ret)
 			ret = -ENODEV;
@@ -1548,10 +1550,12 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 		else
 			goto found;
 	} else {
-		list_for_each_entry(udc, &udc_list, list) {
+		list_for_each_entry(iter, &udc_list, list) {
 			/* For now we take the first one */
-			if (!udc->driver)
-				goto found;
+			if (iter->driver)
+				continue;
+			udc = iter;
+			goto found;
 		}
 	}
 
-- 
2.25.1

