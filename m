Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82852CF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiESJJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiESJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:09:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370A4D614
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:09:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2fee010f509so50046937b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTYN8SQA1Kibj+1iEMNK2WJ4kiFH1jZy+Z6ZLSVIzN0=;
        b=hvulyA/9nIvcQL349rFarbnddLvY9KxNXVzOwnuziFMGzgoXJafIeq4MkYBy6jLk6W
         s3M1vHrQCdqvZAScHSvOaiC24sEZLHS49j0W88ksuOnZWzOJcz/qal8MrrGbJgy3AxE/
         jC8pn9TpW1Fsn7CRdkMKMPRWnyntyy4uNhTFYqyIsPsY3xLU+1Tj8BSmdpt+ZPQQREut
         hKV7/XAof2E30dQbV/qIr57X2zMxMUYLPtvgd3NWcR1W//0MOFeYlipiFSPiPdoYTRkl
         EVNnGm474dJJ1JPi1bY7lymcKpQU0jo24pOGJbZyS5KotlMFZoWGsrDcpf3mxJcprTz2
         2QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTYN8SQA1Kibj+1iEMNK2WJ4kiFH1jZy+Z6ZLSVIzN0=;
        b=hfcS9JJWq+/3wNj1Du4Lae4t9xisx7MFwn7Z7FjjfRqkw8SaLILaeSNmvrnEkPW3l2
         /D06VNEgsFEGk1YuTyvK5lWE3Sp+TvAzo6zDJ+uxPrfYeTQl43KtAZ19Mz7aoNU1MPY2
         3fjDq7YdFU8VTtnK2JQRUayN/WGxX4Gdn8kfyqS2sbJ6GFN+lfGv0mJpkWKqCEZE4cMI
         46quYKF7asq1Rko4q8+Nr6V9DdEJayKEeRn5x7kr2xywq+Ff5hK3gUhCOkZMcF5P6CxW
         iM3jrImHlcZKKFTlAQXrU46kX7uk5GYMEGkgGvw3TlAsxMfIitrzirNTlhAQ3kCRRgeR
         y7fw==
X-Gm-Message-State: AOAM530Bi3QciOHLgCk2DrqWA9O+8qCBZGWiTTRaxPdN4FXO8tsO7w1H
        QU0DRiXYHkY4w57pYZVTYx4Kl3Xc7tClxKkJzPEw6w==
X-Google-Smtp-Source: ABdhPJwWgBnbFPBng8jyysNwYozhHy5L14kmJuY8TO30we9HAg0aLzdUurH9h7SgBVzWDxYOJ2zAzts+I/soNqiTxJU=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr3757471ywd.448.1652951392715; Thu, 19
 May 2022 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651835715.git.jo@jsfamily.in> <BY5PR02MB7009B91FB7306503B58C264BD9C59@BY5PR02MB7009.namprd02.prod.outlook.com>
 <CACRpkdYhkP9RYj98Lu=zkt+6aefx172R=8JtvOFpvh2uJ4byKA@mail.gmail.com> <BY5PR02MB7009831D8BC4DB2B34739CB6D9CF9@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB7009831D8BC4DB2B34739CB6D9CF9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 11:09:41 +0200
Message-ID: <CACRpkdZw+MwU42s8BWHkN2T3A-a-TGML8jJ0kQteMOE06m0UXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel: introduce ebbg,ft8719 panel
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     devicetree@vger.kernel.org, Hao Fang <fanghao11@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        phone-devel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
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

On Mon, May 16, 2022 at 2:56 PM Joel Selvaraj <jo@jsfamily.in> wrote:
> On 13/05/22 03:21, Linus Walleij wrote:
> > On Fri, May 6, 2022 at 2:18 PM Joel Selvaraj <jo@jsfamily.in> wrote:
> >> +#define dsi_dcs_write_seq(dsi, seq...) do {                            \
> >> +               static const u8 d[] = { seq };                          \
> >> +               int ret;                                                \
> >> +               ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d)); \
> >> +               if (ret < 0)                                            \
> >> +                       return ret;                                     \
> >> +       } while (0)
> >
> > First I don't see what the do {} while (0) buys you, just use
> > a basic block {}.
>
> The do {} while (0) in macro ensures there is a semicolon when it's
> used. With normal blocking, it would have issues with if conditions?
> I read about them here: https://stackoverflow.com/a/2381339

Hm that seems true, it enforces the semicolon ; at the end of the
statement which is nice. I suppose we should fix the other macro
as well.

Noralf added this ({}) form in 02dd95fe31693, so maybe he wants
to chip in.

> > Second look at mipi_dbi_command() in include/drm/drm_mipi_dbi.h
> > this is very similar.
>
> Does the ({..}) style blocking used in mipi_dbi_command help workaround
> the semicolon issue I mentioned above?

Nope. But add the rate limited error print please!

> > It's dubious that you always have dsi_dcs_write_seq()
> > followed by dsi_generic_write_seq().
> >
> > That means mipi_dsi_generic_write() followed by
> > mipi_dsi_dcs_write_buffer(). But if you look at these
> > commands in drivers/gpu/drm/drm_mipi_dsi.c
> > you see that they do the same thing!
>
> They almost do the same thing except for the msg.type values? Mostly the
> msg.type value is used to just check whether it's a long or short write
> in the msm dsi_host code. However, in mipi_dsi_create_packet function,
> the msg->type value is used to calculate packet->header[0] as follows:
>
> packet->header[0] = ((msg->channel & 0x3) << 6) | (msg->type & 0x3f);
>
> Wouldn't the difference between the mipi_dsi_dcs_write_buffer's and
> mipi_dsi_generic_write's msg.type values cause issue here?
>
> I tried using mipi_dsi_dcs_write_buffer for all commands and the panel
> worked fine, but I am not sure if it's correct to do so?

I think it's fine? The only issue would be if there is a DSI host controller
that only supports short writes, and in that case it should emulate
long writes by breaking long messages apart. (My amateur view at least.)

> > Lots of magic numbers. You don't have a datasheet do you?
> > So you could #define some of the magic?
>
> Unfortunately, I don't have a datasheet and the power on sequence is
> taken from downstream android dts. It works pretty well though. So I
> don't think I can #define any of these magic.

If you know which display controller the display is using (usually
Novatek nnnnn, Ilitek nnnn etc someting like that) there is often
a datasheet for the display controller available but the display per
se often obscures the display controller.

>  > Doesn't it work to combine them into one call for each
>  > pair?
>  >> +       dsi_dcs_write_seq(dsi, );
>  >> +       dsi_generic_write_seq(dsi, 0xff, 0x87, 0x19);
>
> By using a macro? We can... but I am not sure what (0x00, 0x80), (0x00,
> 0xa0),etc type of commands signify without the datasheet, so I am not
> sure what to name them in the macro and make any sensible meaning out of it.

I meant just sending dsi_generic_write_seq() with everything in
it:

dsi_generic_write_seq(dsi, 0x00, 0x80, 0xff, 0x87, 0x19);

Instead of two writes. Doesn't this work?

Yours,
Linus Walleij
