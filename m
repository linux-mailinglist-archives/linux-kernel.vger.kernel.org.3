Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174E56C343
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiGHVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiGHVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:45:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212992AD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:45:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n12so193930pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=YBc9G5UuEAIKirG2rLX1ZWqv97wMz4nAZu2cr2x+2/o=;
        b=cpWCgFQspdByfnqpqzsWdF0u6wqEPyvUe3n16GMOC9W3Cl1L81V+sLyBTRApTp3xRj
         OW9hRrQsDMWvg24Vo9hNoeQBBe4tN8qslvg/MfEe6QUvWRB6niRDeQee7TKVz2JPFvEf
         338NB4Q2OabrKxJZa24oo7uHPOISFdle6tJtvJ244NyEWersk1NYP+zJ80A6/ZZGUa5h
         BCc2b3lWHqtTX2HO7X51nQkLKJ82/0N9gieovze9awQysbBrsySasIHdG4E7xeOOqwl8
         JUhFutCz8mgbeyudWnj94E5DLvgkCEqRMtqVjapZufWVhuQbZSRXVuFY3t/EtUTOIsdv
         KXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=YBc9G5UuEAIKirG2rLX1ZWqv97wMz4nAZu2cr2x+2/o=;
        b=Yl+Z/2hIIddYewu8V8hdgJmxXwgreeG4fVzKEDzxLI3229zMh96RZE9I+19JNQqxwT
         UAm5STXcJkPZoSVJ+E6JzCbnhT1xS/2x291gudA3I1uOIjfL7EG2RFjlyqEQgQ9ryjqE
         FqQ6r4UKz/yLrscoOYA5qOTShJQQFUHabf6lqM8jm0gZ1cg3AhhgRc9UPU/2wLlZ2X/d
         7YmlNzxwJPb+mVAFDwQ+0R2LMt+UfcUz2f2K5EPbT4QGtTETb7giGiMTZJxQwLSQCad8
         ZMFpEW3o7kk7mLrIqitqPpic6R4+O4pxJEz34LPydt39HUQ9cpkEWoQJzFP6XCJgDMxB
         eGHg==
X-Gm-Message-State: AJIora/M7DTk7tbNFkZJXto3fpf94DVXccuYalvwYdQdJGlRnHhYWmdQ
        Z5Aejxh3RL/BnkTkReq2o+fJl6DkrbWSGw==
X-Google-Smtp-Source: AGRyM1txfb5vm0s4osoLdd3ahuRLDA8B45uPIvFfp/fMN/NWmx+atJIJLE1Yyoiu+xDcEVPwHpnB6A==
X-Received: by 2002:a63:4042:0:b0:411:bbfe:e736 with SMTP id n63-20020a634042000000b00411bbfee736mr5024669pga.1.1657316743257;
        Fri, 08 Jul 2022 14:45:43 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e5d100b0016bea2a0a8dsm1715plf.91.2022.07.08.14.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:45:42 -0700 (PDT)
References: <20220708211755.73637-1-schspa@gmail.com>
 <20220708172614.14191089@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Sat, 09 Jul 2022 05:32:25 +0800
In-reply-to: <20220708172614.14191089@gandalf.local.home>
Message-ID: <m2v8s7mg78.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat,  9 Jul 2022 05:17:54 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> +++ b/kernel/sched/rt.c
>> @@ -1998,11 +1998,14 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>>  			 * the mean time, task could have
>>  			 * migrated already or had its affinity changed.
>>  			 * Also make sure that it wasn't scheduled on its rq.
>> +			 * It is possible the task has running for a while,
>
> I don't understand the "running for a while" part. That doesn't make sense.
>

When I say "run for a while" I mean as long as the task has
run capability, we should check the migrate disabled flag again.

> The only way this can happen is that it was scheduled, set
> "migrate_disabled" and then got preempted where it's no longer on the run
> queue.

Yes, it is the only case.

> -- Steve
>
>
>> +			 * And we check task migration disable flag here.
>>  			 */
>>  			if (unlikely(task_rq(task) != rq ||
>>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>>  				     task_running(rq, task) ||
>>  				     !rt_task(task) ||
>> +				     is_migration_disabled(task) ||
>>  				     !task_on_rq_queued(task))) {
>>  
>>  				double_unlock_balance(rq, lowest_rq);

-- 
BRs
Schspa Shi
