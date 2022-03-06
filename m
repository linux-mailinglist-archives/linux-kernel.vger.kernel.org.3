Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2774CECB9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiCFRwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiCFRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA13E5DD;
        Sun,  6 Mar 2022 09:51:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so27458436ejc.7;
        Sun, 06 Mar 2022 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFt2C4v3MHiA6cRFvbwFucUFojonhWM9CACowSfppes=;
        b=Tolycnv7VYddPSTnHUPVc8T2MLtAr6i1eIjLjhBH86eZUoumoTFWROly+HHb06LqB3
         ugHsQtipGLBEGBGc/SOLNog12BqLN5Xdd17r2TO4VR34UBns31kYHGmNJBZ2zepTxuVE
         7GU/RjLNn0/fIaG2hbIYjgjMPaHF83ma18PD/op0cDq8lEamu0dF8ae3CB4mW5X08BFk
         fqE5yfu6Q167r6L4wJcOwCsX4MfAxduSA+q4mQX6QrKXJFcX2yB3CvGf70ueBRGHSxcb
         Or3DPvp3Ic8PrVu9Af3nPM8uUV+L3uVGasnhL2egxvGCVtSz3bLYr411/OnZJVO87aUc
         1JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFt2C4v3MHiA6cRFvbwFucUFojonhWM9CACowSfppes=;
        b=lBt21sUzMMzy7UQrlCx+0edgmWAVE8ITCqvXe9SXlg8lNHK8IDRFULffVZFTUXdG6l
         4xqxQmlgXCn9cQH81gS6cQ4Cx2zeV7aG4UhjMCIbvpyyKfb/757y4i392nh3mOYANaff
         r4aIdZn04hzsZwNupBLbcS+PeqS6XEFZXd7mER61wMUGdgChcBiNypoMiA+CaARd1vrh
         rFGP+pL/H333oom35cmAaDu+UIvgLJsBHTars3R1TKAFAUqVzxOPoHa6aM3hYfJlwjSU
         PyKe4A+h3ZLFOJqj6pwaNdgMEX4fSa063iJsBgkLhuIDZxAFOfu7gUTONGy5LizfBKOp
         JEAw==
X-Gm-Message-State: AOAM532SEbHqVf3c3tGn0OrOtgpTJTPMnsKOuhSZfHtspK1TXzXTM05P
        121tqjr5nZD+elhz5p0gD4I=
X-Google-Smtp-Source: ABdhPJxcBDS2fKAC3UP2mJtbSlN6nfaiW3fyJgPpLmVwl8GN6KhfNQ55qpfpsXcMqKt2QBcWUp3vQQ==
X-Received: by 2002:a17:906:c053:b0:6b5:fde8:af2 with SMTP id bm19-20020a170906c05300b006b5fde80af2mr6500304ejb.642.1646589070687;
        Sun, 06 Mar 2022 09:51:10 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:10 -0800 (PST)
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
Subject: [PATCH 01/26] usb: gadget: fsl: remove usage of list iterator past the loop body
Date:   Sun,  6 Mar 2022 18:50:09 +0100
Message-Id: <20220306175034.3084609-2-jakobkoschel@gmail.com>
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

If the list representing the request queue does not contain the expected
request, the value of the list_for_each_entry() iterator will not point
to a valid structure. To avoid type confusion in such case, the list
iterator scope will be limited to the list_for_each_entry() loop.

In preparation to limiting scope of the list iterator to the list traversal
loop, use a dedicated pointer to point to the found request object [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c   | 11 +++++++----
 drivers/usb/gadget/udc/fsl_udc_core.c | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 15db7a3868fe..3979a2825e3c 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1776,7 +1776,8 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
-	struct qe_req *req;
+	struct qe_req *req = NULL;
+	struct qe_req *tmp;
 	unsigned long flags;
 
 	if (!_ep || !_req)
@@ -1785,12 +1786,14 @@ static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			break;
+		}
 	}
 
-	if (&req->req != _req) {
+	if (!req) {
 		spin_unlock_irqrestore(&ep->udc->lock, flags);
 		return -EINVAL;
 	}
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 29fcb9b461d7..23d670fae12c 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -918,7 +918,8 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct fsl_ep *ep = container_of(_ep, struct fsl_ep, ep);
-	struct fsl_req *req;
+	struct fsl_req *req = NULL;
+	struct fsl_req *tmp;
 	unsigned long flags;
 	int ep_num, stopped, ret = 0;
 	u32 epctrl;
@@ -940,11 +941,13 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req)
+	list_for_each_entry(tmp, &ep->queue, queue) {
+		if (&tmp->req == _req) {
+			req = tmp;
 			break;
+		}
 	}
-	if (&req->req != _req) {
+	if (!req) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.1

