Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD007546A59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiFJQZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B5426426
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654878338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8T5ujPxO45KWjzpbRoRUfkSCNSXdppXtj+IXIeFMUA=;
        b=BpaJS7ZD8Z+tu9mrneNgfTnEcdnJySgUgg1Fgadxn+7Zkp7PXSRxhrgH2lODu0kBqgZnaL
        4FjU+9rf/s+SrycTDy+H/IdwWoYrsm/id42TOFXt8wWLXzw+VRIZY8UWU0Sz/beR0K/cFA
        Yz3TyaF4Tk+HeIUopy1c1zA7hKBb1gQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-tuMMZRLnP8aJMleMgqBZgQ-1; Fri, 10 Jun 2022 12:25:37 -0400
X-MC-Unique: tuMMZRLnP8aJMleMgqBZgQ-1
Received: by mail-wr1-f72.google.com with SMTP id v4-20020adfebc4000000b002102c69be5eso6328660wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g8T5ujPxO45KWjzpbRoRUfkSCNSXdppXtj+IXIeFMUA=;
        b=TePlMhTtyeb6SEfZwPh2cYFUGco+S7gxfQKZWH/znd98yBsasuRlYHAaitP6R8Cbpa
         KhTJtuIm6lFdPx1RxCBklj6xWIBFQ5Wr/D5csx1BQ2terSWHgyF2nw9xR9DqMdb/LMdO
         mEw6mt4V+Ve5j2RgrW+J5JexvwjsyXoXymsAISHCcxcYpSGNnhSX0v19YqLr0M81E9oE
         P6+vBbw+Bum9Mx+lR/5vaAmTHbmdFV3c1k3QBx4zUGt472Sv311mdgDFCcj51VCak6Qk
         V9NHyYvMjAODiFIPE1CsbZla3+EN8xw3+Um05I/P4jsDy7OCN4IXC3ABfFyXKdM2JmDr
         595w==
X-Gm-Message-State: AOAM5331iSO3eLjtwmNyOPMwZM4D8cbheLJXzxM29qzdXPY85vqZPubq
        huKmrwZmQtf2whLHki0NnteoofJrqN51zbEGnuq+6uh8+pu10+RoM+udipB1gomCPLJDW77HvO8
        FYh+Y29hHaTgxlJ3sEjtGhDk/
X-Received: by 2002:a5d:4648:0:b0:218:5187:c437 with SMTP id j8-20020a5d4648000000b002185187c437mr20090600wrs.266.1654878335911;
        Fri, 10 Jun 2022 09:25:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqIL0rdxExgXao7+VhcxwfCtMWUznyd1SV0hAkoRceuZlLhtyqcJZGYOZorv5Sra4WUtmgzA==
X-Received: by 2002:a5d:4648:0:b0:218:5187:c437 with SMTP id j8-20020a5d4648000000b002185187c437mr20090578wrs.266.1654878335663;
        Fri, 10 Jun 2022 09:25:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c2ccc00b0039c4d9737f3sm3851704wmc.34.2022.06.10.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:25:35 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
In-Reply-To: <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
 <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
 <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
Date:   Fri, 10 Jun 2022 17:25:34 +0100
Message-ID: <xhsmho7z07af5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/22 16:15, Peter Zijlstra wrote:
> On Fri, Jun 10, 2022 at 11:55:37AM +0100, Valentin Schneider wrote:
>> 
>> IIUC we want to pay special attention when the task isn't allowed to run on
>> all online CPUs, wouldn't the below do that?
>> 
>>   !cpumask_subset(cpu_online_mask, p->cpus_ptr)
>
> At that point we might just as well do the whole cpumask_and() thing,
> no? There's not much cost difference between these two operations.
>

Yeah, you got a point there.

>> The task affinity can be a superset of the online mask, obvious case is
>> init_task's CPU_MASK_ALL, and the above test is still false if both masks
>> are equal.
>> 
>> (Additionnaly we could add a step in sched_init() to "properly" initialize
>> the init_task mask and remove the NR_CPUS faff).
>
> I'm confused, NR_CPUS is the right value for CPU_MASK_ALL.

Right, I meant to make the mask match cpu_online_mask from the get go, but
now that I allocate a few more neurons thinking about it it looks like a
can of worms; we'd have to do that after smp_init() to see which CPUs we
actually onlined, and by then we have already forked around.

