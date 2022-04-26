Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642995100E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351581AbiDZOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiDZOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A22B83389C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650984492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enFBGsYxY8NVUeBNUpjaSX+Yt1m7r1MQJgN0eWGlgtU=;
        b=cZGkssdgH/bVHNVlQQ3be3XWb6Qfo0d4LfbB84jgwXFo4j1u7QuFwvkKRM4G/aFydOrYje
        qL8qO39zBGHWges5A7XWy8xs1D05Y/x+gn/lrHvbyBKtgoOqcjBpe+jD4Zk8J1k5kZeICK
        B/ktHDWX1aXDjbz5+rW4sqKowyppCBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-te7eICTzPDmz2GZzKXPn4g-1; Tue, 26 Apr 2022 10:48:11 -0400
X-MC-Unique: te7eICTzPDmz2GZzKXPn4g-1
Received: by mail-wm1-f71.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so941524wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=enFBGsYxY8NVUeBNUpjaSX+Yt1m7r1MQJgN0eWGlgtU=;
        b=Qr+JZKmA+/GngVJyKb27xR56rhecsC9hKGBD5LgQDepvbc/5DeEh1TSAXQDHyMgYLk
         ZdfkYGd1D9Q1690xwM6/IsJAe0EjMrc6ePQn7IvlRwL18vpKQ/mG9bIq4VJEr9rRSEcI
         LS/CSUmrXB3pHtQPlpJsMG/yio1Gmx4aLsuDZcyuFEiSgmeOXO0vPNewA7YNg7gH4WRJ
         oHok7tR/TALeRzXOmXYxMmIziFfazt7oB3HT+p/+BGCCJQPdJzgc4lauM3D3DHraM9Uz
         5w+R50F8LpbXxjbILsQHqqkdJVw07R6/bchTYAPPfrqfLiqKyKuhzXpRnSyaLlBHrmJ0
         JamA==
X-Gm-Message-State: AOAM530gnXXkxuEDXdrWNgz+VWiR7jpQws+E71WtMSgmPsScH0gZZ8/D
        Dv9mIZ15Pot6lS1CWS/FrrLZLTwl+w2TUEMKb+JirUji5XmURrHlOS09nxbP9uhHUHJ3zZynl7T
        DEkUw7WydkbeVor2r8vxpsTZa
X-Received: by 2002:a5d:48c8:0:b0:207:afc8:13fa with SMTP id p8-20020a5d48c8000000b00207afc813famr18487200wrs.487.1650984489824;
        Tue, 26 Apr 2022 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCGWfIzF4GzLPELF/WHxzzKBfcSFYY247bG064wH6UPomn7Y/ffT5Sei0ouz20qbUmSWCNew==
X-Received: by 2002:a5d:48c8:0:b0:207:afc8:13fa with SMTP id p8-20020a5d48c8000000b00207afc813famr18487188wrs.487.1650984489644;
        Tue, 26 Apr 2022 07:48:09 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c3b9400b00393ea849663sm6417769wms.30.2022.04.26.07.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:48:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
In-Reply-To: <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 26 Apr 2022 15:48:06 +0100
Message-ID: <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/22 17:03, Paul E. McKenney wrote:
> On Mon, Apr 25, 2022 at 10:59:44PM +0100, Valentin Schneider wrote:
>> On 25/04/22 10:33, Paul E. McKenney wrote:
>> >
>> > So what did rcu_torture_reader() do wrong here?  ;-)
>> >
>>
>> So on teardown, CPUHP_AP_SCHED_WAIT_EMPTY->sched_cpu_wait_empty() waits for
>> the rq to be empty. Tasks must *not* be enqueued onto that CPU after that
>> step has been run - if there are per-CPU tasks bound to that CPU, they must
>> be unbound in their respective hotplug callback.
>>
>> For instance for workqueue.c, we have workqueue_offline_cpu() as a hotplug
>> callback which invokes unbind_workers(cpu), the interesting bit being:
>>
>>                 for_each_pool_worker(worker, pool) {
>>                         kthread_set_per_cpu(worker->task, -1);
>>                         WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>>                 }
>>
>> The rcu_torture_reader() kthreads aren't bound to any particular CPU are
>> they? I can't find any code that would indicate they are - and in that case
>> it means we have a problem with is_cpu_allowed() or related.
>
> I did not intend that the rcu_torture_reader() kthreads be bound, and
> I am not seeing anything that binds them.
>
> Thoughts?  (Other than that validating any alleged fix will be quite
> "interesting".)
>
>                                                       Thanx, Paul

IIUC the bogus scenario is is_cpu_allowed() lets one of those kthreads be
enqueued on the outgoing CPU *after* CPUHP_AP_SCHED_WAIT_EMPTY.teardown() has
been run, and hilarity ensues.

The cpu_dying() condition should prevent a regular kthread from getting
enqueued there, most of the details have been evinced from my brain but I
recall we got the ordering conditions right...

The only other "obvious" thing here is migrate_disable() which lets the
enqueue happen, but then balance_push()->select_fallback_rq() should punt
it away on context switch.

I need to rediscover those paths, I don't see any obvious clue right now.

