Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE14F080D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbiDCGTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiDCGTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:19:17 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F2BF51
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 23:17:23 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id atY9noVWvN7CcatY9nMrxT; Sun, 03 Apr 2022 08:17:22 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 08:17:22 +0200
X-ME-IP: 90.126.236.122
Message-ID: <7dc70fe2-a418-9842-c9ad-e78216ec1d13@wanadoo.fr>
Date:   Sun, 3 Apr 2022 08:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: codecs: Fix an error handling path in
 va_macro_probe()
Content-Language: fr
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <6d08311472e272fdc1a184f019ec98ade6e9dc46.1648966195.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6d08311472e272fdc1a184f019ec98ade6e9dc46.1648966195.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/04/2022 à 08:10, Christophe JAILLET a écrit :
> After a successful lpass_macro_pds_init() call, lpass_macro_pds_exit() must
> be called.
> 
> Add the missing call in the error handling path of the probe function and
> use it.
> 
> Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")

I'll send a V2. The same issue is also in lpass-tx-macro.c and 
lpass-rx-macro.c.

CJ

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   sound/soc/codecs/lpass-va-macro.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index f3cb596058e0..d18b56e60433 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1434,8 +1434,10 @@ static int va_macro_probe(struct platform_device *pdev)
>   		va->dmic_clk_div = VA_MACRO_CLK_DIV_2;
>   	} else {
>   		ret = va_macro_validate_dmic_sample_rate(sample_rate, va);
> -		if (!ret)
> -			return -EINVAL;
> +		if (!ret) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
>   	}
>   
>   	base = devm_platform_ioremap_resource(pdev, 0);
> @@ -1492,6 +1494,8 @@ static int va_macro_probe(struct platform_device *pdev)
>   err_dcodec:
>   	clk_disable_unprepare(va->macro);
>   err:
> +	lpass_macro_pds_exit(va->pds);
> +
>   	return ret;
>   }
>   

