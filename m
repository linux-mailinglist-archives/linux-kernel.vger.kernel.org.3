Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E66570C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiGKVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:10:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A52B272;
        Mon, 11 Jul 2022 14:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01D16B80ECC;
        Mon, 11 Jul 2022 21:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952F4C34115;
        Mon, 11 Jul 2022 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657573847;
        bh=ew4bowO6kNFQLODResBCj9sJiJJyN84qEWosF0EMHEM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Gyh2Zkn/ZsKToodeu8WZ62KhqOysXZrLTpxnbcKxgxlbbbBV4ED41P8d+UQK6sNgp
         1QTlDuxq59skJFTlVlzqWx8UP8YTgiuNh1b3qaROYVK1ylhzz5DWutaxIfjYJxzoAa
         3Ur2xEV56Fjp5USmy0eskr+agEpfP4ueHJkTgKaT2HN95D1fTi7rOInYNJeAcBmrYl
         a86QCFmaHAXXIGpfL64+7dxjzSnya3o0dTMp6T6PF7IJCNGyM+GukZmr5JNKjJAWhz
         mvZKD1xQm1PbEJNajAUN3jaZMYxM8jPDBN3AjiVNBXkjnoGRz1KZGfWfJbe0/QDrfc
         uHD2iBxfj014Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220515210048.483898-10-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com> <20220515210048.483898-10-robimarko@gmail.com>
Subject: Re: [PATCH v4 10/11] clk: qcom: ipq8074: dont disable gcc_sleep_clk_src
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>
To:     Robert Marko <robimarko@gmail.com>, absahu@codeaurora.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tdas@codeaurora.org
Date:   Mon, 11 Jul 2022 14:10:45 -0700
User-Agent: alot/0.10
Message-Id: <20220711211047.952F4C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Marko (2022-05-15 14:00:47)
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq807=
4.c
> index 3204d550ff76..42d185fe19c8 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -663,6 +663,7 @@ static struct clk_branch gcc_sleep_clk_src =3D {
>                         },
>                         .num_parents =3D 1,
>                         .ops =3D &clk_branch2_ops,
> +                       .flags =3D CLK_IS_CRITICAL,
>                 },

Why not just remove the clk from the driver? Is anything using it?
