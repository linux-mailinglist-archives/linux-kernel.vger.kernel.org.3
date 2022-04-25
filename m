Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1F50DBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiDYJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbiDYJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:06:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F3933A713
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:01:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6AA11FB;
        Mon, 25 Apr 2022 02:01:25 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8F83F73B;
        Mon, 25 Apr 2022 02:01:23 -0700 (PDT)
Message-ID: <05c87803-59d3-2b3f-80ab-47b418c3f10f@arm.com>
Date:   Mon, 25 Apr 2022 11:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/fair: Fix decision matrix of type misfit_task
Content-Language: en-US
To:     zgpeng <zgpeng.linux@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <1650787010-8701-1-git-send-email-zgpeng@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <1650787010-8701-1-git-send-email-zgpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 09:56, zgpeng wrote:
> When the group type of the busiest is misfit_task, as
> long as the type of the local group is not equal to
> has_spare, those situation already filtered while
> updating statistics.
> 
> Signed-off-by: zgpeng <zgpeng@tencent.com>
> Reviewed-by: Samuel Liao <samuelliao@tencent.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299..b8c67e7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9495,7 +9495,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>   * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
>   * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
>   * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> - * misfit_task      force     N/A        N/A    N/A  force      force
> + * misfit_task      force     N/A        N/A    N/A  N/A        N/A
>   * asym_packing     force     force      N/A    N/A  force      force
>   * imbalanced       force     force      N/A    N/A  force      force
>   * overloaded       force     force      N/A    N/A  force      avg_load

This issue has been sorted. Patch from Tao Zhou <tao.zhou@linux.dev> is
already on tip sched/core.

https://lkml.kernel.org/r/165062326028.4207.17060214721845047142.tip-bot2@tip-bot2
