Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D775558C33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiFXAVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXAU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB745DC1B;
        Thu, 23 Jun 2022 17:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0A80B824D7;
        Fri, 24 Jun 2022 00:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BCFC341C0;
        Fri, 24 Jun 2022 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656030055;
        bh=yK4Zpaw3ZHGZQHmZW7TtaxpLVjkSC7bBZS4WR2KxmTI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l9lTf31ikj9HsC9DhtTjkjjCpEYRAdMH3kimqLIVG3W15+EyEHhihk+8pTTSpAsof
         TajdkAlbhriZweDazz6c0I+lwjUmnsLKqKHjq0zfXfq6Gt/HGlA/jHss8iT9YjaW9B
         Ya/eGHv1jIdxTW9U2xaSQeH8OqeB1v6g7XTKGgoWfQSbfILAhimMYHi1Km2YN0uoL4
         QMtLc1zufVAJrYQ6H9H9loZEFxxPMzD4Y0s/HBia/GmEuhv50CMmSG0gVffzXFin6T
         QscbOifhjqdcu3GJk9eklNmJ8LK+TcYsxkdyFKFBPq2b/uR8JBwvtIR9pJWA19rBxU
         fveX6EbJn3JOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220623142837.3140680-1-bmasney@redhat.com>
References: <20220623142837.3140680-1-bmasney@redhat.com>
Subject: Re: [PATCH] clk: qcom: sc8280xp: add parent to gcc_ufs_phy_axi_clk for sa8540p
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
To:     Brian Masney <bmasney@redhat.com>, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Date:   Thu, 23 Jun 2022 17:20:53 -0700
User-Agent: alot/0.10
Message-Id: <20220624002055.58BCFC341C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2022-06-23 07:28:37)
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc828=
0xp.c
> index 4b894442fdf5..4639b50da418 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -5696,6 +5709,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk =3D {
>                 .hw.init =3D &(const struct clk_init_data) {
>                         .name =3D "gcc_ufs_phy_axi_clk",
>                         .parent_hws =3D (const struct clk_hw*[]){
> +                               &gcc_ufs_ref_clkref_clk.clkr.hw,
>                                 &gcc_ufs_phy_axi_clk_src.clkr.hw,
>                         },
>                         .num_parents =3D 1,

num_parents needs an update. But this is a branch, not a mux, so it
can't have more than one parent.
