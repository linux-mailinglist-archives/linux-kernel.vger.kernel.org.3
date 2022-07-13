Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889E9573546
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiGMLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiGMLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:23:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C012D26
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:23:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so3196623pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBv65ePymP8BrvBqJEccHdic2EPa2EXBPtUssXzhwOg=;
        b=WJAHzNZPHYaBkOnHpUQsHsNvlMG0D7+q0blC0hb3ey7VLNCE6BhnhWgLR5TKOl4CVy
         KlBzLf6ICrSJyRZiQ3Jfb13yrTfH4mY8+LQhzMKRdp9948RtdB8bjg0dYdKTNlridZpL
         x1XKBhSYeYAFLvts3J4JXpPcQeGtNvuJu3ZocsMTzZklY/vRr6OEBwF0luD3QTpjxDI1
         0gd2HF+OXqxmKU0e5YvHukDOUKKZl1Dslaut8KNfBnWoyLRGEtci8Oe6f7nMFXSL+xhH
         Gx78N5kAO/ESczBNpyuKdpcUP2QQ+fCpS/ntuX+IWdzTHPCFi1FJlBufX8AEVTn4LR5L
         gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBv65ePymP8BrvBqJEccHdic2EPa2EXBPtUssXzhwOg=;
        b=TkH3txy1RX9MRL4xvnDkU1YrKadIKzSKpOcMRtkH4sgrHpbStaAU7Otib93PmlWymP
         ad+JUfaoRvQKypeeZ2zU6tk+W9/6Tj4rCzisyQxBwMbBr0jWDOmgUIuhE2YIt/nFafKi
         +jD6NCRwsRtw0VkunRuZBt37XXOR+43LUbFReg6HrcVgYXVO2lxEItFGdKFP32KFrQb1
         dXMmbwfzYlb77f3uQUQUwR5HUWwQSXQ7zP7iEh65gJnBMYA9zwBywP0sq+U0jSd9Tcfp
         t8Yy4zrtj7GKYt9mWZWTr/HNeTjUwsGkN4wglrdSAMM6RbIS54rd6FObYBeC0Q1sryaJ
         2iSg==
X-Gm-Message-State: AJIora//vYNiGN4/3rFpKvdAo+IcBcGKZgeX5VMR1usOOzXTkaCjxRsi
        mdWuaSWhDSbGv8XYM73NFb+q0Q==
X-Google-Smtp-Source: AGRyM1vma2fRTzKqlFqr8JzUoIhx2aJdRjOGe9vLEj93pDZb3OCTdhl1QJ6TIZS+hluNNhT9C8eGSA==
X-Received: by 2002:a17:90b:4a08:b0:1ef:f36b:18e1 with SMTP id kk8-20020a17090b4a0800b001eff36b18e1mr9731642pjb.246.1657711426680;
        Wed, 13 Jul 2022 04:23:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 200-20020a6219d1000000b00528d7d27211sm8754024pfz.178.2022.07.13.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:23:46 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:53:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Handle sram regulator probe deferral
Message-ID: <20220713112344.ye4xgjlqbhyvb46h@vireshk-i7>
References: <20220713111536.115097-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713111536.115097-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-22, 13:15, AngeloGioacchino Del Regno wrote:
> If the regulator_get_optional() call for the SRAM regulator returns
> a probe deferral, we must bail out and retry probing later: failing
> to do this will produce unstabilities on platforms requiring the
> handling for this regulator.
> 
> Fixes: ffa7bdf7f344 ("cpufreq: mediatek: Make sram regulator optional")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 3a2be4552020..7f2680bc9a0f 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -439,9 +439,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  
>  	/* Both presence and absence of sram regulator are valid cases. */
>  	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
> -	if (IS_ERR(info->sram_reg))
> +	if (IS_ERR(info->sram_reg)) {
> +		ret = PTR_ERR(info->sram_reg);
> +		if (ret == -EPROBE_DEFER)
> +			goto out_free_resources;
> +
>  		info->sram_reg = NULL;
> -	else {
> +	} else {
>  		ret = regulator_enable(info->sram_reg);
>  		if (ret) {
>  			dev_warn(cpu_dev, "cpu%d: failed to enable vsram\n", cpu);

Applied. Thanks.

-- 
viresh
