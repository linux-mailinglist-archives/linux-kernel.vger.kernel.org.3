Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C1551061
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiFTGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:33:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A826441
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:33:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 68so4002119pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Birko6BVm9pR0csOE6qLnvHxtv0sU5B7VPcVJ+8JxPc=;
        b=ldgy2d2NIgPPCbeDgHy9tMwLL0sSFkkSQiXVaMf/pMsE6csJ6BV7bYSFqjXwyMBXNX
         yv8TkM+IvFKk7ZdfVk1UiDSJ9YmxIREDRU+5HqXCAJHLcJLAtsIYZcvi5sH9cpDpBbGL
         UUk5ekd552hFetSwY9djMDHRD4wkxKncOG/cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Birko6BVm9pR0csOE6qLnvHxtv0sU5B7VPcVJ+8JxPc=;
        b=3OjOEmF16waQ5KSiDABBxuX0perzFnOLue6a/AwndJPko2ltsbg79sgcB9M233jYzE
         qOf7Ez8LI7xxmu7O6KOtkQTdbs9Bylas2egIJxGjf3Yly3kF5AIqS7UZcEO6J5Uw4iGa
         c5vTesGe+klh/cCFqR56bW7yfO3GzYlLpvqF7DtmOLqGTBQraUlHTp/l56QtqoMxU1aU
         XN7pnjSZiNHKiNWAPyVJ92dVdAyFi3yP+rGQ7DJPZ5xc6oxLpDs3XAIUy1a1PH7cvhCk
         CNs4I0lZoN4OS8h+ORcHiIQLndbIlkJ4Lwg67ezSeQUGrvAEOXrgNS9SoMXcw+CG8mSe
         8Btg==
X-Gm-Message-State: AJIora/3qvo/1lavtlKNcbbTBBXW2yvTfzpeFeke2VplDgd2PAuoXhC7
        7CkA1H3QLLvW4jIco9poltq7jA==
X-Google-Smtp-Source: AGRyM1t30EpNMhJshHyan9sCFogrNebskjDCdtDu7RD9nTf7m9a5w3aM9FmTOmPTfnxHw+fbPTOdUQ==
X-Received: by 2002:a63:6c06:0:b0:3fd:ae53:387f with SMTP id h6-20020a636c06000000b003fdae53387fmr20337064pgc.536.1655706837540;
        Sun, 19 Jun 2022 23:33:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:a218:a2c3:eda2:6dc7])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d88500b0016762bb256csm7733286plz.281.2022.06.19.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:33:57 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: Skip SOURCE_CHANGE & EOS events for stateless
Date:   Mon, 20 Jun 2022 14:33:49 +0800
Message-Id: <20220620063349.2754116-1-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stateless decoder API does not specify the usage of SOURCE_CHANGE
and EOF events. These events are used by stateful decoders to signal
changes in the bitstream. They do not make sense for stateless decoders.

Do not handle subscription for these two types of events for stateless
decoder instances. This fixes the last v4l2-compliance error:

Control ioctls:
		fail: v4l2-test-controls.cpp(946): have_source_change || have_eos
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL

Fixes: 8cdc3794b2e3 ("media: mtk-vcodec: vdec: support stateless API")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

This should apply cleanly on next-20220617. The other media patches I
have on my branch:

media: mediatek: vcodec: Initialize decoder parameters after getting dec_capability
media: mediatek: vcodec: Fix non subdev architecture open power fail

should not interfere, though the second is required for proper operation
of the decoder on MT8183.

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 62f29b6fa104..a5fbc0a1c6bc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -234,6 +234,11 @@ static int vidioc_vdec_querycap(struct file *file, void *priv,
 static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 				     const struct v4l2_event_subscription *sub)
 {
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(fh);
+
+	if (ctx->dev->vdec_pdata->uses_stateless_api)
+		return v4l2_ctrl_subscribe_event(fh, sub);
+
 	switch (sub->type) {
 	case V4L2_EVENT_EOS:
 		return v4l2_event_subscribe(fh, sub, 2, NULL);
-- 
2.36.1.476.g0c4daa206d-goog

