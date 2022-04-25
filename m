Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2450D8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiDYFkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiDYFkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:40:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EEA13F16
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:37:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p12so2116699pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSOMoXepvL9Jzmn0TgEVp6Q/+RDInO3nOjN9P+fEr5U=;
        b=MjrOo6gnvWQ0KiRdrU6Nh/2NVJzRw7ov8XS4hxBysvBl6cNws1WvQM19tTZ4KGLDck
         bSRc+8Es5GlXRKZ80j3BtWAp1dm1HyRgQdgJTdavSkUykNna9Wu3bQlxejouzBrqe5E7
         2B9WhnPpRlXvfVWse2iTfmXK2BLMrIor4hEXRR//DaBgm18j/4U2GF5EYC8CXSzfekTo
         1IN8TMnhO7O9zgaBwHfJZxIRAG8nqWyEGy1pCZvMlQoteovNcplc+6Dm1gArbznmvX0/
         tU4qrPzbYmnP1FVBS8syW/MHI1iBGpTvPpLd03tXML7uUYc3EgdBsgE0evs1mo23f7lC
         gjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSOMoXepvL9Jzmn0TgEVp6Q/+RDInO3nOjN9P+fEr5U=;
        b=xBXdoSeOeXrJj3fszULigjCKaXMEBUgaWhM7nwQSzHLcYUKbvgIXuCA2c5UvSBaRAf
         IcYcwqGYzeocXMe09irzPfCT4LLv27pHDkDaU8SwyAItCzCwMthncCVXo/3nro0myOe1
         fTrwniSOYzpPfbBwJFYmzdAd5InaWXAgj2yu2F2zcEFt/5stKeHbJKXEPOyf5NKbrsAY
         UzGUEp9Dm4aJG0m4BbGChtKicoTYJ9S8UsqQ/AAKuonEDx9ZMvwnC+HfzT1WJPCUmC6v
         TSA44Y9PiM4nTCx1oFQ4nXqeeSgTMtGk01Doq/uKP5jr+Rh3CyciiLPuQR+qW9p6iNLu
         LC9Q==
X-Gm-Message-State: AOAM532cmxUbTA9EfFTxfe5voiK947eVlLGNHcM2XbolWChQNj74yhwk
        Hd+h7rJ2inE9HpJ2F7itt1Cm0A==
X-Google-Smtp-Source: ABdhPJwyXdNuPFQBy486nkbr3dpvv19PJ2dYyl94Bx5xB85QCCgV+xHeMfE33UI5nisSl/FYAy4fIQ==
X-Received: by 2002:a05:6a00:228b:b0:50d:3c82:911a with SMTP id f11-20020a056a00228b00b0050d3c82911amr4417789pfe.16.1650865020707;
        Sun, 24 Apr 2022 22:37:00 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id f14-20020a63380e000000b0038253c4d5casm8393549pga.36.2022.04.24.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:37:00 -0700 (PDT)
Date:   Mon, 25 Apr 2022 11:06:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 08/14] cpufreq: mediatek: Make sram regulator optional
Message-ID: <20220425053658.4by4i5hex4buxjza@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-9-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422075239.16437-9-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-22, 15:52, Rex-BC Chen wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> For some MediaTek SoCs, like MT8186, it's possible that the sram regulator
> is shared between CPU and CCI.
> We hope regulator framework can return error for error handling rather
> than a dummy handler from regulator_get api.
> Therefore, we choose to use regulator_get_optional.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 0b2ca0c8eddc..97ce96421241 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -438,7 +438,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	}
>  
>  	/* Both presence and absence of sram regulator are valid cases. */
> -	info->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
> +	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
>  	if (IS_ERR(info->sram_reg))
>  		info->sram_reg = NULL;
>  	else {

Applied. Thanks.

-- 
viresh
