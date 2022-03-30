Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C084EBC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiC3IBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC3IBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:01:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F78201BA;
        Wed, 30 Mar 2022 00:59:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1F7C31F443D2;
        Wed, 30 Mar 2022 08:59:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648627157;
        bh=h3tnoZejbOLZjyN2atSaobYGn8o799H2KiEzYAFUa98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcrLXVqpL/wTu+500y0aqOOpvuc4BCADPVrYxLySFJsZ2Jr5zJeMc6SZi8MJG5Eql
         8EImGRlYtfL7z2Q6Se/E+tthQ8yYdJiPEynqsTdEnkXU2oOt5APJAldERtFqfWoo5o
         dpk6hIZtJfyRXBitCTgkr7KYTuQ97FCu/QwRJ9bnpsu2NVP9nHUZrafiz5UT5GLH3A
         Kf3SPwrQx/FjQm+1d2BKt7z8sHCAOC6s1m+j8mNZIBDTyJytj5s2gPD/B0Y97dVzbI
         rJP9wMYd6KjG7wCai96RwEJu8goepdIHgGnmWuZusOVFSAz8Radw7OOIP5Awdd0/Ro
         cL/SmHo9GVmVA==
Date:   Wed, 30 Mar 2022 09:59:13 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 22/24] media: hantro: h264: Make dpb entry management
 more robust
Message-ID: <20220330075913.wfl3prsyw5fvsv4t@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-23-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-23-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>From: Jonas Karlman <jonas@kwiboo.se>
>
>The driver maintains stable slot location for reference pictures. This

s/slot location/slot locations/

>change makes the code more robust by using the reference_ts as key and
>by marking all entries invalid right from the start.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>---
> drivers/staging/media/hantro/hantro_h264.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
>index 228629fb3cdf..7377fc26f780 100644
>--- a/drivers/staging/media/hantro/hantro_h264.c
>+++ b/drivers/staging/media/hantro/hantro_h264.c
>@@ -258,8 +258,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
> 			    const struct v4l2_h264_dpb_entry *b)
> {
>-	return a->top_field_order_cnt == b->top_field_order_cnt &&
>-	       a->bottom_field_order_cnt == b->bottom_field_order_cnt;
>+	return a->reference_ts == b->reference_ts;
> }
>
> static void update_dpb(struct hantro_ctx *ctx)
>@@ -273,13 +272,13 @@ static void update_dpb(struct hantro_ctx *ctx)
>
> 	/* Disable all entries by default. */
> 	for (i = 0; i < ARRAY_SIZE(ctx->h264_dec.dpb); i++)
>-		ctx->h264_dec.dpb[i].flags &= ~V4L2_H264_DPB_ENTRY_FLAG_ACTIVE;
>+		ctx->h264_dec.dpb[i].flags = 0;

Ehm ... we just remove all flags? Can't this have any unwanted side
effects like removing a flag that we actually wanted to keep?
(Like long term or the field flags?)
If we just want to set the DPB entry inactive, then removing the ACTIVE
flag seems like the correct approach to me.
If we want to get rid of the VALID flag as well, then we could just do:
		ctx->h264_dec.dpb[i].flags &=
       ~(V4L2_H264_DPB_ENTRY_FLAG_ACTIVE | V4L2_H264_DPB_ENTRY_FLAG_VALID);

In case we really want to reset all flags, I'd say adjust the comment
above it:
```
- 	/* Disable all entries by default. */
+ 	/* Reset the flags for all entries by default. */
```

Greetings,
Sebastian

>
> 	/* Try to match new DPB entries with existing ones by their POCs. */
> 	for (i = 0; i < ARRAY_SIZE(dec_param->dpb); i++) {
> 		const struct v4l2_h264_dpb_entry *ndpb = &dec_param->dpb[i];
>
>-		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
>+		if (!(ndpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> 			continue;
>
> 		/*
>@@ -290,8 +289,7 @@ static void update_dpb(struct hantro_ctx *ctx)
> 			struct v4l2_h264_dpb_entry *cdpb;
>
> 			cdpb = &ctx->h264_dec.dpb[j];
>-			if (cdpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE ||
>-			    !dpb_entry_match(cdpb, ndpb))
>+			if (!dpb_entry_match(cdpb, ndpb))
> 				continue;
>
> 			*cdpb = *ndpb;
>-- 
>2.34.1
>
