Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A015474490
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhLNOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhLNOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:14:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53157C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:14:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A807B819AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A83C34601;
        Tue, 14 Dec 2021 14:14:47 +0000 (UTC)
Date:   Tue, 14 Dec 2021 09:14:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sched/fair: fix boolreturn.cocci warning
Message-ID: <20211214091446.383ec08e@gandalf.local.home>
In-Reply-To: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
References: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'll save Peter Zijlstra time from replying to this.

On Tue, 14 Dec 2021 11:38:45 +0000
cgel.zte@gmail.com wrote:

> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./kernel/sched/fair.c: 9781: 9-10: WARNING: return of 0/1 in function
> 'imbalanced_active_balance' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.

This is a stupid warning. In C "1" is the same as "true" and "0" is the
same as "false". 

This is a bogus error message and something not needed to be fixed.

Please remove these checks from your scripts.

NACK

-- Steve

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac5e55441cab..0e62fd7ac0e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9778,9 +9778,9 @@ imbalanced_active_balance(struct lb_env *env)
>  	 */
>  	if ((env->migration_type == migrate_task) &&
>  	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
> -		return 1;
> +		return true;
>  
> -	return 0;
> +	return false;
>  }
>  
>  static int need_active_balance(struct lb_env *env)

