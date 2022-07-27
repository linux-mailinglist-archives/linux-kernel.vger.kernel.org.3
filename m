Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD3581D29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiG0BcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiG0BcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F153AE6D;
        Tue, 26 Jul 2022 18:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA1FB81E95;
        Wed, 27 Jul 2022 01:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E37C433C1;
        Wed, 27 Jul 2022 01:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658885520;
        bh=o1NQvuXzG8ktWr5jgPGsklVP/nB8lxfxcmIWl8DSjzs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qyNBjpJ+Z2JAPLVaON/ljzxNlcEgLG5S3D7ByKWRutp5rXQgzN8m560l+Puy+8aTs
         /dmm2S5VOEpomwIM4K8D0yOhCDR4iwICZ61YKVNXpGZDxXKvNL+5G3Gt3Hneyg+bAP
         owRHZZ5tYKzSae847Bj/XdBlMsJkKflpym8dgD4bYfQQ71hJXI6ozcZomNDnUqg68J
         PkHDB912T/Vun8CzJkRA7hXeA5ryW+JzopnInx0Qpahu1Jhfh7dH/EyDu21O8vubfn
         n+ZRrW6k4oT3z0y08kDTPvK3B7yu0r6EGjEB17ZRi1IjB+qi7l5qCslz9R0Nopgtfp
         SZjQsz/E30mKQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1658315023-3336-6-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com> <1658315023-3336-6-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 5/5] clk: qcom: lpass: Add support for resets & external mclk for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        quic_tdas@quicinc.com, quic_c_skakit@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Date:   Tue, 26 Jul 2022 18:31:58 -0700
User-Agent: alot/0.10
Message-Id: <20220727013200.90E37C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:03:43)
> From: Taniya Das <quic_tdas@quicinc.com>
>=20
> The clock gating control for TX/RX/WSA core bus clocks would be required
> to be reset(moved from hardware control) from audio core driver. Thus
> add the support for the reset clocks.
>=20
> Also add the external mclk to interface external MI2S.
>=20
> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock contr=
oller for SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 22 +++++++++++++++++++++-
>  drivers/clk/qcom/lpasscorecc-sc7280.c  | 33 ++++++++++++++++++++++++++++=
+++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lp=
assaudiocc-sc7280.c
> index 6067328..063e036 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -23,6 +23,7 @@
>  #include "clk-regmap-mux.h"
>  #include "common.h"
>  #include "gdsc.h"
> +#include "reset.h"
> =20
>  enum {
>         P_BI_TCXO,
> @@ -248,7 +249,7 @@ static struct clk_rcg2 lpass_aon_cc_main_rcg_clk_src =
=3D {
>                 .parent_data =3D lpass_aon_cc_parent_data_0,
>                 .num_parents =3D ARRAY_SIZE(lpass_aon_cc_parent_data_0),
>                 .flags =3D CLK_OPS_PARENT_ENABLE,
> -               .ops =3D &clk_rcg2_ops,
> +               .ops =3D &clk_rcg2_shared_ops,

This diff isn't mentioned in the commit text at all. Is it intentional?
If so, please mention why it needs to change.
