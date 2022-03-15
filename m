Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6E4DA58E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbiCOWo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiCOWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002FFD12;
        Tue, 15 Mar 2022 15:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF8FB818FA;
        Tue, 15 Mar 2022 22:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB736C340E8;
        Tue, 15 Mar 2022 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384218;
        bh=QcYqmC9EtcqrxIXAjr3U5b4uFH7SGAQ/mzDiG0FRn88=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=pcS+qJ/NUP5uIYob7rCZmQgzM8idpH+biefZhodEeNpEP/LWGX2K469apAdR2FgbS
         qJ9hDDiNFRcwC86APpuFR+zx1kxCd5iENiMwd/GgWEBeRb1RJCE6gbmDmDCjyjB6pV
         daUsUvY8vjUNZKAAySKZT53TTJ7zDsQj6E664mfBKafOj76kbk7brY6qgJEbGyxXKh
         sEdVKDIecb5RCpi3tKi2NsAwzKx+I9I9Jb0nmKsz/f37xeOo1ywlF6wMPBQVUpDtc+
         QpWlCwYk+xSSKNSl0d2U43Ooq3two8n3HYOBP53AooJ3NTMgY/OqZ/9s/aCm0wqoOV
         6BOTd9z19URkA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220313190419.2207-8-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-8-ansuelsmth@gmail.com>
Subject: Re: [PATCH 07/16] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Date:   Tue, 15 Mar 2022 15:43:36 -0700
User-Agent: alot/0.10
Message-Id: <20220315224338.BB736C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-13 12:04:10)
> Check if hw_parent is present before calculating the round_rate to
> prevent kernel panic.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/clk-krait.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index e447fcc3806d..d8af281eba0e 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -80,7 +80,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
>  static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
>                                   unsigned long *parent_rate)
>  {
> -       *parent_rate =3D clk_hw_round_rate(clk_hw_get_parent(hw), rate * =
2);
> +       struct clk_hw *hw_parent =3D clk_hw_get_parent(hw);
> +
> +       if (!hw_parent)
> +               return -1;

Use -EINVAL or some proper error code, not just -1

> +
> +       *parent_rate =3D clk_hw_round_rate(hw_parent, rate * 2);
>         return DIV_ROUND_UP(*parent_rate, 2);
>  }
> =20
> --=20
> 2.34.1
>
