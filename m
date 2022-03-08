Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DC4D1ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349106AbiCHRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348982AbiCHRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D71B54684;
        Tue,  8 Mar 2022 09:19:43 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw13so40608497ejc.9;
        Tue, 08 Mar 2022 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqxR4IBXZYNnThtWgqyRIE5yTni2priLEgPy6w83o+Q=;
        b=kgTAP8XGpVlUPOF/8Z1AY41u1JN3iLbKcygsYP+oBsccD1GWF+nAWpghgMyp72H+Qj
         L1y7kTy86rEUTIK2dNmSSFN72ROpe1dz8CaETW1pnHrZoVy1fShKLMGoRpWR1EylKUwd
         z5GaJzt8eGncFkPGiVdEaYegad+cPaKy842xY9ILXR81ZlU7w4U8+R93HfiduKFTEylV
         FdylLD9bjZURw96QJo6jao6VG2uLtmK2OakXe6URFFqCWnbG/ps4PYJfyYjtg1VE1Pht
         7gpoFEi2mm5Fhmnxt0WuyM2l3yht46dRtZZtGZukOpAEY495gcQgCo6LGhMrfVNTH+8U
         rHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqxR4IBXZYNnThtWgqyRIE5yTni2priLEgPy6w83o+Q=;
        b=DLn05XSWmJ98PP5g8FanUH41ysvbfG+qoiaQbgQRRLZsqt3GZj9PZbV2nPDF1qErrF
         fMBw+75famDQn4ogVl5ikYvCvk0jSwI545paLNPTgOK919L5cT8tQSnOtUO+5WijPlbY
         tmM1+OQq8xoN9/uCYtCLzuCACMBtycpdmHAAjeVj+0M3VgPlm8OexxjrM6ZIcBqJ8eAr
         /W7g80W2w/SqmCjpm1XMOkHHjSQD8BZcAh7c/H9iglBC739zoAQHrYTrsVnkLqzM7o9w
         7YFMws74sXmVfZGffZ1Ts0I7+PolbLP6XvnsAU3ean9vKOAdzxHC9WwdlKRIhOLiTWwy
         5jhQ==
X-Gm-Message-State: AOAM5334BC8LEUYzkyoYFoxgChcc7Ox6naG9Qr2vwjuHsLieRQeEe9uv
        Ue76C+nhx2MpvpgRV/Xf95k=
X-Google-Smtp-Source: ABdhPJz0t2lt1ecx6E29WZrWRYHg3uEddwUclWaXx43v3UwYgxUGqsHyyVae+6Yj68CK4uozjNPtvQ==
X-Received: by 2002:a17:907:6d0e:b0:6d7:c85:5bf5 with SMTP id sa14-20020a1709076d0e00b006d70c855bf5mr14214634ejc.31.1646759980757;
        Tue, 08 Mar 2022 09:19:40 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:40 -0800 (PST)
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
Subject: [PATCH v2 26/26] usb: gadget: udc: s3c2410: remove usage of list iterator past the loop body
Date:   Tue,  8 Mar 2022 18:18:18 +0100
Message-Id: <20220308171818.384491-27-jakobkoschel@gmail.com>
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
 drivers/usb/gadget/udc/s3c2410_udc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index e3931da24277..c6625aeb7bca 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1265,7 +1265,7 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct s3c2410_ep	*ep = to_s3c2410_ep(_ep);
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct s3c2410_request	*req = NULL;
+	struct s3c2410_request	*req = NULL, *iter;
 
 	dprintk(DEBUG_VERBOSE, "%s(%p,%p)\n", __func__, _ep, _req);
 
@@ -1277,13 +1277,14 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			_req->status = -ECONNRESET;
-			retval = 0;
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		list_del_init(&iter->queue);
+		_req->status = -ECONNRESET;
+		req = iter;
+		retval = 0;
+		break;
 	}
 
 	if (retval == 0) {
-- 
2.25.1

