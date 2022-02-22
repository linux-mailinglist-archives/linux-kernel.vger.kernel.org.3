Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDB4BEFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 04:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiBVCzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbiBVCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:55:52 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9025C78
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:55:27 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so38196114ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flwzoWXjBS1fKxQYSqzor2TYAU8hRShfKYrKLieas1Y=;
        b=DpG8Z7TGWUvG/BQ+qbHS5epx1Ot08wZ4somVg/8Hv8Ipg4wjnOzU/2zaF7cbkFzGQY
         DdNH0nh1ltW3b5lUN4eFL8Gr+kU4irEFLTkTgTxJ2dspwBKKVY9OjQKum+lbDZ1YZq3y
         KjiPhY6gPlTfDnvw6F9YBQwFGxzH4wSBSHj94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flwzoWXjBS1fKxQYSqzor2TYAU8hRShfKYrKLieas1Y=;
        b=VOPKaIxz4xS8uZABUuBpaTWHVpFxU4dvsinlbyOl+0YJn2NPDtOeCBYB9S5dHIMXD+
         8uJxdzgyxITa70j5TKvab6ZL4f37VGunlqHcdkZfuCGxYB/cojAf2+0/cvtA/YP79mtQ
         fM2Gh43fvNeZpM6ti0Rzex31jP4yk/Gta22aNX7SIK0vqQg7NZCXp7qrYWZv/IwDBg1U
         WLJj7NPPhowt4APcAgqRz00qUCnneXP6ASj20efp8v4jxHoiZFikkREaNT6zXn8z0ULw
         LMqUXICvlb8JuNN1zYQ7ODsLkzQbs2Ht2VoON9+qj6bJK5obKe5TvkJXesw3x2xaITcL
         r1Tw==
X-Gm-Message-State: AOAM530GI+oO9EFwg+Ws6kbxP/3PodWZocLduvEy4xzPEpZf4UhdFo3v
        JMLPqcwReoDkERPFPdgPYqloiCPC2mI1wf2/u7Thrw==
X-Google-Smtp-Source: ABdhPJzx/1Y7F9nbMupU99Wa5ez7jb/PujfIQdzFN2lV5ICZOAAPdhGexRkhW8sMu/dsmOHX3knv1+MYsXkEzSrU9C4=
X-Received: by 2002:a25:24d6:0:b0:623:a267:b5ee with SMTP id
 k205-20020a2524d6000000b00623a267b5eemr20997387ybk.278.1645498527071; Mon, 21
 Feb 2022 18:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
 <20220210141931.291712-5-angelogioacchino.delregno@collabora.com> <CAGXv+5GLSnr1rQ_K3Y1Ou3ocoq7cSmv8GMkRCEi4adxewY1dHA@mail.gmail.com>
In-Reply-To: <CAGXv+5GLSnr1rQ_K3Y1Ou3ocoq7cSmv8GMkRCEi4adxewY1dHA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 22 Feb 2022 10:55:16 +0800
Message-ID: <CAGXv+5GyrMnR3Zu9AYT-pkctdEhFibSiX6xuEpS1u_=Zhx3N+Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: mediatek: common-v1: Commonize spec_pupd callback
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:59 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Feb 10, 2022 at 10:20 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Reduce code size and duplication by using a common spec_pupd callback,
> > which is possible to use on all of the pinctrl drivers that are
> > using the v1 pinctrl-mtk-common code, with the exception of mt8135,
> > which has a different handling compared to the others.
> > Since the callback function signature was changed, this had to be
> > propagated to pinctrl-mt8135's spec_pull_set().
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
>
> [...]
>
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > index 007da39b68c9..5e1d17512a0d 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > @@ -222,9 +222,8 @@ static int mtk_pconf_set_driving(struct mtk_pinctrl *pctl,
> >  }
> >
> >  int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
> > -               const struct mtk_pin_spec_pupd_set_samereg *pupd_infos,
> > -               unsigned int info_num, unsigned int pin,
> > -               unsigned char align, bool isup, unsigned int r1r0)
> > +               const struct mtk_pinctrl_devdata *devdata,
> > +               unsigned int pin, bool isup, unsigned int r1r0)
> >  {
> >         unsigned int i;
> >         unsigned int reg_pupd, reg_set, reg_rst;
> > @@ -232,8 +231,11 @@ int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
> >         const struct mtk_pin_spec_pupd_set_samereg *spec_pupd_pin;
> >         bool find = false;
> >
> > -       for (i = 0; i < info_num; i++) {
> > -               if (pin == pupd_infos[i].pin) {
> > +       if (!devdata->spec_pupd)
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < devdata->n_spec_pupd; i++) {
> > +               if (pin == devdata->spec_pupd[i].pin) {
> >                         find = true;
> >                         break;
> >                 }
> > @@ -242,9 +244,9 @@ int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
> >         if (!find)
> >                 return -EINVAL;
> >
> > -       spec_pupd_pin = pupd_infos + i;
> > -       reg_set = spec_pupd_pin->offset + align;
> > -       reg_rst = spec_pupd_pin->offset + (align << 1);
> > +       spec_pupd_pin = devdata->spec_pupd + i;
> > +       reg_set = spec_pupd_pin->offset + devdata->port_align;
> > +       reg_rst = spec_pupd_pin->offset + (devdata->port_align << 1);
> >
> >         if (isup)
> >                 reg_pupd = reg_rst;
> > @@ -293,12 +295,13 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
> >          * resistor bit, so we need this special handle.
> >          */
> >         if (pctl->devdata->spec_pull_set) {
> > -               /* For special pins, bias-disable is set by R1R0,
> > +               /* For special pins, bias-disable is set by R1R0
>
> Nit: This seems unrelated, and doesn't read correctly either way.

Once removed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
