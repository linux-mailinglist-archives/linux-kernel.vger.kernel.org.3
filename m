Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67752E13F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbiETAhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiETAhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:37:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDFA12FEF1;
        Thu, 19 May 2022 17:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D760DB82954;
        Fri, 20 May 2022 00:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F74C385B8;
        Fri, 20 May 2022 00:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653007056;
        bh=cfMx9xFtIAJO7736VsoEPlGYeTJREVnvBIgxmigI54A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O8gZosYzIEowwpf2EtpzPc2U84kfm3L8OSTCsuAEAe4H/NAX1X9Ot1uRX4BAciU8c
         WLx7zikQDQkawO15TBPD2CtN+jqvU6K20CLdh9Aovc0gQ3ZNBUZQrSy/fZDBEPvU6i
         VcSOd5/i6vPh5WBLLxB/enHW1KGLKAbNlAizYoU6AAIHj1jFEUDntNo4R4hki+YlSt
         knB02pePOl8WupErdUrDBLkbqlofPY0D2ExjBBkDpbSGSM2wCdHANDjINUCL6s6XsH
         uuI3sBmnQdoBXPCQfqg13JIP7lIA6ddXJbAI6mRR/rnblqStOKXUowIn8dGcTI58pd
         +Iko1EtN74VVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519071610.423372-5-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org> <20220519071610.423372-5-wenst@chromium.org>
Subject: Re: [PATCH v3 4/5] clk: mediatek: Switch to clk_hw provider APIs
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
Date:   Thu, 19 May 2022 17:37:34 -0700
User-Agent: alot/0.10
Message-Id: <20220520003736.94F74C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-19 00:16:09)
> As part of the effort to improve the MediaTek clk drivers, the next step
> is to switch from the old 'struct clk' clk prodivder APIs to the new
> 'struct clk_hw' ones.
>=20
> In a previous patch, 'struct clk_onecell_data' was replaced with
> 'struct clk_hw_onecell_data', with (struct clk_hw *)->clk and
> __clk_get_hw() bridging the new data structures and old code.
>=20
> Now switch from the old 'clk_(un)?register*()' APIs to the new
> 'clk_hw_(un)?register*()' ones. This is done with the coccinelle script
> below.
>=20
> Unfortunately this also leaves clk-mt8173.c with a compile error that
> would need a coccinelle script longer than the actual diff to fix. This
> last part is fixed up by hand.
>=20
>     // Fix prototypes
>     @@
>     identifier F =3D~ "^mtk_clk_register_";
>     @@
>     - struct clk *
>     + struct clk_hw *
>       F(...);
>=20
>     // Fix calls to mtk_clk_register_<singular>
>     @ reg @
>     identifier F =3D~ "^mtk_clk_register_";
>     identifier FS =3D~ "^mtk_clk_register_[a-z_]*s";
>     identifier I;
>     expression clk_data;
>     expression E;
>     @@
>       FS(...) {
>             ...
>     -   struct clk *I;
>     +   struct clk_hw *hw;
>             ...
>             for (...;...;...) {
>                     ...
>     (
>     -           I
>     +           hw
>                     =3D
>     -           clk_register_fixed_rate(
>     +           clk_hw_register_fixed_rate(
>                                             ...
>                     );
>     |
>     -           I
>     +           hw
>                     =3D
>     -           clk_register_fixed_factor(
>     +           clk_hw_register_fixed_factor(
>                                             ...
>                     );
>     |
>     -           I
>     +           hw
>                     =3D
>     -           clk_register_divider(
>     +           clk_hw_register_divider(
>                                             ...
>                     );
>     |
>     -           I
>     +           hw
>                     =3D
>                     F(...);
>     )
>                     ...
>                     if (
>     -               IS_ERR(I)
>     +               IS_ERR(hw)
>                        ) {
>                             pr_err(...,
>     -                          I
>     +                          hw
>                             ,...);
>                             ...
>                     }
>=20
>     -           clk_data->hws[E] =3D __clk_get_hw(I);
>     +           clk_data->hws[E] =3D hw;
>             }
>             ...
>       }
>=20
>     @ depends on reg @
>     identifier reg.I;
>     @@
>       return PTR_ERR(
>     - I
>     + hw
>       );
>=20
>     // Fix mtk_clk_register_composite to return clk_hw instead of clk
>     @@
>     identifier I, R;
>     expression E;
>     @@
>     - struct clk *
>     + struct clk_hw *
>       mtk_clk_register_composite(...) {
>             ...
>     -   struct clk *I;
>     +   struct clk_hw *hw;
>             ...
>     -   I =3D clk_register_composite(
>     +   hw =3D clk_hw_register_composite(
>                     ...);
>             if (IS_ERR(
>     -              I
>     +              hw
>                        )) {
>                     ...
>                     R =3D PTR_ERR(
>     -                         I
>     +                         hw
>                                   );
>                     ...
>             }
>=20
>             return
>     -           I
>     +           hw
>             ;
>             ...
>       }
>=20
>     // Fix other mtk_clk_register_<singular> to return clk_hw instead of =
clk
>     @@
>     identifier F =3D~ "^mtk_clk_register_";
>     identifier I, D, C;
>     expression E;
>     @@
>     - struct clk *
>     + struct clk_hw *
>       F(...) {
>             ...
>     -   struct clk *I;
>     +   int ret;
>             ...
>     -   I =3D clk_register(D, E);
>     +   ret =3D clk_hw_register(D, E);
>             ...
>     (
>     -   if (IS_ERR(I))
>     +   if (ret) {
>                     kfree(C);
>     +           return ERR_PTR(ret);
>     +   }
>     |
>     -   if (IS_ERR(I))
>     +   if (ret)
>             {
>                     kfree(C);
>     -           return I;
>     +           return ERR_PTR(ret);
>             }
>     )
>=20
>     -   return I;
>     +   return E;
>       }
>=20
>     // Fix mtk_clk_unregister_<singular> to take clk_hw instead of clk
>     @@
>     identifier F =3D~ "^mtk_clk_unregister_";
>     identifier I, I2;
>     @@
>       static void F(
>     -   struct clk *I
>     +   struct clk_hw *I2
>       )
>       {
>             ...
>     -   struct clk_hw *I2;
>             ...
>     -   I2 =3D __clk_get_hw(I);
>             ...
>     (
>     -   clk_unregister(I);
>     +   clk_hw_unregister(I2);
>     |
>     -   clk_unregister_composite(I);
>     +   clk_hw_unregister_composite(I2);
>     )
>             ...
>       }
>=20
>     // Fix calls to mtk_clk_unregister_*()
>     @@
>     identifier F =3D~ "^mtk_clk_unregister_";
>     expression I;
>     expression E;
>     @@
>     - F(I->hws[E]->clk);
>     + F(I->hws[E]);
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
