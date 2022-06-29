Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325C560BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiF2VdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiF2VdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:33:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1691102E;
        Wed, 29 Jun 2022 14:33:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 145so2421121pga.12;
        Wed, 29 Jun 2022 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=P2HquEVtI+pw57E6S5i14/TATcUTeLRqaqJNNbt7nE0=;
        b=CeVJygw/0cgsj7YHNS4X+1qw464Ewte+SybrmPFUSN450ZagwqipfmRtK0X2k8H9xY
         QYkX7ftvy3KaR9CSIO2HftOREwGS3n7gaWivdN9jfFyZejnMw0bWB0ANjLJU2DNoCFHv
         54h928XSvgR3GV6ZFAt1OlsYtzL2qMyqDdO/DKBK+Ywr5cW8hgnDwb9/YpS4m5J26pT4
         HvVNI2o8efGYg1R/SaNDYRXRaI3TmmeRdD/uylI4qmh00KEnx9pUyGVBhwh1bTkwhod/
         Lwr7N1CcfaWGYpLir9nUPRIuLS8yA3mnUgr0B/G8f02E+oIDPBnraVgk83e4PsHQ1V0/
         OC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P2HquEVtI+pw57E6S5i14/TATcUTeLRqaqJNNbt7nE0=;
        b=FYmVCteErxzEZP8gI1rhi5R3Hs/i+KgPVfdTt7CaVaCkVukLv991/o/iNBnAqJ79AW
         jwdU/B8Hp9A9MuT4y9vbb7DeIPbfVZnGkPZzC8GkWc2FEYRWV9l/4cCLlB97vZztSgop
         j7ZswejvqNcjYFb2KR2rsw6hS324e9gzMhbe3YiuHrZ53XXJah/aYyMTa68raOQGlu7f
         CzrIfyGpIfoMZ+h6ArkxqFR/F/8j+Ya1jPqXlUxW+jyugLrS9Qk3m1UquJVzhG+mMlce
         Lv3d9VwXQYzRqvjG9gkZ0eGe5+k78zLsQkJYazk3tv4nPn8yK8dqISZjMh9Z6C16jSfc
         ECRA==
X-Gm-Message-State: AJIora8/TyQ+2kOxVUwEkKat2KhI0inCaA6UlKrvpdHY6FkYcUDKpEJv
        zhCprrD4ypmcN7G7yzOUyyA=
X-Google-Smtp-Source: AGRyM1ucrUKB6ebsaq/gmawyS9muFOGtlInub9/s2LxqaW7A+prAT68k/ANdVjAqG528BJQuSA3DUw==
X-Received: by 2002:a05:6a00:b45:b0:525:7ad2:91a7 with SMTP id p5-20020a056a000b4500b005257ad291a7mr11974724pfo.22.1656538388446;
        Wed, 29 Jun 2022 14:33:08 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i1-20020a625401000000b00527dba9e37bsm2675845pfb.73.2022.06.29.14.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 14:33:07 -0700 (PDT)
Message-ID: <6256a27e-58fc-1c72-be93-f203feb79b0a@gmail.com>
Date:   Thu, 30 Jun 2022 06:33:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PM / devfreq: Fix kernel warning with cpufreq passive
 register fail
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220619222939.32029-1-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220619222939.32029-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 20. 07:29, Christian Marangi wrote:
> Remove cpufreq_passive_unregister_notifier from
> cpufreq_passive_register_notifier in case of error as devfreq core
> already call unregister on GOV_START fail.
> 
> This fix the kernel always printing a WARN on governor PROBE_DEFER as
> cpufreq_passive_unregister_notifier is called two times and return
> error on the second call as the cpufreq is already unregistered.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/governor_passive.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 72c67979ebe1..8055801cf182 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -336,7 +336,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>  err_put_policy:
>  	cpufreq_cpu_put(policy);
>  err:
> -	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
>  
>  	return ret;
>  }

Applied. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
