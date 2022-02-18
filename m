Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560704BC306
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiBRXrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiBRXrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:47:07 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248EB5133A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:46:49 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f14so1712243ioz.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ApOdbLf2viFC8HOyVIL76M9o9gtvAN0a+oYBSzuctM=;
        b=RcM5KBnGh0md1BmuL/NkOW3FBn7vrf1DLi5eD8iLAFpvoLxufqWXnNAL1eW4ImjZmj
         lZIt5d9oC7CAvM09QsarVhPsvTQDJUcSgaCgJM7T8j1WkUu6p7qy4HpbdIvnOr6EwnUT
         TT78lmKlb0uPeOS4KWzuId+rcI8SDXctopcM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ApOdbLf2viFC8HOyVIL76M9o9gtvAN0a+oYBSzuctM=;
        b=qny2L8Ftt6lkN3yskEmldcpsvbZ4Hjc9gDffFKEl/tHsYr85FGOzLvYM8Lu/uziydo
         YlmM/N+aEzyoC3OlhXqP2sgmnMncAhMTDKBmIl/UHpBICFt7O9ERK/SNO6xR3KGVRI51
         LGYb1c3faStK7o+XIX/3BQdjyKpFUP5LlCkYzJ2YwnaUPQmVdRcdZKbCX3ZHCqvPdBvm
         V4o3pQQDY+9lumjTJ00kYRufY9dlrvcexeJyLe5nvm0N0Feg57kJxZ+u3rs5euQs5olY
         tELaP9yIGdOhTMC6SfLn/sfJQRsxIj+EIevKqzNVliPjhqA/GLMGiRWgWm4YPS0dYECL
         YiWQ==
X-Gm-Message-State: AOAM530rkaWKLRvfDXflWRTeJN3AnZ6MUBQPq9rmqgqdOmU01lYrs3wJ
        BIrfOzAMTmaC4Ed+iQThNGgATw==
X-Google-Smtp-Source: ABdhPJzG9Wf5D3tQinJhQj0RW7b2acZ6v/jfrdaRwlJbxWjpxlcyOpEftDqAh0A5tXrFDUnK+pL5vw==
X-Received: by 2002:a05:6602:27c9:b0:5ed:1c27:2982 with SMTP id l9-20020a05660227c900b005ed1c272982mr6972651ios.163.1645228008561;
        Fri, 18 Feb 2022 15:46:48 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d18sm4272666iln.79.2022.02.18.15.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 15:46:47 -0800 (PST)
Subject: Re: [PATCH RESEND v6 4/9] cpupower: Add the function to get the sysfs
 value from specific table
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-5-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <10708ac3-d33b-90b7-e096-14bccdfab942@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 16:46:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216073558.751071-5-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 12:35 AM, Huang Rui wrote:
> Expose the helper into cpufreq header, then cpufreq driver can use this
> function to get the sysfs value if it has any specific sysfs interfaces.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
>   tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
>   2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index c3b56db8b921..c011bca27041 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
>   	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
>   };
>   
> -
> -static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> -						 enum cpufreq_value which)
> +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> +						 const char **table,
> +						 unsigned index,

unsigned int

> +						 unsigned size)

unsigned int

>   {
>   	unsigned long value;
>   	unsigned int len;
>   	char linebuf[MAX_LINE_LEN];
>   	char *endp;
>   
> -	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
> +	if (!table || index >= size || !table[index])
>   		return 0;
>   
> -	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
> -				linebuf, sizeof(linebuf));
> +	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
> +				      sizeof(linebuf));
>   
>   	if (len == 0)
>   		return 0;
> @@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
>   	return value;
>   }
>   
> +static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> +						 enum cpufreq_value which)
> +{
> +	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
> +						  which,
> +						  MAX_CPUFREQ_VALUE_READ_FILES);
> +}
> +
>   /* read access to files which contain one string */
>   
>   enum cpufreq_string {
> diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> index 95f4fd9e2656..107668c0c454 100644
> --- a/tools/power/cpupower/lib/cpufreq.h
> +++ b/tools/power/cpupower/lib/cpufreq.h
> @@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
>   int cpufreq_set_frequency(unsigned int cpu,
>   				unsigned long target_frequency);
>   
> +/*
> + * get the sysfs value from specific table
> + *
> + * Read the value with the sysfs file name from specific table. Does
> + * only work if the cpufreq driver has the specific sysfs interfaces.
> + */
> +
> +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> +						 const char **table,
> +						 unsigned index,

unsigned int?

> +						 unsigned size);

unsigned int?

> +
>   #ifdef __cplusplus
>   }
>   #endif
> 

thanks,
-- Shuah
