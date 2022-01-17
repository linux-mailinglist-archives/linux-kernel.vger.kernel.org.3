Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB809490899
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiAQMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiAQMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:22:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DFC061574;
        Mon, 17 Jan 2022 04:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GzoRhHoraaVA0kMnbdbBCv1nuN5yxpvht+5i/5xcrnc=; b=XZxQfrPd/Jw8CK0JiUzMDp4VqK
        4KLe820Yoy9CGkkkJlAnamTnt2jk6LNuqcSDRey3eW2/Rv0wXK+EaUqMa38q2JRtv1ZJza5bkFDqo
        eBPYHTWtdvFoeGkV7FB2RPA8HNWVUQm+LqW6e0di2U22GmppQlNMj9/1BehR8fB+SJ7xPhoTmQR1s
        oIzXZ4y74ivI8GVaFSH4ugg4JLFZ6tox6mototkDVokRdPsLx0l2wqY6X6wKWwTxD0Arov4R5XL94
        IymVQxfiMImQgX8Hun01a90SJiQaQK5x3pG5eSIRqUPy0pVg5pyNylyv7BjJv3JlCRfFIa2bJ4RU8
        6Yg9Ny7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9R1r-001duW-9D; Mon, 17 Jan 2022 12:22:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC1FF300222;
        Mon, 17 Jan 2022 13:22:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A44882027C5FC; Mon, 17 Jan 2022 13:22:30 +0100 (CET)
Date:   Mon, 17 Jan 2022 13:22:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeVfhi3bXzgYBdf3@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeVUgXd6C85VmaP7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVUgXd6C85VmaP7@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:35:29PM +0100, Peter Zijlstra wrote:
> @@ -794,16 +798,31 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
>  		      UMCG_CTL_WORKER))
>  		return -EINVAL;
>  
> -	if (flags == UMCG_CTL_UNREGISTER) {
> -		if (self || !current->umcg_task)
> +	if (flags & UMCG_CTL_UNREGISTER) {
> +		int ret;
> +
> +		if (!self || self != current->umcg_task)
>  			return -EINVAL;
>  
> -		if (current->flags & PF_UMCG_WORKER) {
> -			umcg_worker_exit();
> -			// XXX wake server
> -		} else
> -			umcg_clear_task(current);
> +		current->flags &= ~PF_UMCG_WORKER;
>  
> +		ret = umcg_pin_pages();
> +		if (ret) {
> +			current->flags |= PF_UMCG_WORKER;
> +			return ret;
> +		}
> +
> +		ret = umcg_update_state(current, self, UMCG_TASK_RUNNING, UMCG_TASK_NONE);
> +		if (ret) {
> +			current->flags |= PF_UMCG_WORKER;
> +			return ret;
> +		}

Sorry, should obv only restore PF_UMCG_WORKER for workers.. /me fixes

> +
> +		if (current->flags & PF_UMCG_WORKER)
> +			umcg_wake(current);
> +
> +		umcg_unpin_pages();
> +		umcg_clear_task(current);
>  		return 0;
>  	}
>  
