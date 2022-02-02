Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF34A7126
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiBBM6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBBM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:58:20 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 04:58:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id i62so60635423ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dU/z995NUTHrMzTqiAvkMkdF79WLwDMcbs55TIijfcE=;
        b=fHDdFC5FWRcThCd0Tfbp/dR2XIbwHtRs9H3VgjSuG/yWGDTofEDHUBZnWEJs5mh1uT
         Doh4KUlfwdcL923Pp48pI6OQf4MfQ1kFgpj5kywLiYCCot7ZS/7GM4UexJ8o91/sRPcr
         kyLnSvmRXg0QtssqbGSnERTChrpShqxV90zKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dU/z995NUTHrMzTqiAvkMkdF79WLwDMcbs55TIijfcE=;
        b=F6xHVvjrMMqdK2L4H6J24XlJmCzZGPp6yDMuAzwQWB91oXWMSfM8aId4fYeD0TkrfQ
         ncN5Dik5d5MkeALlQ2Su/AsxBL4vhOgUPqQlzvzcMQj3cnlD1rbeb36uyAuBPn3KyZFt
         gggSWs822a77qBLeGgIBu1ymAWn90XExH6q6bDpB5d8PjLL1cIcK8KGNaRYKccwh8EuV
         A/K/s9ZtiMcCr0DT3XVb4y2+3WSehJgVSYphQHR5qCz7PRczmqGtroAID5wxNrvtuOVN
         IQJ7M1qV1mOsez0jokx0O7fbBQqsLILeHGuZT+25EtMnah3gA029MBOfTbdEeoiS7Owt
         fszA==
X-Gm-Message-State: AOAM533CofBf5HKg00zy5TXIj+5sllteeW9RM31iYhFSitLF91P5JmP8
        7JTb10ZzMNzyyctivBseOLM+UaQj3oTQjY/i369DSA==
X-Google-Smtp-Source: ABdhPJxOekHpFlkiPIYTTgHOA7chVTJIdKfOU7Gx9z5sD2o1KBdROJnYT6/dSYpbYolgkvDYcwWRm5+E1jZer/H+E00=
X-Received: by 2002:a81:1458:: with SMTP id 85mr937225ywu.199.1643806699120;
 Wed, 02 Feb 2022 04:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20220122091731.283592-15-wenst@chromium.org> <20220126063643.11544-1-miles.chen@mediatek.com>
In-Reply-To: <20220126063643.11544-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 2 Feb 2022 20:58:08 +0800
Message-ID: <CAGXv+5HH0gsjNJcLoig=wt+QfjfJ7E9r8UAxm2PFjsR09x9NmQ@mail.gmail.com>
Subject: Re: [PATCH 14/31] clk: mediatek: pll: Clean up included headers
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     chun-jie.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:36 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> > Some included headers aren't actually used anywhere, while other headers
> > with the declaration of functions and structures aren't directly
> > included.
> >
> > Get rid of the unused ones, and add the ones that should be included
> > directly.
> >
> > Also, expand the MHZ macro with spelled-out "1000 * 1000" to be able
> > to not include clk-mtk.h. The existing ternary operator is rewritten
> > in a shortened form to accommodate the expanded macro.
>
> I think MHZ is more human readable than 1000*1000,
> like SZ_4K in linux/sizes.h.
>
> MHZ is also use by other clk-mtxxxx.c (by including clk-mtk.h)
> , so maybe we should keep clk-mtk.h?

This seems like overkill. I'll define MHZ in the file instead.

ChenYu

> Miles
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/clk/mediatek/clk-pll.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index 081e0df8203e..9698d1c97cd6 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -4,15 +4,15 @@
> >   * Author: James Liao <jamesjj.liao@mediatek.com>
> >   */
> >
> > -#include <linux/of.h>
> > -#include <linux/of_address.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/container_of.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/of_address.h>
> >  #include <linux/slab.h>
> > -#include <linux/clkdev.h>
> > -#include <linux/delay.h>
> >
> > -#include "clk-mtk.h"
> >  #include "clk-pll.h"
> >
> >  #define REG_CON0             0
> > @@ -162,7 +162,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >               u32 freq, u32 fin)
> >  {
> > -     unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
> > +     unsigned long fmin = pll->data->fmin ?: (1000 * 1000 * 1000);
> >       const struct mtk_pll_div_table *div_table = pll->data->div_table;
> >       u64 _pcw;
> >       int ibits;
> > --
> > 2.35.0.rc0.227.g00780c9af4-goog
>
>
