Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2D58D702
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiHIKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbiHIKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838CE21E1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660039332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQ4rx3p2EcFXQ1V5iVeBvBViEa90MF16sMNOOJrJ4ZY=;
        b=TDVLhPFUWTPmUAtj4rx8UuRmd7wsibOtfNqIFDa2dFb90rmduo8AwjIBGfwzfqvRVRsyRD
        FnNxzyAeff9F0H8b0U/Z5h8dBJ66euSe/OxKzIrX9RYCH3+udH/pXVBYew39j7k+P1XMiH
        AIGM7oRNUiiuMm5MSpElsWtDyUk2GaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-L4opxke5M7GWzXJapHC_cw-1; Tue, 09 Aug 2022 06:02:11 -0400
X-MC-Unique: L4opxke5M7GWzXJapHC_cw-1
Received: by mail-wm1-f69.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so102009wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=JQ4rx3p2EcFXQ1V5iVeBvBViEa90MF16sMNOOJrJ4ZY=;
        b=Hutdb0CKmQgErR53uXPoh7gIpiQbBWy1HxuUp8YqnTyFLm5bGVsFLyE00etPlfOfjA
         JIu63fTC4yhACH+arxW6ii9/pW4IdLH021keWGqHtqHnA3bx0/6Ze3icilhNfXZjTo3J
         CXlOM/bxXbTe9kjbX8t3SA1iCs5kW59N2VOc/6JF29KEVyxSbKN1+Pb/EoL5RLitQ1yC
         zZmZaYV43zCJAm7yfCS28fV/R6lXnR0SloS24J5qklLkgf2WaYZEdyzxKnQmL18T4Jzt
         3IzN7QoXsVGap5Or/gSUWREiaqRqx0incMG3ARfnuk/Q4UbzoY/x+oxgGCzx6AadV9T0
         ZQDQ==
X-Gm-Message-State: ACgBeo2lPMSzY8O/VX8MlScYe6zGOKPVqvcf/0GOqQWAyg1N3LFFLaJY
        T6cvPtsadoXMzA5Ys0+1GENd1mQfGkMN/gbpLVA9LpTEq17KAZtI5+ePbnRZc47lIzIEFruNQzN
        ftNBtz7dLE/QRMH75uI6CQf9ewlpx0yJJmfG1GJnDYCaKRHDvqU0NecRbvRoGpnd8Q+dW3tSKGn
        P0
X-Received: by 2002:a05:600c:4e41:b0:3a5:1a0c:c52 with SMTP id e1-20020a05600c4e4100b003a51a0c0c52mr12748590wmq.51.1660039329914;
        Tue, 09 Aug 2022 03:02:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6tm2HzECoaWBmuka51DwVtiBM0cqXZcsf+uzA99fhRZwJPX20Dz1mrLQVRih/G0pCKAWwPSQ==
X-Received: by 2002:a05:600c:4e41:b0:3a5:1a0c:c52 with SMTP id e1-20020a05600c4e4100b003a51a0c0c52mr12748545wmq.51.1660039329572;
        Tue, 09 Aug 2022 03:02:09 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a32297598csm21171607wmq.43.2022.08.09.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:02:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V4 1/3] sched/topology: Add NUMA-based CPUs
 spread API
In-Reply-To: <df8b684d-ede6-7412-423d-51d57365e065@gmail.com>
References: <20220728191203.4055-1-tariqt@nvidia.com>
 <20220728191203.4055-2-tariqt@nvidia.com>
 <xhsmhedxvdikz.mognet@vschneid.remote.csb>
 <df8b684d-ede6-7412-423d-51d57365e065@gmail.com>
Date:   Tue, 09 Aug 2022 11:02:07 +0100
Message-ID: <xhsmh35e5d9b4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/22 17:39, Tariq Toukan wrote:
> On 8/4/2022 8:28 PM, Valentin Schneider wrote:
>> On 28/07/22 22:12, Tariq Toukan wrote:
>>> +static bool sched_cpus_spread_by_distance(int node, u16 *cpus, int ncpus)
>>                                                         ^^^^^^^^^
>> That should be a struct *cpumask.
>
> With cpumask, we'll lose the order.
>

Right, I didn't get that from the changelog.

>>
>>> +{
>>> +	cpumask_var_t cpumask;
>>> +	int first, i;
>>> +
>>> +	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
>>> +		return false;
>>> +
>>> +	cpumask_copy(cpumask, cpu_online_mask);
>>> +
>>> +	first = cpumask_first(cpumask_of_node(node));
>>> +
>>> +	for (i = 0; i < ncpus; i++) {
>>> +		int cpu;
>>> +
>>> +		cpu = sched_numa_find_closest(cpumask, first);
>>> +		if (cpu >= nr_cpu_ids) {
>>> +			free_cpumask_var(cpumask);
>>> +			return false;
>>> +		}
>>> +		cpus[i] = cpu;
>>> +		__cpumask_clear_cpu(cpu, cpumask);
>>> +	}
>>> +
>>> +	free_cpumask_var(cpumask);
>>> +	return true;
>>> +}
>>
>> This will fail if ncpus > nr_cpu_ids, which shouldn't be a problem. It
>> would make more sense to set *up to* ncpus, the calling code can then
>> decide if getting fewer than requested is OK or not.
>>
>> I also don't get the fallback to cpumask_local_spread(), is that if the
>> NUMA topology hasn't been initialized yet? It feels like most users of this
>> would invoke it late enough (i.e. anything after early initcalls) to have
>> the backing data available.
>
> I don't expect this to fail, as we invoke it late enough. Fallback is
> there just in case, to preserve the old behavior instead of getting
> totally broken.
>

Then there shouldn't be a fallback method - the main method is expected to
work.

>>
>> Finally, I think iterating only once per NUMA level would make more sense.
>
> Agree, although it's just a setup stage.
> I'll check if it can work for me, based on the reference code below.
>
>>
>> I've scribbled something together from those thoughts, see below. This has
>> just the mlx5 bits touched to show what I mean, but that's just compile
>> tested.
>
> My function returns a *sorted* list of the N closest cpus.
> That is important. In many cases, drivers do not need all N irqs, but
> only a portion of it, so it wants to use the closest subset of cpus.
>

Are there cases where we can't figure this out in advance? From what I grok
out of the two callsites you patched, all vectors will be used unless some
error happens, so compressing the CPUs in a single cpumask seemed
sufficient.

