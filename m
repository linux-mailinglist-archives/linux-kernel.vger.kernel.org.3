Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774BC4AE7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiBIDNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbiBIDNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:13:16 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76DC061355
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:13:15 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g14so2206654ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/R2LriswMiHtMayk3cQe3ZgDGVpDn6vfPdguZ1VAL8c=;
        b=Z4htK1PvPjLN2hbBeC6YYrji+agQMuMV5YG42X2kwEw2dpzm0JxFKo8hsFa2C1Jfx6
         aiqSpFNGQmDBS2DDI+xB/nArXQTRf8UlOzrFaZGH+fyy6IVPwIXsISWvJMcGQ6vwcd4N
         brBY26HkIFXOwhYOm+A2RznepAOysyGRvyKdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/R2LriswMiHtMayk3cQe3ZgDGVpDn6vfPdguZ1VAL8c=;
        b=wcwMcInRSsdfSwe8AgoovRbUP+6h9HXoiYUF9Og2Q1ikTSo3iAMSNjejDGpEHYU+N2
         Mp/77KMoOO8k8T5hde7fnjTvBUXX46skUg6MGV578W/4O6FL42HNdvKnFI2uemD3GEe5
         363Qpx+pU01yAV1CJiHh+JdfLfMVF2LAKNiQQD3tYImUKd2/lflEwwPjAnhVxj7rx3KS
         ap4uXSVOo8cnOYHWmmUGagIv6nCGEJxp2buc2GAlh9w8qrdwB7Qy98WmVM0Qd6qyzkFW
         H9Tp4dWeaX+nFU7ePROPL063MxzMluj8LXsO1dFf/QrNQMrvEfn7ez7jJQiGJVwBCZzp
         SwEg==
X-Gm-Message-State: AOAM530gk60iDru8Fcs5EHUtnuk5ETCF0erIgvthnltRBksrKd6wdWaU
        6hUUs7YfUm75nIwX3bMBF6zSA3TtA1m5hFqDOM2Lsg==
X-Google-Smtp-Source: ABdhPJxTxvn/1WdP/keqrM63kkqlFYBObLI54gDsNyXkQOm6LGSkEX7oidm2bg05AxRzM3cqFgbOsLGSQybe+5qqx+o=
X-Received: by 2002:a25:5382:: with SMTP id h124mr384351ybb.291.1644376394583;
 Tue, 08 Feb 2022 19:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20220208124034.414635-1-wenst@chromium.org> <20220208223252.7f179c63@pc>
In-Reply-To: <20220208223252.7f179c63@pc>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 9 Feb 2022 11:13:03 +0800
Message-ID: <CAGXv+5Hz6-aZpisXuFqdez5CQBtsg-h7H6yOAWUwBP-L8L=qkw@mail.gmail.com>
Subject: Re: [PATCH v3 00/31] clk: mediatek: Cleanups and Improvements - Part 1
To:     Boris Lysov <arz65xx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 9, 2022 at 3:32 AM Boris Lysov <arz65xx@gmail.com> wrote:
>
> Hi, I couldn't find a particular patch to reply to so I'm replying cover
> letter to give some input on the PLL subsystem.
>
> On Tue,  8 Feb 2022 20:40:03 +0800
> Chen-Yu Tsai <wenst@chromium.org> wrote:
> >  drivers/clk/mediatek/clk-pll.c                | 100 +++++-
> >  drivers/clk/mediatek/clk-pll.h                |  57 ++++
>
> In clk-pll.c there is an mtk_clk_register_pll function which at some point
> executes this:
>
> > init.ops = &mtk_pll_ops;
>
> In my opinion there should be a possibility to define a custom mtk_pll_ops for a
> given SoC instead of using a hardcoded one because not all Mediatek SoCs share
> the same PLL startup/powerdown flow. For example, the existing mtk_pll_prepare
> implementation won't work for the entire Mediatek Cortex-A9 SoC family (this
> includes but not limited to mt6515, mt6517, mt6575, and mt6577).

Ack. My scope is limited to SoCs used in Chromebooks. However Miles and
Chun-Jie, who are Cc-ed on the series, should know more.

That said, we can implement support for these varying parameters as we
see them, not before.

> > static int mtk_pll_prepare(struct clk_hw *hw)
> > {
> >       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> >       u32 r;
> >       u32 div_en_mask;
> >
> >       r = readl(pll->pwr_addr) | CON0_PWR_ON;
> >       writel(r, pll->pwr_addr);
>
> This code sets a bit to 1 to start a PLL but the SoCs I mentioned above would
> need to have that bit cleared (set to 0) [1] [2].
>
> Another interesting thing in mtk_pll_prepare is
> >       udelay(20);
> Is 20 ms a settle time for PLL? If yes then it would also be cool to specify an
> arbitrary value easily as some PLLs have longer settle time [3] [4].

This is a question for whomever upstreamed the driver.
> Worth noting the SoCs I mentioned aren't in mainline yet, and I think there are
> more modern mainline-worthy Mediatek SoCs that might also need these changes in
> the future.

Again, we can implement varying parameters as they appear.

Thanks
ChenYu


>
> Thanks.
>
> [1] MT6577 HSPA Smartphone Application Processor Datasheet, pages 1212-1227
> (*_CON0 registers).
> [2] MT6515 GSM/EDGE Smartphone Application Processor Datasheet, pages
> 1202-1216 (*_CON0 registers).
> [3] pages 1303-1306 of [1]
> [4] MT6589 HSPA+ Smartphone Application Processor Datasheet, page 1344
> (MDPLL1 & MDPLL2)
