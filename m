Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDDB580F69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGZIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:54:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324092CDF0;
        Tue, 26 Jul 2022 01:54:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 756A96601B15;
        Tue, 26 Jul 2022 09:54:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658825681;
        bh=1iaVgIqkvqng7ciBfQWjGnm3J+Dd5w0l/SpsumKNy98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DTWln5MH9nDgWRzFzCd03y2BUudE9Ndz+sh35jeUDme8zX5EN3n7w8MfN9OBKmYNh
         oO55WutYJaPoDELJyyG7bhpvi5zWJDRv5pinsEpUucvps4qHt5be1SkhhVaOUn1hrr
         x2EDbnfBaS3QCLa8BTPvrpGgnlbJMByQyhjqT6v0B5qxiek9AvWRuUUza6DJ9ZCoR7
         4UDwdFfY9O4UW2AwPLXuNCHMv4Hibfx2MLVg09Krbiz2wsIrt+P+ktq/48vabBM/Wu
         p/GuIT7IuWwVgg2aZl0T5RqghCFgm3xcw5hNwCK2Aj4hKqsel15UD8GhIRkblO5NXs
         mSp1A2XYzaZbg==
Message-ID: <c923758d-b591-26bf-8091-527500ae7a6f@collabora.com>
Date:   Tue, 26 Jul 2022 10:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] soc: mediatek: update power domain data of MT7623A
Content-Language: en-US
To:     Chukun Pan <amadeus@jmu.edu.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>
References: <20220726030621.7555-1-amadeus@jmu.edu.cn>
 <20220726030621.7555-2-amadeus@jmu.edu.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726030621.7555-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 05:06, Chukun Pan ha scritto:
> When running OpenWrt on MT7623A, I receive a kernel
> warning as follows (Device dts using mt7623.dtsi):
> 
> mtk-scpsys 10006000.scpsys: Failed to power on domain mfg
> WARNING: CPU: 0 PID: 1 at drivers/soc/mediatek/mtk-scpsys.c:457 0xc04a4130
> 
> When I switch the device dts to using mt7623a.dtsi,
> the system fails to boot:
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 0-...0: (0 ticks this GP) idle=146/1/0x40000000 softirq=53/53 fqs=1051
>   (detected by 1, t=2102 jiffies, g=-1111, q=18)
> Sending NMI from CPU 1 to CPUs 0:
> 
> Solved the problem by duplicating the power domain of
> the MT7623 (except MFG) to MT7623A, the system works
> fine without kernel warnings/errors.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Can anyone from MediaTek check if these power domains do exist on MT7623A?

Thanks,
Angelo

> ---
>   drivers/soc/mediatek/mtk-scpsys.c | 35 +++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index ca75b14931ec..8b5713db1ca3 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -910,6 +910,41 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
>   		.clk_id = {CLK_NONE},
>   		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>   	},
> +	[MT7623A_POWER_DOMAIN_VDEC] = {
> +		.name = "vdec",
> +		.sta_mask = PWR_STATUS_VDEC,
> +		.ctl_offs = SPM_VDE_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.clk_id = {CLK_MM},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT7623A_POWER_DOMAIN_DISP] = {
> +		.name = "disp",
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = SPM_DIS_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.clk_id = {CLK_MM},
> +		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT7623A_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = PWR_STATUS_ISP,
> +		.ctl_offs = SPM_ISP_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.clk_id = {CLK_MM},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT7623A_POWER_DOMAIN_BDP] = {
> +		.name = "bdp",
> +		.sta_mask = PWR_STATUS_BDP,
> +		.ctl_offs = SPM_BDP_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.clk_id = {CLK_NONE},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
>   };
>   
>   /*


