Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F150511AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiD0NuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiD0NuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12A0404AC3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F4EFB82767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F6C385A9;
        Wed, 27 Apr 2022 13:47:00 +0000 (UTC)
Date:   Wed, 27 Apr 2022 09:46:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] ftrace: Drop duplicate mcount locations
Message-ID: <20220427094658.502fcaee@gandalf.local.home>
In-Reply-To: <9b1b816cff1f479c8de0e9baa5a6ac680b84e17e.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <9b1b816cff1f479c8de0e9baa5a6ac680b84e17e.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 15:01:21 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> In the absence of section symbols [1], objtool (today) and recordmcount
> (with a subsequent patch) generate __mcount_loc relocation records with
> weak symbols as the base. This works fine as long as those weak symbols
> are not overridden, but if they are, these can result in duplicate
> entries in the final vmlinux mcount location table. This will cause
> ftrace to fail when trying to patch the same location twice. Fix this by
> dropping duplicate locations during ftrace init.
> 
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/trace/ftrace.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4f1d2f5e726341..8bc4f282bb3ff4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6496,7 +6496,7 @@ static int ftrace_process_locs(struct module *mod,
>  	struct dyn_ftrace *rec;
>  	unsigned long count;
>  	unsigned long *p;
> -	unsigned long addr;
> +	unsigned long addr, prev_addr = 0;
>  	unsigned long flags = 0; /* Shut up gcc */
>  	int ret = -ENOMEM;
>  
> @@ -6550,6 +6550,16 @@ static int ftrace_process_locs(struct module *mod,
>  	while (p < end) {
>  		unsigned long end_offset;
>  		addr = ftrace_call_adjust(*p++);
> +
> +		/*
> +		 * Drop duplicate entries, which can happen when weak
> +		 * functions are overridden, and __mcount_loc relocation
> +		 * records were generated against function names due to
> +		 * absence of non-weak section symbols
> +		 */
> +		if (addr == prev_addr)
> +			addr = 0;

Please don't use the side effect of addr == 0 causing the loop to continue
for this logic. The two are not related. Simply call continue.

		if (addr == prev_addr)
			continue;


-- Steve


> +
>  		/*
>  		 * Some architecture linkers will pad between
>  		 * the different mcount_loc sections of different
> @@ -6569,6 +6579,7 @@ static int ftrace_process_locs(struct module *mod,
>  
>  		rec = &pg->records[pg->index++];
>  		rec->ip = addr;
> +		prev_addr = addr;
>  	}
>  
>  	/* We should have used all pages */

