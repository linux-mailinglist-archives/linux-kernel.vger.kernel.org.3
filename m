Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3175927C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiHOC16 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 Aug 2022 22:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiHOC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D5202
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B6760FD2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E922C433D7;
        Mon, 15 Aug 2022 02:27:54 +0000 (UTC)
Date:   Sun, 14 Aug 2022 22:27:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc1
Message-ID: <20220814222758.5aed931a@gandalf.local.home>
In-Reply-To: <20220815012300.hiz5pd3nynrehkhm@box.shutemov.name>
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
        <20220815012300.hiz5pd3nynrehkhm@box.shutemov.name>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 04:23:00 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same
> function") breaks build for me (CONFIG_MODULE=n):
> 
>   CC      kernel/trace/ftrace.o
> kernel/trace/ftrace.c:3149:1: error: ‘ops_references_rec’ defined but not used [-Werror=unused-function]
>  3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
>       | ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> The fix I used locally:
> 

This was submitted back here:

   https://lore.kernel.org/all/20220801084745.1187987-1-wangjingjin1@huawei.com/

But the broken change went through the BPF tree, so I can't fix it.

-- Steve

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bc921a3f7ea8..90fa3ceeaeeb 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3138,19 +3138,6 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
>  	return true;
>  }
> 
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
> -
>  static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  {
>  	bool init_nop = ftrace_need_init_nop();
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
> +
>  static int referenced_filters(struct dyn_ftrace *rec)
>  {
>  	struct ftrace_ops *ops;

