Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147BE4BE3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355066AbiBUKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354936AbiBUKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:33:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4637030;
        Mon, 21 Feb 2022 01:54:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i11so17571366lfu.3;
        Mon, 21 Feb 2022 01:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FBQCAwLGItt59fBHH1fMX/rXCxY4p1v9wuPJWfMr/EE=;
        b=OMjFpUKSoI/8tDW559i/11H2ijvy+X7Cyy6+WRTh9BpYhAd0ESthUOs21QFcduRLUX
         tGwZzFtj90IC1hBoKntcyQvsn11UKiofViSoSA/V7l/NNjHPUvvL4b9XTN6qSrbYDpLs
         gbdjvTfYbe7a8VYjZFTFv0/F88nhCwe5RCFWeRMN79SOD+ga3jJgJPl85LdsYhffSx9O
         f0KieNs5r3M64JzpMGPsA6JxAEaFgRZUxnb+MT8MmRvmkHQVofikUxrarsiCe+saU+TX
         qmZ7towRvoIrZdYqqnFpWmWme6fYEZVk2g784cMY0LEkmtGG9Zj/XjfRtzaUPbkWq6VZ
         9gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FBQCAwLGItt59fBHH1fMX/rXCxY4p1v9wuPJWfMr/EE=;
        b=fzErLDosCq+yQQvdLCzy/3VRe9IRWl+osHQBZeYNE2mQxEv2mE3SyJF+A+oWnqzOPh
         rM80g//N+ucPKltopcs9e4kc99D9wo4SNF7lJT/gA8TrjOEHr9Ui6G7btCgoXKXmDwcH
         gYnU3cisUjj/vdlSGE3xN5uirrd+BHkFi8w5UHr0259ii+/u7MOc1FSj/TRcgYgLJikE
         7haNkEd3+9iEPof8o0nkMECt/+0mfUltTwtJwUhP7kUB7VEq27cXKGpj8PSmVgGJUdRD
         n2kI/eKV3AeylL/gs5O38eE9lYWtVaMSicpGYRbDWdDqiOPlm/3v+2QfISGd2dXxS6QV
         or0Q==
X-Gm-Message-State: AOAM530vmvEOfc/fUZYeXyNYEcIkPmF/AMvup+TQfyBIwa5QJaInCR6A
        mD2KvR1cku940Ds7rkgbnto=
X-Google-Smtp-Source: ABdhPJyjpoLC4dkht2ubnC2fLVCm11jEQES+SqN3/jJaPUC4j1RTjBwAfYihJh/DiezuaKLTQVLqDw==
X-Received: by 2002:a19:4f02:0:b0:441:39df:161c with SMTP id d2-20020a194f02000000b0044139df161cmr13408076lfb.504.1645437240280;
        Mon, 21 Feb 2022 01:54:00 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id q12sm1066973lfr.157.2022.02.21.01.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:53:59 -0800 (PST)
Message-ID: <677beebd-5a16-297f-c09a-fa4b72c001c9@gmail.com>
Date:   Mon, 21 Feb 2022 12:53:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 21/40] pwm: tegra: Add runtime PM and OPP support
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-22-digetx@gmail.com>
 <20220221081727.jeq2jff5ewjzubxv@pengutronix.de>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220221081727.jeq2jff5ewjzubxv@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

21.02.2022 11:17, Uwe Kleine-König пишет:
>> @@ -344,7 +387,10 @@ static const struct of_device_id tegra_pwm_of_match[] = {
>>  MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
>>  
>>  static const struct dev_pm_ops tegra_pwm_pm_ops = {
>> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_pwm_suspend, tegra_pwm_resume)
>> +	SET_RUNTIME_PM_OPS(tegra_pwm_runtime_suspend, tegra_pwm_runtime_resume,
>> +			   NULL)
>> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +				pm_runtime_force_resume)
>>  };
>>  
>>  static struct platform_driver tegra_pwm_driver = {
> I admit to not completely understand the effects of this patch, but I
> don't see a problem either. So for me this patch is OK:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I spot a problem, it's not introduced by this patch however: If the
> consumer of the PWM didn't stop the hardware, the suspend should IMHO be
> prevented.

Why? The PWM driver itself will stop the h/w on suspend.

> I wonder if the patches in this series go in in one go via an ARM or
> Tegra tree, or each patch via its respective maintainer tree.

This series, including this patch, was already applied to 5.17 via the
tegra/soc tree. No action is needed anymore.
