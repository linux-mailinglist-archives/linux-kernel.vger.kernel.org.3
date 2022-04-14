Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A82500B34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbiDNKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiDNKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:35:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8526C6D39B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:33:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A559A139F;
        Thu, 14 Apr 2022 03:33:27 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0413F5A1;
        Thu, 14 Apr 2022 03:33:27 -0700 (PDT)
Message-ID: <a443f8ed-7bc9-5ded-89de-b19fad014359@arm.com>
Date:   Thu, 14 Apr 2022 12:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Revise comment about lb decision matrix
To:     Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org
References: <20220403175946.7323-1-tao.zhou@linux.dev>
Content-Language: en-US
In-Reply-To: <20220403175946.7323-1-tao.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2022 19:59, Tao Zhou wrote:
> If busiest group type is group_misfit_task, the local
> group type must be group_has_spare according to below
> code in update_sd_pick_busiest():
> 
> if (sgs->group_type == group_misfit_task &&
>     (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>      sds->local_stat.group_type != group_has_spare))
>          return false;
> 
> group type imbalanced and overloaded and fully_busy are filtered in here.
> misfit and asym are filtered before in update_sg_lb_stats().
> So, change the decision matrix to:
> 
> busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
> asym_packing     force     force      N/A    N/A  force      force
> imbalanced       force     force      N/A    N/A  force      force
> overloaded       force     force      N/A    N/A  force      avg_load
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb..5765d96202c7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9441,7 +9441,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>   * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
>   * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
>   * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> - * misfit_task      force     N/A        N/A    N/A  force      force
> + * misfit_task      force     N/A        N/A    N/A  N/A        N/A
>   * asym_packing     force     force      N/A    N/A  force      force
>   * imbalanced       force     force      N/A    N/A  force      force
>   * overloaded       force     force      N/A    N/A  force      avg_load

You should put people you find in `./scripts/get_maintainer.pl
kernel/sched/fair.c` on To/Cc to attract more attention.

Otherwise, LGTM.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

