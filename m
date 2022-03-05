Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793944CE521
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCEOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCEOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:12:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA081FE560
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jeNcFmgrn3+kY5jZmV4s6VOWhKaGUdSIMA7lAQuefnQ=; b=eTDJsFJadMdqT2cIkkmbl+KMMh
        sAkMjhLGNSCkNU256Bpd/2yb5tEDtoZVUebG5qEgdHgoicmAovEQ/6CG3xehm22Jfrpf1iyAaT8Kq
        GEs8ab8RGmwsmZOHqDajMvHTHXLhMqWd5rbBWrJuitTbFJYJvTKELkrRUqRvG1lvtXnNAOadL5zDX
        2zLFfmFLWVQ/J/AdVV/Xox2UA6orKCl5WtG61qbpRNff3Zr9B/8zku2cogDhBetTRr+MoY0AE4k8/
        uffLBymcL1oKEHGkscstR1vqkyQk24+Yao/R2w0wTZ7/1kYmms/1I1TW3WG+Mw5THQdHCBRJF0Fnb
        PKxNCwzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQV7o-00DdBp-TQ; Sat, 05 Mar 2022 14:11:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95D4A9865F2; Sat,  5 Mar 2022 15:02:33 +0100 (CET)
Date:   Sat, 5 Mar 2022 15:02:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/19] context_tracking: Rename
 context_tracking_enter/exit() to ct_user_enter/exit()
Message-ID: <20220305140233.GV11184@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-4-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:47:54PM +0100, Frederic Weisbecker wrote:
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 83e050675b23..e8e58c10f135 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -103,7 +103,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
>  }
>  EXPORT_SYMBOL_GPL(__ct_user_enter);
>  
> -void context_tracking_enter(enum ctx_state state)
> +void ct_user_enter(enum ctx_state state)
>  {
>  	unsigned long flags;
>  
> @@ -122,8 +122,8 @@ void context_tracking_enter(enum ctx_state state)
>  	__ct_user_enter(state);
>  	local_irq_restore(flags);
>  }
> -NOKPROBE_SYMBOL(context_tracking_enter);
> -EXPORT_SYMBOL_GPL(context_tracking_enter);
> +NOKPROBE_SYMBOL(ct_user_enter);
> +EXPORT_SYMBOL_GPL(ct_user_enter);
>  
>  /**
>   * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
> @@ -173,7 +173,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
>  }
>  EXPORT_SYMBOL_GPL(__ct_user_exit);
>  
> -void context_tracking_exit(enum ctx_state state)
> +void ct_user_exit(enum ctx_state state)
>  {
>  	unsigned long flags;
>  
> @@ -184,8 +184,8 @@ void context_tracking_exit(enum ctx_state state)
>  	__ct_user_exit(state);
>  	local_irq_restore(flags);
>  }
> -NOKPROBE_SYMBOL(context_tracking_exit);
> -EXPORT_SYMBOL_GPL(context_tracking_exit);
> +NOKPROBE_SYMBOL(ct_user_exit);
> +EXPORT_SYMBOL_GPL(ct_user_exit);
>  
>  /**
>   * user_exit_callable() - Unfortunate ASM callable version of user_exit() for

Why is it NOKPROBE but not notrace, also local_irq_*() include explicit
tracepoints.
