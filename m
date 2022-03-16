Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F744DAC11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiCPHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354347AbiCPHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:53:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619B60CEF;
        Wed, 16 Mar 2022 00:52:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t2so2882187pfj.10;
        Wed, 16 Mar 2022 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=r86Uhz+1lX3u0Xky+aQ3JdrpwMrTIezbGKn+VRBOt3U=;
        b=lABWo/4nXGSnQfOOU4NY6qC3Gcdo2T5t3oNS1Mn2DH8YA4YvELSeML9nsHh51WbdJr
         P5jnvQUJQmGmKv1VbQKY7XkEpRLPQoX6u95HAIAIai8QLnUdBQmQlIO1jeAI8BgVFg4O
         mOt54SOb0ZBP9g0ZJdu7LVqrm9cpFmzboyJw0tFX01cGyEAL0KuCHw08EZVWcGfdD8/u
         VXqJgHRdfralSos5DiP9b0CtWs3EEtB6GBpXUpzZ6Fz5Ov3uEZlhT81bHPcfhU4MK+C7
         35lcHj3yYKqstRYswCEJU+SqQ7z+65hbKUpyqBYz7q3f3uuqHe1YSboJuYQ60aHC1+Z7
         7Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r86Uhz+1lX3u0Xky+aQ3JdrpwMrTIezbGKn+VRBOt3U=;
        b=YAanNCZwhHY4+z8qXSXaRewQN0EaDPS9NDlUcPJrSzOd1UHPyUzoX8uTC4Qe7WVuaQ
         09bq4dErNgpXLvca43Sv2/yWbW9W2zzPQpNRcIC5ZDc97WLkM57LkBVsqypyHzbPiuxC
         ctghsAYkyuy+3V0bGv/BnZg/JO5agid9KKEGsg7gSbQpfw5iKBJRA5zOy2ojqk6dSK5k
         4exsAOrXoNjgqNqp+2uND7bNY1Z2YW7q3X/2O3n2YSRgXdUHUnqtzrB0LVoY7Wohg3NG
         D9HaIjfHKWKi1a1KLkzWbHkotXbqxkupEPTYT7CPid0/hV9QLSDkR045u31ppIv8ptw1
         Jbag==
X-Gm-Message-State: AOAM533g2gDqjMjpRiYNrgJQfm69Mp5LojYhuxvvF4pQuGUkIHZMGlId
        868DOltRQzb/2ZnVeJlV75Y=
X-Google-Smtp-Source: ABdhPJy89FBz6Ml9CJ9C6wLdr+N7QV6mngezYZ/2QDD9auytklePsPZkgn0R3v9o6vi4qxmo+QG2Yw==
X-Received: by 2002:a63:f1d:0:b0:381:8478:e9e4 with SMTP id e29-20020a630f1d000000b003818478e9e4mr2157737pgl.240.1647417124299;
        Wed, 16 Mar 2022 00:52:04 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.19])
        by smtp.googlemail.com with ESMTPSA id d6-20020a17090a6f0600b001c64b1bcd50sm1560852pjk.39.2022.03.16.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 00:52:03 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] usb: gadget: udc-xilinx: remove unnecessary initialization of list iterator
Date:   Wed, 16 Mar 2022 15:51:53 +0800
Message-Id: <20220316075153.3708-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'req' will always be set by the subsequent list_for_each_entry()
before any uses. Thus, to avoid ambiguity it is better to remove
the unnecessary initialization of list iterator 'req'.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 6ce886fb7..fa6cbfc63 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1136,7 +1136,7 @@ static int xudc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int xudc_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct xusb_ep *ep	= to_xusb_ep(_ep);
-	struct xusb_req *req	= to_xusb_req(_req);
+	struct xusb_req *req;
 	struct xusb_udc *udc	= ep->udc;
 	unsigned long flags;
 
-- 
2.17.1

