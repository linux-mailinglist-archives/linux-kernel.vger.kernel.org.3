Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED06C4E912A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiC1JZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiC1JZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:25:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CAFF1408C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:23:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3200FD6E;
        Mon, 28 Mar 2022 02:23:51 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9EF3F66F;
        Mon, 28 Mar 2022 02:23:47 -0700 (PDT)
Message-ID: <6bee2e39-34a8-905f-084f-379b8476ea98@arm.com>
Date:   Mon, 28 Mar 2022 11:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-4-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220311161406.23497-4-vincent.guittot@linaro.org>
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

On 11/03/2022 17:14, Vincent Guittot wrote:

[...]

> @@ -98,6 +99,22 @@ struct sched_param {
>   * scheduled on a CPU with no more capacity than the specified value.
>   *
>   * A task utilization boundary can be reset by setting the attribute to -1.
> + *
> + * Latency Tolerance Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes allows to specify the relative latency
> + * requirements of a task with respect to the other tasks running/queued in the
> + * system.
> + *
> + * @ sched_latency_nice	task's latency_nice value
> + *
> + * The latency_nice of a task can have any value in a range of
> + * [LATENCY_NICE_MIN..LATENCY_NICE_MAX].

s/LATENCY_NICE_MIN/MIN_LATENCY_NICE
s/LATENCY_NICE_MAX/MAX_LATENCY_NICE

> + * A task with latency_nice with the value of LATENCY_NICE_MIN can be
> + * taken for a task with lower latency requirements as opposed to the task with
> + * higher latency_nice.

low latency nice (priority): -20 -> high weight: 1024 ... Doesn't a task
with MIN_LATENCY_NICE -20 have the highest latency requirements?

[...]
