Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD59B48DF94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiAMV2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAMV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:28:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F2C061574;
        Thu, 13 Jan 2022 13:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F0BB82380;
        Thu, 13 Jan 2022 21:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88BFC36AE3;
        Thu, 13 Jan 2022 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642109282;
        bh=Uw7sKyZezZUSGk90rWf7fiPngEeef5ZBZM1owhhATBI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ojWvA73JsanpuZXZr/R8UTiPvmoIhGTGPTQC7WDyJ7p/06CaX6gOdIWdUv0KTksi3
         Vqyu2mn3XR5z/3ORCHpc0UKKbEjZNoJToTvuULSqlEKfioDcjtFrdhAIdJEFoi66ER
         8xvdPIYwvAJjDaE52dzRiRAMj/hDiYRHaghQW60hGUDKYEtKxWw9Xi46qC2xtNOIOB
         bwXiax/r4EJicx6uaH1leAj2NOzRPsg0GLYiaq+lNPTRMAs4S2dRO2bwiyQibpPXQb
         IFYiLv3zJC4dDNeq9f0ZtNxpTkn0C/XEJAaOPVyIK9skLipGR4k7wpuaYEQnI4AMIP
         9GFORupFR4WbA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220113115745.45826-2-liang.yang@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-2-liang.yang@amlogic.com>
Subject: Re: [PATCH v9 1/4] clk: meson: add one based divider support for sclk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Date:   Thu, 13 Jan 2022 13:28:00 -0800
User-Agent: alot/0.9.1
Message-Id: <20220113212801.E88BFC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-13 03:57:42)
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> index 76d31c0a3342..79c9efd28115 100644
> --- a/drivers/clk/meson/sclk-div.c
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -28,22 +29,39 @@ meson_sclk_div_data(struct clk_regmap *clk)
>         return (struct meson_sclk_div_data *)clk->data;
>  }
> =20
> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
> +static inline int sclk_get_reg(int val, unsigned char flag)
>  {
> -       return (1 << sclk->div.width) - 1;
> +       if ((flag & MESON_SCLK_ONE_BASED) || !val)
> +               return val;
> +       else
> +               return val - 1;

Please drop the else

> +}
> +
> +static inline int sclk_get_divider(int reg, unsigned char flag)
> +{
> +       if (flag & MESON_SCLK_ONE_BASED)
> +               return reg;
> +       else

Please drop the else

> +               return reg + 1;
>  }
> =20
>  static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>  {
> -       return sclk_div_maxval(sclk) + 1;
