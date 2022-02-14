Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C394B5B99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiBNUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:54:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiBNUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:54:17 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E45BC9B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:51 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p7so15816449qvk.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RIas+GyVDApC3xDrXULa8rp+llTjzXjwfENj9r1hIhE=;
        b=qFTlR0PWa747IABqwNN/t8GNIse7KZphJV5hb5vFFtsGpXNfVaZtn7Hyjm+JfpF+eM
         mwYqBmTgvYY3zZ4WSa+5bokDrFUpN7LCfTNJea82vfqeTF7DiUI/At97Ha0OfuhKOi2a
         kUslq1/4r5JPlE/qXy4lnJ633NCJXlUuUpnDPyHDOV/oan3sqPcVJtF9W/WJKHxQyIOW
         d9XCPDQq0pyvfqbLp2iRBcG388aYhHJSmKOKTiWQBPQF+0TwuuWX50jn02l1qrFbWPhM
         +5T3jqdNitbG8jENnTpfEbraUbFJMa6bB9obQOAIilKXLCuvDPYffS7y0NNe6N1qCirQ
         9VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RIas+GyVDApC3xDrXULa8rp+llTjzXjwfENj9r1hIhE=;
        b=haYJ4q+lKuxiwELkAWkvWgrhi2OlnWSL1OFTotOaJzpNFmobMRozmsuvnm/K1yYQjv
         CidqtvhKc1LTZnc9L83pEzI0xqEYEeBUEUMb13iBXrSBe8CPO3r3Lv4gPifEeknovxLJ
         9fWGg/SmndibRt9bWawYT7QvT7/eeG4ffXJ+bHCTuworzTgqNEi+9rpuOKbWdyeZ+RzR
         QZzqwbMbr2p/nsHKyLvpv5YxZKS2/ZyXFl1Whsn9kOZ2XpYTrnfdUFflCWZJXqg+lDgd
         X/3YroRD+SiSZXcR66sGHz5Op5cJcXtXpzj3xc0QMKVXAsPZ4uc4ageHf7QQHP/aZrVN
         fAAQ==
X-Gm-Message-State: AOAM533GgKrPotYK5Mpfw27fRsYUhuB4vCVFbXmzcd90zvIBTjlI4cxo
        0U9BhSXiEkC55wRsZal+oUE0KG02tec=
X-Google-Smtp-Source: ABdhPJx5efBjjZxkoqMiDNkblXbHgtDCztk7rsHet1nW179xwlXvIPgrOUzNy2Dwc6k6XC2SXQOJRA==
X-Received: by 2002:a17:903:283:: with SMTP id j3mr393533plr.132.1644867834186;
        Mon, 14 Feb 2022 11:43:54 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q2sm39651861pfj.94.2022.02.14.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:43:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 09:43:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] workqueue: Fix race in schedule and flush work
Message-ID: <Ygqw+EHo//6VGs6q@slm.duckdns.org>
References: <20220210184319.25009-1-treasure4paddy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210184319.25009-1-treasure4paddy@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 33f1106b4f99..a3f53f859e9d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3326,28 +3326,38 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
>   */
>  int schedule_on_each_cpu(work_func_t func)
>  {
> -	int cpu;
>  	struct work_struct __percpu *works;
> +	cpumask_var_t sched_cpumask;
> +	int cpu, ret = 0;
>  
> -	works = alloc_percpu(struct work_struct);
> -	if (!works)
> +	if (!alloc_cpumask_var(&sched_cpumask, GFP_KERNEL))
>  		return -ENOMEM;
>  
> +	works = alloc_percpu(struct work_struct);
> +	if (!works) {
> +		ret = -ENOMEM;
> +		goto free_cpumask;
> +	}
> +
>  	cpus_read_lock();
>  
> -	for_each_online_cpu(cpu) {
> +	cpumask_copy(sched_cpumask, cpu_online_mask);
> +	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask) {

This definitely would need a comment explaining what's going on cuz it looks
weird to be copying the cpumask which is supposed to stay stable due to the
cpus_read_lock(). Given that it can only happen during early boot and the
online cpus can only be expanding, maybe just add sth like:

        if (early_during_boot) {
                for_each_possible_cpu(cpu)
                        INIT_WORK(per_cpu_ptr(works, cpu), func);
        }

BTW, who's calling schedule_on_each_cpu() that early during boot. It makes
no sense to do this while the cpumasks can't be stabilized.

Thanks.

-- 
tejun
