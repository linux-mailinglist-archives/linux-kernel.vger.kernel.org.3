Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77E4E6BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357131AbiCYBIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357123AbiCYBI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514CBBE2D;
        Thu, 24 Mar 2022 18:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A7E8B82708;
        Fri, 25 Mar 2022 01:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A90C340EC;
        Fri, 25 Mar 2022 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648170412;
        bh=AIPvWxPwW8hERZp8DHR9OAv1OYMebm+vPl1GARoNXYU=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=NXX5hAcq1R6W+CQW3rr/pRXT6zhusl2ZlDvhBCaNGk85FaetY3clu26Rff7fZbJJO
         NDQnYFRms6ANlMakjIoN0BfhQP5xkTuzKiCrV3gwH9IX5MAkei6m5PP3BjBUVOfh0O
         Midgsr7tSVjBg8ZGEc6nLYyXj8QhDk6XKcsCV/aLOunmhXw91Lc4tMJf8M1gh3eZPb
         JbRdw91M0xpi5XeT8oevGN36Bu3d6RR5gY4rrZJQ3FiGCu10Dh3RnwZ6fJ7z1tE9ES
         G7iItlq8rQKPuJfnmxPejlxwPCdlpkdLC1GlXHEOZQJKLIFzsO5gzjbSDPZg1FYLty
         8gO8cZKG2ivCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-6-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-6-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 05/18] clk: qcom: kpss-xcc: convert to parent data API
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:06:50 -0700
User-Agent: alot/0.10
Message-Id: <20220325010652.B1A90C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:35)
> Convert the driver to parent data API. From the Documentation pll8_vote
> and pxo should be declared in the DTS so fw_name can be used instead of
> parent_names. Name is still used to save regression on old definition.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/kpss-xcc.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
> index 4fec1f9142b8..347f70e9f5fe 100644
> --- a/drivers/clk/qcom/kpss-xcc.c
> +++ b/drivers/clk/qcom/kpss-xcc.c
> @@ -12,9 +12,9 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> =20
> -static const char *aux_parents[] =3D {
> -       "pll8_vote",
> -       "pxo",
> +static const struct clk_parent_data aux_parents[] =3D {
> +       { .name =3D "pll8_vote", .fw_name =3D "pll8_vote" },
> +       { .name =3D "pxo", .fw_name =3D "pxo" },
>  };
> =20
>  static unsigned int aux_parent_map[] =3D {
> @@ -32,8 +32,8 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
>  static int kpss_xcc_driver_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *id;
> -       struct clk *clk;
>         void __iomem *base;
> +       struct clk_hw *hw;
>         const char *name;
> =20
>         id =3D of_match_device(kpss_xcc_match_table, &pdev->dev);
> @@ -55,24 +55,15 @@ static int kpss_xcc_driver_probe(struct platform_devi=
ce *pdev)
>                 base +=3D 0x28;
>         }
> =20
> -       clk =3D clk_register_mux_table(&pdev->dev, name, aux_parents,
> -                                    ARRAY_SIZE(aux_parents), 0, base, 0,=
 0x3,
> -                                    0, aux_parent_map, NULL);
> +       hw =3D __devm_clk_hw_register_mux(&pdev->dev, NULL, name, ARRAY_S=
IZE(aux_parents),

Does something in devm_clk_hw_register_mux() not work here? Do we need a
devm_clk_hw_register_mux_parent_data()? If so, please add it.

> +                                       NULL, NULL, aux_parents, 0, base,=
 0, 0x3,
> +                                       0, aux_parent_map, NULL);
>
