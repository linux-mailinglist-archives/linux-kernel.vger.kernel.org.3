Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7251650C643
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiDWB4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWB4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:56:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A318E4B;
        Fri, 22 Apr 2022 18:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCE54B83240;
        Sat, 23 Apr 2022 01:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6558BC385A0;
        Sat, 23 Apr 2022 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650678834;
        bh=ebt/+pYOKnE58SDIUycCnkf6NKohTZ1uBIKku+9SzJk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B0+BnFaCe7LZwAulDY/wiY16VxCNnDc+ZPewt5nh5+cttZCxC4UUop9VKFaR6iW5g
         Q9chqlVr9CscKelfl5wPi7ZB/vKMUgQMB8RhA/RZZM71UlJ6MHMfQVQY9ziht2BMjA
         lHsjnySFwPRpLpODCXMeJztF9/9n9RW5OkPThSlfasjTvFJ6wXyRPdk4+t+ehFLqkl
         vrP+ceGMwoe9C87cQ5GrNUxastRAlFKWnOugOdThyF8GRSR8vdd2cY4SpnCLOxmS9n
         QdX2Je50IfO0eUOkoLiF8MBHecsl30s8d8JRW1n/RUEYKs85rGyIMAroNfjacsLOD1
         hZtQTBGLaBdDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220422230013.1332993-2-bjorn.andersson@linaro.org>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org> <20220422230013.1332993-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: add sc8280xp GCC driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Apr 2022 18:53:52 -0700
User-Agent: alot/0.10
Message-Id: <20220423015354.6558BC385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-22 16:00:13)
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc828=
0xp.c
> new file mode 100644
> index 000000000000..16bfe62efca2
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -0,0 +1,7451 @@
[...]
> +static struct clk_branch gcc_video_vcodec_throttle_clk =3D {
> +       .halt_reg =3D 0x28020,
> +       .halt_check =3D BRANCH_HALT_SKIP,
> +       .hwcg_reg =3D 0x28020,
> +       .hwcg_bit =3D 1,
> +       .clkr =3D {
> +               .enable_reg =3D 0x28020,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

The clk_init_data can be const too, right?

> +                       .name =3D "gcc_video_vcodec_throttle_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
