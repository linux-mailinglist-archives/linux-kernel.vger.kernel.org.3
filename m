Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA194E6671
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbiCXP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351536AbiCXP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A182ADD6C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:56:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so2604523plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ne9OYL5CfWNLmAIU1ktd7k6bzX961vRnh7JsrHpoDCE=;
        b=Mo5KsPPSgnxGxZkAbOQY4wXE7rPREwoiIpmvFYqkA2rgmGggEsYL7IPCwqlDS1MZxW
         tRDAp0+YpIQjI813unWjBmL6NWl4EgP8KFOuOTpNtUBJpDyoaAumOWEU4Dh/Gh1EGCYu
         oEu4rfjYp1y38w6+m35Z9v4plMMCrqnjTuRSWYgxfMY7nKkpVtU9f7N9KxhpMS+zYaGc
         sE5pCNsfufxQKD6hVtemU9rl3xWOijablRSYktVU7wwqVkV6sDXSUzv+5B+8cDE7f3e/
         G1uYT9qT5FYAVOkFp0dGlh2ds8Xn6cDAuFiJ94c2ZX9cdRCCjAzG6V5Tqz0bKj98W0J4
         +RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ne9OYL5CfWNLmAIU1ktd7k6bzX961vRnh7JsrHpoDCE=;
        b=GevV7kkCkTHXY6XubU6RkNYnu9PpKKLsXodEhelisw+eOF0vdg46T48ammxzq6cDYe
         L6/ZLAP2zUJY9Hzk58SYmqYXU2Yxn384yubXHwbL1JUagP/NTKjbBHcvQT+MfcdRey6o
         nXnzfTZhkkGs9sV8hdqjDfnAbB5xEvvsvAvJVC4bAoodIpLamCa+sx10QFqEUKcEHbrj
         rBQcFrccJRoZpntDuh5R7tfZb8S3rsoS8rCMW2Qa5hmTB7L1gSk3Iuefi4wI4pYj8c8L
         oP83GYwDb9iwBxZOdqxVsC/cAShdBocpR7lPdukMRw5tLm8eiQdDJO2eWsU8TQdrS+ZS
         7NJw==
X-Gm-Message-State: AOAM53045Yl8C1KY+Q3+98yGbghzkeyJQ/cEsTL+yFoKnOseS06OXmCj
        GCfxGMA6IadAA+xFPhwJpfJp2w==
X-Google-Smtp-Source: ABdhPJy8nDCvoMyZv7HY/JHEm34TZfmOQhWBhT7JqRM3pglG7soXNfBfct5EyFVyJ7HskDz+ILQeQQ==
X-Received: by 2002:a17:902:bd88:b0:14f:8ddf:e373 with SMTP id q8-20020a170902bd8800b0014f8ddfe373mr6771743pls.89.1648137391723;
        Thu, 24 Mar 2022 08:56:31 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4256187pfc.41.2022.03.24.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:56:30 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:56:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: mediatek: enable cache for mt8186 SCP
Message-ID: <20220324155628.GC3514576@p14s>
References: <20220322122845.4068-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322122845.4068-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Tue, Mar 22, 2022 at 08:28:45PM +0800, Allen-KH Cheng wrote:
> 1. Set SCP cache size before loading SCP FW. (8KB+8KB)
> 2. Adjust ipi_buf_offset from 0x7bdb0 to 0x3BDB0 for enableing cache
> 
> SCP side
>  - IPI Buffer: 0x3BDB0 <-> 0x3C000
>  - Cache: 0x3C000 <-> 0x40000
>

I would also like to find in this changelog "why" this patch is needed and more
importantly, how it remains compatible with existing implementation.  I am
mostly worried about implemenations where the application processor is using
caches while the SCP is not.

I will also need a couple of "Tested-by" tags before moving forward with this
patch.

Thanks,
Mathieu

> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 38609153bf64..24065b6b4da8 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -401,6 +401,14 @@ static int mt8186_scp_before_load(struct mtk_scp *scp)
>  	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_P1);
>  	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_p2);
>  
> +	/*
> +	 * Set I-cache and D-cache size before loading SCP FW.
> +	 * SCP SRAM logical address may change when cache size setting differs.
> +	 */
> +	writel(MT8183_SCP_CACHE_CON_WAYEN | MT8183_SCP_CACHESIZE_8KB,
> +	       scp->reg_base + MT8183_SCP_CACHE_CON);
> +	writel(MT8183_SCP_CACHESIZE_8KB, scp->reg_base + MT8183_SCP_DCACHE_CON);
> +
>  	return 0;
>  }
>  
> @@ -905,7 +913,7 @@ static const struct mtk_scp_of_data mt8186_of_data = {
>  	.scp_da_to_va = mt8183_scp_da_to_va,
>  	.host_to_scp_reg = MT8183_HOST_TO_SCP,
>  	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
> -	.ipi_buf_offset = 0x7bdb0,
> +	.ipi_buf_offset = 0x3bdb0,
>  };
>  
>  static const struct mtk_scp_of_data mt8192_of_data = {
> -- 
> 2.18.0
> 
