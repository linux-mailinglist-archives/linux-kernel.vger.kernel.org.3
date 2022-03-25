Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0884E6BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357137AbiCYBKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbiCYBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682345ADD;
        Thu, 24 Mar 2022 18:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2247C6186A;
        Fri, 25 Mar 2022 01:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77277C340ED;
        Fri, 25 Mar 2022 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648170550;
        bh=5ly/TWLlvs8wkSgCbJLfBRzJN6ldBdF8OZK18Ogzrw4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=PefXn2AUb364Kxbqqbd+tqrw78TUkvLX8i96UIyO/KpB31Uvi/BwBtOGQpGDjBCMz
         AVH4nrA8RcqIn2o1Bm15XlHHYkJ+Hz75q4cklmSMR0oalnlAusovfjmaLAggqtoIvJ
         65sQ7hW5neXHsOxms+O/JVMlLEgh2PT8L++czXjX2i4PAajtV4S6l0qmJgbozukLmS
         5JYKlHRfleVDegQKRr4TPjb5h4Im6yQqnfCLzkDH/tmR7Hlcn/t6jYJ02VkUbFdtd6
         UIRqHoLyMcLdV0AMJO1KoOuaZitmhi7ZWBKgy5Mvam1qbOIioH/xldfsinKquwoblx
         Mk/8jsZRyX2pA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-5-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-5-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 04/18] clk: qcom: clk-hfpll: use poll_timeout macro
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:09:08 -0700
User-Agent: alot/0.10
Message-Id: <20220325010910.77277C340ED@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:34)
> Use regmap_read_poll_timeout macro instead of do-while structure.

Please add a note that this isn't an equivalent translation. Now we
timeout if the PLL fails to lock whereas before we would loop
potentially forever.

> diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
> index e847d586a73a..a4e347eb4d4d 100644
> --- a/drivers/clk/qcom/clk-hfpll.c
> +++ b/drivers/clk/qcom/clk-hfpll.c
> @@ -12,6 +12,8 @@
>  #include "clk-regmap.h"
>  #include "clk-hfpll.h"
> =20
> +#define HFPLL_BUSY_WAIT_TIMEOUT        100

We don't really need a define for this.

> +
>  #define PLL_OUTCTRL    BIT(0)
>  #define PLL_BYPASSNL   BIT(1)
>  #define PLL_RESET_N    BIT(2)
> @@ -72,13 +74,12 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
>         regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N=
);
> =20
>         /* Wait for PLL to lock. */
> -       if (hd->status_reg) {
> -               do {
> -                       regmap_read(regmap, hd->status_reg, &val);
> -               } while (!(val & BIT(hd->lock_bit)));
> -       } else {
> +       if (hd->status_reg)
> +               regmap_read_poll_timeout(regmap, hd->status_reg, val,
> +                                        !(val & BIT(hd->lock_bit)), USEC=
_PER_MSEC * 2,

Why are we waiting between reads?

> +                                        HFPLL_BUSY_WAIT_TIMEOUT * USEC_P=
ER_MSEC);
> +       else
>                 udelay(60);
> -       }
>
