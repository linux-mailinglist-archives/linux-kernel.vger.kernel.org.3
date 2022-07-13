Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F8572D52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiGMFcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiGMFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:31:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC52B9DAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:29:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso1874035pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=73CbFZyz5/Oh4NJ0Bvz1lGW0c6O6K5fxXQrseozXHcw=;
        b=Rbrcne9hJO5zFt0sQ2gZynRRzzWRe5SVR1wRHlRMHAKMVaSR6X+f7wxY71QYwDLec5
         s1z9K4AKE3ujnTmHO73UkxpIQcmIopjo41Z9xVevoud6Y6vZagu0xcBbMD8l4JZtcqYA
         eidITirbBSI0SmJx9c5CY2c3yzVBlDgFSPxAkbPnxz8wdCsVE3EBxJRs17Ih9ca1Jk/1
         7sGzaQqZEthak1timNppoSF+bPzgKtq3FSNQHLZk8mJoxTEwWDvitnTP5Kcac0JeTYEY
         BBN32x3b30jEKItgp+Seb0c+QCGKPsdYwz4eOjF2zQD8xoA55OtPd7ycjv6siuOA/KIK
         t/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73CbFZyz5/Oh4NJ0Bvz1lGW0c6O6K5fxXQrseozXHcw=;
        b=t/mLykSLcQWYsipQsH77L2USpZ2zg80t2XS6PAm6rZ4Hespdj60EnsbcFmWt0Mg/8z
         ysQCer0DwTt8/E1T9WrIblLv2FloAzAHhyvoH0Ui8AUa6nmgRgkWbcQO32wShnR218FL
         LN1zu29WRYVz33LLEUcd9dd+/rGWs4YF7ybsd3zwtQp2e1Fx8rjg7I3C3OKBZb18HXqW
         meupjKWpkXZ55QnqyJ9qA1YXKEhpfwpPBRRgd6Tv4bsZpUwXGFoFzbzLdbF52XzON4aL
         HTb8EXkoNJCdVYiE5KpytBGKr2sGHMOtEiLn4zd5wXbl0OB1gaxIho8s9urdz4f9jdMO
         aBDA==
X-Gm-Message-State: AJIora/usPbTvobxHQtw+wuxWgYw4kUzNGJwvjEGE9QCx3F7XyKg4dsE
        boLKx6y8ikm3X82n7OIsbtKdig==
X-Google-Smtp-Source: AGRyM1suN/HlXdQcKewriih20qhQdaYhuVcOHxFq9ixS+8B1rNZ4ZjRmQjrryfvQPl5jijyUwIbL5Q==
X-Received: by 2002:a17:90b:4c8c:b0:1ef:bff6:c964 with SMTP id my12-20020a17090b4c8c00b001efbff6c964mr1892390pjb.36.1657690188493;
        Tue, 12 Jul 2022 22:29:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b0016a1e2d148csm7809072pls.32.2022.07.12.22.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:29:48 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:59:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 13/13] cpufreq: CPPC: remove the acpi_disabled check
Message-ID: <20220713052944.xpk4fi7nuj6rmekd@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <d36d38953cf819d89eb9be4d1a2baa5b5feeb52a.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36d38953cf819d89eb9be4d1a2baa5b5feeb52a.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:43, Perry Yuan wrote:
> "acpi_cpc_valid" function already includes the acpi_disabled check and we can
> remove the duplicated check here
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..9adb7612993e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
>  
> -	if ((acpi_disabled) || !acpi_cpc_valid())
> +	if (!acpi_cpc_valid())
>  		return -ENODEV;
>  
>  	cppc_check_hisi_workaround();

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
