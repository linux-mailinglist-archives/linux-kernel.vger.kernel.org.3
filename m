Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C894D1EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbiCHRVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348808AbiCHRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC453E38;
        Tue,  8 Mar 2022 09:19:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h13so13273601ede.5;
        Tue, 08 Mar 2022 09:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5DfRiN4tVEInDy1EaFlW5SfOWSz7K0FfgTOmN6xKLdM=;
        b=hb8FdLB1uM1UKpdPJwEPXncuuxGUo2wvVu7FMZEvId0f8lNvB/SYyf1WG2N9sZqfgp
         ONf7EkT/5NFZRrkb5nZcHlTkEo823pCm229yUB6t5pBkzC1esqh+mgWnQK8xOSFYYZT+
         +9GwTybV0FJolqLU3f8kcJNlLvprhGzYJvvpzJsY7W+87+U/bZmQW1T5FDOQ8v+1jXkB
         gAlEw/HpCrkJSnRrdngIzrJhdeTzyVHDfDbKTNcUuTsWXSiCmxH+HCpBYEep5Rhu0nV2
         GqWyn+Bau4wVoJdugkzsVR1UK3q4PwowaO3X7DIm+6IFxAdgcE1R9uXrwu0GXTL7JfIp
         Q5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DfRiN4tVEInDy1EaFlW5SfOWSz7K0FfgTOmN6xKLdM=;
        b=VrqAIXxQpT8vBi6DBLCg9738M0rMxT2lHPOBlufdtmz2RQL+Sza/yWjwVn1sPOPTUH
         Y2sDNfJneOLcuYuJfL03nSFJATpk4SrZ/6C3VFUQ2XR43WNRpCJr73zviPi581PXUZCP
         k0v4pdAJBgcDoQCs7zfWZH+JeZ0z/N9eGW2m9gLrWZeBNOLe5OWZ5U17qc5GExZtKJDC
         yWHShY6wPLLoNU58T5HDU5Yd3Q65vL9fZSKIDVMhYrjaTEwCna7pNmmVkFXEjYMyYMXA
         Ee1Hvge4Zkqq+iHhISNC8DqSBFjcu6usW6sJ+bEzq0FJD1Q94TPLR3HGhSK3aaHkJx1b
         M7hA==
X-Gm-Message-State: AOAM532HEzucO7Z+xPGLlgLFD7c9wksMpYTvvST0RjIgxJx6sXN4MX8K
        PXc2IYn308pyNEIIzCsha/c=
X-Google-Smtp-Source: ABdhPJx5czam/LGVZPYwb0egaL0FVjfrwCPS7zG4IWJTAsKhpAMjuNXf6RzEKFj7FDaxzZ1pYO9iWw==
X-Received: by 2002:aa7:c3d8:0:b0:415:a0a9:1f18 with SMTP id l24-20020aa7c3d8000000b00415a0a91f18mr16877614edr.412.1646759961620;
        Tue, 08 Mar 2022 09:19:21 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:21 -0800 (PST)
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
Subject: [PATCH v2 13/26] usb: gadget: omap_udc: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:05 +0100
Message-Id: <20220308171818.384491-14-jakobkoschel@gmail.com>
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

If the list representing the request queue does not contain the expected
request, the value of the list_for_each_entry() iterator will not point
to a valid structure. To avoid type confusion in such case, the list
iterator scope will be limited to the list_for_each_entry() loop.

In preparation to limiting scope of the list iterator to the list traversal
loop, use a dedicated pointer to point to the found request object [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 494da00398d7..2d9815dad2ff 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -1003,7 +1003,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 static int omap_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct omap_ep	*ep = container_of(_ep, struct omap_ep, ep);
-	struct omap_req	*req;
+	struct omap_req	*req = NULL, *iter;
 	unsigned long	flags;
 
 	if (!_ep || !_req)
@@ -1012,11 +1012,13 @@ static int omap_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		req = iter;
+		break;
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&ep->udc->lock, flags);
 		return -EINVAL;
 	}
-- 
2.25.1

