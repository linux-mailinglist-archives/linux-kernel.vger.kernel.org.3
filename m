Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7D585F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiGaOlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C35A19E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 07:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF204B80D8A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF51C433D6;
        Sun, 31 Jul 2022 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659278504;
        bh=/VY0JcpWBzVlKgTefY2QmyW3gX+3iv5TvEdiLJBFYxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o0OievKP/OuWplIHdFfsi1yDZ5VZjNb1ZHETFcxRoV+KwD4t6Z3WZrYgl69x19c3c
         8Q58lrhHej5y7vPgVHI9m/T+3VNOKOrYuFwvLw2M+MX3NSoG4uFly4L7qkIK9gQAVE
         bsYO1ev0bW7OwFptYhBSlsh2CHAVdOtuGBKiOE7Z5hI+DflCIeEczuxOnphcNm25Zu
         gL48CbIwLI5fPCAeTM91n4lY9TeyhDjOW3VJKnjp64aF37eLelzJdgVe4OtMICD7KC
         ebnvfcjXCO4qeYSAwMDzhEzwqQbLxlm5O7XyLRaUzb+toKAfK9kqQN4KaxQR0DpMGS
         vVSzRWkdmGGdw==
Date:   Sun, 31 Jul 2022 23:41:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     zhangduo <zduo006@163.com>
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, zhangduo@kylinos.cn
Subject: Re: [PATCH 2/2] kprobes: modify the copy_kprobe to make more
 clearly
Message-Id: <20220731234140.ad23f7d8c7c389112ac65487@kernel.org>
In-Reply-To: <20220728124516.60621-1-zduo006@163.com>
References: <20220728124516.60621-1-zduo006@163.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 20:45:16 +0800
zhangduo <zduo006@163.com> wrote:

> From: zhangduo <zhangduo@kylinos.cn>
> 
>   copy_kprobe() are called in init_aggr_kprobe() to copy opcode
>   and insn from 'p' to 'ap',but in copy_kprobe(p,ap) implemtation
>   'p' pass to 'struct kprobe *ap' , 'ap' pass to 'struct kprobe *p',
>   it looks strange, because p means orig kprobe instance, ap
>   means aggregator kprobe, not the same.  and before the add_new_kprobe()
>   calling used the opposite copy from 'ap' to 'p', so modify copy_kprobe's
>   parameter name as 'p_src' and 'p_dst' to fit all.

Agreed, that was confusing.

This doesn not change the behavior, but better to be read
(the arguments are sorted as same as memcpy(dst, src))

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: zhangduo <zhangduo@kylinos.cn>
> ---
>  kernel/kprobes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4f3e84343..8bcef7d3c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -405,10 +405,10 @@ static inline bool kprobe_unused(struct kprobe *p)
>  }
>  
>  /* Keep all fields in the kprobe consistent. */
> -static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
> +static inline void copy_kprobe(struct kprobe *p_dst, struct kprobe *p_src)
>  {
> -	memcpy(&p->opcode, &ap->opcode, sizeof(kprobe_opcode_t));
> -	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
> +	memcpy(&p_dst->opcode, &p_src->opcode, sizeof(kprobe_opcode_t));
> +	memcpy(&p_dst->ainsn, &p_src->ainsn, sizeof(struct arch_specific_insn));
>  }
>  
>  #ifdef CONFIG_OPTPROBES
> @@ -1277,7 +1277,7 @@ static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
>  static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
>  {
>  	/* Copy the insn slot of 'p' to 'ap'. */
> -	copy_kprobe(p, ap);
> +	copy_kprobe(ap, p);
>  	flush_insn_slot(ap);
>  	ap->addr = p->addr;
>  	ap->flags = p->flags & ~KPROBE_FLAG_OPTIMIZED;
> @@ -1350,7 +1350,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
>  	}
>  
>  	/* Copy the insn slot of 'ap' to 'p'. */
> -	copy_kprobe(ap, p);
> +	copy_kprobe(p, ap);
>  	ret = add_new_kprobe(ap, p);
>  
>  out:
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
