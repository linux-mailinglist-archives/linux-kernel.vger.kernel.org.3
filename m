Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB25827D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiG0Niq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiG0Nin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:38:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAB24BDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658929122; x=1690465122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4fzlMdFpCX30nlloAxt/drB1D1zwZCDcg/D581dbx7o=;
  b=ZAd+1pj8USEapNsiMEvYXvs0ENwKe+ppXW8DCBYn4WB4+WflsIeH39nI
   LeXsXHEMGsoS1BAzFl+H2qUoSspDwD4kFt/VzV6s2nlk4oOfWikZjOZ9v
   suVojRJdBf2cYn1kQ23dKCaNu/Ko/QOzcacxyEfuTpXNCfs+E2L2Jg+oP
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Jul 2022 06:38:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 06:38:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 06:38:41 -0700
Received: from [10.216.8.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Jul
 2022 06:38:38 -0700
Message-ID: <08899e74-9d1e-52a6-722a-c802ba429662@quicinc.com>
Date:   Wed, 27 Jul 2022 19:08:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: codecs: va-macro: use fsgen as clock
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20220727124749.4604-1-srinivas.kandagatla@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220727124749.4604-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the Patch Srini!!!

On 7/27/2022 6:17 PM, Srinivas Kandagatla wrote:
> VA Macro fsgen clock is supplied to other LPASS Macros using proper
> clock apis, however the internal user uses the registers directly without
> clk apis. This approch has race condition where in external users of
> the clock might cut the clock while VA macro is actively using this.
>
> Moving the internal usage to clk apis would provide a proper refcounting
> and avoid such race conditions.
>
> This issue was noticed while headset was pulled out while recording is
> in progress and shifting record patch to DMIC.
>
> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
This is verified on SC7280 based platform.

Tested-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

>   sound/soc/codecs/lpass-va-macro.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index d18b56e60433..1ea10dc70748 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -199,6 +199,7 @@ struct va_macro {
>   	struct clk *mclk;
>   	struct clk *macro;
>   	struct clk *dcodec;
> +	struct clk *fsgen;
>   	struct clk_hw hw;
>   	struct lpass_macro *pds;
>   
> @@ -467,9 +468,9 @@ static int va_macro_mclk_event(struct snd_soc_dapm_widget *w,
>   
>   	switch (event) {
>   	case SND_SOC_DAPM_PRE_PMU:
> -		return va_macro_mclk_enable(va, true);
> +		return clk_prepare_enable(va->fsgen);
>   	case SND_SOC_DAPM_POST_PMD:
> -		return va_macro_mclk_enable(va, false);
> +		clk_disable_unprepare(va->fsgen);
>   	}
>   
>   	return 0;
> @@ -1473,6 +1474,12 @@ static int va_macro_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_clkout;
>   
> +	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
> +	if (IS_ERR(va->fsgen)) {
> +		ret = PTR_ERR(va->fsgen);
> +		goto err_clkout;
> +	}
> +
>   	ret = devm_snd_soc_register_component(dev, &va_macro_component_drv,
>   					      va_macro_dais,
>   					      ARRAY_SIZE(va_macro_dais));
