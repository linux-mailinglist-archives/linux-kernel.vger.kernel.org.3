Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF2466E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhLCAXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhLCAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:23:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4363C06174A;
        Thu,  2 Dec 2021 16:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A9D628FD;
        Fri,  3 Dec 2021 00:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8225CC00446;
        Fri,  3 Dec 2021 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638490810;
        bh=J20VugyS8+xAyKyciGR/dXez8GCICzVybNNhP8zJTIk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WXT14ki6rlIQo+I/iv4nC5TdTnI4fRMByxYB38Tv6iNujWLqLqWOIfpL7K/jVL562
         OXE8i+bTbE0mhv6wqilKMUPQrK2EWHgsOKluobWW6mTbsWcteNDtz+QCfXBVx24iaM
         yshoJ6b+fZESf2Fdd7jIE3BFHVDQx1/+/T9rzbdcY+dR7zyENNaJNI+cZSRyzJOuwp
         lIx5nw5Rp6mwJtYMLq/2z/kdbQ2x0LtPolnLsLhXEb8X6ogPezqOV5pwxdYOu/OGVm
         nFHSOhJT/vbLmmQMQJoV+hSZ+xcBJv+BXTzOpHWpek4kq0eRib7PBdfi8UsuYYyYGf
         nOdUxYKfenyCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <475a055e403762e54a1cae6c2c97d4ada6064607.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com> <475a055e403762e54a1cae6c2c97d4ada6064607.1638402361.git.quic_vamslank@quicinc.com>
Subject: Re: [PATCH v6 3/5] clk: qcom: Add SDX65 GCC support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, maz@kernel.org,
        mturquette@baylibre.com, quic_vamslank@quicinc.com,
        robh+dt@kernel.org, tglx@linutronix.de
Date:   Thu, 02 Dec 2021 16:20:09 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203002010.8225CC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quic_vamslank@quicinc.com (2021-12-01 16:21:33)
> +static struct clk_branch gcc_gp3_clk =3D {
> +       .halt_reg =3D 0x39000,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x39000,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_gp3_clk",
> +                       .parent_data =3D &(const struct clk_parent_data){
> +                               .hw =3D &gcc_gp3_clk_src.clkr.hw,
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_pcie_0_clkref_en =3D {
> +       .halt_reg =3D 0x88004,
> +       /* The clock controller does not handle the status bit for

Please leave /* on it's own line for multiline comments.

> +        * the clocks with gdscs(powerdomains) in hw controlled mode
> +        * and hence avoid checking for the status bit of those clocks
> +        * by setting the BRANCH_HALT_DELAY flag */

And */ too

> +       .halt_check =3D BRANCH_HALT_DELAY,
> +       .clkr =3D {
> +               .enable_reg =3D 0x88004,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_pcie_0_clkref_en",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
