Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2048C145
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352190AbiALJsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349532AbiALJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:48:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC41C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:48:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a5so3121053wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvNdPw4A75PyvJZJhJ+BPOLK9/MSxsg60VQkLM65tgg=;
        b=qPgICBIwsAuQ1mjh5JgLh0eGoMrUhQKrlo4MV2YdySlBeeHB+POQad1H7CiUqxuS8O
         U+1Kajkl33THx+j+VFNYgF0NTzwxJfYSKfWZ19JKQLygMlJGY52ETkqGYKGTgS+DSG+d
         HKX7mMWAQ0rt45qMKIuof/rJnYn3z1SYaMoqS4K1QXEKg4LcXx9UV/VQrOYFB6JvOmO5
         VF1biEL6X5LiKhNgv3hcQ3C1VWy0FCenj+CQzgt3r3Ii3MMNIJGZhG6VZ2YSRmLq2z4a
         iVbZ/YMrmf3ThWxhjErjR2fCeYAOJ5hi3XXAW0knA3QMLeTtEYt3o2lPtt/2EgDIZgmW
         Bang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvNdPw4A75PyvJZJhJ+BPOLK9/MSxsg60VQkLM65tgg=;
        b=VhdEHjAXZhQNcLP2AvpFiV4unu9LOe355OlcyDVY0/o4/mHOz5cbEKMBJDzL83x/5K
         RDdRLU7wUGD2ydfEt/IDtl25iDeTvTBveW1+h0wfAjAtrke4ETOceFs13nUrY3m/3IdG
         CJ286p7zhPRHUuElra2B4eBOq1vFUTwBay0KGJ1A0ngs4MaDhhWe/8jVLYJ77ELRK4x1
         M4DOHhbFTFFP1kk+mOw6WJNXB6Vua4uQP8V5nO49pvrbft+7MhcPJj6AYWAwNN/to+fO
         fRFl2cGtkVrXmOBY21gUsk8r2cAV0bUyT/rs3ubMynMU4Rc7qDqgf6YE9GnKKTlNr3lw
         fRIQ==
X-Gm-Message-State: AOAM531hm6wciMNrRPPE7krqwdE/v+3izd01mOqlSo+7gE/lw5J/lV1c
        P68eymQ3cvbMzivQ+ShUdG4EirTgLyCXIA==
X-Google-Smtp-Source: ABdhPJwxxZwVdV43gKiB2TyUPoD+VU3fvQnEiXCfMxT94G6fGkWA+CDZt+6ONQEfiW/WQTdGzINeEA==
X-Received: by 2002:adf:8023:: with SMTP id 32mr6168506wrk.136.1641980893667;
        Wed, 12 Jan 2022 01:48:13 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o13sm12390642wrc.111.2022.01.12.01.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 01:48:13 -0800 (PST)
Subject: Re: [PATCH] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, cezary.rojewski@intel.com,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8be9a48c-6b61-9272-a2e4-0bd483e0544c@linaro.org>
Date:   Wed, 12 Jan 2022 09:48:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2022 01:32, Jiasheng Jiang wrote:
> The devm_regmap_init_mmio() may return error pointer under certain
> circumstances, for example the possible failure of the kzalloc() in
> regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().
> Then the error pointer will be dereferenced.
> For example rx->regmap will be used in rx_macro_mclk_enable().
> Therefore, it should be better to check it.
> 
> Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
> Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
> Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Thanks for the patch,

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/lpass-rx-macro.c  | 2 ++
>   sound/soc/codecs/lpass-tx-macro.c  | 2 ++
>   sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 07894ec5e7a6..2adbf2e2697f 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -3542,6 +3542,8 @@ static int rx_macro_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
> +	if (IS_ERR(rx->regmap))
> +		return PTR_ERR(rx->regmap);
>   
>   	dev_set_drvdata(dev, rx);
>   
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 27a0d5defd27..e4bbc6bd4925 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -1803,6 +1803,8 @@ static int tx_macro_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	tx->regmap = devm_regmap_init_mmio(dev, base, &tx_regmap_config);
> +	if (IS_ERR(tx->regmap))
> +		return PTR_ERR(tx->regmap);
>   
>   	dev_set_drvdata(dev, tx);
>   
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index d3ac318fd6b6..dd1a8b7bc794 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2405,6 +2405,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	wsa->regmap = devm_regmap_init_mmio(dev, base, &wsa_regmap_config);
> +	if (IS_ERR(wsa->regmap))
> +		return PTR_ERR(wsa->regmap);
>   
>   	dev_set_drvdata(dev, wsa);
>   
> 
