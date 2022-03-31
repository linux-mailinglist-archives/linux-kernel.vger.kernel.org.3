Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668924ED674
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiCaJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCaJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:06:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F74C1E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:04:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0517723A;
        Thu, 31 Mar 2022 02:04:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA283F718;
        Thu, 31 Mar 2022 02:04:32 -0700 (PDT)
Message-ID: <66f29bee-e26c-b40e-c3af-79d5297565d8@arm.com>
Date:   Thu, 31 Mar 2022 11:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arch/arm64: Fix topology initialization for core
 scheduling
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220330155611.30216-1-pauld@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220330155611.30216-1-pauld@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 17:56, Phil Auld wrote:
> Arm64 systems rely on store_cpu_topology() to call update_siblings_masks()
> to transfer the toplogy to the various cpu masks. This needs to be done 
> before the call to notify_cpu_starting() which tells the scheduler about 
> each cpu found, otherwise the core scheduling data structures are setup 
> in a way that does not match the actual topology.
> 
> Without this change stress-ng (which enables core scheduling in its prctl 
> tests) causes a warning and then a crash (trimmed for legibility):
> 
> [ 1853.805168] ------------[ cut here ]------------
> [ 1853.809784] task_rq(b)->core != rq->core
> [ 1853.809792] WARNING: CPU: 117 PID: 0 at kernel/sched/fair.c:11102 cfs_prio_less+0x1b4/0x1c4
> ...
> [ 1854.015210] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> ...
> [ 1854.231256] Call trace:
> [ 1854.233689]  pick_next_task+0x3dc/0x81c
> [ 1854.237512]  __schedule+0x10c/0x4cc
> [ 1854.240988]  schedule_idle+0x34/0x54
> 
> Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
> This is a similar issue to 
>   f2703def339c ("MIPS: smp: fill in sibling and core maps earlier") 
> which fixed it for MIPS. 
> 
> v2: Fixed the commit message. No code change.

Ah, the reason is that smt_mask is not correctly setup, so we bail on
`cpumask_weight(smt_mask) == 1` for !leaders in:

notify_cpu_starting()
  cpuhp_invoke_callback_range()
    sched_cpu_starting()
      sched_core_cpu_starting()

which leads to rq->core not being correctly set for !leader-rq's.

LGTM. Tested on: HPE Apollo 70 X1

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

