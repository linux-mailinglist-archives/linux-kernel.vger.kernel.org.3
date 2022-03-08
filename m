Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC304D1E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiCHRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348901AbiCHRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F653E1C;
        Tue,  8 Mar 2022 09:19:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gb39so40697946ejc.1;
        Tue, 08 Mar 2022 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkWk+pJBOAzTyRQTmBb712+gQyHq/pA4s9cAlOSRA8E=;
        b=PGCNMcLMI62MHZBGcmL1CRySCL3E80fhSQcmm570QvuEOjBOK7zBv9VtYr4hEpxNq0
         qCAiPDLZ1W2scA39q/4BXOyNk/f+rc0vInBGsDts9ftfs0jHfyxk6lnsJUU9WA/nmfYe
         9hMkkTTv6Jr7AV852g+ov8HLeaZbGAizdSN2XiOdN6cfUlWYC9QoQIYdK+t6o74wY1Kz
         CAqsdr8WXA3CDaYefVVxpFTQfz5k9IxbXU3Hccb3pnhAO73izhjqEF73t1bzso1C649z
         55jhLcQyxctDXRTfGHJxapyhhUzWeYZ2jB5t6qhYhTd6grcEZm6/vrEb9XyFatgooNJd
         x6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkWk+pJBOAzTyRQTmBb712+gQyHq/pA4s9cAlOSRA8E=;
        b=3UQDc0pHeBBzEo7oUFUwYTPmW9pNbm+YJlDDXb0t8FOWvw4kcxZM9nM8XS6QU9QYP6
         bcdiF6ksmAZGVgPRwgRAQ24HcEW0U7KUm1r5gujSUFnECiC1XBWMLtp5j6bzKu7TvY0/
         lMBUjhEqr70dhzzpmss6lnW6GmMZHW7gC+ws+Mp/h7nJrRLoFDMzorVpA2Fp0LP0KAVQ
         /lPg/U0Zgo63M1pl8Jrt9NlLMqNXlWVUS3i3jZK1KKtRYxl4jM+3lONHkGKprPSKufx4
         9N+MMuCdCblToOjOtrD5Awb5cEsq74jxNoh6Rk48h2OUmzRiZmSegfPrztGNAY29I53S
         VVMA==
X-Gm-Message-State: AOAM533isHXQGSPRkHZAyeQEgR7S/emZLbyyubJS/LyOsEmeEmOmXoM+
        RDhsw0hOUCePayX/fD6U1NA=
X-Google-Smtp-Source: ABdhPJwjd15xQrk2r0RtEosI5eNq0bUkl2GLZ4+qkb9+rHvJjGw5YP/fVseF5ysgEMd8FexKkfauuQ==
X-Received: by 2002:a17:907:2d11:b0:6da:924b:748f with SMTP id gs17-20020a1709072d1100b006da924b748fmr13875456ejc.584.1646759946545;
        Tue, 08 Mar 2022 09:19:06 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:06 -0800 (PST)
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
Subject: [PATCH v2 01/26] usb: gadget: fsl: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:17:53 +0100
Message-Id: <20220308171818.384491-2-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/fsl_qe_udc.c   | 13 ++++++++-----
 drivers/usb/gadget/udc/fsl_udc_core.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 15db7a3868fe..d80a7fe5ff62 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1776,7 +1776,8 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
-	struct qe_req *req;
+	struct qe_req *req = NULL;
+	struct qe_req *iter;
 	unsigned long flags;
 
 	if (!_ep || !_req)
@@ -1785,12 +1786,14 @@ static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
-			break;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue
+		req = iter;
+		break;
 	}
 
-	if (&req->req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&ep->udc->lock, flags);
 		return -EINVAL;
 	}
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 29fcb9b461d7..50435e804118 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -918,7 +918,8 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct fsl_ep *ep = container_of(_ep, struct fsl_ep, ep);
-	struct fsl_req *req;
+	struct fsl_req *req = NULL;
+	struct fsl_req *iter;
 	unsigned long flags;
 	int ep_num, stopped, ret = 0;
 	u32 epctrl;
@@ -940,11 +941,13 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
 
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
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

