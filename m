Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08F5A4223
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH2FNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:13:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FA3A422F5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:13:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0522D23A;
        Sun, 28 Aug 2022 22:13:20 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8033F766;
        Sun, 28 Aug 2022 22:13:39 -0700 (PDT)
Message-ID: <42b2c57d-33d4-dc41-efc4-682aa02f9429@arm.com>
Date:   Mon, 29 Aug 2022 07:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] sched/fair: Check if prev_cpu has highest spare cap
 in feec()
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     qperret@google.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20220819153320.291720-1-pierre.gondois@arm.com>
 <20220819153320.291720-2-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220819153320.291720-2-pierre.gondois@arm.com>
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

On 19/08/2022 17:33, Pierre Gondois wrote:
> When evaluating the CPU candidates in the perf domain (pd) containing
> the previously used CPU (prev_cpu), find_energy_efficient_cpu()
> evaluates the energy of the pd:
> - without the task (base_energy)
> - with the task placed on prev_cpu (if the task fits)
> - with the task placed on the CPU with the highest spare capacity,
>   prev_cpu being excluded from this set
> 
> If prev_cpu is already the CPU with the highest spare capacity,
> max_spare_cap_cpu will be the CPU with the second highest spare
> capacity.
> 
> On an Arm64 Juno-r2, with a workload of 10 tasks at a 10% duty cycle,
> when prev_cpu and max_spare_cap_cpu are both valid candidates,
> prev_spare_cap > max_spare_cap at ~82%.
> Thus the energy of the pd when placing the task on max_spare_cap_cpu
> is computed with no possible positive outcome 82% most of the time.
> 
> Do not consider max_spare_cap_cpu as a valid candidate if
> prev_spare_cap > max_spare_cap.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

LGTM. When I ran the workload I see this happening in 50%-90% of the EAS
wakeups. This should prevent one needless compute_energy() call out of 7
on a typical 3-gear system like 2x2x4 in these cases.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
