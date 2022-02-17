Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275554BACD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbiBQWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:43:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbiBQWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:43:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DF6E350;
        Thu, 17 Feb 2022 14:43:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668EA61838;
        Thu, 17 Feb 2022 22:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED00C340E8;
        Thu, 17 Feb 2022 22:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137779;
        bh=X01ZrUQvcSGn5HLOXD0ZzNYdg8VRmead+loYpD878OQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AAuYueGKZ5PXOWzuxo39QuXwIgCJKCkJTUKT87naKNzvsei9AkZMizuNFYuBBmj/2
         5fZe+8P06aDAJYtVah+zln39z43E7Na2YqdUdZZMa1Gq8Gan9zScG1ycs9GCPwMR0e
         sy4QccPhp7aMi097Xpo0rODECcqC85ZxtDEuaMBvpqjg2QNBmdlxE+lx3LOpcjRrpu
         ZqHpBZBAekYflLgGQKhBO+CCHcsTgfCEdidcj+DCp0QBKVKGheh1l3yisuzorVc8Br
         f9VI8+63yuLub+fUCDwktQuLRjlVOKmnqK6KZ5frFmJKdjSC/O3oW6rD0Xemj76pCb
         T+6CaNvVgdWrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126081236.25255-3-tdas@codeaurora.org>
References: <20220126081236.25255-1-tdas@codeaurora.org> <20220126081236.25255-3-tdas@codeaurora.org>
Subject: Re: [PATCH v4 2/2] clk: qcom: lpass: Add support for LPASS clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 14:42:58 -0800
User-Agent: alot/0.10
Message-Id: <20220217224259.AED00C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-26 00:12:36)
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lp=
assaudiocc-sc7280.c
> new file mode 100644
> index 000000000000..c97ead75f02a
> --- /dev/null
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -0,0 +1,838 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[...]
> +
> +static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_cc_desc *desc;
> +       struct regmap *regmap;
> +       int ret;
> +
> +       ret =3D lpassaudio_create_pm_clks(pdev);
> +       if (ret)
> +               return ret;
> +
> +       lpass_audio_cc_sc7280_regmap_config.name =3D "lpassaudio_cc";
> +       lpass_audio_cc_sc7280_regmap_config.max_register =3D 0x2f000;
> +       desc =3D &lpass_audio_cc_sc7280_desc;
> +
> +       regmap =3D qcom_cc_map(pdev, desc);
> +       if (IS_ERR(regmap)) {
> +               pm_runtime_disable(&pdev->dev);
> +               return PTR_ERR(regmap);
> +       }
> +
> +       clk_zonda_pll_configure(&lpass_audio_cc_pll, regmap, &lpass_audio=
_cc_pll_config);
> +
> +       ret =3D qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, r=
egmap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC cl=
ocks\n");
> +               pm_runtime_disable(&pdev->dev);
> +               return ret;
> +       }
> +
> +       /* PLL settings */
> +       regmap_write(regmap, 0x4, 0x3b);
> +       regmap_write(regmap, 0x8, 0xff05);

Shouldn't this be done before registering the clks? So after
zonda_pll_configure?

> +
> +       pm_runtime_mark_last_busy(&pdev->dev);
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +       pm_runtime_put_sync(&pdev->dev);
