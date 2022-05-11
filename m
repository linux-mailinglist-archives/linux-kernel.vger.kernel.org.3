Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBF522A41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbiEKDQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbiEKDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:16:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB03BBF1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:16:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s16so650036pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=351fsulzgIB9s45r5aDOm6WnMH7u9ny+vycNfOOPWQs=;
        b=KiltleuwVgGeRkRv9NEZxDAhsZnrsI0rvrspNE5rpKFJHuJJCryNVRWRascDsZP5+c
         VgFWYsZXNZ1KTwYc4JqZL/sr4jK9ZcbGO4knq5y+y4yaqst6dPDXf3BWKwC4Q4Le0L5h
         sFVKbTCnZZDE25GFlNbrOktAR5o9nZY6Lrvby1msNEMQ9P7CpnnnDLuML9KHXDSNWdTJ
         LWmPxBu7Cu0zXHQDQMWmd6fka+7E4MPgEqTY6MXCVJE9yOgzfUK4vQV2rpAoL/jtz+mz
         GDdygl97K77j7WecH0qaNLnLGsheZN98PYga879q41+ohCQkzAsmUzWot4ir+6p2qw3c
         dlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=351fsulzgIB9s45r5aDOm6WnMH7u9ny+vycNfOOPWQs=;
        b=7cv9ivkt7T8dwfkPkG2xUNOvqyhKPlZy+/HJz3bKEzgiM6Jz4YOvKhOzpVyUSJfm3W
         5XNPHoIvx3ksjCqTnzuH/53/3OphE4qXLIrhY/1DCvGkUDfFUxX8F5djgUfn27v335Gk
         tcmFScCbXtNoLAju0rEkOH4pfLAgGaMoMorXaMhrCuoEkDMSZ1IlFZWlKRBRA9EG7xEV
         iRyVzhNg9DkOF4fsv3u6RZerwBIxrsI2Nq5Y4A5ff30RYbkH1SCWCm1QOzMb9IDxFnck
         yxQzgS/DGqi812+3UUkgp9Ic/yg04nOmaeI9k7goPCNtPs653AV++QHxhYJ7ygIX/Iqg
         ci8w==
X-Gm-Message-State: AOAM531gd3JLsVQWFvt4l8TJCTLad5BJLhk/z3KWDf+TDJJDmHWlAvm4
        wgEnOnSboAOOJ595DpVy9dGobQ==
X-Google-Smtp-Source: ABdhPJwH9MkjfMSImU0n8xgNYqs/wPiW1E3mNUN0UGgqP2wMeA/84jCkmHUFOVpu/jendWWQERL3Rg==
X-Received: by 2002:a63:6381:0:b0:3c6:4449:fc60 with SMTP id x123-20020a636381000000b003c64449fc60mr18596862pgb.457.1652239005368;
        Tue, 10 May 2022 20:16:45 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0050dd876f5f8sm313012pfm.49.2022.05.10.20.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:16:44 -0700 (PDT)
Date:   Wed, 11 May 2022 08:46:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 21/22] cpufreq: use cpumask_weight_gt() in
 policy_is_shared()
Message-ID: <20220511031642.6isyzny6ldhsj43q@vireshk-i7>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-22-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154750.212913-22-yury.norov@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-22, 08:47, Yury Norov wrote:
> cpumask_weight_gt() is better than cpumask_weight() because it may
> return earlier depending on condition.
> 
> CC: Rafael J. Wysocki <rafael@kernel.org>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/cpufreq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d5595d57f4e5..865cc9e23518 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -214,7 +214,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>  
>  static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  {
> -	return cpumask_weight(policy->cpus) > 1;
> +	return cpumask_weight_gt(policy->cpus, 1);
>  }
>  
>  #ifdef CONFIG_CPU_FREQ

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Though the patch to add cpumask_weight_gt() is still in linux-next and so this
patch should get merged after rc1 is out.

And it would have been nice to know of this dependency in the original mail
itself instead of me searching for it :)

-- 
viresh
