Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229E4D3FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiCJDbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiCJDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:31:24 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78812A751
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:30:24 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c0so44829737b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgRCsCLWYCcRTmUTMqwnDRYue1IsKXpGcRsc3GS7hcU=;
        b=bTmH5bmcH/U/4uCsCmXzu+Ix6JFxxrKutkNq+STjXVK63oKlZUPzuNjfK3ADEaQxV6
         JOOXFEOr+zjOHCrbYY/H33UEZk2p4cb1Famj9f87Uy8+SH31gNUlQpdF5YfxwZprAfVO
         qA4wQh+0eK0n3aqJBtjY59fXp9MZGpaYELU0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgRCsCLWYCcRTmUTMqwnDRYue1IsKXpGcRsc3GS7hcU=;
        b=zt8CdMepd84TSXP58jt0pdPrKMZBhCcWt8K9twSe8dm2K5DdS1kAwBOiP5f9SnBKI+
         GvgIPFIbfUxLDLXIOfKp6ayMdBa8bnHvlQeTHQxyDk4FuZo/uE05/MvbEiwHaGtuT3Zv
         qJwsYWZH1ZVt34ZsxWHmjRj174OZSkL6slIjvJhP4wqIYJ4TxNopAxed8R2iW8UUeYxC
         RGHm28Y7R5tPLL1z9KGbcz2PZEJqfmcuqZn/hUaDE3Ivys9JJfm9Gbd5TBBhKpK8LY+E
         MC8L98QQiRs1tJF2nOfAMQTzI51rRWFTOtKAyp2FtGXxSRO9tn+XfMtgI4mUtmyeeP0f
         kEuQ==
X-Gm-Message-State: AOAM531YM+twy4H2Cm2lPUmepdSfyMSN3EzsF6GZuvJxq3nRLEPAdVT6
        RqkjQsHFWyn6wRAyyYEIPqpGEmzZ87Q+Oj/H7Yt8Sg==
X-Google-Smtp-Source: ABdhPJzXi4nwrmcagVkrjtM225SxnGi8cQ0ildeViV9+Ph+DRtdhBYcRycwlj8wpEmf6UJ4qvADYZ6TExd3tXQlrEE4=
X-Received: by 2002:a81:b044:0:b0:2d6:bd1f:5d8b with SMTP id
 x4-20020a81b044000000b002d6bd1f5d8bmr2386642ywk.27.1646883023764; Wed, 09 Mar
 2022 19:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20220310011548.2487-1-chun-jie.chen@mediatek.com>
In-Reply-To: <20220310011548.2487-1-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 10 Mar 2022 11:30:12 +0800
Message-ID: <CAGXv+5HecgmXVMnAqUJVvjy2S1P5qvPWSVkcu5BwkhfAqDPEYQ@mail.gmail.com>
Subject: Re: [PATCH v1] soc: mediatek: pm-domains: Fix the power glitch issue
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 9:20 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Power reset maybe generate unexpected signal. In order to avoid
> the glitch issue, we need to enable isolation first to guarantee the
> stable signal when power reset is triggered.
>
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
> This patch is based on 5.17-rc1.
> ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index b762bc40f56b..0195f6c3396b 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -272,9 +272,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>
>         /* subsys power off */
> -       regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>         regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>         regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
> +       regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
>
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
