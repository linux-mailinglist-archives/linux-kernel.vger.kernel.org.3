Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF84C6BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiB1MIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiB1MI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:08:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC95FD3D;
        Mon, 28 Feb 2022 04:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F3eTU03pb76E1ORP3hb/KpZsjDGhzZCbE56yzxqP8q4=; b=JN3jrRBpX2T88x6YqGvSH9chlW
        JQ1HApPsnmw/Z2eJORa/9yH42lJoXMCBTKkO0oL61dOUXdUBOx93wTr8bN9LBxACbVjHEvcVbD3De
        /HQZyf6z7tUvM3j1BbTuYk1R9GNNE2WdsqvR76prGUV6PQdDjPbGhgeMQF2CMIAy3tTPqHKfZWm0L
        PfKRF8M3qLXVsRB+4nqws9Lx4YavRanPh1K7pT64rPJ2zA9P80Ku6kcamz003Gd54ixZicmQ02a2P
        BTRJSXx+t7Y14NljhBdlf8Ydu3jx0i8AQdMIkiJ573RlE4EsTIiEb1oU9G8/t5ROuP2Cokh9ejbTm
        fh7HIm2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOeoQ-008U6Q-1m; Mon, 28 Feb 2022 12:07:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B716300390;
        Mon, 28 Feb 2022 13:07:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5575120244B2C; Mon, 28 Feb 2022 13:07:30 +0100 (CET)
Date:   Mon, 28 Feb 2022 13:07:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, arnd@arndb.de
Subject: Re: [RFT v2] tty/sysrq: Make sysrq handler NMI aware
Message-ID: <Yhy7AnwEMqbcKsEg@hirez.programming.kicks-ass.net>
References: <20220228075351.1412452-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228075351.1412452-1-sumit.garg@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 01:23:51PM +0530, Sumit Garg wrote:
> Allow a magic sysrq to be triggered from an NMI context. This is done

*why* though?


> +#define SYSRQ_NMI_FIFO_SIZE	2
> +static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
> +
> +static void sysrq_do_nmi_work(struct irq_work *work)

That naming don't make sense, it does the !NMI work, from IRQ context.

> +{
> +	const struct sysrq_key_op *op_p;
> +	int orig_suppress_printk;
> +	int key;
> +
> +	orig_suppress_printk = suppress_printk;
> +	suppress_printk = 0;
> +
> +	rcu_sysrq_start();
> +	rcu_read_lock();
> +
> +	if (kfifo_peek(&sysrq_nmi_fifo, &key)) {
> +		op_p = __sysrq_get_key_op(key);
> +		if (op_p)
> +			op_p->handler(key);
> +	}
> +
> +	rcu_read_unlock();
> +	rcu_sysrq_end();
> +
> +	suppress_printk = orig_suppress_printk;
> +
> +	kfifo_reset_out(&sysrq_nmi_fifo);
> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>  	const struct sysrq_key_op *op_p;
> @@ -573,6 +612,10 @@ void __handle_sysrq(int key, bool check_mask)
>  	int orig_suppress_printk;
>  	int i;
>  
> +	/* Skip sysrq handling if one already in progress */
> +	if (!kfifo_is_empty(&sysrq_nmi_fifo))
> +		return;
> +
>  	orig_suppress_printk = suppress_printk;
>  	suppress_printk = 0;
>  
> @@ -596,7 +639,13 @@ void __handle_sysrq(int key, bool check_mask)
>  		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>  			pr_info("%s\n", op_p->action_msg);
>  			console_loglevel = orig_log_level;
> -			op_p->handler(key);
> +
> +			if (in_nmi() && !op_p->nmi_safe) {
> +				kfifo_put(&sysrq_nmi_fifo, key);
> +				irq_work_queue(&sysrq_nmi_work);
> +			} else {
> +				op_p->handler(key);
> +			}
>  		} else {
>  			pr_info("This sysrq operation is disabled.\n");
>  			console_loglevel = orig_log_level;

I'm missing the point of that kfifo stuff; afaict it only ever buffers
_1_ key, might as well use a simple variable, no?
