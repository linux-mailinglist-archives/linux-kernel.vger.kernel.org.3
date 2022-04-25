Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2250EC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiDYW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiDYWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F6013298E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650923989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cN/7P16/pl2aWC7+3xLQLZmXX5wgJctZprhKvrxwdx0=;
        b=A221Eubpm99Lz7vvbGucZTYCQRvuorCtXsIm5EA3yL6u1uvu0hQzRpW50muuEoJx4jt08n
        2I4RF8krALU3QMK1llNCvSJG79zJ757tE7QPI3NSDEzQnIYLTvXLW8S22cmgXAw1N1SoQ/
        sKdb7CCRWGxrqjTd/BqB+SthP5EDQ6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-AeK5VyioPPa5ji3YQMZHeA-1; Mon, 25 Apr 2022 17:59:48 -0400
X-MC-Unique: AeK5VyioPPa5ji3YQMZHeA-1
Received: by mail-wm1-f71.google.com with SMTP id i66-20020a1c3b45000000b0038eab4e0feaso7263921wma.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cN/7P16/pl2aWC7+3xLQLZmXX5wgJctZprhKvrxwdx0=;
        b=NZkhanyZ1k0dA1SsLs457zbTfvXQlvPacDXMQc0yaxSGorA0JsHQFvhiZnLv+W6QLn
         Yk0mgLuVM7Yrk/QsDJEEZMTrJwtUCCJuj4eQ6LtCAGJNd4IYfNiR2ruoVnyOW4YtEos3
         L0v4pS26ghOlqrrUYYt+M4+H8Z90zHt+fiw+2JIpZ725LVnFb5T8wCd1QiQxAIDeKbiD
         3n9RMPwqNmjDdiBbBK0l9uxugpmTQN20YXmU6gcFXT56+KLolLs9i1SdlGI71oBtf0JT
         OMuSkR/n/LyCVKDM/ZFZyPA8fIFDGrgL3+m/VrWV2qnofSt7tCc1Hk4D0Ae9beXGHLv9
         MSvQ==
X-Gm-Message-State: AOAM530FVXa+XowuOLfxZNZ69cacuyFmh0iADh3MvXfnsqv+f/OOE981
        OUXeVBILbQD6JNUNsEZpFnM4ktoUQEIwV6tlXeUUsuTAmQDUp+xFiziqav/fZXGzX2cuAeHBVwD
        I6KU75VPDh4tX7e8kx6lJwrKB
X-Received: by 2002:a1c:4489:0:b0:392:aa5d:1e01 with SMTP id r131-20020a1c4489000000b00392aa5d1e01mr18318952wma.40.1650923986801;
        Mon, 25 Apr 2022 14:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySTPjZ89pDYe6iKi3jCxpsym6BBaw3EytnAI40Z836ix8Wge4rySsnOsLynTub++vuj7RPFA==
X-Received: by 2002:a1c:4489:0:b0:392:aa5d:1e01 with SMTP id r131-20020a1c4489000000b00392aa5d1e01mr18318940wma.40.1650923986623;
        Mon, 25 Apr 2022 14:59:46 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id n16-20020adf8b10000000b0020ae5ed2b9dsm35891wra.20.2022.04.25.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:59:45 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
In-Reply-To: <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 25 Apr 2022 22:59:44 +0100
Message-ID: <xhsmh1qxkakof.mognet@vschneid.remote.csb>
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

On 25/04/22 10:33, Paul E. McKenney wrote:
> On Mon, Apr 25, 2022 at 05:15:13PM +0100, Valentin Schneider wrote:
>>
>> Hi Paul,
>>
>> On 21/04/22 12:38, Paul E. McKenney wrote:
>> > Hello!
>> >
>> > The rcutorture TREE03 scenario got the following splat, which appears
>> > to be a one-off, or if not, having an MTBF in the thousands of hours,
>> > even assuming that it is specific to TREE03.  (If it is not specific to
>> > TREE03, we are talking tens of thousands of hours of rcutorture runtime.)
>> >
>> > So just in case this rings any bells or there are some diagnostics I
>> > should add in case this ever happens again.  ;-)
>>
>> There should be a dump of the enqueued tasks right after the snippet you've
>> sent, any chance you could share that if it's there? That should tell us
>> which tasks are potentially misbehaving.
>
> And now that I know to look for them, there they are!  Thank you!!!
>
> CPU7 enqueued tasks (2 total):
>  pid: 52, name: migration/7
>  pid: 135, name: rcu_torture_rea
> smpboot: CPU 7 is now offline
>
> So what did rcu_torture_reader() do wrong here?  ;-)
>

So on teardown, CPUHP_AP_SCHED_WAIT_EMPTY->sched_cpu_wait_empty() waits for
the rq to be empty. Tasks must *not* be enqueued onto that CPU after that
step has been run - if there are per-CPU tasks bound to that CPU, they must
be unbound in their respective hotplug callback.

For instance for workqueue.c, we have workqueue_offline_cpu() as a hotplug
callback which invokes unbind_workers(cpu), the interesting bit being:

                for_each_pool_worker(worker, pool) {
                        kthread_set_per_cpu(worker->task, -1);
                        WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
                }

The rcu_torture_reader() kthreads aren't bound to any particular CPU are
they? I can't find any code that would indicate they are - and in that case
it means we have a problem with is_cpu_allowed() or related.

