Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB35B0B74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIGR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIGR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FD7B79C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F9461993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BD7C433D6;
        Wed,  7 Sep 2022 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662571634;
        bh=zQkxLyJV/ZVaWJTNUJCn3/hQDVgwS2Dscv1v7/418+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJ2FCz5VATBfWjyd4ZkKYP3xEhQpP5RAzoammBnR5HpmUbjvheKTclq95QrbLUz3n
         G8/jCyxsTTSwJP+kor8EG5PvtumauQ2SVcwcPZCfWW+kKE+d9BC5JZWBaOBvkk2YzQ
         wXkLr+Gm0UN4mg54vbbUqALxG/ZdKeM/bA29zFU9fzcF5fbNq5QfFG5hQAsWlJF08q
         8Ga6VuUN71JnCoulwKPfvEraMvHCALDrVrHTW3krAKipY92jNOvrFf4ANDDqqe5hC0
         Op4Qk7Va1aXOspXYNmvDaEfBXii2DLjDQqiS12wgCIE3T9aPE8ZJtocmG9azsQ22kx
         f+zBB7fHI7Q8A==
From:   SeongJae Park <sj@kernel.org>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region() definitions
Date:   Wed,  7 Sep 2022 17:27:12 +0000
Message-Id: <20220907172712.61006-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907112924.65546-1-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

> In lru_sort.c and reclaim.c, they are all define get_monitoring_region()

s/define/defining/

> function, there is no need to define it separately.

Good point!

> 
> BTW, this patch remove tow struct 'damon_lru_sort_ram_walk_arg' and

s/remove/removes/
s/tow/two/

> 'damon_reclaim_ram_walk_arg', though the two struct are removed, if we
> want to add more fields to these struct for other purposes later, it will

s/struct/structs/

> not too late for us to use them again.
> For example:
>     struct damon_reclaim_ram_walk_arg {
> 	struct damon_addr_range raw_walk;
> 	xxx  A;
> 	xxx  B;
>     }
>     struct damon_lru_sort_ram_walk_arg {
> 	struct damon_addr_range raw_walk;
> 	xxx  A;
> 	xxx  B;
>     }

I haven't read the below part yet, but seems you're gonna use 'struct
damon_addr_range' instead of 'struct damon_{reclai,lru_sort}_ram_walk_arg'.

And I think we have already discussed about this before:
https://lore.kernel.org/damon/20220818172322.51705-1-sj@kernel.org/

My point is, we might add some more fileds to 'struct damon_addr_range' in a
future, though it seems very unlikely at the moment.  Sorry for not making my
opinion clear enough.

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/lru_sort.c   | 35 ++---------------------------------
>  mm/damon/ops-common.c | 28 ++++++++++++++++++++++++++++
>  mm/damon/ops-common.h |  1 +
>  mm/damon/reclaim.c    | 35 ++---------------------------------
>  4 files changed, 33 insertions(+), 66 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 9de6f00a71c5..5032d59d46e4 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -13,6 +13,8 @@
>  #include <linux/sched.h>
>  #include <linux/workqueue.h>
> 
> +#include "ops-common.h"
> +
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
>  #endif
> @@ -257,39 +259,6 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
>  static struct damon_ctx *ctx;
>  static struct damon_target *target;
> 
> -struct damon_lru_sort_ram_walk_arg {
> -	unsigned long start;
> -	unsigned long end;
> -};
> -
> -static int walk_system_ram(struct resource *res, void *arg)
> -{
> -	struct damon_lru_sort_ram_walk_arg *a = arg;
> -
> -	if (a->end - a->start < resource_size(res)) {
> -		a->start = res->start;
> -		a->end = res->end;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Find biggest 'System RAM' resource and store its start and end address in
> - * @start and @end, respectively.  If no System RAM is found, returns false.
> - */
> -static bool get_monitoring_region(unsigned long *start, unsigned long *end)
> -{
> -	struct damon_lru_sort_ram_walk_arg arg = {};
> -
> -	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
> -	if (arg.end <= arg.start)
> -		return false;
> -
> -	*start = arg.start;
> -	*end = arg.end;
> -	return true;
> -}
> -
>  /* Create a DAMON-based operation scheme for hot memory regions */
>  static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  {
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index b1335de200e7..01938f33038d 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> 
>  	return hotness;
>  }
> +
> +static inline int walk_system_ram(struct resource *res, void *arg)
> +{
> +	struct damon_addr_range *a = arg;
> +
> +	if (a->end - a->start < resource_size(res)) {
> +		a->start = res->start;
> +		a->end = res->end;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Find biggest 'System RAM' resource and store its start and end address in
> + * @start and @end, respectively.  If no System RAM is found, returns false.
> + */
> +bool get_monitoring_region(unsigned long *start, unsigned long *end)
> +{
> +	struct damon_addr_range arg = {};
> +
> +	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
> +	if (arg.end <= arg.start)
> +		return false;
> +
> +	*start = arg.start;
> +	*end = arg.end;
> +	return true;
> +}

'ops-common.c' is for code that common in monitoring operations
implementations.  I'd prefer to have yet another source file for the DAMON
modules including reclaim and lru_sort, say, 'modules-common.c'.

Also, as 'get_monitoring_region()' is not a 'static' function anymore, let's
have a prefix to distinguish with other functions, say, 'damon_modules_'?

> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 52329ff361cd..e6f1c9b48042 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -16,3 +16,4 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
>  int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
> +bool get_monitoring_region(unsigned long *start, unsigned long *end);

Let's move it to a dedicated source file, say, 'modules-common.h'

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index a7faf51b4bd4..20e83eee3c7d 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -13,6 +13,8 @@
>  #include <linux/sched.h>
>  #include <linux/workqueue.h>
> 
> +#include "ops-common.h"
> +
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
>  #endif
> @@ -229,39 +231,6 @@ module_param(nr_quota_exceeds, ulong, 0400);
>  static struct damon_ctx *ctx;
>  static struct damon_target *target;
> 
> -struct damon_reclaim_ram_walk_arg {
> -	unsigned long start;
> -	unsigned long end;
> -};
> -
> -static int walk_system_ram(struct resource *res, void *arg)
> -{
> -	struct damon_reclaim_ram_walk_arg *a = arg;
> -
> -	if (a->end - a->start < resource_size(res)) {
> -		a->start = res->start;
> -		a->end = res->end;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Find biggest 'System RAM' resource and store its start and end address in
> - * @start and @end, respectively.  If no System RAM is found, returns false.
> - */
> -static bool get_monitoring_region(unsigned long *start, unsigned long *end)
> -{
> -	struct damon_reclaim_ram_walk_arg arg = {};
> -
> -	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
> -	if (arg.end <= arg.start)
> -		return false;
> -
> -	*start = arg.start;
> -	*end = arg.end;
> -	return true;
> -}
> -
>  static struct damos *damon_reclaim_new_scheme(void)
>  {
>  	struct damos_watermarks wmarks = {
> --
> 2.31.0


Thanks,
SJ
