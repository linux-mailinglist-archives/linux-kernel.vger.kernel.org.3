Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE87554FED9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383562AbiFQUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383497AbiFQUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:53:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D4A13FB5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:53:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x4so5097641pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JzCoePPltyIJ1REZe29g/ry+WmVSWZaFBIw/sVJ2Jb4=;
        b=YtY+zp8B3TVD1muP4s9LC83VkIeHz9a9vrx+Tgme9Bs8vDuSQ/fFnXEksI5mWZqojT
         SPCNXX7Zf6MMTTcUvOLNrCVSZLM5lI/lU6lqccrmNHyNu3s0oc1EPXTWn+qs0BseZdBW
         RMh9sHSM2rBE/T7x5eWzwASfy/PL9dI0ZIx/LE5hGNuAHgip0FR5o6l66L/CljWWZgbZ
         PrQogLDlhV/LtvSu7ww0jmtN0jV8y7YBCeu2Il6oEaV9ey+qY5IcMMMDhOhtIkl3/MM+
         YWeCdf4dl3TW0HMdQ9R31W/6r75/mw5LJObPq2PUBcmq2jhQwKlEK04urt5OEcU/A69t
         jLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JzCoePPltyIJ1REZe29g/ry+WmVSWZaFBIw/sVJ2Jb4=;
        b=LI28PWIDSv1G+4iakJbUMaMN7DLwov8IaBmO2KBMX5RbZyxz2yJ2au32pwmumq0E0s
         +0S9+4b1KhS94hJdxCSQeJT4W8fbd16Hxcxb+Ztn7qIspOX9UT9K4Tzpq1JSdWvDct2T
         h+AU+63iz01MN/b/AKJutKOUiQ6rIAlKTR6UAULmjumPT+SDRfmay5YAaJ2iLjBhFmm3
         f8wssvWF8HTzkQwfyQ8URyQ8MHxkHHn7vtpNyqR1WgW1vkhehH492qkipnhvW4HoPhSU
         KU+jYb3NuTGRboO0tYmRtRFIsrm8abmbVyAVPUe1TRw9ELRpN0BTJcNp2AmhBgL966GR
         JLZA==
X-Gm-Message-State: AJIora+kluLtO/CnR5TvZse3n2B5Avs2EwKZ7wiAZX1vSzzoo5T4UHVp
        ll99KBqB9LwSumqEkFV7p7A7Qg==
X-Google-Smtp-Source: AGRyM1s0RJHZl208xR17sJB49POLXSqf28nRDtL1lkg0keJvUcbwhL57O4Qt52t3wvqeWdFfo4GJHA==
X-Received: by 2002:a62:1603:0:b0:522:c66b:70ac with SMTP id 3-20020a621603000000b00522c66b70acmr11586382pfw.83.1655499182008;
        Fri, 17 Jun 2022 13:53:02 -0700 (PDT)
Received: from [172.31.214.180] ([216.9.110.13])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170902e14c00b001624dab05edsm1903782pla.8.2022.06.17.13.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:53:01 -0700 (PDT)
Message-ID: <7f9cafb8-a223-c16d-38af-fcb0df05b659@linaro.org>
Date:   Fri, 17 Jun 2022 13:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 05/11] ASoC: wsa881x: use pm_runtime_resume_and_get()
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
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-6-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220616220427.136036-6-pierre-louis.bossart@linux.intel.com>
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
>   sound/soc/codecs/wsa881x.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index f3a56f3ce4871..dc954b85a9881 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -749,11 +749,9 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
>   	unsigned int mask = (1 << fls(max)) - 1;
>   	int val, ret, min_gain, max_gain;
>   
> -	ret = pm_runtime_get_sync(comp->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put_noidle(comp->dev);
> +	ret = pm_runtime_resume_and_get(comp->dev);
> +	if (ret < 0 && ret != -EACCES)
>   		return ret;
> -	}
>   
>   	max_gain = (max - ucontrol->value.integer.value[0]) & mask;
>   	/*
