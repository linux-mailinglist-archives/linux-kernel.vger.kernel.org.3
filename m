Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38D464A75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbhLAJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:23:57 -0500
Received: from foss.arm.com ([217.140.110.172]:60236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345941AbhLAJXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:23:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C5C1063;
        Wed,  1 Dec 2021 01:20:34 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8DF53F766;
        Wed,  1 Dec 2021 01:20:33 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
To:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211125165233.1425633-1-qais.yousef@arm.com>
 <87wnkvb35n.mognet@arm.com>
 <20211130112356.25bm5s66sywtdgw4@e107158-lin.cambridge.arm.com>
 <875ys9bzcz.mognet@arm.com>
 <20211130154116.w5wjtbc4shpwcoku@e107158-lin.cambridge.arm.com>
Message-ID: <296f08f4-f229-ec83-5dae-b8b499b81d49@arm.com>
Date:   Wed, 1 Dec 2021 10:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130154116.w5wjtbc4shpwcoku@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.21 16:41, Qais Yousef wrote:
> On 11/30/21 12:29, Valentin Schneider wrote:
>> On 30/11/21 11:23, Qais Yousef wrote:
>>> Hi Valentin
>>>
>>> On 11/26/21 10:51, Valentin Schneider wrote:
>>>> On 25/11/21 16:52, Qais Yousef wrote:
>>>>> Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
>>>>> uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
>>>>> match the woken up task's uclamp_max when the rq is idle. This only
>>>>> impacts the first wake up after enabling the static key. And it only

LGTM.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Tested with rt-app:

   "tasks": {
        "task_n1": {
            "util_min": 0,
            "util_max": 369,
            "loop": 1,
            "phases": {
                "p000001": {                     
                    "loop": 5,
                    "run": 800,
                    "timer": {
                        "period": 16000,
                        "ref": "task_n1"
                    }
                }
            },
            "policy": "SCHED_OTHER"
        }
    }

w/o patch:

/*  missing (1) since rq->uclamp_flags = UCLAMP_FLAG_IDLE is not set initially */
[75.002086] (3) uclamp_rq_inc_id() CPU5 p=[task_n1-0 1693] uc_se->value=369 uc_rq->value=1024
/* first dequeue to _uclamp_ idle set UCLAMP_FLAG_IDLE */
[75.013851] (2) uclamp_idle_value() CPU5 p=[task_n1-0 1693] clamp_id=1 value=369
[75.017972] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1693] clamp_id=0 value=0
/* UCLAMP_FLAG_IDLE is set -> set rq->uclamp[UCLAMP_MAX].value to *369* */
[75.017984] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1693] clamp_id=1 value=369
[75.017995] (3) uclamp_rq_inc_id() CPU5 p=[task_n1-0 1693] uc_se->value=369 uc_rq->value=*369*

w/ patch:

[63.393974] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1700] clamp_id=0 value=0
/* UCLAMP_FLAG_IDLE is set -> set rq->uclamp[UCLAMP_MAX].value to *369* */
[63.401269] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1700] clamp_id=1 value=369
[63.415513] (3) uclamp_rq_inc_id() CPU5 p=[task_n1-0 1700] uc_se->value=369 uc_rq->value=*369*
/* first dequeue to _uclamp_ idle set UCLAMP_FLAG_IDLE (again) */
[63.434781] (2) uclamp_idle_value() CPU5 p=[task_n1-0 1700] clamp_id=1 value=369
[63.449681] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1700] clamp_id=0 value=0
[63.449691] (1) uclamp_idle_reset() CPU5 p=[task_n1-0 1700] clamp_id=1 value=369
[63.449699] (3) uclamp_rq_inc_id() CPU5 p=[task_n1-0 1700] uc_se->value=369 uc_rq->value=369

[...]
