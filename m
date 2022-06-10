Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2255464F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbiFJK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbiFJK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF8E52D2522
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654858541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zz4FcuWwsUSXGAJMbqMsSNCwY/ABPIpK2Pm5RbgJbQg=;
        b=ZQcDa/DI4D9SSXNF/qKsk6zqp7hqdPyxfgzFKkRyr21cO6/gJL1vwwCBq/2Lpq5My/xqg1
        onzKj2x3Im2FuCPD2FbsfiAZVAVmgvHMW2xZtLBbcq6a40ZBljfJOkMmllvkgv2ACSa0Wc
        b3Rri4DUgFZHxRo6Il7eLxMnIMCaPpE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-rr6WpqsWOEetn97keS7TCw-1; Fri, 10 Jun 2022 06:55:40 -0400
X-MC-Unique: rr6WpqsWOEetn97keS7TCw-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so9501906wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zz4FcuWwsUSXGAJMbqMsSNCwY/ABPIpK2Pm5RbgJbQg=;
        b=5NIp4igGLfLdDZKhICY7319IR7TZYa3dKAXI4JC5mfmFW69SviA6ZXz/l1mlTn/X/d
         uyi75F3Fn+/p5Am4kjV5X+z9qjFYz5MP8PuguMP5z09hxN6ptqnR9fYmDDcoJyup9tyG
         rQqyXaKgFRPS/KIzIF6OQHH+ECB749r3dFtYZcPq8aFc4wQ1/Ome0BgYjV7MbZaHTRvA
         zMm5H04qKh5PjE8CJR2WTOIfFfCgusS2OblDs58fW4kYkADAy9W7dTz/3bPMzMEdul4B
         3nUKbgnU2N8dDxormoS+y1eXw8AnJ6+w9AT5yxHvF/BVzd/GDHxdSsWTHxDgiUskdZRJ
         1ExA==
X-Gm-Message-State: AOAM532h1IE1DCoGyf5PBD3p634bgAtr/WnyKrNYgQeOKpFNf0I08ry/
        zqF3rT39M/P7oFfWUbRYiX78eL52U9CeU8Wr088X6H1fIjI5q2x23B/W/+gGjdBWdjtMqVk5aIM
        81ay1QxrqR9i5mZbSwmJPV4qy
X-Received: by 2002:a05:600c:4f04:b0:39c:75e9:a3a5 with SMTP id l4-20020a05600c4f0400b0039c75e9a3a5mr5534271wmq.181.1654858539547;
        Fri, 10 Jun 2022 03:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIESYBb9wLI6gE8ep4bMC3Rlvyyi6Izcpxz5yNfkW/GdAdhNvis/Qs2p7Cym6z95sPDwrWbg==
X-Received: by 2002:a05:600c:4f04:b0:39c:75e9:a3a5 with SMTP id l4-20020a05600c4f0400b0039c75e9a3a5mr5534244wmq.181.1654858539295;
        Fri, 10 Jun 2022 03:55:39 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w7-20020adfee47000000b002185631adf0sm9818110wro.23.2022.06.10.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:55:38 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
In-Reply-To: <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
Date:   Fri, 10 Jun 2022 11:55:37 +0100
Message-ID: <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
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

On 09/06/22 13:54, Peter Zijlstra wrote:
> Now, I can (and have) fixed up the conflict, but it did make me look at
> this in a little more detail; and the thing I noticed is that your:
>
>   'p->nr_cpus_allowed != num_online_cpus()'
>
> test makes no sense. That's basically 'true'. The thing is,
> nr_cpus_allowed is initialized to NR_CPUS, and unless someone somewhere
> did set_cpus_allowed() on it, it'll still be NR_CPUS.
>
> Also, CPU hotplug doesn't change nr_cpus_allowed, so num_online_cpus()
> is just plain wrong.
>
> Now, something that might work is:
>
>   'p->nr_cpus_allowed < num_online_cpus()'
>
> And even that is no guarantee. You can construct a situation where this
> is still false even though you actually have a constrained set.
> Consider a machine with 8 CPUs. Then set the mask to: 0x55, which has 4
> CPUs set. Then offline the last 4 so that the online mask becomes 0x0f.
>
> Then the effective mask is 0x05, and the number we're looking for above
> is 2, but the suggested test would still be false, because
> nr_cpus_allowed would be 4, as would num_online_cpus().
>

IIUC we want to pay special attention when the task isn't allowed to run on
all online CPUs, wouldn't the below do that?

  !cpumask_subset(cpu_online_mask, p->cpus_ptr)

The task affinity can be a superset of the online mask, obvious case is
init_task's CPU_MASK_ALL, and the above test is still false if both masks
are equal.

(Additionnaly we could add a step in sched_init() to "properly" initialize
the init_task mask and remove the NR_CPUS faff).

