Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C224E6BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357108AbiCYBGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiCYBGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77058B6E41;
        Thu, 24 Mar 2022 18:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 117FF61831;
        Fri, 25 Mar 2022 01:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE19C340ED;
        Fri, 25 Mar 2022 01:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648170283;
        bh=x3Grx/gHZ954qA2Qc4dJR2/P8JyOJ/CJ1ZMyfIhoGcY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=hH5P4crGfpzOPbGDETLAwfczWbuP+dSIx3ZI8HprjDY6uCcaTCzikvYWQ5Mr/2wSf
         XFMwsUqMxiVRaR+ud6sK74TzwH6rlxf+DwImP0Np/QZgabLu+L562RVcxcopCaA8ZR
         EZPUQ/OjVG5W9I9FwY5ZyfHyCKuNELSN8RI5IAber1Op6sR7IKqdN3DX9nPfUjt1fK
         F6LuVL9hQPsVlrGUONf+sdKkedVt2X7TmR40nxk41I3ucbk5RmaNVkGXujdRmd8Fx9
         syHax3kwyi5aVLsiohj4lJk/ifIsEfdgWCIob74bLB9b4fzTCE2k0PSO7I4CpQt1N6
         8jJXFtoP66G6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-7-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-7-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 06/18] clk: qcom: clk-krait: unlock spin after mux completion
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:04:41 -0700
User-Agent: alot/0.10
Message-Id: <20220325010443.6AE19C340ED@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:36)
> Unlock spinlock after the mux switch is completed to prevent any corner
> case of mux request while the switch still needs to be done.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Please add a Fixes tag.

>  drivers/clk/qcom/clk-krait.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index 59f1af415b58..e447fcc3806d 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -32,11 +32,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk =
*mux, int sel)
>                 regval |=3D (sel & mux->mask) << (mux->shift + LPL_SHIFT);
>         }
>         krait_set_l2_indirect_reg(mux->offset, regval);
> -       spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
> =20
>         /* Wait for switch to complete. */
>         mb();
>         udelay(1);
> +

Please add a comment here indicating we want to make sure the mux
register isn't modified while switching to the new parent.

> +       spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
>  }
>
