Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6F4748F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhLNRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhLNRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:10:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CDC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:10:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q17so14004047plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2RVSJpdSrOMO+Ud0zcnlzEGiRYwyXEk9MXea2dveug=;
        b=mRXPTAH5cG3J70WUMLAE9svKToKgHT5VrNSe7pxtPbGn8oT0DdktrYBFNndLKyw4gE
         m2ttzS1mv+85znp21RyeZpH0MDvHNN6x0LGSVraNtiBX7TpKJ+w6hrdpCJhakS15H/6y
         XFUKtyjg6XBKlQdtYB4gWhfmU4FDewKKNceNwIq687P7lu9o/cMwQ5YK1CGDgBLRpyKy
         tT0mBPdjYqLzIPEGeGQbVufnDPoLieAO0F3F1Kb20nlAqyTE2DN+nYrLlyX7hG+4S+Bi
         kZNa/Sg78bffDpVO/2nY5ukIxQCEej7VPnwIjtIoLhstldT8kji3o/ZMfzPsf9Y+Zg5G
         f4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2RVSJpdSrOMO+Ud0zcnlzEGiRYwyXEk9MXea2dveug=;
        b=Rrq5WhVBf0V23GBbozVALWdsoEgm2hSMth6wReLbS1K1djhIC0lg/zlkRXFBF/xrW3
         1yZubnGCYab2XLR30hRCDSncJUKT5gtMvyMo9fJhU0IhZTzFEW/TaYQM3wEzzZ5fHUEq
         J+4IGA83+O3HYn5UnXkx/hokc2XIOyrKdO9RdgQrg/WN4vJnIKSY5pcc+DDkuXrFU16h
         jvWKV7bcnx2qfSxEfPM6B5TYlFhPyQLCEOrymWIHw7ZA6ciJooP5KipvbN99YrWU3NiN
         ciDwRhFlho0X0Xvh8YxOS/2K++889k088B+PaTwko8v6xnjQgP0vDPYkdDiQzgJ6T3Fb
         ktKg==
X-Gm-Message-State: AOAM5322VRb+1HUN88NEJZAbF25DFb6mR5wzeeZJjAR6dgreHeNtuwne
        Ns+n/mTwOX/TXyfo5POwqBDwGw==
X-Google-Smtp-Source: ABdhPJysAqqaP7kJx6wd1gL0M8YYyVnEXvAVkKn6JRw772Dl7xV+NahFt15Q4IHNjwI0LG0F69xAgw==
X-Received: by 2002:a17:902:bc85:b0:143:954e:8548 with SMTP id bb5-20020a170902bc8500b00143954e8548mr7081011plb.82.1639501838167;
        Tue, 14 Dec 2021 09:10:38 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 78sm268850pgg.85.2021.12.14.09.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:10:37 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:10:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        hushiyuan@huawei.com, luolongjun@huawei.com, hejingxian@huawei.com
Subject: Re: [PATCH v2 1/7] x86/apic/x2apic: Fix parallel handling of
 cluster_mask
Message-ID: <YbjQCf29BH7aTblP@google.com>
References: <20211214123250.88230-1-dwmw2@infradead.org>
 <20211214123250.88230-2-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214123250.88230-2-dwmw2@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, David Woodhouse wrote:
> -static int alloc_clustermask(unsigned int cpu, int node)
> +static int alloc_clustermask(unsigned int cpu, u32 cluster, int node)
>  {
> +	struct cluster_mask *cmsk = NULL;
> +	unsigned int cpu_i;
> +	u32 apicid;
> +
>  	if (per_cpu(cluster_masks, cpu))
>  		return 0;
> -	/*
> -	 * If a hotplug spare mask exists, check whether it's on the right
> -	 * node. If not, free it and allocate a new one.
> +
> +	/* For the hotplug case, don't always allocate a new one */
> +	for_each_present_cpu(cpu_i) {
> +		apicid = apic->cpu_present_to_apicid(cpu_i);
> +		if (apicid != BAD_APICID && apicid >> 4 == cluster) {
> +			cmsk = per_cpu(cluster_masks, cpu_i);
> +			if (cmsk)
> +				break;
> +		}
> +	}
> +	if (!cmsk) {
> +		cmsk = kzalloc_node(sizeof(*cmsk), GFP_KERNEL, node);
> +	}
> +	if (!cmsk)
> +		return -ENOMEM;

This can be,

	if (!cmsk) {
		cmsk = kzalloc_node(sizeof(*cmsk), GFP_KERNEL, node);
		if (!cmsk)
			return -ENOMEM;
	}

which IMO is more intuitive, and it also "fixes" the unnecessary braces in thew
initial check.

> +
> +	cmsk->node = node;
> +	cmsk->clusterid = cluster;
> +
> +	per_cpu(cluster_masks, cpu) = cmsk;
> +
> +        /*
> +	 * As an optimisation during boot, set the cluster_mask for *all*
> +	 * present CPUs at once, to prevent *each* of them having to iterate
> +	 * over the others to find the existing cluster_mask.
>  	 */
> -	if (cluster_hotplug_mask) {
> -		if (cluster_hotplug_mask->node == node)
> -			return 0;
> -		kfree(cluster_hotplug_mask);
> +	if (system_state < SYSTEM_RUNNING) {

This can be

	if (system_state >= SYSTEM_RUNNING)
		return 0;

to reduce indentation below.

> +		for_each_present_cpu(cpu) {

Reusing @cpu here is all kinds of confusing.

> +			u32 apicid = apic->cpu_present_to_apicid(cpu);

This shadows apicid.  That's completely unnecessary.

> +			if (apicid != BAD_APICID && apicid >> 4 == cluster) {

A helper for retrieving the cluster from a cpu would dedup at least three instances
of this pattern.

> +				struct cluster_mask **cpu_cmsk = &per_cpu(cluster_masks, cpu);
> +				if (*cpu_cmsk)
> +					BUG_ON(*cpu_cmsk != cmsk);
> +				else
> +					*cpu_cmsk = cmsk;

The if statement is a little confusing because of the double pointer.  BUG_ON()
won't return, maybe write it like so?

				BUG_ON(*cpu_mask && *cpu_mask != cmsk);
				*cpu_cmsk = cmsk;

> +			}
> +		}
>  	}
>  
> -	cluster_hotplug_mask = kzalloc_node(sizeof(*cluster_hotplug_mask),
> -					    GFP_KERNEL, node);
> -	if (!cluster_hotplug_mask)
> -		return -ENOMEM;
> -	cluster_hotplug_mask->node = node;
>  	return 0;
>  }
>  
>  static int x2apic_prepare_cpu(unsigned int cpu)
>  {
> -	if (alloc_clustermask(cpu, cpu_to_node(cpu)) < 0)
> +	u32 phys_apicid = apic->cpu_present_to_apicid(cpu);
> +	u32 cluster = phys_apicid >> 4;
> +	u32 logical_apicid = (cluster << 16) | (1 << (phys_apicid & 0xf));
> +
> +	x86_cpu_to_logical_apicid[cpu] = logical_apicid;
> +
> +	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
>  		return -ENOMEM;
>  	if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
>  		return -ENOMEM;
> -- 
> 2.31.1
> 
