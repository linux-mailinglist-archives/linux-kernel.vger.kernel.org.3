Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFE4F07F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiDCFxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiDCFxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:53:39 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCD3B01D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 22:51:45 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id at9JnoLlRN7Ccat9JnMpFF; Sun, 03 Apr 2022 07:51:43 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 07:51:43 +0200
X-ME-IP: 90.126.236.122
Message-ID: <93751991-30ce-93a0-0f33-105f99b8dfe3@wanadoo.fr>
Date:   Sun, 3 Apr 2022 07:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Fix missing
 clk_disable_unprepare() in msm8916_wcd_digital_probe
Content-Language: fr
To:     Miaoqian Lin <linmq006@gmail.com>
References: <20220307084523.28687-1-linmq006@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220307084523.28687-1-linmq006@gmail.com>
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

Le 07/03/2022 à 09:45, Miaoqian Lin a écrit :
> Fix the missing clk_disable_unprepare() before return
> from msm8916_wcd_digital_probe in the error handling case.
> 
> Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   sound/soc/codecs/msm8916-wcd-digital.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
> index fcc10c8bc625..9ad7fc0baf07 100644
> --- a/sound/soc/codecs/msm8916-wcd-digital.c
> +++ b/sound/soc/codecs/msm8916-wcd-digital.c
> @@ -1201,7 +1201,7 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
>   	ret = clk_prepare_enable(priv->mclk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to enable mclk %d\n", ret);
> -		return ret;
> +		goto err_clk;
>   	}
>   
>   	dev_set_drvdata(dev, priv);
> @@ -1209,6 +1209,9 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
>   	return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
>   				      msm8916_wcd_digital_dai,
>   				      ARRAY_SIZE(msm8916_wcd_digital_dai));
> +err_clk:
> +	clk_disable_unprepare(priv->ahbclk);
> +	return ret;
>   }
>   
>   static int msm8916_wcd_digital_remove(struct platform_device *pdev)

Hi,
I think that the same should be done for 'priv->mclk' if 
devm_snd_soc_register_component() returns an error.

Can you give it a look?

CJ
