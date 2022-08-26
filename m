Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E85A2F51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbiHZStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345263AbiHZStH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:49:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14BEEA179
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:46:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B41CD6E;
        Fri, 26 Aug 2022 11:46:10 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6433F93E;
        Fri, 26 Aug 2022 11:46:02 -0700 (PDT)
Message-ID: <43de1f15-42cf-45ea-db5c-30de976a6828@arm.com>
Date:   Fri, 26 Aug 2022 20:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 1/2] sched/rt: fix bad task migration for rt tasks
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai
References: <20220713134823.95141-1-schspa@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713134823.95141-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 15:48, Schspa Shi wrote:
> Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
> allow find_lock_lowest_rq to pick a task with migration disabled.
> This commit is intended to push the current running task on this CPU
> away.
> 
> There is a race scenario, which allows a migration disabled task to
> be migrated to another CPU.
> 
> When there is a RT task with higher priority, rt sched class was
> intended to migrate higher priority task to lowest rq via push_rt_tasks,
> this BUG will happen here.
       ^^^

You mean the warning in set_task_cpu()?

> With the system running on PREEMPT_RT, rt_spin_lock will disable
> migration, this will make the problem easier to reproduce.
> 
> I have seen this crash on PREEMPT_RT, from the logs, there is a race
                   ^^^^^
                     ?

We still talking about the set_task_cpu() warning, right?

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

You should carry the Reviewed-by:'s you got in previous versions.
