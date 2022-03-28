Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847864EA0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbiC1UDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbiC1UCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:02:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61A5C34B;
        Mon, 28 Mar 2022 13:00:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 2C2AF1F438C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497623;
        bh=Og2wNbsGzxzouALoYhFoXVFpDemGtbhl+ssP9/EEn08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQ8pTF5N12gMnd+ao3DJztqsVvAZXfgkH3/36NVWu1VlrUL2QKRyzP3+n9F2SRvvS
         NWT28qm9AbEx2JhJiRHOkaWU30WY6mQMHXQcsHyhvo5Gb+fsk/y0jvWSTiUAfpSfN+
         TdPxbOuq+77LsI05gd/INB5I/KjbFuPUxc6ilHPFqAamcBKY3f2/jtD/7NugF274lq
         9OsmTwu0HedVjbtwOvEc8AC+fW1uxBJI8lhMSG3+OX/pGiGOSSpV5FhKgxjbAVYsdL
         QADmAXLcOOhvpbEdRQ1FslUWrbZbUp1dqJtS5p8D6bg94ppj/xTy5qI50Vux3c6zx1
         dOW2ZBNutLEXg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 22/24] media: hantro: h264: Make dpb entry management more robust
Date:   Mon, 28 Mar 2022 15:59:34 -0400
Message-Id: <20220328195936.82552-23-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

The driver maintains stable slot location for reference pictures. This
change makes the code more robust by using the reference_ts as key and
by marking all entries invalid right from the start.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/hantro/hantro_h264.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
index 228629fb3cdf..7377fc26f780 100644
--- a/drivers/staging/media/hantro/hantro_h264.c
+++ b/drivers/staging/media/hantro/hantro_h264.c
@@ -258,8 +258,7 @@ static void prepare_table(struct hantro_ctx *ctx)
 static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
 			    const struct v4l2_h264_dpb_entry *b)
 {
-	return a->top_field_order_cnt == b->top_field_order_cnt &&
-	       a->bottom_field_order_cnt == b->bottom_field_order_cnt;
+	return a->reference_ts == b->reference_ts;
 }
 
 static void update_dpb(struct hantro_ctx *ctx)
@@ -273,13 +272,13 @@ static void update_dpb(struct hantro_ctx *ctx)
 
 	/* Disable all entries by default. */
 	for (i = 0; i < ARRAY_SIZE(ctx->h264_dec.dpb); i++)
-		ctx->h264_dec.dpb[i].flags &= ~V4L2_H264_DPB_ENTRY_FLAG_ACTIVE;
+		ctx->h264_dec.dpb[i].flags = 0;
 
 	/* Try to match new DPB entries with existing ones by their POCs. */
 	for (i = 0; i < ARRAY_SIZE(dec_param->dpb); i++) {
 		const struct v4l2_h264_dpb_entry *ndpb = &dec_param->dpb[i];
 
-		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
+		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
 			continue;
 
 		/*
@@ -290,8 +289,7 @@ static void update_dpb(struct hantro_ctx *ctx)
 			struct v4l2_h264_dpb_entry *cdpb;
 
 			cdpb = &ctx->h264_dec.dpb[j];
-			if (cdpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE ||
-			    !dpb_entry_match(cdpb, ndpb))
+			if (!dpb_entry_match(cdpb, ndpb))
 				continue;
 
 			*cdpb = *ndpb;
-- 
2.34.1

