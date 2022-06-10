Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310B546DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350586AbiFJT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiFJT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8A4ECE5;
        Fri, 10 Jun 2022 12:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412CE611E2;
        Fri, 10 Jun 2022 19:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D7EC3411C;
        Fri, 10 Jun 2022 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654891136;
        bh=WWXrwEFko5hYfaIMqNjo1K4YUAKrZpIONasUIUWJCb4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=glT70v/MYLZtzjPQoFUsEGIgn0Jaq/mrwjh79pbvuVlIPcjm4R5jl826fnHlugvHh
         AH2Kq8mIFz/cORgwcVEi5wnwcTytQ4GvxKjK+4G4Xw6VvIkFQwNEWJdVVF++xg7GJT
         Qk/3rdYWHxyK6Tdz95N7xBy1X5EPy9F443kd4ZgVur6Yuyh5R/KnxAo4W/OBbjWfjm
         GiaW3WuAVRYuGoncnA1agkTujLOlWJyEWDQIV5mfTMDTSsMsyfyc9gX2HkryIGQkJ5
         1i24pVz1SOU5PNbzzn+KYJ/a9hxYpgEXIqVSbs3KsMre24vFdw6kOG5dxLzCRpHu8t
         czlsR4Cd0e5Mw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220531094539.252642-1-lizhengyu3@huawei.com>
References: <20220531094539.252642-1-lizhengyu3@huawei.com>
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Fix if statement to match comment
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Li Zhengyu <lizhengyu3@huawei.com>, quic_tdas@quicinc.com
Date:   Fri, 10 Jun 2022 12:58:54 -0700
User-Agent: alot/0.10
Message-Id: <20220610195856.A2D7EC3411C@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Zhengyu (2022-05-31 02:45:39)
> (c->state) is u32, (enable) is bool. It returns false when
> (c->state) > 1 and (enable) is true. Convert (c->state) to bool.
>=20
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>

Nice catch! It looks like it fixes an optimization, where we don't want
to run through and check has_state_changed() if this clk is already
enabled or disabled. But how does this ever happen? The clk framework
already reference counts prepare/unprepare, so how can we get into this
function when the condition would be true, after this patch?

I think we can simply remove the if condition entirely. Do you agree?

> ---
>  drivers/clk/qcom/clk-rpmh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index aed907982344..851e127432a9 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -196,7 +196,7 @@ static int clk_rpmh_aggregate_state_send_command(stru=
ct clk_rpmh *c,
>         int ret;
> =20
>         /* Nothing required to be done if already off or on */
> -       if (enable =3D=3D c->state)
> +       if (enable =3D=3D !!c->state)
>                 return 0;
> =20
>         c->state =3D enable ? c->valid_state_mask : 0;
