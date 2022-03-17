Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFBF4DCEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiCQTji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiCQTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F21EAC8B;
        Thu, 17 Mar 2022 12:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7870618B3;
        Thu, 17 Mar 2022 19:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BC1C340E9;
        Thu, 17 Mar 2022 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647545895;
        bh=YDBqqtsD8hurDcBaCOcL4NXPfM8to2wSvDT1JakwR+U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QHOjltqeHi+HQG2Xky3LWk1zqqafGF3WxgeGSm8rT3vPU0OrIVtLl3wS6uocN6bUc
         Iz9caqzXOHhc9wy/pqpGQWLiUT7tEAYL04H3Off9vCiP7LW2TXslbbnrF9M9FlQCV8
         attIKQFFR35qHc16JPmEtjl44Q5Ff7maf96V5okDuWAb49J7rdiDeNzTYTncKzvF6Z
         T1iQSTqsCDlTlep0XNjgklbMVXIHWtcGfmRnX1G3rClnGTe5a/M2H3sdA+adcK70ew
         XDm0JwOvUwJoPhdpLYxbPEH2ppUF0xVoM3GXRKcaZKCN77N1oT1TWg0Zam3UXU1/mi
         F6m00k3fi+c+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220228124112.3974242-2-peng.fan@oss.nxp.com>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com> <20220228124112.3974242-2-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 17 Mar 2022 12:38:13 -0700
User-Agent: alot/0.10
Message-Id: <20220317193815.47BC1C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-28 04:41:12)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> If mcore_booted is true, ignore the clk root gate registration and
> this will simplify AMP clock management and avoid system hang unexpectly
> especially Linux shutdown clk used by mcore.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  None
>=20
>  drivers/clk/imx/clk-composite-8m.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> index 2dfd6149e528..b16c2c0ea9f6 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -223,14 +223,19 @@ struct clk_hw *__imx8m_clk_hw_composite(const char =
*name,
>         div->lock =3D &imx_ccm_lock;
>         div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> =20
> -       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> -       if (!gate)
> -               goto fail;
> -
> -       gate_hw =3D &gate->hw;
> -       gate->reg =3D reg;
> -       gate->bit_idx =3D PCG_CGC_SHIFT;
> -       gate->lock =3D &imx_ccm_lock;
> +       /* skip registering the gate ops if M4 is enabled */
> +       if (mcore_booted) {
> +               gate_hw =3D NULL;

It could even use the protected-clocks property and then parse it to
figure out to not register this gate?

> +       } else {
> +               gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +               if (!gate)
> +                       goto fail;
> +
> +               gate_hw =3D &gate->hw;
> +               gate->reg =3D reg;
> +               gate->bit_idx =3D PCG_CGC_SHIFT;
> +               gate->lock =3D &imx_ccm_lock;
> +       }
