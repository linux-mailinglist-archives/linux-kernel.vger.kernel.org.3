Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57EF4D9E44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbiCOPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiCOPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:00:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB62251F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:58:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647356330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulf/uwGYySvO0GU6zVR9J6JfZ+MYD4+7rV3PLJWiuI8=;
        b=LpzjqtcaozRawwKXyxPRQbb+KtmnspcDkxrH+H9PHlnFbSHNigfps+Bm8HPXh30nZFurcB
        giwA32TPGNPcwYXdRcd4hdgzFsz9NgNO8oKMng6GdVAlq+O9Ud6j0WosZVrXEjBTAZehSw
        p7lqwS2B9JpNjgwZ+fBy4w3ZsOwfgonQMjTy5++ymHlcaUKZWZ+3Qcc1eAK/bcjXeg3K9O
        Ievdie5xBTulyNpIXf0cnAihT8I65dxwrgLFJwA0QTFHDV3ExseuqQxxu1cqIf/LFsKEsN
        txRT5+12hSsj4oLJPWXo5jaTGyl1bXt3ZgbLGfrbinxRdtjhorQtLmWOTR7DYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647356330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulf/uwGYySvO0GU6zVR9J6JfZ+MYD4+7rV3PLJWiuI8=;
        b=dnh1cPyZ723IZjxPEZcC1flakjJpM+2pDWasj7nQ3Qgf4bgvPAMkHVPm+k4IknhSZ3nfmB
        DMFcjanJl04j0hDg==
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_work: simplify the task_work_add() interface
In-Reply-To: <20220223072754.616027-1-hch@lst.de>
References: <20220223072754.616027-1-hch@lst.de>
Date:   Tue, 15 Mar 2022 15:58:49 +0100
Message-ID: <87y21b5kk6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23 2022 at 08:27, Christoph Hellwig wrote:
> Provide a low-level task_work_add_nonotify interface that just adds
> the work to the list and open code the TWA_SIGNAL and TWA_NONE callers
> using it.  task_work_add() itself now only handles the common TWA_RESUME
> case and can drop the notify argument.

There is a distinct lack of justification in that change log.

>  	worker->create_index = acct->index;
> -	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
> +	if (!task_work_add_nonotify(wq->task, &worker->create_work)) {
> +		set_notify_signal(wq->task);

I fail to see the improvement here.

> @@ -9606,7 +9606,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
>  					ctx_node);
>  		/* don't spin on a single task if cancellation failed */
>  		list_rotate_left(&ctx->tctx_list);
> -		ret = task_work_add(node->task, &exit.task_work, TWA_SIGNAL);
> +		ret = task_work_add_nonotify(node->task, &exit.task_work);

While I clearly see the regression in this case ...

>  		if (WARN_ON_ONCE(ret))
>  			continue;
>  /**
> - * task_work_add - ask the @task to execute @work->func()
> + * task_work_add_nonotify - ask the @task to execute @work->func()
>   * @task: the task which should run the callback
>   * @work: the callback to run
>   * @notify: how to notify the targeted task

This parameter is removed below ...

Thanks,

        tglx
