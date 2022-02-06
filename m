Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C734AB27D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiBFVwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiBFVwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:52:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEAC06173B;
        Sun,  6 Feb 2022 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LpmECHwhY5bymF/szEavvJfdxr7I9/BGBB6YXd8SHcs=; b=Tg8wngnVpOc29GsiU16mOE6ZpV
        18W3XiRucZIN/NFQO1lLA2Vmr23uUa7sHkwouG+mVCk/RxeUeikKzzW/VUwAIRb+lL9IZafbwAoqG
        zlXOdRLwpJHN4J6LqGDvHhwYzOizMr9DJkPuLO25oiBenjhyRRvwpR7yHVXsZduN5Pz7HsLxgpLPE
        ddb8gDyixOVU4LKN3ELA8yOULwTeYLzEVErZ9FhBDbB44zoBeBLL/DvGcL1cC2E/F3yw8/SCQyFxq
        DQk75IVjVm/55+evUez8G9aPvBvZrbmFX+CZPInT/Dd9GNZHzcnkOe8Y5EftEXyjlYcyveOauJVGv
        fdu0exyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGpSB-007YhO-3H; Sun, 06 Feb 2022 21:52:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5E1B300470;
        Sun,  6 Feb 2022 22:52:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B09A420137FA2; Sun,  6 Feb 2022 22:52:13 +0100 (CET)
Date:   Sun, 6 Feb 2022 22:52:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        libc-coord@lists.openwall.com
Subject: Re: [RFC PATCH 3/3] rseq: extend struct rseq with numa node id
Message-ID: <YgBDDVZSZqID8L3R@hirez.programming.kicks-ass.net>
References: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
 <20220203193853.21511-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203193853.21511-3-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:38:53PM -0500, Mathieu Desnoyers wrote:
> +static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
>  {
> -	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
> +	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
>  
>  	/*
>  	 * Reset cpu_id_start to its initial state (0).
> @@ -124,6 +126,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>  	 */
>  	if (put_user(cpu_id, &t->rseq->cpu_id))
>  		return -EFAULT;
> +	/*
> +	 * Reset node_id to its initial state (0).
> +	 */
> +	if (put_user(node_id, &t->rseq->node_id))
> +		return -EFAULT;

Why 0 vs -1 ?
