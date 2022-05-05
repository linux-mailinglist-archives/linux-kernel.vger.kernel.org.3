Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63B51C0D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379828AbiEENge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379840AbiEENgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:36:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C157981;
        Thu,  5 May 2022 06:31:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k2so6128736wrd.5;
        Thu, 05 May 2022 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5pSUK+NARKQGP0RSfhMDxUAusxVl8fziSm0RmmnAc6E=;
        b=bretBRaPEZmVMji52YIT2cPIghpPUcOUPpBAKJc5YUPDThrBkg42K5pCLeNarY+bxW
         17Kof9p/ykq91o+GLZ6upG204f288SaZmouWEERoOkA3JVyL/+I8lYCAsxCsvXAzSiK6
         YQUZs7GQZed3srmxxNEKyXoD3mjbkSwvELw5yX4A/0hQ1wTlNAaF7hRs6nIkEPjBaRli
         UydZcr4EHMgsFPIt0gvmmkM8PK1ZWa5Dzkl4UUTAFCoW6d9puNs82UtG8dHweLdcGeU8
         pcIoKLh9o2TiGNDb9LdiQtI9TP7L6G6A3wIjD4EFRVJ7c0VR1oKEKYzvhUH28cxyeHfd
         FmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5pSUK+NARKQGP0RSfhMDxUAusxVl8fziSm0RmmnAc6E=;
        b=F+8jZig9fx2F0bAMy8Lmeo6Ou0NlfuNurGAehq/jnnuizgze7I6cM1kfP1omDyvOmd
         KV0bs2p9HDz3NIzf1MLS8CXhE1pkg9wViHwwAjLnFlWwFHzTCRNkNCzWji5kfAqMBVs6
         vZoAKhe4HffjoELHrQ3iKrHnjEr4UAxSFheFNYcBrRrqV2EPDkkhF8PZTpJWkVuIfoy1
         b7Y/0GHk6KF0hP5TcBwLcbzxarD+Osh8oYmh7EFUgBUMIjWSJJlwWGxmBiz2pHM7fFqL
         86zyFSiHzeZ26gX281pazgUnSnTgDHKLZkAVV6d/DdFyPgWJbshbaTqcRLXRug8WBcE3
         /uYQ==
X-Gm-Message-State: AOAM5310I5Srs8RPPnVv2zt2WmaaT4Q1sofj+8gREoSKiUkcI44Fq+9k
        M/CZLzO6ScXvVJyNb/13SAE=
X-Google-Smtp-Source: ABdhPJy6T3JY2QzQ/ndLAhrjpHqo9Ok+/mi3IOHf5OfKw5JxhwBq4ViMM7UYjpOnxVCjgszbhN88aw==
X-Received: by 2002:a05:6000:100c:b0:20a:c68a:e9a with SMTP id a12-20020a056000100c00b0020ac68a0e9amr21047454wrx.314.1651757516554;
        Thu, 05 May 2022 06:31:56 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm1422829wmj.20.2022.05.05.06.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:31:56 -0700 (PDT)
Message-ID: <0b9e332d-f479-ed3d-78ce-6386383d827b@gmail.com>
Date:   Thu, 5 May 2022 15:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to
 mismatch
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2022 10:21, Viresh Kumar wrote:
> For some platforms, the frequency returned by hardware may be slightly
> different from what is provided in the frequency table. For example,
> hardware may return 499 MHz instead of 500 MHz. In such cases it is
> better to avoid getting into unnecessary frequency updates, as we may
> end up switching policy->cur between the two and sending unnecessary
> pre/post update notifications, etc.
> 
> This patch has chosen allows the hardware frequency and table frequency
> to deviate by 1 MHz for now, we may want to increase it a bit later on
> if someone still complains.
> 
> Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/cpufreq/cpufreq.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d58b0f8f3af..233e8af48848 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -28,6 +28,7 @@
>   #include <linux/suspend.h>
>   #include <linux/syscore_ops.h>
>   #include <linux/tick.h>
> +#include <linux/units.h>
>   #include <trace/events/power.h>
>   
>   static LIST_HEAD(cpufreq_policy_list);
> @@ -1708,6 +1709,16 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>   		return new_freq;
>   
>   	if (policy->cur != new_freq) {
> +		/*
> +		 * For some platforms, the frequency returned by hardware may be
> +		 * slightly different from what is provided in the frequency
> +		 * table, for example hardware may return 499 MHz instead of 500
> +		 * MHz. In such cases it is better to avoid getting into
> +		 * unnecessary frequency updates.
> +		 */
> +		if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> +			return policy->cur;
> +
>   		cpufreq_out_of_sync(policy, new_freq);
>   		if (update)
>   			schedule_work(&policy->update);
