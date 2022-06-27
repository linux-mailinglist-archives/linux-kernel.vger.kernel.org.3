Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA655E1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiF0L0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiF0LZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:25:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091965C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so8692281pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Bdt/pZAOacqJuCFzII9rBWAKqWiyNAPCi+XwvqCQy0=;
        b=gND2N7zr6zJtFEQ1/Qh++AaC/I3sYIjuvDxr52m7Vusjymll7C22xQJnXtQSAgXqpJ
         r89NGcuSNrr6jtyaN6WQTCKIh/3bqzP4HhpSMrh/aHkJRp7fHeZuEPYn9tacdAUncKNg
         MRC5No3iihpOW7bs07Qq05whWNJSKaynJZWv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Bdt/pZAOacqJuCFzII9rBWAKqWiyNAPCi+XwvqCQy0=;
        b=gHYCdkuA053mbQfsojIGCd4+MkXoN/ztH14H079cdv4EsALF2LnZCUnGGhll3FKJF/
         OVhY/X8p6Gum9Noje6WQG9VmHsEC1K9PQzpdUf7OV0Vp1LAoun1kNWvf/v+gYdimC0kq
         tA9NS5klDmIBc4cSWhiwqDubKKcVvY7pwkjOhjaQKxyRiw8pNVRo/vECJYtYIRonIyVR
         Qfwl4ANzfIfOk9yzfOBMrOnrgbBOGtUwKg/6DV1ty6dgAdae2TiQ6CJSlKJs4kFEYThM
         Mcv3SM2frvdtX7Mh+pgnMDgC8zcreoQQqAfYr6YtHpSV4JeNzmblmaTLz38EObdz/d0d
         cNLQ==
X-Gm-Message-State: AJIora9oFMrjGQjRGoFJHEC8O84XL4TnFk/cL8lOBFAEILPgVPjgB3Nz
        BlOjyNCnVACPohbr++c07uMPnf74076r7A==
X-Google-Smtp-Source: AGRyM1upMeiOln1K4lkc+rTedGu7rooW/59+/KUoBEA/D4qTE+BzMxTrodbWQsrklKjwp/RQ1Lgmcw==
X-Received: by 2002:a65:6045:0:b0:399:3a5e:e25a with SMTP id a5-20020a656045000000b003993a5ee25amr12685653pgp.139.1656329107880;
        Mon, 27 Jun 2022 04:25:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2dc1:c31b:b5ed:f3aa])
        by smtp.gmail.com with ESMTPSA id lj4-20020a17090b344400b001ece32cbec9sm9246889pjb.24.2022.06.27.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:25:07 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH 4/4] media: mediatek: vcodec: dec: Set maximum resolution when S_FMT on output only
Date:   Mon, 27 Jun 2022 19:24:02 +0800
Message-Id: <20220627112402.2332046-5-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627112402.2332046-1-wenst@chromium.org>
References: <20220627112402.2332046-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the coded format impacts whether 4K resolution is supported: the
decoder does not support 4K for VP8, but does for other formats.

Update the maximum resolution in S_FMT only when called for the output
format. Otherwise we could set output format for VP8, then set capture
format, and then the resolution limit becomes inconsistent.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index ea951cb3b927..995c61d6a40e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -521,7 +521,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	if (fmt == NULL)
 		return -EINVAL;
 
-	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
+	if (V4L2_TYPE_IS_OUTPUT(f->type) &&
+	    !(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
 	    fmt->fourcc != V4L2_PIX_FMT_VP8_FRAME) {
 		mtk_v4l2_debug(3, "4K is enabled");
 		ctx->max_width = VCODEC_DEC_4K_CODED_WIDTH;
-- 
2.37.0.rc0.161.g10f37bed90-goog

