Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3402B5631FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiGAKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiGAKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:53:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041121833
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:53:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d14so2265968pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOBWwqnNtZ38dDVIIzLfaocfRAGUVvDLs14+wanTT94=;
        b=dz2Le1USQnBFFoW4ejZ1CuEd017eDMuliW3CFPa3lyAyzu0tUApEEcCNgYik7mPZ83
         WGRUIz00iiW2jbnOEIdxoTZy7nqyK3vTpCsj5KGuCZ39yIdmfqMQ+HB3xw2UNMldOBef
         vKItRQ0qyTzxsLBAQjWSCRidIpo/X+sh85qfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOBWwqnNtZ38dDVIIzLfaocfRAGUVvDLs14+wanTT94=;
        b=Ufnqn7XYlMaf6jTyaetyLI9ZcWY/sTs11yKv2vqHSAT/+TcOSFliSNU8Ma2vD8/Qr9
         X7euc1GFIkhQoAzS7iK/+sreo7PbnjTOPTxdVxtXRKV3lNyvG5u7Rjdi7dk76jpfWp5R
         t7vLpWzxlLu/dkvmMJjSdYR+H6n9W86e2mfLwkag9EXf/Il1b7rWVEcHTDsrCEGhW7Dn
         ArXM3PAUaFLanUVKTw/iI2iQVWSj0G/KQdD+ve59G47msItxwoEaRrfJSLXmP+FWDVLE
         ylYEZ21R27E+4xtq86g81vutXNXLhioP/bIOw4L+umqu3M2/iRg76QPaAIDDl879ZKeS
         vXxg==
X-Gm-Message-State: AJIora8xXma0Xd+mu+AeWQQvpl6sqMb3jMBBGGQLSCdo4xsOp5EZXDFf
        O/n7yrvVO8vugQ7dZNPshtUXRQ==
X-Google-Smtp-Source: AGRyM1uljxxSPIi8WxVPeVlccyqJ5E8bRD7D8dokyrQyOuYTXJYQrh07tl8mekQZDh2EtQzXh3M3vQ==
X-Received: by 2002:a17:90b:4ac9:b0:1ec:9bd1:92ff with SMTP id mh9-20020a17090b4ac900b001ec9bd192ffmr15545625pjb.178.1656672796441;
        Fri, 01 Jul 2022 03:53:16 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:16 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 5/6] media: mediatek: vcodec: Use meaningful encoder card name including chip name
Date:   Fri,  1 Jul 2022 18:52:36 +0800
Message-Id: <20220701105237.932332-6-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220701105237.932332-1-wenst@chromium.org>
References: <20220701105237.932332-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The card name for the video encoder previously held a static platform
name that was fixed to match MT8173. This obviously doesn't make sense
for newer chips. Since commit fd9f8050e355 ("media: mediatek: vcodec:
Change encoder v4l2 capability value"), this field was changed to hold
the driver's name, or "mtk-vcodec-dec". This doesn't make much sense
either, since this still doesn't reflect what chip this is.

Instead, fill in the card name with "MTxxxx video encoder" with the
proper chip number.

Fixes: fd9f8050e355 ("media: mediatek: vcodec: Change encoder v4l2 capability value")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 30aac54d97fa..cc286e59021e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -238,7 +238,7 @@ static int vidioc_venc_querycap(struct file *file, void *priv,
 
 	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-enc", platform_name);
-	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
+	snprintf(cap->card, sizeof(cap->card), "MT%d video encoder", platform_name);
 
 	return 0;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

