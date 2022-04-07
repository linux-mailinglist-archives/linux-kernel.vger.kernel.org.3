Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E34F73FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiDGDgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDGDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:36:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F69229CA6;
        Wed,  6 Apr 2022 20:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D66B8269A;
        Thu,  7 Apr 2022 03:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC889C385A1;
        Thu,  7 Apr 2022 03:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649302449;
        bh=CzpCh+DZuA4tm7ZwIdm62bJnfKCjs5B1CyTpOTHCkLo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hZSIYtqgBssFY8OJg0G93whVvaL7mppBNXCidYafwXTIns3GAriHoGIS8jL1wMvFU
         8qIhlBB5hgfFxzLtAM46Z5lGE5eaZNzINj51Lm5c35zApxE4H9ZGW4YxmsiFDegR/q
         cI5g9L8xxwjwjMVYFe/Tfv6fCxL246luicP4eXBAqT2tMnltZ1WS7Gm2vD0GCo1/SO
         V5uvaLY9DeCQByvljwYdZ4zOVsIcuwrjGmcn3mKSrNBNMKT0h9jELouVkTukO3EPwc
         42Tqt3rLrC8XpcH5zkG18qkYPGyouhqocCIs4+e1EO/3ZpCS0DYqzfjrhcVkP60u6U
         5xibJFeihjwLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_C0622B5C4209E83F1C6495D926979F239D05@qq.com>
References: <tencent_C0622B5C4209E83F1C6495D926979F239D05@qq.com>
Subject: Re: [PATCH] clk: pxa: add a check for the return value of kzalloc()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
To:     mturquette@baylibre.com, xkernel.wang@foxmail.com
Date:   Wed, 06 Apr 2022 20:34:07 -0700
User-Agent: alot/0.10
Message-Id: <20220407033409.DC889C385A1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting xkernel.wang@foxmail.com (2022-03-25 03:27:20)
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>=20
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/clk/pxa/clk-pxa.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
> index cfc79f9..d0df104 100644
> --- a/drivers/clk/pxa/clk-pxa.c
> +++ b/drivers/clk/pxa/clk-pxa.c
> @@ -102,6 +102,8 @@ int __init clk_pxa_cken_init(const struct desc_clk_ck=
en *clks, int nb_clks)
> =20
>         for (i =3D 0; i < nb_clks; i++) {
>                 pxa_clk =3D kzalloc(sizeof(*pxa_clk), GFP_KERNEL);
> +               if (!pxa_clk)
> +                       continue;

Shouldn't we stop trying to allocate more and return an error?
