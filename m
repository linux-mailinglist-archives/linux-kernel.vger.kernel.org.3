Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83858DD4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbiHIRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245634AbiHIRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AF0B25287
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660066624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EpsfinQmEWM+SHyZD/utaFr+TSXXqftEifyBCQeGArk=;
        b=JhiHI6G9Q3Rg713hTTgKC+6o3pw78HSSRkgXUSwJAaZEF/q+qprx28EHoZaKguxDc9UnLJ
        s3OI1IvuhZtLRzJCr8sV79eIp7uk14Nw/mcliUO6vpgaKmfYdi5Oly+Z1SdTTTQeBjSzEE
        Kac7hTfIw8ozCEhZJ2s4HBd7klP3jzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ye-AW4zNN32hW3ycAyBOiQ-1; Tue, 09 Aug 2022 13:37:03 -0400
X-MC-Unique: ye-AW4zNN32hW3ycAyBOiQ-1
Received: by mail-wm1-f69.google.com with SMTP id j22-20020a05600c485600b003a50fa6981bso8353199wmo.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=EpsfinQmEWM+SHyZD/utaFr+TSXXqftEifyBCQeGArk=;
        b=7al2eDqbQjkfu9ltUaZS3XtThSbpgeuaonLDoLDQnHpXfbd/TsLc2s9RrQfVTprXOR
         y8uByY+V0Xl5EpjGRWO5ZPXsgZhDiMN8zihCZ6Ypjm8F4Uaa8LR4qw5kGSsziN9dgPTQ
         fPmxTc1phjBD8dIj5lJgG6xSKd9QfG/yk8NumoPA4DBY5tqinqc1jyMMrIcK7Ax+2jY6
         IwxSQvkO/V68UqKAD64bomuNwr7jCj5HtdAGgsrPVFvX54hp3ZRwnooVMPvq9uCZFpxQ
         V+mt+/9UJe1l6a4+0k/Lr8N1OEcJefe+/+V+qcT+fMx7oUQo1Qq87QFRZCYD42JQbhh9
         y4yg==
X-Gm-Message-State: ACgBeo10oEvJcWimz58vF6IIueqEHmSbdS4czdAarBvDJWJuCbi5T9WE
        baDWgejI761usAuDE715coaTAmgGTpcptPDhLjxg+/HrnzNHiVoycQZ5VhEX/FuvWGZwo9paeAm
        CIjKm497yNJ0mm7SlM7cAggrGZgwl5SD28BO2iEEVtUq/PNpKEIh6Jm/94F71NOlSu4YDKgfUU0
        IQ
X-Received: by 2002:adf:ed4f:0:b0:220:5fe9:9995 with SMTP id u15-20020adfed4f000000b002205fe99995mr15127524wro.388.1660066621807;
        Tue, 09 Aug 2022 10:37:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6mkGTB7+aLk5uKplC4+jkPFwpYsueIl6Qwhh9EU9hVZuwEODF0Nc7JyFKPBKl80Pk0ZKkREA==
X-Received: by 2002:adf:ed4f:0:b0:220:5fe9:9995 with SMTP id u15-20020adfed4f000000b002205fe99995mr15127500wro.388.1660066621582;
        Tue, 09 Aug 2022 10:37:01 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b00220606afdf4sm14366974wro.43.2022.08.09.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:37:01 -0700 (PDT)
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
In-Reply-To: <69829c71-d51c-b25f-2d74-5fdd231ed9e4@gmail.com>
References: <20220728191203.4055-1-tariqt@nvidia.com>
 <20220728191203.4055-2-tariqt@nvidia.com>
 <xhsmhedxvdikz.mognet@vschneid.remote.csb>
 <df8b684d-ede6-7412-423d-51d57365e065@gmail.com>
 <xhsmh35e5d9b4.mognet@vschneid.remote.csb>
 <12fd25f9-96fb-d0e0-14ec-3f08c01a5a4b@gmail.com>
 <xhsmhzggdbmv6.mognet@vschneid.remote.csb>
 <69829c71-d51c-b25f-2d74-5fdd231ed9e4@gmail.com>
Date:   Tue, 09 Aug 2022 18:36:59 +0100
Message-ID: <xhsmhwnbhb9ok.mognet@vschneid.remote.csb>
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

On 09/08/22 17:04, Tariq Toukan wrote:
> On 8/9/2022 3:52 PM, Valentin Schneider wrote:
>> On 09/08/22 13:18, Tariq Toukan wrote:
>>> On 8/9/2022 1:02 PM, Valentin Schneider wrote:
>>>>
>>>> Are there cases where we can't figure this out in advance? From what I grok
>>>> out of the two callsites you patched, all vectors will be used unless some
>>>> error happens, so compressing the CPUs in a single cpumask seemed
>>>> sufficient.
>>>>
>>>
>>> All vectors will be initialized to support the maximum number of traffic
>>> rings. However, the actual number of traffic rings can be controlled and
>>> set to a lower number N_actual < N. In this case, we'll be using only
>>> N_actual instances and we want them to be the first/closest.
>>
>> Ok, that makes sense, thank you.
>>
>> In that case I wonder if we'd want a public-facing iterator for
>> sched_domains_numa_masks[%i][node], rather than copy a portion of
>> it. Something like the below (naming and implementation haven't been
>> thought about too much).
>>
>>    const struct cpumask *sched_numa_level_mask(int node, int level)
>>    {
>>            struct cpumask ***masks = rcu_dereference(sched_domains_numa_masks);
>>
>>            if (node >= nr_node_ids || level >= sched_domains_numa_levels)
>>                    return NULL;
>>
>>            if (!masks)
>>                    return NULL;
>>
>>            return masks[level][node];
>>    }
>>    EXPORT_SYMBOL_GPL(sched_numa_level_mask);
>>
>
> The above can be kept static, and expose only the foo() function below,
> similar to my sched_cpus_set_spread().
>

So what I was thinking with this was to only have to export the
sched_numa_level_mask() thing and the iterator, and then consumers would be
free to use whatever storage form they want (cpumask, array, list...).

Right now I believe sched_domains_numa_masks has the right shape for the
interface (for a given node, you a cpumask per distance level) and I
don't want to impose an interface that uses just an array, but perhaps I'm
being silly and the array isn't so bad and simpler to use - that said we
could always build an array-based helper on top of the array of cpumasks
thing.

Clearly I need to scratch my head a bit longer :-)

> LGTM.
> How do you suggest to proceed?
> You want to formalize it? Or should I take it from here?
>

I need to have a think (feel free to ponder and share your thoughts as
well) - I'm happy to push something if I get a brain-wave, but don't let
that hold you back either.

