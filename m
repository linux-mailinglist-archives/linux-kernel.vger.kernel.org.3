Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8D52E140
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbiETAh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbiETAh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6C12FEE7;
        Thu, 19 May 2022 17:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8965661ABD;
        Fri, 20 May 2022 00:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88EC385AA;
        Fri, 20 May 2022 00:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653007045;
        bh=LTTQowMe5fIFG76ASzuMYoCSU9Z8TH3Z9IDQ21ShTMo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V+pWojR87D4Tdluo1EBAh/3o6oMjRUB/uTPjQ+4keHDYRbuqZQ+p4ifk5Q+RIUK1R
         O+CxyOOkdDTSE+TkInjzZykmJAU1wqMSacAnpO2vn7h/smTwGNCs6PWwAV0eINw6Up
         5xfm/htovEfTgONomyG2vhCsTGv1FW1J46IrNtht9IXXHjYI9ggNOY/NSVFnc7P+BB
         hZA9Ns/kuKaqPE79DrCZUo8mC6NhhUPpYwYNMZd8jyuoTVQzO1/zB5hqrig4WX3mgL
         i0L5eu1ZX87w2lDBBMvPbyOBA8rhCEmt9BLHVfhlCzzpHLbkoDPxrij+NRFMxlYCvl
         0PE0hZobAiSvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519071610.423372-4-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org> <20220519071610.423372-4-wenst@chromium.org>
Subject: Re: [PATCH v3 3/5] clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 19 May 2022 17:37:21 -0700
User-Agent: alot/0.10
Message-Id: <20220520003724.DD88EC385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-19 00:16:08)
> As part of the effort to improve the MediaTek clk drivers, the next step
> is to switch from the old 'struct clk' clk prodivder APIs to the new
> 'struct clk_hw' ones.
>=20
> Instead of adding new APIs to the MediaTek clk driver library mirroring
> the existing ones, moving all drivers to the new APIs, and then removing
> the old ones, just migrate everything at the same time. This involves
> replacing 'struct clk' with 'struct clk_hw', and 'struct clk_onecell_data'
> with 'struct clk_hw_onecell_data', and fixing up all usages.
>=20
> For now, the clk_register() and co. usage is retained, with __clk_get_hw()
> and (struct clk_hw *)->clk used to bridge the difference between the APIs.
> These will be replaced in subsequent patches.
>=20
> Fix up mtk_{alloc,free}_clk_data to use 'struct clk_hw' by hand. Fix up
> all other affected call sites with the following coccinelle script.
>=20
>     // Replace type
>     @@
>     @@
>     - struct clk_onecell_data
>     + struct clk_hw_onecell_data
>=20
>     // Replace of_clk_add_provider() & of_clk_src_simple_get()
>     @@
>     expression NP, DATA;
>     symbol of_clk_src_onecell_get;
>     @@
>     - of_clk_add_provider(
>     + of_clk_add_hw_provider(
>             NP,
>     -   of_clk_src_onecell_get,
>     +   of_clk_hw_onecell_get,
>             DATA
>       )
>=20
>     // Fix register/unregister
>     @@
>     identifier CD;
>     expression E;
>     identifier fn =3D~ "unregister";
>     @@
>       fn(...,
>     -    CD->clks[E]
>     +    CD->hws[E]->clk
>          ,...
>         );
>=20
>     // Fix calls to clk_prepare_enable()
>     @@
>     identifier CD;
>     expression E;
>     @@
>       clk_prepare_enable(
>     -                CD->clks[E]
>     +                CD->hws[E]->clk
>       );
>=20
>     // Fix pointer assignment
>     @@
>     identifier CD;
>     identifier CLK;
>     expression E;
>     @@
>     - CD->clks[E]
>     + CD->hws[E]
>       =3D
>     (
>     - CLK
>     + __clk_get_hw(CLK)
>     |
>       ERR_PTR(...)
>     )
>       ;
>=20
>     // Fix pointer usage
>     @@
>     identifier CD;
>     expression E;
>     @@
>     - CD->clks[E]
>     + CD->hws[E]
>=20
>     // Fix mtk_clk_pll_get_base()
>     @@
>     symbol clk, hw, data;
>     @@
>       mtk_clk_pll_get_base(
>     -                  struct clk *clk,
>     +                  struct clk_hw *hw,
>                            const struct mtk_pll_data *data
>       ) {
>     - struct clk_hw *hw =3D __clk_get_hw(clk);
>       ...
>       }
>=20
>     // Fix mtk_clk_pll_get_base() usage
>     @@
>     identifier CD;
>     expression E;
>     @@
>       mtk_clk_pll_get_base(
>     -    CD->clks[E]
>     +    CD->hws[E]->clk
>          ,...
>       );
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
