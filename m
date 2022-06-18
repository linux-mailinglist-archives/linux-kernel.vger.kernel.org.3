Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE5550348
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiFRGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiFRGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 02:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23D28E0A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6FFCB82C43
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 06:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AFAC3411A;
        Sat, 18 Jun 2022 06:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655535262;
        bh=IfuF4V5SRJPWx6U7qc89W7AfTGWnp9ELPIxv5KVbttw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vCvdbg6GcVxDsNKGOcFryu/PHLiOyk3eu+VHpnO3y827yGEmz7NvYkHlrRDayxdxr
         q6uGbs0AOmcz9Qh6TICc6kImBI7wd89a782AkNOlFX8kx1W328agZVGpSBgh3iNoCl
         4kp4S0vGjJOZ7a4eV5Z+56QKLWrX+He0XHuybCWM/4f9nwxhsSExfrhBUsrbj/NHFv
         brG3WcF7TQci15Pzxmeg2z5YOuE4KHxwFb3FLdFMxtX/RykI7ogrzC0iF4ilC7x+U6
         LF0/RvxfNGFJ50xPuiftP9ZVE62508n5C5Vcuc2RNB4toDNLWqu26iejWI5Szi1fbv
         TtME/tdVCtrrg==
Date:   Sat, 18 Jun 2022 15:54:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Binglei Wang <l3b2w1@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: check the prameter offset in _kprobe_addr()
Message-Id: <20220618155418.e52e7ea9a4872c763d24f84a@kernel.org>
In-Reply-To: <1655476365-21662-1-git-send-email-l3b2w1@gmail.com>
References: <1655476365-21662-1-git-send-email-l3b2w1@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 22:32:45 +0800
Binglei Wang <l3b2w1@gmail.com> wrote:

> From: l3b2w1 <l3b2w1@gmail.com>
> 
> I encounter a problem when using kprobe.
> There is no checkping about the parameter offset in _kprobe_address().
> 
> a. execute command with a valid address, it succeed.
> echo 'p:km __kmalloc+4099' > kprobe_events
> In reality, __kmalloc+4099 points to free_debug_processing+579.
> 
> so we end up with:
> p:kprobes/kp __kmalloc+4099
> 
> b. execute command with an invalid address,
>    failing because of addr crossing instruction boundary
> echo 'p:km __kmalloc+4096' > kprobe_events
> In reality, __kmalloc+4096 points to free_debug_processing+576.
> 
> Thus, if not checkping the offset, it could point to anywhere,
> may succeed with a valid addr, or fail with an invalid addr.
> that's not what we want already.
> 
> When registering a kprobe to debug something,
> either supplied with a symbol name through the sysfs trace
> interface,
> or programming kp.addr with a specific value in a module,
> that means the target function to be probed by us is determined.
> 
> With or whitout an offset(0 or !0),
> it should be limited to be whithin the function body.
> to avoid ending up with a different and unknown function.
> 
> Maybe it's better to check it.

Thanks for reporting. But sorry, this is the intended behavior.
Since there are many "local" symbols those have the same name in
the kernel, we need to use the relative offset from the anchor
symbol (e.g. _text) to put a probe on those functions.
The perf probe tool actually uses that.

Thank you,

> 
> Thank you to review this!
> 
> Signed-off-by: l3b2w1 <l3b2w1@gmail.com>
> ---
>  kernel/kprobes.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c..d5b907a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1449,6 +1449,9 @@ static kprobe_opcode_t *
>  _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
>  	     unsigned long offset, bool *on_func_entry)
>  {
> +	unsigned long addr_offset;
> +	unsigned long symbol_size;
> +
>  	if ((symbol_name && addr) || (!symbol_name && !addr))
>  		goto invalid;
>  
> @@ -1465,14 +1468,20 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
>  			return ERR_PTR(-ENOENT);
>  	}
>  
> +	if (!kallsyms_lookup_size_offset((unsigned long)addr,
> +				&symbol_size, &addr_offset))
> +		return ERR_PTR(-ENOENT);
> +
> +	/* Guarantee probed addr do not step over more than one function */
> +	if (offset >= symbol_size || offset >= symbol_size - addr_offset)
> +		goto invalid;
> +
>  	/*
> -	 * So here we have @addr + @offset, displace it into a new
> -	 * @addr' + @offset' where @addr' is the symbol start address.
> +	 * @addr is the symbol start address
> +	 * @offset is the real 'offset' relative to start address
>  	 */
> -	addr = (void *)addr + offset;
> -	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
> -		return ERR_PTR(-ENOENT);
> -	addr = (void *)addr - offset;
> +	addr -= addr_offset;
> +	offset += addr_offset;
>  
>  	/*
>  	 * Then ask the architecture to re-combine them, taking care of
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
