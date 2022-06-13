Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DD548330
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiFMJQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiFMJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:16:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794AD186D5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:16:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso2488441pja.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJRfqg9HkN44fleneYTjJ9EnvdcW4R72qwZ/V7VQbac=;
        b=yK1nHi6rzbvXAKNIcrov1WBs9NwS2Rm6W++7rkBo4BaVm+B3JADgPP0nDXG4CvTAy4
         gQ9j4714xGwpKQugwUXXfXlnJ9UPeADjhha06PG5nNCbxcomKKU27sct3u8jiR1o1BpU
         Hfo5Z7NRsVqp4iEqRYdncmV/8HBy5ZEgWWcQAPQ/V0sJHxTUXjzJN3sKKflDBBT4RWF9
         freNEFqlzSKqQ7vWzVzWZ1Yq+2eFSkEMHmQ0KdFJnrupAAaqnZ1BjSa6zbpUSqeq3AVP
         XisXB7ClYbFWJ1McwakTDgkVwOFbV5ntDZNTOZ49Obkq09YJDYbPQV/L3VjW13cGOOYB
         RsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJRfqg9HkN44fleneYTjJ9EnvdcW4R72qwZ/V7VQbac=;
        b=HkbLySIEGei2pI/z0ksVH1O0mbqPdSix2PI2QFPIEu8O871vwcEpmYV23sfxOk5y2k
         Cd25RwaqadWVX9tuD7bM4JUhbre7Qa/5R7IMQ2S1KwIiftwYBHW7QJS1AacLVuF+Uc8u
         goxHspj8ufUP65XRVtf6n5j2plLzD7epKLR7Vq2ozwmSAgQv7+Ku3o53bHmKMWV90EH9
         ZIWufcEvq/wQ3yxcT09f2K8hZObArG0yYRuC0sLxWOl9Bt7/CV4E49Sy8aNgeP3SENED
         ftxa93GhOF3y+mPRt5guYfHUtjQt/fLnqc7RAikGw48tJEUDOqy6V2/2mt6e4ic2Qfho
         ryOA==
X-Gm-Message-State: AOAM533zxdeyFMkgb1GWqbzaG4+xmwMXVMnzW+N8VBWfbgVSjCIwtvQW
        3R3tUYSAoKp/69Oe62zlUOOGYRzQxC4IlQ==
X-Google-Smtp-Source: ABdhPJw6QO957bc2HczxS1WBwNhGY0B3tBN10voJ7BMxQqeJq+tDzl5TYSttMmzrGnG7G3GMuqxR8A==
X-Received: by 2002:a17:90b:35c8:b0:1ea:4cec:62d4 with SMTP id nb8-20020a17090b35c800b001ea4cec62d4mr14477584pjb.156.1655111773997;
        Mon, 13 Jun 2022 02:16:13 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id v29-20020a63b95d000000b003c14af5060fsm4797737pgo.39.2022.06.13.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:16:13 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:46:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/3] thermal: cpufreq_cooling: Use a copy of local ops
 for each cooling device
Message-ID: <20220613091611.ncd2hziu4nbyip4x@vireshk-i7>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610100343.32378-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 11:03, Lukasz Luba wrote:
> It is very unlikely that one CPU cluster would have the EM and some other
> won't have it (because EM registration failed or DT lacks needed entry).
> Although, we should avoid modifying global variable with callbacks anyway.
> Redesign this and add safety for such situation.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b8151d95a806..e33183785fac 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -554,7 +554,12 @@ __cpufreq_cooling_register(struct device_node *np,
>  	/* max_level is an index, not a counter */
>  	cpufreq_cdev->max_level = i - 1;
>  
> -	cooling_ops = &cpufreq_cooling_ops;
> +	cooling_ops = kmemdup(&cpufreq_cooling_ops, sizeof(*cooling_ops),
> +			      GFP_KERNEL);

I don't like the way we are duplicating the ops here. Instead of this it would
be better to add the OPs field in the cooling device structure and fill its
fields from here. The ops structure will be allocated with the cooling device
itself.

-- 
viresh
