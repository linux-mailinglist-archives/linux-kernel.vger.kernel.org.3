Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38154BE00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357280AbiFNW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357287AbiFNW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:58:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FFD52E55;
        Tue, 14 Jun 2022 15:58:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f9so8986466plg.0;
        Tue, 14 Jun 2022 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6rypLVDEi4Al+h2wMUYsIuc8jJslLN5EPrmzWEFbMuo=;
        b=pxb/CAZdPFSGlo6VVkJyhZU3NdVha+pVgZFpcgpSTF3fH3JxiGjGJCXIpkJqAoas48
         XlGIEYxr3nZwZ4j/opxfKbsMvLggMZ5S066/YRl2cOvIWyrThTKph/fBaifXYIuENlaQ
         GsQzztHLvHIZKSRDY9D04//MeQe/4qrHnaMZ2GY8zMDBKeaE4wZUCWvCbWPlMQIEEmII
         UewdInTMDijCmlCJAgpSF7tuKsqJueAWG/OULuCz2pXNTKZAzIfyJ0yhQbfqqg/YsU7X
         H0lp7E2TFM4zLgcYkeBq/B1JWEZ4/A7/EHycstMoWCUmxaUinEpKWxOEloGX08giBUpK
         OEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6rypLVDEi4Al+h2wMUYsIuc8jJslLN5EPrmzWEFbMuo=;
        b=V5VrKtdfvR/T+5fEkNQN6BGfY6CbX9D+jLeYX7Lwa371zQKBXYDTbyMVaz7gisYXwq
         tLj3mRaysnpnBBdNUZ43/GQzy7PTb+Lo4tDQBi6ze3da3h5LIs99L89kPW280sHabN9M
         lOEVptCCk4+uSnU8Z6fR2ck2YniUbJaaWEA/MjhmcXAEV8e+1lTusSEoXN3+5mG87b2t
         P1/m3KrEz15VneIK+R/IRzNN/hFKjhB5MpSBTD5sMn1M5i4pY1MUzV0U3ZZRaLdf0LRp
         SQZIX7SPQ/PciFPbJXhUYsdc0e/6lUaogfBiugyx45cc6C/tZz2xRmuPrB3nSRj6HhD+
         7KhA==
X-Gm-Message-State: AJIora8l/hL20otAL9dcZ4is2WhYLQgLC/phoP1YOH6kD/KmUAXjZEm9
        ZgRCg6fYPyd8Rcd+gO5FvWQ=
X-Google-Smtp-Source: ABdhPJwofxFlNwHyeEkoxKk5EJ0NkYQN/adYl+33Xqnv+rHItyPrWR+2eZWo/2ukpK2LLuPmvQUgww==
X-Received: by 2002:a17:902:e892:b0:167:4570:32e3 with SMTP id w18-20020a170902e89200b00167457032e3mr6376651plg.51.1655247500321;
        Tue, 14 Jun 2022 15:58:20 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b0015e9d4a5d27sm7796067plb.23.2022.06.14.15.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:58:19 -0700 (PDT)
Message-ID: <7f00333d-40f9-34d5-fd84-54c10d7a243d@gmail.com>
Date:   Wed, 15 Jun 2022 07:58:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
 <20220614110701.31240-2-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614110701.31240-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 14. 20:06, Christian 'Ansuel' Marangi wrote:
> With the passive governor, the cpu based scaling can PROBE_DEFER due to
> the fact that CPU policy are not ready.
> The cpufreq passive unregister notifier is called both from the
> GOV_START errors and for the GOV_STOP and assume the notifier is
> successfully registred every time. With GOV_START failing it's wrong to
> loop over each possible CPU since the register path has failed for
> some CPU policy not ready. Change the logic and unregister the notifer
> based on the current allocated parent_cpu_data list to correctly handle
> errors and the governor unregister path.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/governor_passive.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 72c67979ebe1..0188c32f5198 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -222,8 +222,8 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>  {
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
> -	struct devfreq_cpu_data *parent_cpu_data;
> -	int cpu, ret = 0;
> +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
> +	int ret;
>  
>  	if (p_data->nb.notifier_call) {
>  		ret = cpufreq_unregister_notifier(&p_data->nb,
> @@ -232,27 +232,16 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>  			return ret;
>  	}
>  
> -	for_each_possible_cpu(cpu) {
> -		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -		if (!policy) {
> -			ret = -EINVAL;
> -			continue;
> -		}
> -
> -		parent_cpu_data = get_parent_cpu_data(p_data, policy);
> -		if (!parent_cpu_data) {
> -			cpufreq_cpu_put(policy);
> -			continue;
> -		}
> -
> +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
>  		list_del(&parent_cpu_data->node);
> +
>  		if (parent_cpu_data->opp_table)
>  			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> +
>  		kfree(parent_cpu_data);
> -		cpufreq_cpu_put(policy);
>  	}

I agree this patch. Just, I'd like to make the separate function
to handle the removing of parent_cpu_data.

Please add new delete_parent_cpu_data() function under get_parent_cpu_data()
implementation and then call delete_parent_cpu_data()
in cpufreq_passive_unregister_notifier().

>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int cpufreq_passive_register_notifier(struct devfreq *devfreq)


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
