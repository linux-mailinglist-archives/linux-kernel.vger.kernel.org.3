Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E004C97A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiCAVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiCAVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:20:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C0377C8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:19:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 35D431F44A83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646169577;
        bh=tfESyi7NvHZ8rcLBdONcaqbAYAO7h6asmbKPmAHGiqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chzC4LURLh1Iw0bO8ScXp8/6TVuIpVaDbHAWMn7rT6LYyKI/23RG9RRmQJJYWDZ2O
         Y3Bd/OTYCvC7QINYJC/1V+zttNqjhrGGmm/ZbFBejfTrhn6rr5C0RH05MO+cMWUb5q
         RSJfVJKx2XIpVl2Hv0vj083GAy5pqQEMTVPwYA1zMpElavYRwK9VEOcLQLMAyqJ8Cu
         FMjPlbQSLclAJLAZred6P4Vl1klWiaZT3eUteXh6aY/rsX0R4IjHse2e4+lOh8G1OF
         b1OwzOWdAH1Q5FpnAAhaSAil2Typfuwpni1bc3PsX2G+P817XFjCFJUdOYg90g0O/j
         CAVdNkgcDRjLw==
Date:   Tue, 1 Mar 2022 16:19:31 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Adam Ford <aford173@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Fabio Estevam <festevam@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com,
        agx@sigxcpu.org, nm@ti.com, andrey.zhizhikin@leica-geosystems.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable SC7180 interconnect driver
Message-ID: <20220301211931.bzybpp376t6fz6wm@notapiano>
References: <20220131173223.567303-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220131173223.567303-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:32:23PM -0500, Nícolas F. R. A. Prado wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> On SC7180 device trees, almost all of the nodes are declaring
> interconnect properties, including the QUP nodes: at least on
> some machines, leaving this configuration option disabled, or
> as a module, the kernel appears to hang while initializing the
> QUP node containing the UART device.
> 
> To solve this issue, enable the interconnect driver for this
> SoC as built-in.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: "kernelci.org bot" <bot@kernelci.org>
> Acked-by: Georgi Djakov <djakov@kernel.org>
> [rebased on top of mainline]
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Hi Bjorn, could you pick this, as well as
https://lore.kernel.org/all/20220201200504.854917-1-nfraprado@collabora.com/,
up for arm64-defconfig-for-5.18?

Both series apply cleanly on that branch. Thanks!

Nícolas

> ---
> Changes in v2:
> - Just rebased and fixed conflicts
> 
> v1: https://lore.kernel.org/lkml/20211011154003.904355-1-angelogioacchino.delregno@collabora.com/T/#u
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 30516dc0b70e..68913a575784 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1191,6 +1191,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_QCOM=y
>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> +CONFIG_INTERCONNECT_QCOM_SC7180=y
>  CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SDM845=y
>  CONFIG_INTERCONNECT_QCOM_SM8150=m
> -- 
> 2.35.1
> 
> 
> -- 
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.
