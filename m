Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B6581693
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiGZPjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jul 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGZPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:39:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452AF2BB11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 040AEB80A48
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F2C433D7;
        Tue, 26 Jul 2022 15:39:11 +0000 (UTC)
Date:   Tue, 26 Jul 2022 11:39:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     WangJingjin <wangjingjin1@huawei.com>
Cc:     <mingo@redhat.com>, <daniel@iogearbox.net>, <song@kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <gaochao49@huawei.com>
Subject: Re: [PATCH -next] ftrace: Fix build error whithout CONFIG_MODULES
Message-ID: <20220726113910.5b2cac1c@gandalf.local.home>
In-Reply-To: <20220726113538.2992790-1-wangjingjin1@huawei.com>
References: <20220726113538.2992790-1-wangjingjin1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 19:35:38 +0800
WangJingjin <wangjingjin1@huawei.com> wrote:

> Fix build errors on kernel/trace/ftrace.c:
>     ‘ops_references_rec’ defined but not used.
> 
> Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
> Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bc921a3f7ea8..16d3d3884e17 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1861,8 +1861,6 @@ static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
>  	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
>  }
> 
> -static bool ops_references_ip(struct ftrace_ops *ops, unsigned long ip);
> -
>  /*
>   * Try to update IPMODIFY flag on each ftrace_rec. Return 0 if it is OK
>   * or no-needed to update, -EBUSY if it detects a conflict of the flag
> @@ -3108,6 +3106,7 @@ static inline int ops_traces_mod(struct ftrace_ops *ops)
>  		ftrace_hash_empty(ops->func_hash->notrace_hash);
>  }
> 
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) || defined(CONFIG_MODULES)

Honesly, this block needs to be moved down to closer to where it is
first used (just above the #ifdef CONFIG_MODULES).

>  /*
>   * Check if the current ops references the given ip.
>   *
> @@ -3137,19 +3136,7 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
> 
>  	return true;
>  }
> -
> -/*
> - * Check if the current ops references the record.
> - *
> - * If the ops traces all functions, then it was already accounted for.
> - * If the ops does not trace the current record function, skip it.
> - * If the ops ignores the function via notrace filter, skip it.
> - */
> -static bool
> -ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
> -{
> -	return ops_references_ip(ops, rec->ip);
> -}
> +#endif
> 
>  static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  {
> @@ -6818,6 +6805,19 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
> 
>  static LIST_HEAD(ftrace_mod_maps);
> 
> +/*
> + * Check if the current ops references the record.
> + *
> + * If the ops traces all functions, then it was already accounted for.
> + * If the ops does not trace the current record function, skip it.
> + * If the ops ignores the function via notrace filter, skip it.
> + */
> +static bool
> +ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
> +{
> +	return ops_references_ip(ops, rec->ip);
> +}

And we should just nuke this function, and call the ops_references_ip()
directly, as it is only used in one location.

 static int referenced_filters(struct dyn_ftrace *rec)
 {
        struct ftrace_ops *ops;
        int cnt = 0;
 
        for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-               if (ops_references_rec(ops, rec)) {
+               if (ops_references_ip(ops, rec->ip)) {
                        if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
                                continue;
                        if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_IPMODIFY))


-- Steve

> +
>  static int referenced_filters(struct dyn_ftrace *rec)
>  {
>  	struct ftrace_ops *ops;
> --
> 2.25.1

