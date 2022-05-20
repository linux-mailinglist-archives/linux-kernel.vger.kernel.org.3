Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92E52EEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350698AbiETPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiETPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:19:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF417788A;
        Fri, 20 May 2022 08:19:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 5B1971F46586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653059940;
        bh=YQ31OR4ZEDVzd2CcVyEsIJ0oD9usN7dRjGllBd1TqMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9k2T7C3tWF2Q3ecHJRuck5leEQwLkSwMo5DGMerg1mS8Fr1EogfPo6jonnSsp4g7
         Xw/fpwTKwWh1esgVSCvVPbiZTYPUKvdEDFGGTZ6wvbSRWULRyV9d6KMSqc5vhK7GUZ
         URBfBdk9fvBJiiMUTml9XZzIW+It09ZGGGev+NcCA6uVo5/B10pF6kU3JA8nIoZPNQ
         R5aQ98ClKg4IaWUZHu8WvxcXjOWN3SPxm942NPVV1Gh6ynm+Xc1T+iytkEIiMtyT6G
         ml7WR6OSxIvUhUcjkWkYci1HAMrMp6UHqOJRwIcj3BWXnEbBfC9UCMo1DIwqkQhF17
         HkK472iVQYwtQ==
Date:   Fri, 20 May 2022 11:18:54 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 07/19] clk: mediatek: reset: Support nonsequence base
 offsets of reset registers
Message-ID: <20220520151854.kkr2tezmrfniks4j@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-8-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519125527.18544-8-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

On Thu, May 19, 2022 at 08:55:15PM +0800, Rex-BC Chen wrote:
> The bank offsets are not serial for all reset registers.
> For example, there are five infra reset banks for MT8192: 0x120, 0x130,
> 0x140, 0x150 and 0x730.
> 
> To support this,
> - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets of
>   the reset register.
> - Add a new define RST_NR_PER_BANK to define reset number for each
>   reset bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

<snip>

> diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
> index 9cfd589939e5..5cbc5c42204d 100644
> --- a/drivers/clk/mediatek/clk-mt2701-g3d.c
> +++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
> @@ -35,10 +35,12 @@ static const struct mtk_gate g3d_clks[] = {
>  	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
>  };
>  
> +static u16 rst_ofs[] = { 0xC, };

Very nitpicky, but you could have left the hex lowercase '0xc'.

Thanks,
Nícolas
