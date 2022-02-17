Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2F4BAD43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiBQXmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:42:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBQXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:42:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA8403DE;
        Thu, 17 Feb 2022 15:41:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9133F618DB;
        Thu, 17 Feb 2022 23:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE517C340E8;
        Thu, 17 Feb 2022 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645140175;
        bh=NWO9XCOtwUQtF6tq1ZJYa4BZ/0zXbfe09y1GXCcdSqY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pmH7iPjYU2L5V0fqmszIt6z4bpsXPQYc+TfRlkpcPAK9gPc5iTPenrwdeNcZsgbq0
         79KOwvKQsUKXT8f6X93aX4ZoNGi58wc95k+riFdrmYM8Aiy4EEDvHvrp7pNB2hl+aS
         tzdMV9zjD7RRg35jyqs+T/10yLvQk6hTQGoxGO7QgrN3PWImApdV78fim6FdIfAEfn
         8ryxpie1pxGdPpOWTh47r7SPWbbccRyFkii4H00WwuUJ656BFxX/AhSl8/Bi0ZX/Ud
         ENUaXjjSDXxDhg3TB90rOQxv9/0PyufhJID4DDYfZlv0MUh+M763f7y43hkkBTawXS
         5wf1NDIkOdadA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220207185411.19118-3-bartosz.dudziak@snejp.pl>
References: <20220207185411.19118-1-bartosz.dudziak@snejp.pl> <20220207185411.19118-3-bartosz.dudziak@snejp.pl>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add MSM8226 Multimedia Clock Controller support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Thu, 17 Feb 2022 15:22:53 -0800
User-Agent: alot/0.10
Message-Id: <20220217232254.DE517C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Dudziak (2022-02-07 10:54:11)
> Modify the existing MSM8974 multimedia clock controller driver to
> support the MMCC found on MSM8226 based devices. This should allow most
> multimedia device drivers to probe and control their clocks.
>=20
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> ---
>  drivers/clk/qcom/mmcc-msm8974.c | 206 +++++++++++++++++++++++++++++++-
>  1 file changed, 201 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8=
974.c
> index a1552b6771..f74662925a 100644
> --- a/drivers/clk/qcom/mmcc-msm8974.c
> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> @@ -257,6 +257,18 @@ static struct clk_rcg2 mmss_ahb_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_mmss_axi_clk_msm8226[] =3D {

const?

> +       F(19200000, P_XO, 1, 0, 0),
> +       F(37500000, P_GPLL0, 16, 0, 0),
> +       F(50000000, P_GPLL0, 12, 0, 0),
> +       F(75000000, P_GPLL0, 8, 0, 0),
> +       F(100000000, P_GPLL0, 6, 0, 0),
> +       F(150000000, P_GPLL0, 4, 0, 0),
> +       F(200000000, P_MMPLL0, 4, 0, 0),
> +       F(266666666, P_MMPLL0, 3, 0, 0),
> +       { }
> +};
> +
>  static struct freq_tbl ftbl_mmss_axi_clk[] =3D {
>         F( 19200000, P_XO, 1, 0, 0),
>         F( 37500000, P_GPLL0, 16, 0, 0),
> @@ -364,6 +376,23 @@ static struct clk_rcg2 csi3_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_camss_vfe_vfe0_clk_msm8226[] =3D {

const?

> +       F(37500000, P_GPLL0, 16, 0, 0),
> +       F(50000000, P_GPLL0, 12, 0, 0),
> +       F(60000000, P_GPLL0, 10, 0, 0),
> +       F(80000000, P_GPLL0, 7.5, 0, 0),
> +       F(100000000, P_GPLL0, 6, 0, 0),
> +       F(109090000, P_GPLL0, 5.5, 0, 0),
> +       F(133330000, P_GPLL0, 4.5, 0, 0),
> +       F(150000000, P_GPLL0, 4, 0, 0),
> +       F(200000000, P_GPLL0, 3, 0, 0),
> +       F(228570000, P_MMPLL0, 3.5, 0, 0),
> +       F(266670000, P_MMPLL0, 3, 0, 0),
> +       F(320000000, P_MMPLL0, 2.5, 0, 0),
> +       F(400000000, P_MMPLL0, 2, 0, 0),
> +       { }
> +};
> +
>  static struct freq_tbl ftbl_camss_vfe_vfe0_1_clk[] =3D {
>         F(37500000, P_GPLL0, 16, 0, 0),
>         F(50000000, P_GPLL0, 12, 0, 0),
> @@ -407,6 +436,18 @@ static struct clk_rcg2 vfe1_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_mdss_mdp_clk_msm8226[] =3D {

const?

> +       F(37500000, P_GPLL0, 16, 0, 0),
> +       F(60000000, P_GPLL0, 10, 0, 0),
> +       F(75000000, P_GPLL0, 8, 0, 0),
> +       F(92310000, P_GPLL0, 6.5, 0, 0),
> +       F(100000000, P_GPLL0, 6, 0, 0),
> +       F(133330000, P_MMPLL0, 6, 0, 0),
> +       F(177780000, P_MMPLL0, 4.5, 0, 0),
> +       F(200000000, P_MMPLL0, 4, 0, 0),
> +       { }
> +};
> +
>  static struct freq_tbl ftbl_mdss_mdp_clk[] =3D {
>         F(37500000, P_GPLL0, 16, 0, 0),
>         F(60000000, P_GPLL0, 10, 0, 0),
> @@ -513,6 +554,14 @@ static struct clk_rcg2 pclk1_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_venus0_vcodec0_clk_msm8226[] =3D {

const?

> +       F(66700000, P_GPLL0, 9, 0, 0),
> +       F(100000000, P_GPLL0, 6, 0, 0),
> +       F(133330000, P_MMPLL0, 6, 0, 0),
> +       F(160000000, P_MMPLL0, 5, 0, 0),
> +       { }
> +};
> +
>  static struct freq_tbl ftbl_venus0_vcodec0_clk[] =3D {
>         F(50000000, P_GPLL0, 12, 0, 0),
>         F(100000000, P_GPLL0, 6, 0, 0),
> @@ -593,6 +642,13 @@ static struct clk_rcg2 camss_gp1_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_camss_mclk0_3_clk_msm8226[] =3D {

const?

> +       F(19200000, P_XO, 1, 0, 0),
> +       F(24000000, P_GPLL0, 5, 1, 5),
> +       F(66670000, P_GPLL0, 9, 0, 0),
> +       { }
> +};
> +
>  static struct freq_tbl ftbl_camss_mclk0_3_clk[] =3D {
>         F(4800000, P_XO, 4, 0, 0),
>         F(6000000, P_GPLL0, 10, 1, 10),
> @@ -705,6 +761,15 @@ static struct clk_rcg2 csi2phytimer_clk_src =3D {
>         },
>  };
> =20
> +static struct freq_tbl ftbl_camss_vfe_cpp_clk_msm8226[] =3D {

const?

> +       F(133330000, P_GPLL0, 4.5, 0, 0),
> +       F(150000000, P_GPLL0, 4, 0, 0),
> +       F(266670000, P_MMPLL0, 3, 0, 0),
> +       F(320000000, P_MMPLL0, 2.5, 0, 0),
> +       F(400000000, P_MMPLL0, 2, 0, 0),
> +       { }
> +};
> +
