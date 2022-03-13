Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712834D73C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 09:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiCMIiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiCMIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 04:38:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967821AC289
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 00:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C672B80BE9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96625C340E8;
        Sun, 13 Mar 2022 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647160610;
        bh=ht5hDgsEPryySIdBuQQk2Z5zFTX49R9ecbzuDs9mlyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=axTThlfkUS3SYbgDSjxnhpOo2dVTNrAtA6OYbXlSXnLaH4V/iay+MomXf0aNwZ2AN
         hFWhlmaYQQqYyhiw6Fk+38Er//uIwVDd/L9s5Es8aUSVkY83JYm+wnnTXTVn6KYlOq
         i1n58vPrDT1fa7U/hi8FWhSl0u7rtQJVW7H3RqyWI8hyQMVhHo4FU78wNK4s25dH1A
         FBg81W4FRqQ9GJwltixBnkkv3Y2VJ8OMKqRI/fBrWRCCVoIiWfILSUQ9JmbzKX/4Ei
         5/eYYn0UqkVdTnBVbsFUvkrIdh/3PjKy2zLLHekssrNz4unEyifYCvZ0j/xFT91+yS
         kMTind9LgnfrA==
Date:   Sun, 13 Mar 2022 17:36:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Bang Li <libang.linuxer@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Allow both @symbol_name and @addr to exist
Message-Id: <20220313173646.e3d797f9ee3105239179fb5d@kernel.org>
In-Reply-To: <20220313032125.124094-1-libang.linuxer@gmail.com>
References: <20220313032125.124094-1-libang.linuxer@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 11:21:25 +0800
Bang Li <libang.linuxer@gmail.com> wrote:

> If the address found by the @symbol_name is equal to the @addr, this case
> should be considered a valid parameter combinations.

Could you tell me the reason why this is needed and use case?
I explictly made this case as an error, because I couldn't find
any good reason to support this case.

Thank you,

> 
> Example:
> 
> static struct kprobe kp = {
>     .symbol_name    = "kernel_clone",
>     .addr           = (kprobe_opcode_t*)kernel_clone,
> };
> 
> Signed-off-by: Bang Li <libang.linuxer@gmail.com>
> ---
>  kernel/kprobes.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 94cab8c9ce56..70d4ed9e7dc7 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1497,13 +1497,19 @@ bool within_kprobe_blacklist(unsigned long addr)
>  static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
>  			const char *symbol_name, unsigned int offset)
>  {
> -	if ((symbol_name && addr) || (!symbol_name && !addr))
> +	kprobe_opcode_t *symbol_addr;
> +
> +	if (!symbol_name && !addr)
>  		goto invalid;
>  
>  	if (symbol_name) {
> -		addr = kprobe_lookup_name(symbol_name, offset);
> -		if (!addr)
> +		symbol_addr = kprobe_lookup_name(symbol_name, offset);
> +		if (!symbol_addr)
>  			return ERR_PTR(-ENOENT);
> +
> +		if (addr && symbol_addr != addr)
> +			goto invalid;
> +		addr = symbol_addr;
>  	}
>  
>  	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
> @@ -2062,8 +2068,7 @@ bool __weak arch_kprobe_on_func_entry(unsigned long offset)
>   * function entry address or not.
>   * This returns 0 if it is the function entry, or -EINVAL if it is not.
>   * And also it returns -ENOENT if it fails the symbol or address lookup.
> - * Caller must pass @addr or @sym (either one must be NULL), or this
> - * returns -EINVAL.
> + * Caller must pass @addr or @sym, or this returns -EINVAL.
>   */
>  int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
>  {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
