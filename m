Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4C4DA1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiCOR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiCOR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9A522C5;
        Tue, 15 Mar 2022 10:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C8F61634;
        Tue, 15 Mar 2022 17:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E1AC340EE;
        Tue, 15 Mar 2022 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647366920;
        bh=DnJBRB69KPEnIPM6pi87Ym+S0PQ45uLanLNzMJWai8c=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=CIHKi2eDxeLTRpDkaifVYJP3UoodHCktIhnCjwUdmYcF+N50KnGjE2KdUfGQbabkY
         e9UmgBf5/TErJtxiLrCwuyf3sBZxFhIDoJ/Gg4TrXW/JXcpB7soflew1EDG0+WNJ75
         e2kIqZ7EiURge5ibuELBkb9TBAwM5jSz8Dqtv7aVMz/Mag8+cbcW3m3N1vi+o98TrZ
         viLW4/VDukMZ+rjqCiH6IelYRlAzVqI+dQMoh1chXKwzGOTTc7VbJ0np+5SKcePbLh
         TyAcBDVIq5hBEVW0vsRzbFIJyPyz8znuH4fxPWH9F347Bk3yITn66aTvorKWgNMoM8
         rSS5L1K24Tyfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220313190419.2207-2-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH 01/16] clk: permit to define a custom parent for clk_hw_get_parent_index
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Date:   Tue, 15 Mar 2022 10:55:18 -0700
User-Agent: alot/0.10
Message-Id: <20220315175520.32E1AC340EE@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-13 12:04:04)
> Clk can have multiple parents. Some clk may require to get the cached
> index of other parent that are not current associated with the clk.
> Extend clk_hw_get_parent_index() with an optional parent to permit a
> driver to get the cached index. If parent is NULL, the parent associated
> with the provided hw clk is used.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/clk.c                 | 14 +++++++++-----
>  drivers/clk/tegra/clk-periph.c    |  2 +-
>  drivers/clk/tegra/clk-sdmmc-mux.c |  2 +-
>  drivers/clk/tegra/clk-super.c     |  4 ++--
>  include/linux/clk-provider.h      |  2 +-
>  5 files changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8de6a22498e7..fe42f56bfbdf 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1711,15 +1711,19 @@ static int clk_fetch_parent_index(struct clk_core=
 *core,
>  /**
>   * clk_hw_get_parent_index - return the index of the parent clock
>   * @hw: clk_hw associated with the clk being consumed
> + * @parent: optional clk_hw of the parent to be fetched
>   *
> - * Fetches and returns the index of parent clock. Returns -EINVAL if the=
 given
> - * clock does not have a current parent.
> + * Fetches and returns the index of parent clock. If parent is not
> + * provided the parent of hw is used.
> + * Returns -EINVAL if the given clock does not have a current parent.
>   */
> -int clk_hw_get_parent_index(struct clk_hw *hw)
> +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent)

Please introduce another API vs. tacking on an "output" argument to this
API. That makes the patch less invasive. And it can also return a
pointer instead of an integer in that case.

>  {
> -       struct clk_hw *parent =3D clk_hw_get_parent(hw);
> +       /* With parent NULL get the current parent of hw */
> +       if (!parent)
> +               parent =3D clk_hw_get_parent(hw);
