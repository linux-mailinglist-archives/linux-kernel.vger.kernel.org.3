Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746FA565006
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiGDIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiGDItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:49:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7925EF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:49:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o18so8010893plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnEriNYuJ+gQuwuDEbWWl/0zL8PaLW5rMUygXWAZFe8=;
        b=QWTmYN34OAag4G/WUeu87bDQWcWiFQu5Nx192xyHrdPvROX9gfPYARTnBXhE9NyU2n
         XHwz50ysJ/Ck85II8/6GH9qLRkQcElfBt7j9GSphZr4LRcClPpq8n6kXqLUVAUldLxJA
         jTC115rf3RHCznW80jLlV6q/gxp4RB4umoaRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnEriNYuJ+gQuwuDEbWWl/0zL8PaLW5rMUygXWAZFe8=;
        b=TNt00mKFS8XWjV5n+A/Piv7KPxY5KeoP2oC4QBaUmkaHJkaE62r16GzMKAY7NnlWdq
         PKWH3UQxjlSveA6Izt6YiKmp5FiWgFhebWFgu7/l/gFs4ug4PlPhFDdkA25XVr8Rcsb5
         x82M9WJtS+wo1YzQF5H/Ek3S0+CJ04/w98cB+TwSDc1ugii7xUQdRT3BssZjnBpIwzbz
         ZYvn9xzZnWEJHMGnwsVkqVuhdwMyeQFImG/3iLBWEuhTbN/y9KzGsKy5WXUAntoxX48C
         0YWUjqUikOyN/ThKB/KOUdqgrEWjdfJbO34lvWQyfXx+E5X/oABQnoq9irj0WT7yhxSv
         lwMg==
X-Gm-Message-State: AJIora8LGdBmOSMBrLmWSXQqH93dKa7L2QoqjC88/ap9RLnjUy8OPe4G
        VRmqqNczjny2eSi3OI6APngM6g==
X-Google-Smtp-Source: AGRyM1snabMZLbYQYTTtsCz88Vow5ixcBi7ao2OpFSlj0Wz3Sy8FxpBgdIuAx7cueZJSeCsvVK3kEA==
X-Received: by 2002:a17:90b:474b:b0:1ef:86ac:2a58 with SMTP id ka11-20020a17090b474b00b001ef86ac2a58mr5842915pjb.26.1656924575113;
        Mon, 04 Jul 2022 01:49:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:bdd0:6a17:90d3:15e4])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b0016be4d78792sm1347926pla.257.2022.07.04.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:49:34 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] media: mediatek: vcodec: Initialize decoder parameters for each instance
Date:   Mon,  4 Jul 2022 16:49:30 +0800
Message-Id: <20220704084930.1625768-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder parameters are stored in each instance's context data. This
needs to be initialized per-instance, but a previous fix incorrectly
changed it to only be initialized for the first opened instance. This
resulted in subsequent instances not correctly signaling the requirement
for the Requests API.

Fix this by calling the initializing function outside of the
v4l2_fh_is_singular() conditional block.

Fixes: faddaa735c20 ("media: mediatek: vcodec: Initialize decoder parameters after getting dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This was found during backport of mtk-vcodec patches onto the ChromeOS
v5.10 kernel, which caused one of our tests that does multiple concurrent
decodes to fail, as some decoder instances didn't have their
requires_requests and supports_requests flags marked correctly.
Evidently my previous testing of culprit patch was not thorough enough.

This fixes commit faddaa735c20 ("media: mediatek: vcodec: Initialize decoder
parameters after getting dec_capability") in the media stage repo. This
could either be queued up after it, or squashed into it.

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 55dffb61e58c..e0b6ae9d6caa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -208,11 +208,12 @@ static int fops_vcodec_open(struct file *file)
 
 		dev->dec_capability =
 			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
-		ctx->dev->vdec_pdata->init_vdec_params(ctx);
 
 		mtk_v4l2_debug(0, "decoder capability %x", dev->dec_capability);
 	}
 
+	ctx->dev->vdec_pdata->init_vdec_params(ctx);
+
 	list_add(&ctx->list, &dev->ctx_list);
 
 	mutex_unlock(&dev->dev_mutex);
-- 
2.37.0.rc0.161.g10f37bed90-goog

