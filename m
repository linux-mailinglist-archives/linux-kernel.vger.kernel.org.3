Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C3565D87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiGDSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:40:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4111A1E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:40:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so12655884edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxRBS06pE2CQHpTgzqatJymLAXpPxBjp9lWephyRcDY=;
        b=ZzhWOBgJ0GXukDvteK8pJ1ErEi30xPBI7PuEbXANjYY+GfjMg8DGZmihDOeq55CeNv
         B3EiHByVuVltQhnfQsGWQ6tM991OfExy7KSZm7UHWTy/AAlMJfLRe3S9xBf1Mu8+JvYE
         6jlc7j6DzV70SzlqcJIeDFOI+9bgZcBZj48GnHQb1TJCKiJObYNEQpaTyHq4xVFnXTgs
         Zb4oMM6tMTl/XzmH4/O+/jGX0nS2ogif4uIKXLt3Mgahojcge6y+TRPbPnxM+sTenBqt
         mkEy00pY5fntyEdKWymMdJmhxCgNjgZzPSNUHc3CFQAye9q10oBCd3jprGZJJcQjwxWP
         Vp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxRBS06pE2CQHpTgzqatJymLAXpPxBjp9lWephyRcDY=;
        b=fJbKtqab49Bsq3iMLEDk8Nx5nLpKoZe/v1AxxxZPox73pAYDOt6vsEFc6vF5eUzF0R
         vMKcQ7cOzMRXj72/yKj8B9a3q2Nnu4/Xn4+2274t4lqgPmyNttrBhKJzHXSLcIgMOYNx
         kalr1Q2dfl3DICCaKgkHJujAAMxZ566XIpBHAq0xRM6u+24Gu08PxTxIIvdCgA/g8IXw
         8ANJbWViW6McBdnpRWJnplTayqZ6p0rAUZd+EWN4p/Ty432dDXC4tnd9QXjB4XbvV/Hy
         Vd79igL3SjUPYgfBIfyYBJO7KHsf/sQ7nKDToq8SoyBc08mT3sIqqIIjJK33iXwI2J5H
         r33w==
X-Gm-Message-State: AJIora8BAIE672H2wuGKr6RYMWhL39P+5zL4pGaYMCrvjTQzN+2F5bhI
        xwjEhdHUBwzahXqharQPkNSUjQFMVjkzMv6OsVwqHvonashuTw==
X-Google-Smtp-Source: AGRyM1v61sLa0Q+4hwdTmFbbx9mwGhQVVpp9ymXC4i+qg4KlnAe+6zmh0YCXopnDMl6JRzNEZMVijDCYhENkXwVUQC4=
X-Received: by 2002:aa7:cdc2:0:b0:43a:7255:5274 with SMTP id
 h2-20020aa7cdc2000000b0043a72555274mr1955839edw.159.1656960050072; Mon, 04
 Jul 2022 11:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065856.18936-1-hbh25y@gmail.com> <dc52f807-f4bc-13d6-7b9e-81b4fe94a6e0@intel.com>
 <fe6fe929-578e-5828-7886-3fe69b9d3a6a@gmail.com>
In-Reply-To: <fe6fe929-578e-5828-7886-3fe69b9d3a6a@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 4 Jul 2022 20:40:38 +0200
Message-ID: <CAG3jFytopyV+gN3QAVAZYd_HYWeAygTZkb7iQAA-jmSBMQexfw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: sii8620: fix possible off-by-one
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        architt@codeaurora.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 04:55, Hangyu Hua <hbh25y@gmail.com> wrote:
>
> On 2022/5/18 15:57, Andrzej Hajda wrote:
> >
> >
> > On 18.05.2022 08:58, Hangyu Hua wrote:
> >> The next call to sii8620_burst_get_tx_buf will result in off-by-one
> >> When ctx->burst.tx_count + size == ARRAY_SIZE(ctx->burst.tx_buf). The
> >> same
> >> thing happens in sii8620_burst_get_rx_buf.
> >>
> >> This patch also change tx_count and tx_buf to rx_count and rx_buf in
> >> sii8620_burst_get_rx_buf. It is unreasonable to check tx_buf's size and
> >> use rx_buf.
> >>
> >> Fixes: e19e9c692f81 ("drm/bridge/sii8620: add support for burst eMSC
> >> transmissions")
> >> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> >
> > Regards
> > Andrzej
> >> ---
> >>   drivers/gpu/drm/bridge/sil-sii8620.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
> >> b/drivers/gpu/drm/bridge/sil-sii8620.c
> >> index ec7745c31da0..ab0bce4a988c 100644
> >> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> >> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> >> @@ -605,7 +605,7 @@ static void *sii8620_burst_get_tx_buf(struct
> >> sii8620 *ctx, int len)
> >>       u8 *buf = &ctx->burst.tx_buf[ctx->burst.tx_count];
> >>       int size = len + 2;
> >> -    if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
> >> +    if (ctx->burst.tx_count + size >= ARRAY_SIZE(ctx->burst.tx_buf)) {
> >>           dev_err(ctx->dev, "TX-BLK buffer exhausted\n");
> >>           ctx->error = -EINVAL;
> >>           return NULL;
> >> @@ -622,7 +622,7 @@ static u8 *sii8620_burst_get_rx_buf(struct sii8620
> >> *ctx, int len)
> >>       u8 *buf = &ctx->burst.rx_buf[ctx->burst.rx_count];
> >>       int size = len + 1;
> >> -    if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
> >> +    if (ctx->burst.rx_count + size >= ARRAY_SIZE(ctx->burst.rx_buf)) {
> >>           dev_err(ctx->dev, "RX-BLK buffer exhausted\n");
> >>           ctx->error = -EINVAL;
> >>           return NULL;
> >
>
> Hi guys,
>
> Another patches for this module that I submitted at the same time as
> this one have been merged. Is this patch forgotten to merge?

Applied to drm-misc-next.
