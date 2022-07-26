Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2C5810FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiGZKSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiGZKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D74B252AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658830705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lnSTLtfpiMG3nHTtX3jKFzE3hNNSSLXlSNWKqDtSbM=;
        b=a+j/zzrpAHJIJkvfcWAdaY4VL/E5ZHl17fomZXZU31r5JGdxYhclY6Z3IwPMbUWaJK/Zx7
        JW/4Zqcm2qy5pbyWh9EIgx7AyKtBu2TZ5d+/F/sDEskOfCsisccgZLRyvNXIGJFROpt0/y
        jjxzaFA87D03D9g0+8cnvnPAZsnxaTg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-RA-bByWDOvKUDlfN8EamxQ-1; Tue, 26 Jul 2022 06:18:23 -0400
X-MC-Unique: RA-bByWDOvKUDlfN8EamxQ-1
Received: by mail-wm1-f71.google.com with SMTP id a18-20020a05600c225200b003a30355c0feso5203573wmm.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5lnSTLtfpiMG3nHTtX3jKFzE3hNNSSLXlSNWKqDtSbM=;
        b=pA4Ey55drLgdPFMkHapUEJKV8AbE/tICEZSLaRaTxxDNoelgz0N/O9Y8b6u2qF4iek
         v6i0sXeWbAuPs9aOVw0xWiCSeStIXPXh42u2qvhTdvZbwzOUvFf2rnRWwF2gDnJJ89Kl
         QB30+iGe6BpPp3Ia5mSUlE+ogWjfKQ9iIgxXQA9hnoJVVulwHYANIh8+HLpfpedWNdCp
         RE8gb+WfIMgpg5uSFRfBPPIB43+LrnsBxm4g2JfKjSIqV+RH6k3Lyh2f9LfBXSCxuUlt
         wzbaluIjst9bT2HZWGCrJPduVoYXB722Pxl7Z1PxyfI0vExCFwCMXnTqMGqCO00+3jfF
         upMA==
X-Gm-Message-State: AJIora93MR1vownNtvxEM7QqlX+mRH3Tm+V/UVOkJankpBeWpKBghDIa
        3qrCZqUJc6WcdoZjTQ1fe5BIgbK2qaZSBSLZ+QuAKfzKle7SA7Ut06Lt0erCujEUI1KMh37n0vE
        xaVCzUJVaLuX2xneEelsx3ZPS
X-Received: by 2002:a7b:cbce:0:b0:3a3:2d78:f066 with SMTP id n14-20020a7bcbce000000b003a32d78f066mr11827326wmi.66.1658830702612;
        Tue, 26 Jul 2022 03:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8kydM3js1Qil6SAxeNCdOc4EVpN3aiOG2Sa/CTbqYiQy1OSiHZETtGoU4toS9G3LOObJOnA==
X-Received: by 2002:a7b:cbce:0:b0:3a3:2d78:f066 with SMTP id n14-20020a7bcbce000000b003a32d78f066mr11827305wmi.66.1658830702343;
        Tue, 26 Jul 2022 03:18:22 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b003a2e7c13a3asm16726137wmr.42.2022.07.26.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:18:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] sched: Consider task_struct::saved_state in
 wait_task_inactive().
In-Reply-To: <Yt+G/somh8qcKc/R@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
 <20220720154435.232749-3-bigeasy@linutronix.de>
 <xhsmhy1whdqy9.mognet@vschneid.remote.csb>
 <Yt+G/somh8qcKc/R@linutronix.de>
Date:   Tue, 26 Jul 2022 11:18:20 +0100
Message-ID: <xhsmhsfmodvo3.mognet@vschneid.remote.csb>
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

On 26/07/22 08:17, Sebastian Andrzej Siewior wrote:
> On 2022-07-25 18:47:58 [+0100], Valentin Schneider wrote:
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -3257,6 +3257,40 @@ int migrate_swap(struct task_struct *cur
>> >  }
>> >  #endif /* CONFIG_NUMA_BALANCING */
>> >
>> > +#ifdef CONFIG_PREEMPT_RT
>>
>> Would something like the below be useful?
>>
>> /*
>>  * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
>>  * rtlock *before* voluntarily calling into schedule() after setting its state
>>  * to X. For things like ptrace (X=TASK_TRACED), the task could have more work
>>  * to do upon acquiring the lock before whoever called wait_task_inactive()
>>  * should return. IOW, we have to wait for:
>>  *
>>  *   p.saved_state = TASK_RUNNING
>>  *   p.__state     = X
>>  *
>>  * which implies the task isn't blocked on an RT lock and got to schedule() by
>>  * itself.
>>  *
>>  * Also see comments in ttwu_state_match().
>>  */
>
> This sums up the code. I would s/schedule/schedule_rtlock/ since there
> are two entrypoints.

Right, this any better?

/*
 * Consider:
 *
 *  set_special_state(X);
 *
 *  do_things()
 *    // Somewhere in there is an rtlock that can be contended:
 *    current_save_and_set_rtlock_wait_state();
 *    [...]
 *    schedule_rtlock(); (A)
 *    [...]
 *    current_restore_rtlock_saved_state();
 *
 *  schedule(); (B)
 *
 * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
 * rtlock (A) *before* voluntarily calling into schedule() (B) after setting its
 * state to X. For things like ptrace (X=TASK_TRACED), the task could have more
 * work to do upon acquiring the lock in do_things() before whoever called
 * wait_task_inactive() should return. IOW, we have to wait for:
 *
 *   p.saved_state = TASK_RUNNING
 *   p.__state     = X
 *
 * which implies the task isn't blocked on an RT lock and got to schedule() (B).
 *
 * Also see comments in ttwu_state_match().
 */

