Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE9254FF03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383559AbiFQUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383674AbiFQUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:53:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0D1B7AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:53:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c196so5124202pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gk5x1jCh3cBaZdr+I2YroVIlBVqwNBM6ZD+Wwafw4ck=;
        b=WWM7psGs0QH1ShTqqeM8WSlVG4uF2enBj2PRdmP7NHwvAC7ZSQxDmKxMyU1oOIOhzX
         FOBlEvqochqZBjEQQhgwxInHMa4gJFM39cABp1vCBrWx/m2VTv3ODDYz+b0sqLRlGrgq
         C85SdT/BF+iTCimXOTcrZ5unKBRggLztCNO1/Rucw2W58CjjsjqdlFBxcStwWk3fMmOt
         zSjgRdlns8M41Kr/jam6BvYL7ejzsf+isUB/4BLMeAtLirmbgP3cYRkmvNJZaWj5mex/
         25lY6zR8jsFhJn/ivTMI9Hm0Wgp7/UHPCTD9B6rO/E2cQ677OOCy9vw69r4Ie4MZalX3
         5w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gk5x1jCh3cBaZdr+I2YroVIlBVqwNBM6ZD+Wwafw4ck=;
        b=UNvz3CWAfyFUcd4lwU6eP833+5p06QvkLnkGg0W2g2uMKgC7DSjkliDZ8C0DNPegHy
         p7YHY35A8uv86DTlPCy2FYWNLqj5LSyC6gbxP/t/YUpbMuqq2GoatmJsH5tr8UxrkOqD
         +2rR2pb1+qCIFY48fFuvIoRvCMn/Nrfrd1KJ+KyaBPUvungGeuo9wrD8LsV8fLrp3mmn
         QCc0zCvDoxhMZllJQ22g0Zkla1PpuodOSOIyPUexQNkQULYwR7xapGCqs0jjBYiNmpP3
         1bZgRe8QkkbDcXHLgF5U41as3yEGPZyK//TDJAdAc/6gztDi4tM6iZc9BArBSp+/0rK7
         gpTA==
X-Gm-Message-State: AJIora9RzLC6vYHNTCf/RQeeqX/sJdXhocExGY0J6tjkQYn2wvSyHzvV
        01RXLo70Ha4y+yTThc+r9oIgxw==
X-Google-Smtp-Source: AGRyM1vQWI/PczVCbdS6/Rd6XdpcbnewF7gplMuHiRn1jmWqVz8dsXS7FwdRM4q7fg/r68ZW6RI+NQ==
X-Received: by 2002:a63:814a:0:b0:3fc:ee2c:340f with SMTP id t71-20020a63814a000000b003fcee2c340fmr10645882pgd.380.1655499219487;
        Fri, 17 Jun 2022 13:53:39 -0700 (PDT)
Received: from [172.31.214.180] ([216.9.110.13])
        by smtp.googlemail.com with ESMTPSA id g4-20020a17090a67c400b001ec7ba41fe7sm1367233pjm.48.2022.06.17.13.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:53:39 -0700 (PDT)
Message-ID: <edb78d7b-8ca5-f03c-7ba1-558279cb6d69@linaro.org>
Date:   Fri, 17 Jun 2022 13:53:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/11] ASoC: wcd-mbhc-v2: use pm_runtime_resume_and_get()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-5-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220616220427.136036-5-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 15:04, Pierre-Louis Bossart wrote:
> simplify the flow. No functionality change, except that on -EACCESS
> the reference count will be decreased.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
Thanks Pierre,

LGTM,
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   sound/soc/codecs/wcd-mbhc-v2.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 31009283e7d4a..98baef594bf31 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -714,12 +714,11 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
>   	struct snd_soc_component *component = mbhc->component;
>   	int ret;
>   
> -	ret = pm_runtime_get_sync(component->dev);
> +	ret = pm_runtime_resume_and_get(component->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(component->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(component->dev);
>   		return ret;
>   	}
>   
> @@ -1097,12 +1096,11 @@ static void wcd_correct_swch_plug(struct work_struct *work)
>   	mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
>   	component = mbhc->component;
>   
> -	ret = pm_runtime_get_sync(component->dev);
> +	ret = pm_runtime_resume_and_get(component->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(component->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(component->dev);
>   		return;
>   	}
>   	micbias_mv = wcd_mbhc_get_micbias(mbhc);
