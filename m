Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D315631F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiGAKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiGAKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:53:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5E237EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:53:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cv13so2259107pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAb8BhaEnoy6g4TUthkAckgbU5LqWiMd2MpRJwBJ244=;
        b=iKv4thd0wDQP8anbuEyzEQ+Zqxa2RoLpovoXs077tea1xpsXOBelzTXGmK4y7MqftT
         5BJnXPH8YNdKWTHrIlCKk2Y5qhZu1/pNfrnZsu0+Mx5vhh0AMDhG/LEBw6Yr2orVpLpS
         c9Rif9I0bUJFib7BjpoRdmrjmJJMel7dBcIgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAb8BhaEnoy6g4TUthkAckgbU5LqWiMd2MpRJwBJ244=;
        b=5HelQs3R4oDShmK4fZHkwZ5emqjE6xjINEZwfuj5Q9s04s+9nOgE7dCGOndHkl+KcA
         HcZZZCp4mllxvdsc+Q9nwMaCcYvHad2wEQEulzdAmz9hpBw//pspGMpsnwTThiSEsIn8
         YCpSsbBnQJlhmLNLhpJyJ71G+nLpyKNyQd8tZF/2gdhV2Ah8puKDSkG5SlQAOgP0uVur
         GgtclQLBfxXsjK2bj0fTjwqK3kzrT/W/lGFwXAJJ2yuPt79u8YydnrIbeOHy6UrqOgKw
         RJLE9W1qk21XQc0oF88q8xykpBjiic9rhZG0QgjQItO2r2RzOzUBcDRv4UsQB1dvDh9+
         Rx4w==
X-Gm-Message-State: AJIora/N+NsaCnnBPmXVczPCf3ZFdQdKgHwjRtTn0E24IRk6EZgoiZIW
        L+SF7+7RDOX7fOqtFg1hLsyxAg==
X-Google-Smtp-Source: AGRyM1v7WmL7Uss1HNkKbQMy8M5hpzoThkEh0hNwmVYgcfIBghgHA/BIAT8PEL/BvGq+Wt4ZftbeQQ==
X-Received: by 2002:a17:902:9f87:b0:16a:1efc:42fe with SMTP id g7-20020a1709029f8700b0016a1efc42femr20863524plq.124.1656672798693;
        Fri, 01 Jul 2022 03:53:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:18 -0700 (PDT)
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
Subject: [PATCH 6/6] media: mediatek: vcodec: Use default bus_info for encoder capability
Date:   Fri,  1 Jul 2022 18:52:37 +0800
Message-Id: <20220701105237.932332-7-wenst@chromium.org>
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

Since commit f2d8b6917f3b ("media: v4l: ioctl: Set bus_info in
v4l_querycap()"), the V4L2 core provides a default value for the
bus_info field for platform and PCI devices. This value will match
the default value for media devices added by commit cef699749f37
("media: mc: Set bus_info in media_device_init()"). These defaults
are stable and device-specific.

Drop the custom capability bus_info from the mtk-vcodec encoder
driver, and use the defaults.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index cc286e59021e..25e816863597 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -237,7 +237,6 @@ static int vidioc_venc_querycap(struct file *file, void *priv,
 	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
 
 	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-enc", platform_name);
 	snprintf(cap->card, sizeof(cap->card), "MT%d video encoder", platform_name);
 
 	return 0;
-- 
2.37.0.rc0.161.g10f37bed90-goog

