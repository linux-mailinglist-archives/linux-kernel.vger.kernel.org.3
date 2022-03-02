Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625EF4CA7D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiCBOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiCBOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:20:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 218684EA25
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:20:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEC913D5;
        Wed,  2 Mar 2022 06:20:03 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 592843F73D;
        Wed,  2 Mar 2022 06:20:02 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     cgel.zte@gmail.com, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sched/topology: avoid calling synchronize_rcu()
In-Reply-To: <20220302011433.2054613-1-lv.ruyi@zte.com.cn>
References: <20220302011433.2054613-1-lv.ruyi@zte.com.cn>
Date:   Wed, 02 Mar 2022 14:19:55 +0000
Message-ID: <87mti84et0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/22 01:14, cgel.zte@gmail.com wrote:
> From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
>
> Kfree_rcu() usually results in even simpler code than does
> synchronize_rcu() without synchronize_rcu()'s multi-millisecond
> latency, so replace synchronize_rcu() with kfree_rcu().
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> ---
>  kernel/sched/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 974212620fa1..0ce302b4d732 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1970,8 +1970,7 @@ static void sched_reset_numa(void)
>       if (distances || masks) {
>               int i, j;
>
> -		synchronize_rcu();
> -		kfree(distances);
> +		kfree_rcu(distances);

What about the freeing of the cpumasks below? You don't want to free those
before the end of the grace period either. With that in mind, I think the
current synchronize_rcu() + batch of kfree()'s is fine, it's a slow path
anyway (hotplug).


>               for (i = 0; i < nr_levels && masks; i++) {
>                       if (!masks[i])
>                               continue;
> --
> 2.25.1
