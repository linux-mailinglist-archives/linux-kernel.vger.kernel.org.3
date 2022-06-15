Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7A54C21A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiFOGsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiFOGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:48:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408012DA9C;
        Tue, 14 Jun 2022 23:48:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c196so10604846pfb.1;
        Tue, 14 Jun 2022 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jEzroN9krnUkZ2+Y46mqGxrDo8hTabqX3KY2I2rzfxE=;
        b=KnRE/wBH4kTNZhS7caskp/emMiN9IUW6MSHYhje8kK1JVkHgS89FZACYMwwnwH+ewB
         I2xFtQqCywvOVOKQn+prVpQgf9EiGWZoQSz42tLGMcfN8tVYCojY0iQ0ZmEbz8m66UXK
         w3u9vLaAumpSQ4THVWRo8v3eoWHdzNw0xDsS7A0CdyR7EjDViyjq0GxX8MO96+QtJwUZ
         9U5C7c5QZt9c9ICvFrqEC5hdZge+Q7+rHCMbWn3VGncPk0DJxJTr4mZsk9+NNfCN9UAG
         KlsF1Mxu3OjsLWUYfyvBnVx9Kfn+B8zt/E9Pvuq4Fd28ONQjcrbJ8rcBzz79OgElXaYh
         qPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jEzroN9krnUkZ2+Y46mqGxrDo8hTabqX3KY2I2rzfxE=;
        b=LAhrLQgLEfnQKzNrX4f2J/EqYCbwhXsku8A8MoGIvoOABp2a7Um++4R42rNH+dt8Gy
         h7tkeX/PQW0p8V2z0YL9i3ZALGu5lODMZqw5PogbzwcNuGA+6ctWzqBY3Fz06B/Cw8YP
         Yl77V3REoFC9xDxYj2bAqM027CGrVUABb9n1K7yvXqLXuE2rDis2i6MbRSq/LjdF4++Y
         BQuyX/q7WDzNZpSkYf5enHKXSP2Crn7f84XerDnqwCJUdI6vaWgVYN/EQvCJEwYJ+pB+
         r0/gpieLDtRt81GPOn4DxwEYb9BPPU/T3kvke6ktQ9kUzJzD+yPQMKH8VUNdsHp5NeHy
         gQSQ==
X-Gm-Message-State: AOAM533BSfZxQLaBuZJhtucsa6LPBOrorkgzE5+vsF3XvDbFto7wf/Id
        FEWxQyiAT2DfkZyk/yeSxno=
X-Google-Smtp-Source: ABdhPJyWM743ytURp4tznEG+0ckbSOUe+kwhe5PahJKknnQY57U1mcESiTQNwxdt7aMzf6SHt5RqGQ==
X-Received: by 2002:a63:221b:0:b0:401:afc8:dbfc with SMTP id i27-20020a63221b000000b00401afc8dbfcmr7654908pgi.482.1655275687544;
        Tue, 14 Jun 2022 23:48:07 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e4-20020a170903240400b00168f329b27dsm1414604plo.53.2022.06.14.23.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 23:48:07 -0700 (PDT)
Message-ID: <17cb21c6-317a-3f70-8c4d-4d8fe20604d4@gmail.com>
Date:   Wed, 15 Jun 2022 15:48:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/4] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-2-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614230950.426-2-ansuelsmth@gmail.com>
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

On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
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
>  drivers/devfreq/governor_passive.c | 39 +++++++++++++-----------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 72c67979ebe1..95de336f20d5 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -34,6 +34,20 @@ get_parent_cpu_data(struct devfreq_passive_data *p_data,
>  	return NULL;
>  }
>  
> +static void delete_parent_cpu_data(struct devfreq_passive_data *p_data)
> +{
> +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
> +

Need to add the validation checking of argument as following:

	if (!p_data)
		return;

> +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
> +		list_del(&parent_cpu_data->node);
> +
> +		if (parent_cpu_data->opp_table)
> +			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> +
> +		kfree(parent_cpu_data);
> +	}
> +}
> +
>  static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
>  						struct opp_table *p_opp_table,
>  						struct opp_table *opp_table,
> @@ -222,8 +236,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>  {
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
> -	struct devfreq_cpu_data *parent_cpu_data;
> -	int cpu, ret = 0;
> +	int ret;
>  
>  	if (p_data->nb.notifier_call) {
>  		ret = cpufreq_unregister_notifier(&p_data->nb,
> @@ -232,27 +245,9 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
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
> -		list_del(&parent_cpu_data->node);
> -		if (parent_cpu_data->opp_table)
> -			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> -		kfree(parent_cpu_data);
> -		cpufreq_cpu_put(policy);
> -	}
> +	delete_parent_cpu_data(p_data);
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
