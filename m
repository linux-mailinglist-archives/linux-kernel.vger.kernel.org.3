Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80F506F87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiDSN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbiDSN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:59:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC638BF6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:56:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c12so15823118plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rw5QjY021RyzTeQ4xpVG99hTPF+Ij7oZl3AemnBjCL8=;
        b=KKbhPDuGJRNq+DSB9QxKIKwy8Tbd6ZArY094PBzD0N6dhwyeuB5UYs1cnDu9zNtHdD
         lgVXMlIhfl9h8fIW5SONAlLGncVvHUerMBgd+XthiBeXtwyG/PYlHIUCZoPW4xLuY/M9
         /XBtqGUMjQ/poMaTuf5nPSxu1y1M0NVcE1IFw4sINmE6FPN5wte3AWBMiIJLwmIESjeY
         ghnam4GhIHcgxzlMHO5ais+I1k6ySIPePgiIIkTIF/Aawv1LLiKbQMasGbq022GUtPNb
         uXPN/3tvtINHCvtKCvHmrKGcgysOkCwuEH1uhwzOuWrGtrC8ngqQzJXDQM2YjpI71e5D
         C4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rw5QjY021RyzTeQ4xpVG99hTPF+Ij7oZl3AemnBjCL8=;
        b=7d6e2sDaRyGu9pMyZSR7yHV66Z7quKsRWpOdTcXTS0tyBMc3bVmhfrE/KLqDv9hCna
         CAjv5xiANgHvXSmfCVkYd5EhnsFyO9DKDi7Zb/CgCayss6QjAJ9Y7XwM9w1GL5rvoh5S
         fAgme6yB14l9hycytPV+nV6+ggaUFqY45iXFGtm4QqOq/kQZxy4oOBIMBCD1wOxDLNf2
         ke6KwvNGCKzxeHw+5RcB2q46vkFF9OZrNQ7QnjTi2nc9iRGlIMRgvO/3ymwGIEaIHGI8
         ELIzvALHZQu44BAK5JnuMuQ8QlfdoTKQOijpWzIm5Nk1HTUWrnH6KI1Mh85KyhliNSov
         aFfQ==
X-Gm-Message-State: AOAM531o6Ub+pH8T+8p3G02jssh1xX5WOCXKnLpbRiMzYAXPRN5QVXRM
        DXCN+7Mlx5C45LanQbr8ebgMGLFtFF3ogWCHj7xeeaV2msQ=
X-Google-Smtp-Source: ABdhPJwBanz3ZRElr/JD62R6VOJBk6pj27yLywloqYKldOS4kZbt7T1PXjjtGvH7meviG4zpYbv4lcXrNzqFbbvW9HA=
X-Received: by 2002:a17:90b:3e84:b0:1d2:c015:2182 with SMTP id
 rj4-20020a17090b3e8400b001d2c0152182mr6322697pjb.232.1650376606210; Tue, 19
 Apr 2022 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220414090003.1806535-1-hsinyi@chromium.org> <20220419022932.GA629745@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220419022932.GA629745@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Apr 2022 15:56:35 +0200
Message-ID: <CAG3jFyv5Sv6Kr1Xad=gE6rd4=9t-0Yqz090pR26WOUrf3sqvMA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fill in empty ELD when no connector
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, 19 Apr 2022 at 04:29, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Thu, Apr 14, 2022 at 05:00:04PM +0800, Hsin-Yi Wang wrote:
> > Speaker may share I2S with DP and .get_eld callback will be called when
> > speaker is playing. When HDMI wans't connected, the connector will be
> > null. Instead of return an error, fill in empty ELD.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 6516f9570b86..f2bc30c98c77 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1932,14 +1932,14 @@ static int anx7625_audio_get_eld(struct device *dev, void *data,
> >       struct anx7625_data *ctx = dev_get_drvdata(dev);
> >
> >       if (!ctx->connector) {
> > -             dev_err(dev, "connector not initial\n");
> > -             return -EINVAL;
> > +             /* Pass en empty ELD if connector not available */
> > +             memset(buf, 0, len);
> > +     } else {
> > +             dev_dbg(dev, "audio copy eld\n");
> > +             memcpy(buf, ctx->connector->eld,
> > +                    min(sizeof(ctx->connector->eld), len));
> >       }
> >
> > -     dev_dbg(dev, "audio copy eld\n");
> > -     memcpy(buf, ctx->connector->eld,
> > -            min(sizeof(ctx->connector->eld), len));
> > -
> >       return 0;
> Hi Hsin-Yi, it's OK for me.
> Reviewed-by: Xin Ji <xji@analogixsemi.com>

Applied to drm-misc-next
