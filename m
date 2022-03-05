Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABBC4CE518
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiCEOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCEOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:01:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6A4ECFE
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uN2YqCFYxNaPrhAtrpzGne50Njd776Ops2A1Ik2InlM=; b=IlK7BZltsplKRPTKOsfyiStA8a
        D6ajVssDEq87Gm4ohj+BBdMU+bRRhDzGks9LaHj3o/GvRdKW96pTFbCUxbZR5ZBz6Yd8AZgeBdXE2
        EVHU69Uhmulv+XZkaC0XK6WKsk+QTmC2ttXfWxDwETHwFZHv+KHJEjMy+okQtnxZpleBQPC/Z2buj
        23Wbn/y8b8PRLz7eJqcnfzdwIEqfLGcslmpG6lY7r2uUd76iK2tJfCe9Pv3R2UlvWcXayzF6fFg7J
        e50WqTw5XAr+aFvTPrxUQ8gxUfybYK/1fsbcVr97CMx4XBLFjItvvxra0Ip80EHSPOZAJg4Nt+rf/
        zOZLThyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQUwg-00FX30-KE; Sat, 05 Mar 2022 13:59:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B0AF9865F2; Sat,  5 Mar 2022 14:59:40 +0100 (CET)
Date:   Sat, 5 Mar 2022 14:59:40 +0100
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
Subject: Re: [PATCH 02/19] context_tracking: Rename
 context_tracking_user_enter/exit() to user_enter/exit_callable()
Message-ID: <20220305135940.GU11184@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:47:53PM +0100, Frederic Weisbecker wrote:
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index ad2a973393a6..83e050675b23 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -125,11 +125,16 @@ void context_tracking_enter(enum ctx_state state)
>  NOKPROBE_SYMBOL(context_tracking_enter);
>  EXPORT_SYMBOL_GPL(context_tracking_enter);
>  
> -void context_tracking_user_enter(void)
> +/**
> + * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
> + * 			   archs that didn't manage to check the context tracking
> + * 			   static key from low level code.
> + */
> +void user_enter_callable(void)
>  {
>  	user_enter();
>  }
> -NOKPROBE_SYMBOL(context_tracking_user_enter);
> +NOKPROBE_SYMBOL(user_enter_callable);
>  
>  /**
>   * __ct_user_exit - Inform the context tracking that the CPU is
> @@ -182,11 +187,16 @@ void context_tracking_exit(enum ctx_state state)
>  NOKPROBE_SYMBOL(context_tracking_exit);
>  EXPORT_SYMBOL_GPL(context_tracking_exit);
>  
> -void context_tracking_user_exit(void)
> +/**
> + * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
> + * 			  archs that didn't manage to check the context tracking
> + * 			  static key from low level code.
> + */
> +void user_exit_callable(void)
>  {
>  	user_exit();
>  }
> -NOKPROBE_SYMBOL(context_tracking_user_exit);
> +NOKPROBE_SYMBOL(user_exit_callable);

I'm thinking all this wants to be noinstr instead of NOKPROBE_SYMBOL..
