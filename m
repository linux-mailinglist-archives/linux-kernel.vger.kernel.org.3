Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20B46110A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbhK2J3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhK2J1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:27:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE9C06179E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:10:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i12so16189786pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqZU7dB4c+Rw9JAiakkbCvFsmlXNXYUS7tOeUtIOfLQ=;
        b=d6l5RiPebDIJXUvKHVE/UQhhHqwbzzNGJru/7cPRP2K6NvZcqgPXgOnpkyTzEQ4COG
         L/GR90IS/yB2VOoHr1jO1sIBX3cKxV/H+CY57EW1fYfLnh6KSQFrgvGuC2uRf7EwSK0T
         tfyU5G1B2m7aDmZOup9i9S7968vLpOgu6YRuTmf0rCOa41Rnw0JDzj03L4xfovujo+KS
         4aRVX7E87YmWrVtmDe66eHLlyAM+I8BgnoRgjCjAW97iXAGAu4d0EAbfZbJUKQyOAxNu
         GH4siRwuLdVmIyiwiPWXcLuJQYb2zrE4n6eYRCAx4rlfsa2FeCFrhYJpp+KrSh6E1PnH
         lQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqZU7dB4c+Rw9JAiakkbCvFsmlXNXYUS7tOeUtIOfLQ=;
        b=Mp36AIgdig8MANylvPqWS1ybIeC2QroU57R1m5FWqeH0fl0NadhgcQoZVJ9IJwUmC3
         VM0sxUW1OrIHJK/BOdQyPIYDNo8PYzMpp8/MIPBeCECp29nCR2HsLzCif8r5wRBfFO3Z
         IUFVL0MIqYuBUaVhPrRMAOeRKujFeiph+Cje/46J2XmdYUU5kc0Ol6d36h2nipQ6CPMF
         OO/i8SzChWgRiXnLt/AQUgcBaF+aaLOawL/Jq2tG6PNebu3NfxzZGZ3nWad7H1EWQzLL
         aG6y4fpu49uIx7O7VRAIpr5wTM20ozK0sZmUVnqUouCB3y+avZulDKoImoSwAuUOD9rJ
         zKXA==
X-Gm-Message-State: AOAM533f7BfDqTumh0THquqCI+8pp3meOA+Cpts4995qmziw3iRcoRe1
        BPaWSom+0din9AtXmOp4pLuOHw==
X-Google-Smtp-Source: ABdhPJzZlt6748dnh3okRdnl0hdxTSnyx8TLAXDzcuEYGeCHx5b1L18l83I1H82Ht23zjtgvWm8tTA==
X-Received: by 2002:a63:8b4a:: with SMTP id j71mr34782170pge.447.1638177043059;
        Mon, 29 Nov 2021 01:10:43 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id lt5sm12617490pjb.43.2021.11.29.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:10:42 -0800 (PST)
Date:   Mon, 29 Nov 2021 14:40:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in
 add_cpu_dev_symlink()
Message-ID: <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-21, 16:02, Xiongfeng Wang wrote:
> When I hot added a CPU, I found 'cpufreq' directory is not created below
> /sys/devices/system/cpu/cpuX/. It is because get_cpu_device() failed in
> add_cpu_dev_symlink().
> 
> cpufreq_add_dev() is the .add_dev callback of a CPU subsys interface. It
> will be called when the CPU device registered into the system. The stack
> is as follows.
>   register_cpu()
>   ->device_register()
>    ->device_add()
>     ->bus_probe_device()
>      ->cpufreq_add_dev()
> 
> But only after the CPU device has been registered, we can get the CPU
> device by get_cpu_device(), otherwise it will return NULL. Since we
> already have the CPU device in cpufreq_add_dev(), pass it to
> add_cpu_dev_symlink(). I noticed that the 'kobj' of the cpu device has
> been added into the system before cpufreq_add_dev().
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..22aa2793e4d2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1004,10 +1004,9 @@ static struct kobj_type ktype_cpufreq = {
>  	.release	= cpufreq_sysfs_release,
>  };
>  
> -static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
> +static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
> +				struct device *dev)
>  {
> -	struct device *dev = get_cpu_device(cpu);
> -
>  	if (unlikely(!dev))
>  		return;
>  
> @@ -1391,7 +1390,7 @@ static int cpufreq_online(unsigned int cpu)
>  	if (new_policy) {
>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
> -			add_cpu_dev_symlink(policy, j);
> +			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>  		}
>  
>  		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> @@ -1565,7 +1564,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	/* Create sysfs link on CPU registration */
>  	policy = per_cpu(cpufreq_cpu_data, cpu);
>  	if (policy)
> -		add_cpu_dev_symlink(policy, cpu);
> +		add_cpu_dev_symlink(policy, cpu, dev);
>  
>  	return 0;
>  }

Interesting that I never hit it earlier despite doing rigorous testing of
hotplug stuff :(

Anyway the patch is okay,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
