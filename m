Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E845A705E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiH3WGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH3WGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53526A48E;
        Tue, 30 Aug 2022 15:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A141560ED9;
        Tue, 30 Aug 2022 22:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07440C433B5;
        Tue, 30 Aug 2022 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661897187;
        bh=VVaAyTdAfsCPJoUa2MTvj/q7KQPHl/s8HHj/gCUuUo4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LTn4IbBMxJEp6Q7V3tyca8rMfjQhb+1sZ9XVw4Heq6M3hFxTPF2Jf8VJuW4BLujGq
         6EnCmAkoYl7oKR4cZWzhieamjP0PFdXe8u+KuZjqkrMvdi5Ecql9GbbuRY0EwHww3k
         DsW9peqa5b389Czrd08ZNAcSQ5nhxrgOHVzmkeW75iG9iDTUQFVxLmofwIV3KzWZm1
         Zww9BFNfLcHwpmy8GlKA0OHCxOwIQicey0IzaNGYyadxq2WJGt1JeuAoHYvHRfdMyh
         udIxGuajZrdmm6eX2SJDIUz2fj8NhU0VdcQvIIwKAo7GpfFpOcEct730Am3TDKdtHX
         A/8PrIm1/0vUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220826142030.213805-1-quanyang.wang@windriver.com>
References: <20220826142030.213805-1-quanyang.wang@windriver.com>
Subject: Re: [PATCH] clk: zynqmp: pll: rectify rate rounding in zynqmp_pll_round_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com
Date:   Tue, 30 Aug 2022 15:06:25 -0700
User-Agent: alot/0.10
Message-Id: <20220830220627.07440C433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quanyang.wang@windriver.com (2022-08-26 07:20:30)
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> The function zynqmp_pll_round_rate is used to find a most appropriate
> PLL frequency which the hardware can generate according to the desired
> frequency. For example, if the desired frequency is 297MHz, considering
> the limited range from PS_PLL_VCO_MIN (1.5GHz) to PS_PLL_VCO_MAX (3.0GHz)
> of PLL, zynqmp_pll_round_rate should return 1.872GHz (297MHz * 5).
>=20
> There are two problems with the current code of zynqmp_pll_round_rate:
>=20
> 1) When the rate is below PS_PLL_VCO_MIN, it can't find a correct rate
> when the parameter "rate" is an integer multiple of *prate, in other word=
s,
> if "f" is zero, zynqmp_pll_round_rate won't return a valid frequency which
> is from PS_PLL_VCO_MIN to PS_PLL_VCO_MAX. For example, *prate is 33MHz
> and the rate is 660MHz, zynqmp_pll_round_rate will not boost up rate and
> just return 660MHz, and this will cause clk_calc_new_rates failure since
> zynqmp_pll_round_rate returns an invalid rate out of its boundaries.
>=20
> 2) Even if the rate is higher than PS_PLL_VCO_MIN, there is still a risk
> that zynqmp_pll_round_rate returns an invalid rate because the function
> DIV_ROUND_CLOSEST makes some loss in the fractional part. If the parent
> clock *prate is 33333333Hz and we want to set the PLL rate to 1.5GHz,
> this function will return 1499999985Hz by using the formula below:
>     value =3D *prate * DIV_ROUND_CLOSEST(rate, *prate)).
> This value is also invalid since it's slightly smaller than PS_PLL_VCO_MI=
N.
> because DIV_ROUND_CLOSEST makes some loss in the fractional part.
>=20
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---

Applied to clk-next
