Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C777A4FC820
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiDKXhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiDKXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:37:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3782B1276B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:34:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B511570;
        Mon, 11 Apr 2022 16:34:55 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0209E3F73B;
        Mon, 11 Apr 2022 16:34:52 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:34:47 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Subject: Re: Scheduling tasks on idle cpu
Message-ID: <20220411233447.rcencjivkhyltyxm@airbuntu>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/22 08:26, David Laight wrote:
> From: Qais Yousef
> > Sent: 09 April 2022 18:09
> ...
> > RT scheduler will push/pull tasks to ensure the task will get to run ASAP if
> > there's another cpu at lower priority is available
> 
> Does that actually happen?

For RT tasks, yes. They should get distributed.

> I've seen the following:
>   34533 [017]: sys_futex(uaddr: 1049104, op: 85, val: 1, utime: 1, uaddr2: 1049100, val3: 4000001)
>   34533 [017]: sched_migrate_task: pid=34512 prio=120 orig_cpu=14 dest_cpu=17
>   34533 [017]: sched_wakeup: pid=34512 prio=120 success=1 target_cpu=017

prio=120 is a CFS task, no?

> and pid 34512 doesn't get scheduled until pid 34533 finally sleeps.
> This is in spite of there being 5 idle cpu.
> cpu 14 is busy running a RT thread, but migrating to cpu 17 seems wrong.
> 
> This is on a RHEL7 kernel, I've not replicated it on anything recent.
> But I've very much like a RT thread to be able to schedule a non-RT
> thread to run on an idle cpu.

Oh, you want CFS to avoid CPUs that are running RT tasks.

We had a proposal in the past, but it wasn't good enough

	https://lore.kernel.org/lkml/1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com/

The approach in that patch modified RT to avoid CFS actually.

Can you verify whether the RT task woke up after task 34512 was migrated to CPU
17? Looking at the definition of available_idle_cpu() we should have avoided
that CPU if the RT task was already running. Both waking up at the same time
would explain what you see. Otherwise I'm not sure why it picked CPU 17.

Thanks

--
Qais Yousef
