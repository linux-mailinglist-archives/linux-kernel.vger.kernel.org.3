Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240234DBDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 05:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiCQE4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 00:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiCQE4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 00:56:02 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEFA1BA692
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 21:37:33 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id gm1so3450838qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7smyLFvHz2Kxey0W+Yi7oN5ICRziKPJC1LjV5NQwwk=;
        b=KemArhaWTIVubPvMsIMQ8OlKGpoQDmo1ZZvhcN6gDYzj3bp37U2sI8SYEvB8h546r+
         v/fcNlo0HEBe40u5ftBopH13Nu3Ut74gyGyves4UQhGZw0afG849ELCeT51K7OphAgxE
         MqHUnL/WaDThCJiDKVvXKnIiUH+93YEPokJS5k+KtgyZyjwXoYsjDgQLMrT6jmXkNwKF
         26hlKxTWIR6aGsUm+DPNf35VJS7ZmekGDLbdXbIFGL9/1jvwblv93a4DbEZ/nyDGsr89
         +vh+jLwe4L6/KAodk4fycFAbdpUbkbJ+Ooi2JZSZ5dL4UHaTblChfnfNBuM8vjdIDyWq
         94HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7smyLFvHz2Kxey0W+Yi7oN5ICRziKPJC1LjV5NQwwk=;
        b=6ln+FGJ+ddi+4rFPWdJ6qii0w6FVoO1lC4UWArHrIsrjr3jbAWoVi1Ep6OGVUHw5Tv
         flzuzhWIh/bex8PzZY1v3uT6odHedmZxmVffO0ZyKzTsuym1owILGxn29uQak4gf5fye
         xqOQeecqavG+LdKrKJl405g/0kI7m69CFZKxm2P/+1pEYVLUVdtSeRwUmC6jthOD3Be2
         efpHDIjyDcwIFxDSCJ5n0oyEN2Sv80QiMpypLEqoWiNPVPcyIS60yvqpiXg+TnjblGWp
         ZltLw+ouz5us7q+446Z4mhYHfa6vPSHaayMLjXcxbGrts5r3D4jKKy4XsqbQFyfoHsVY
         bgPw==
X-Gm-Message-State: AOAM530Ah/ljyx5i99H14TwShJtGnVBcOdfpNbK0ThDQBESN5QH2Oucu
        IvAP/UOPFMA1jWyulTsalj8UFDxRMw+nig==
X-Google-Smtp-Source: ABdhPJyGO6HDpoqeNPuTMyPE4VKjjOoL2RhB+3LchyawYMdBOmrYAbi19m1JeKQ8UBgHzgLUX1tdPA==
X-Received: by 2002:a17:903:1c9:b0:153:6e7:d505 with SMTP id e9-20020a17090301c900b0015306e7d505mr3138053plh.69.1647489839811;
        Wed, 16 Mar 2022 21:03:59 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a000cc500b004f6ff0f51f4sm4883441pfv.5.2022.03.16.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 21:03:59 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:33:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Ray.Huang@amd.com
Subject: Re: [PATCH] cpufreq: powernow-k8: Re-order the init checks
Message-ID: <20220317040357.l4k6h5oh5awwxicn@vireshk-i7>
References: <20220316215548.6013-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316215548.6013-1-mario.limonciello@amd.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-22, 16:55, Mario Limonciello wrote:
> The powernow-k8 driver will do checks at startup that the current
> active driver is acpi-cpufreq and show a warning when they're not
> expected.
> 
> Because of this the following warning comes up on systems that
> support amd-pstate and compiled in both drivers:
> `WTF driver: amd-pstate`
> 
> The systems that support powernow-k8 will not support amd-pstate,
> so re-order the checks to validate the CPU model number first to
> avoid this warning being displayed on modern SOCs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 12ab4014af71..d289036beff2 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1172,14 +1172,14 @@ static int powernowk8_init(void)
>  	unsigned int i, supported_cpus = 0;
>  	int ret;
>  
> +	if (!x86_match_cpu(powernow_k8_ids))
> +		return -ENODEV;
> +
>  	if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
>  		__request_acpi_cpufreq();
>  		return -ENODEV;
>  	}
>  
> -	if (!x86_match_cpu(powernow_k8_ids))
> -		return -ENODEV;
> -
>  	cpus_read_lock();
>  	for_each_online_cpu(i) {
>  		smp_call_function_single(i, check_supported_cpu, &ret, 1);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
