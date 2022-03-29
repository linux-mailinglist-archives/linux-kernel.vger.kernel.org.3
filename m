Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619114EA78D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiC2Fz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiC2Fz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:55:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7436117C90;
        Mon, 28 Mar 2022 22:54:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b189so13272997qkf.11;
        Mon, 28 Mar 2022 22:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pv+YK+YGh5jKY9olKETrPHwQ2n/4aGK/xdNlhbRhxZE=;
        b=bzfdyo0uWDEELn9OY8t+TxbY1Ftpv5siDPYc9FfEkJVioVH+JcBmi4NXkU3ExK4txJ
         V4wcKhhNtNJj/mSRct/VeLhvQ/xVpG+cstkFDYUCPLDX7Ancm8YxbX7cVKvXBS1Scrqf
         RqYBvlZVwjxP+E3A14MYIgKwNfi4PO8Esj9PM4uH1PrSiDct7BJkTyqtYUG/ooWacNOf
         /0f7m0CtjQTpx+bpWNEX5nmGTzq26HAwaRLvizDU0bdcKh6MawRNNR3/SvZBeuIV2Wgn
         P/+rF+neDixlfmZ+g0aODbF+n6mAUD7WYaIwmK5bTgIxe4vX4+x2yvvfjeCUTnnGBNN8
         UemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pv+YK+YGh5jKY9olKETrPHwQ2n/4aGK/xdNlhbRhxZE=;
        b=itCTQZtf7yzmgEjeN5fn83ck4V1MSTiY391q22MMm4suwjmXYHWK0nfQFqNfeRdHA1
         2M0uL8zvoX3thCrUQeV4RW79S49+8Zo9LitKm5lRVG0YhbY4WmiNk+Jgyifti30aMoUr
         7OVxdR4t0texIQpHQXnA4IM+6qVLFX42lGOlh5X6KE8bim+91jpsPHYwZP2sGsg46eC4
         aVyRFmASc/nElrKsb/8SGxit8EkacNHY8NzNz8Byx4wM4E6sc/8QsL7SmyV+Ateu2YJW
         BcZlug754WDnZgy7kqFijHmrSlG4xv5RibGBxp2FzqfJIRBqvwWsJiYjEjjlJs430xM8
         Mfag==
X-Gm-Message-State: AOAM533NqyCX+zyaUOdSQzbi0HXdTdZltoO2JCZFZAqL9pw4vHHig/Dk
        /zxwiWlKPuOrJohgT8sj7SM=
X-Google-Smtp-Source: ABdhPJwJBS651D1AOrfIEPFs1X/yrROJZ3kEVo8OVq7tmILjMxKIkGAGhWkCC4zP5kwnrkYuwYYK0g==
X-Received: by 2002:ae9:f448:0:b0:67e:1929:1782 with SMTP id z8-20020ae9f448000000b0067e19291782mr19142197qkl.578.1648533254133;
        Mon, 28 Mar 2022 22:54:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m14-20020a05622a054e00b002e2072cffe6sm13749111qtx.5.2022.03.28.22.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 22:54:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, peter.chen@kernel.or,
        christophe.jaillet@wanadoo.fr, skhan@linuxfoundation.org,
        lv.ruyi@zte.com.cn, johan@kernel.org, jakobkoschel@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: gadget: udc: add NULL pointer check
Date:   Tue, 29 Mar 2022 05:54:07 +0000
Message-Id: <20220329055407.2375626-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kzalloc() is a memory allocation function which can return NULL when some
internal memory errors happen. It is safer to check NULL pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index fdb17d86cd65..f52eb3f2420a 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2231,6 +2231,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.25.1

