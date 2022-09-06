Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797605AE74C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiIFMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiIFMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:10:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2052402DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:10:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qh18so22714905ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vCwl8j+RWcYnHs2Ge4KIIN5Weh4JvqT5rY25vxWNLag=;
        b=lOa6WYPsC1uUBdMQKtoUl2jwn4GzkujrcdNHqpHHagPEkQznc0SQeaek3uPXhsII9/
         aWPQmIh2WGQPv77i4xNjBsSWZ8abLLQe+5DF3vYb4xuKgBVSFgzLmamx19gqzj+Qfi5q
         Em92ghJNH10uPXU62B69AYerZ6D/8jZbKnj1kmFla5ZL8FK6XqyPf+4kqZ9++hn2PlII
         Bsp9dHsaKTze2hAOo6NLT/sGZytLyUlAODLhJn49VeVWs3KkglxqcPf4RNCiGsruzntX
         fVgwOzbzHgjK3Tzqz8Jj55H+wD8Fk8kC8PuzcwFx1aHhT/B65klc5BVwIi/sDedtJuY1
         gkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vCwl8j+RWcYnHs2Ge4KIIN5Weh4JvqT5rY25vxWNLag=;
        b=ub5NFLGOXDObH5vBFTmD/3AuQpSdNcPYbKFFImnPRYG7uZRwDsl+/wfJbLJDSNhM+3
         +6VKyX3/UUVns3JwQSuGqRzYY0d/bbKumrDx3i+TAeFkbK9azcZe76JIzZxdeRMb91yM
         q4VbuHo5wvbWkwFtS66DUwG2mEwEw8lqedGHvEAosmKrCZ/X8jxH0DOjHfR6r2wEwWdv
         U3nQvmm+miGcvOMQqjAwRvnKyLRAiMskUt4+EUehyWb4vmok/WXyeJqgVBMLBFehzOe8
         HJstogPqa7MwkDEJxMNKrxKhwXN+YB3LcwX6ZSSlGxK9CExtaQksy636Lc1pWABYU+T5
         wVhQ==
X-Gm-Message-State: ACgBeo2+E0iurLLbmsz7IyRy4w5sjMnFuXKIn6brT/BhTsciFq5h+Gpi
        RC2q7aTl9WoCE5oYd3qC/Kr9jm7+ly2VLNq/xUDEfNaja3U=
X-Google-Smtp-Source: AA6agR7GgqK7ijpgcdaNkqRz3n6PJtmaaPGE/4WCyXXWgF5BzYxZFDL2Rnn6TA/iG4hP73Hpgtay6650+CxP+9k+oDY=
X-Received: by 2002:a17:906:eece:b0:76f:5c6:2340 with SMTP id
 wu14-20020a170906eece00b0076f05c62340mr2662494ejb.383.1662466215963; Tue, 06
 Sep 2022 05:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220903130833.541463-1-xji@analogixsemi.com> <CAG3jFyum5M8iGdW++c7rayUn4ogJ6izWaX7VaqMfV7ShAe_kRQ@mail.gmail.com>
 <20220906025753.GA642918@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220906025753.GA642918@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 6 Sep 2022 14:10:05 +0200
Message-ID: <CAG3jFysnwnq7pQE4fKA3XiUzZPC0inJOyvszaf2QGNsMhqCVUw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Set HPD irq detect window to 2ms
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, mliu@analogixsemi.com, hsinyi@chromium.org,
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

On Tue, 6 Sept 2022 at 04:58, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Mon, Sep 05, 2022 at 06:48:06PM +0200, Robert Foss wrote:
> > Hi Xin,
> >
> > On Sat, 3 Sept 2022 at 15:09, Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > Some panels trigger HPD irq due to noise, the HPD debounce
> > > may be 1.8ms, exceeding the default irq detect window, ~1.4ms.
> > > This patch set HPD irq detection window to 2ms to
> > > tolerate the HPD noise.
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++++++++
> > >  drivers/gpu/drm/bridge/analogix/anx7625.h |  6 ++++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index c74b5df4cade..0c323b5a1c99 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -1440,6 +1440,20 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
> > >
> > >  static int anx7625_read_hpd_status_p0(struct anx7625_data *ctx)
> > >  {
> > > +       int ret;
> > > +
> > > +       /* Set irq detect window to 2ms */
> > > +       ret = anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > > +                               HPD_DET_TIMER_BIT0_7, HPD_TIME & 0xFF);
> > > +       ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > > +                                HPD_DET_TIMER_BIT8_15,
> > > +                                (HPD_TIME >> 8) & 0xFF);
> > > +       ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> > > +                                HPD_DET_TIMER_BIT16_23,
> > > +                                (HPD_TIME >> 16) & 0xFF);
> >
> > Does the HPD debounce timer register need to be written for every HPD
> > status read?
> Hi Robert Foss, yes, it is better to set it in every HPD status check, because the
> HPD may be affected by noise, once the chip detect HPD is low, the timer
> register will be automatically set to 1.4ms, so the driver better set it
> in each check loop.
>
> Thanks,
> Xin
> >
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > >         return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, SYSTEM_STSTUS);
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> > > index e257a84db962..14f33d6be289 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> > > @@ -132,6 +132,12 @@
> > >  #define I2S_SLAVE_MODE 0x08
> > >  #define AUDIO_LAYOUT   0x01
> > >
> > > +#define HPD_DET_TIMER_BIT0_7   0xea
> > > +#define HPD_DET_TIMER_BIT8_15  0xeb
> > > +#define HPD_DET_TIMER_BIT16_23 0xec
> > > +/* HPD debounce time 2ms for 27M clock */
> > > +#define HPD_TIME               54000
> > > +
> > >  #define AUDIO_CONTROL_REGISTER 0xe6
> > >  #define TDM_TIMING_MODE 0x08
> > >
> > > --
> > > 2.25.1
> > >

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
