Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41FE50EC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiDYWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiDYWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF72104F2C;
        Mon, 25 Apr 2022 15:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A46061553;
        Mon, 25 Apr 2022 22:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE973C385A4;
        Mon, 25 Apr 2022 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650926066;
        bh=kcoJOwxO7li9dg8WiipeoY/VN7Fr/qwxU1nP5uosILM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pOb/CjVMTnNj5CtyEGmtzZu4ukywwssAoRr6dCrvih/QV+LtwArQKq3zBai0RCpQ4
         /e5snSqYfUO+LCP1azsjP8yTgLm1KgrZPQCoHbUX/GPDl88MabLpNDuu016aDz3j8l
         jsvhHMCCl56daLBIP1YKtTS59MZrERDn1wvWvJAaBXQnHR79+wivFJwMOoxlLjiNK6
         b8xjvbKWsIeWJCGJjRf4RlhrZCtpC7JYTI1f4yPh/4YZMt9mLWQsE9k/B0WAdbmrsV
         MJ0K/zgfEMII79g+Z/8NPeXb+FKfpp8nqSzaD1wtCe8JUfwsus48jgftn1o5etP/gG
         WVQGk/hEli9aQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YmN11qt/PqogYruQ@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org> <20220423014824.912ACC385A0@smtp.kernel.org> <YmNsYSxLtwLpw98t@ripper> <20220423031350.01299C385A0@smtp.kernel.org> <YmN11qt/PqogYruQ@ripper>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 25 Apr 2022 15:34:24 -0700
User-Agent: alot/0.10
Message-Id: <20220425223426.BE973C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-22 20:43:18)
> On Fri 22 Apr 20:13 PDT 2022, Stephen Boyd wrote:
> >=20
> > I'd really rather not have clock-names at all because we spend a bunch
> > of time comparing strings with them when we could just as easily use
> > a number.
>=20
> I know that you would like to get rid of the clock-names for the clock
> controllers. I've looked at it since and while it will be faster to
> execute I still feel that it's going to be harder to write and maintain.
>=20
> E.g. look at gcc_pcie_4_pipe_clk_src, its parents today are
> pcie_4_pipe_clk and bi_tcxo. Something I can reason about being correct
> or not.
>=20
> If we ditch the clock-names I will have:
>=20
> static const struct clk_parent_data gcc_parent_data_14[] =3D {
>         { .index =3D 30 },
>         { .index =3D 0 },

Those numbers could have some #define.

	{ .index =3D PCIE_4_PIPE_CLK_DT }
	{ .index =3D BI_TCXO_DT }

> };
>=20
> Generally we would perhaps use some compile time constant, but that
> won't work here because we're talking about the index in the clocks
> array in the yaml.
>=20
>=20
> But perhaps I'm missing something that would make this manageable?

I dunno. Maybe a macro in the dt-binding header could be used to specify
the 'clocks' property of the DT node that is providing the other side?
The idea is to make a bunch of macros that insert the arguments of the
macro in the right place for the clocks property and then define the
order of arguments otherwise. It would be similar to how
CREATE_TRACE_POINTS is used in include/trace/define_trace.h=20

In the dt-bindings/qcom,gcc-soc.h file:

	#ifdef IN_DTSI

	#undef GCC_DT_NODE_CLOCKS
	#define GCC_DT_NODE_CLOCKS
		clocks =3D <BI_TCXO_DT>,
			 <SLEEP_CLK_DT>;

	#endif /* IN_DTSI */

	#define BI_TCXO_DT 0
	#define SLEEP_CLK_DT 1


And then in the SoC.dtsi file have

	#define IN_DTSI
	#include <dt-bindings/qcom,gcc-soc.h>

	#define BI_TCXO_DT	&xo_board
	#define SLEEP_CLK_DT	&sleep_clk

	...

	clock-controller@a000000 {
		compatible =3D "qcom,gcc-soc";
		reg =3D <0xa000000 0x10000>;
		GCC_DT_NODE_CLOCKS
	};


and then in drivers/clk/qcom/gcc-soc.c file:

	#include <dt-bindings/qcom,gcc-soc.h>

	static const struct clk_parent_data gcc_parent_data_14[] =3D {
		{ .index =3D PCIE_4_PIPE_CLK_DT },
		{ .index =3D BI_TCXO_DT },
	};

The benefit I see to this is that the index for each clock is in the
header file (BI_TCXO_DT is 0) and it's next to the clocks property.
Someone could still mess up the index based on where the macro is used
in the clocks property though.
