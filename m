Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E49545703
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiFIWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiFIWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:14:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F55160874;
        Thu,  9 Jun 2022 15:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3815CB83099;
        Thu,  9 Jun 2022 22:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8990C34114;
        Thu,  9 Jun 2022 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654812873;
        bh=H+jLa2rwFapf2Ofk7AqrjLvwyTI2J1EztZNbf9m0syw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lEkzbE74y9VKqlOW0aCd+63moxuAPWhVC79dtjZKcpDjP2CRWzAAn1OkGvueerRvC
         uKlPdp3ZxGJvAawBGHgNz662O022+tnX3ZLy1mx59fK/rwUkh9iDvjDUZLklKVXsrN
         DiQ4w4Bb/F4Xo97a/Vx7bWD8fQ4LJlqO14LgGrw1qnv4QF/YdnTk72CyZj2mnsxxf2
         EtfozD9ebbjzLFpM4ySgwRi5zvaCkdec6M/6KuRO16wR3JBPZKCE+SApPXydGqnTSC
         AC6wSbgTqzA+2amQpeJy45P4jzzzHFCJQHj0VzugzGD23C+85wURnohiar8RROZIkN
         d5f4f7R5rpLVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608095623.22327-8-tmaimon77@gmail.com>
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-8-tmaimon77@gmail.com>
Subject: Re: [PATCH v2 07/20] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, arnd@arndb.de,
        avifishman70@gmail.com, benjaminfair@google.com,
        biju.das.jz@bp.renesas.com, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        j.neuschaefer@gmx.net, jirislaby@kernel.org, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        lkundrak@v3.sk, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        olof@lixom.net, p.zabel@pengutronix.de, robert.hancock@calian.com,
        robh+dt@kernel.org, shawnguo@kernel.org, tali.perry1@gmail.com,
        tglx@linutronix.de, venture@google.com, vkoul@kernel.org,
        will@kernel.org, wim@linux-watchdog.org, yuenn@google.com
Date:   Thu, 09 Jun 2022 15:14:31 -0700
User-Agent: alot/0.10
Message-Id: <20220609221433.B8990C34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-06-08 02:56:10)
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..40340c3611b5
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,756 @@
[...]
> +
> +#define PLLCON_LOKI    BIT(31)
> +#define PLLCON_LOKS    BIT(30)
> +#define PLLCON_FBDV    GENMASK(27, 16)
> +#define PLLCON_OTDV2   GENMASK(15, 13)
> +#define PLLCON_PWDEN   BIT(12)
> +#define PLLCON_OTDV1   GENMASK(10, 8)
> +#define PLLCON_INDV    GENMASK(5, 0)
> +
> +static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rat=
e)
> +{
> +       struct npcm8xx_clk_pll *pll =3D to_npcm8xx_clk_pll(hw);
> +       unsigned long fbdv, indv, otdv1, otdv2;
> +       unsigned int val;
> +       u64 ret;
> +
> +       if (parent_rate =3D=3D 0) {
> +               pr_debug("%s: parent rate is zero", __func__);

Missing newline.

> +               return 0;
> +       }
> +
> +       val =3D readl_relaxed(pll->pllcon);
> +
> +       indv =3D FIELD_GET(PLLCON_INDV, val);
