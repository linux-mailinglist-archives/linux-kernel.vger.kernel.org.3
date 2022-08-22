Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476A959CB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiHVVuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiHVVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:50:01 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252FA5140C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661205000; x=1692741000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pixz7g+KkMzwbfbZ7vhsdaC9zaHW9EzQWos4Q+nR9cQ=;
  b=pCUdK+pOnRe4/PQ3PWA/HUoyh63QH3Bmfpv29OzLFc5dlGVmEF+FeUUA
   iPAJ3vinVaMMMDgePzP9kRRL3ysKEbav7ZxhcalFbqNusYNTZFNNejU+d
   /KWk7cyt/omT4/5bC9AViftSeCPWzhj72HABETt6jZ1ZeMe0/UyysRXk7
   o=;
X-IronPort-AV: E=Sophos;i="5.93,255,1654560000"; 
   d="scan'208";a="232840128"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:49:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 95A828127C;
        Mon, 22 Aug 2022 21:49:46 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 21:49:45 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.140) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 22 Aug 2022 21:49:43 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <keescook@chromium.org>
CC:     <ayudutta@amazon.com>, <brauner@kernel.org>, <kuni1840@gmail.com>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <luto@amacapital.net>,
        <syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com>,
        <wad@chromium.org>
Subject: Re: [PATCH v1] seccomp: Release filter when copy_process() fails.
Date:   Mon, 22 Aug 2022 14:49:35 -0700
Message-ID: <20220822214935.29842-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202208221414.A0E13E7@keescook>
References: <202208221414.A0E13E7@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D01UWA001.ant.amazon.com (10.43.160.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Aug 2022 14:16:03 -0700
> On Mon, Aug 22, 2022 at 01:44:36PM -0700, Kuniyuki Iwashima wrote:
> > Our syzbot instance reported memory leaks in do_seccomp() [0], similar
> > to the report [1].  It shows that we miss freeing struct seccomp_filter
> > and some objects included in it.
> > 
> > We can reproduce the issue with the program below [2] which calls one
> > seccomp() and two clone() syscalls.
> > 
> > The first clone()d child exits earlier than its parent and sends a
> > signal to kill it during the second clone(), more precisely before the
> > fatal_signal_pending() test in copy_process().  When the parent receives
> > the signal, it has to destroy the embryonic process and return -EINTR to
> > user space.  In the failure path, we have to call seccomp_filter_release()
> > to decrement the filter's ref count.
> > 
> > Initially, we called it in free_task() called from the failure path, but
> > the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
> > dead") moved it to release_task() to notify user space as early as possible
> > that the filter is no longer used.
> > 
> > To keep the change, let's call seccomp_filter_release() in copy_process()
> > and add a WARN_ON_ONCE() in free_task() for future debugging.
> 
> Thanks for tracking this down! I think I'd prefer to avoid changing the
> semantics around the existing seccomp refcount lifetime, so what about
> just moving copy_seccomp() below the last possible error path?

Actually, I also thought of it but avoid it because it means we move the
signal check relatively earlier than before, so would-be-killed processes
could consume more resouces.

What do you think about this?

> 
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 90c85b17bf69..e7f4e7f1e01e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2409,12 +2409,6 @@ static __latent_entropy struct task_struct *copy_process(
>  
>  	spin_lock(&current->sighand->siglock);
>  
> -	/*
> -	 * Copy seccomp details explicitly here, in case they were changed
> -	 * before holding sighand lock.
> -	 */
> -	copy_seccomp(p);
> -
>  	rv_task_fork(p);
>  
>  	rseq_fork(p, clone_flags);
> @@ -2431,6 +2425,14 @@ static __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_cancel_cgroup;
>  	}
>  
> +	/* No more failures paths after this point. */
> +
> +	/*
> +	 * Copy seccomp details explicitly here, in case they were changed
> +	 * before holding sighand lock.
> +	 */
> +	copy_seccomp(p);
> +
>  	init_task_pid_links(p);
>  	if (likely(p->pid)) {
>  		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
> 
> 
> Totally untested, but I think it would fix this?
> 
> -Kees
> 
> -- 
> Kees Cook
