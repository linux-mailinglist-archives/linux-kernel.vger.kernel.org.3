Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12346D6CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhLHPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:23:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51378 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbhLHPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:23:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8ABFECE2207;
        Wed,  8 Dec 2021 15:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA916C341C6;
        Wed,  8 Dec 2021 15:20:09 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:20:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Jerome Marchand" <jmarchan@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] ftrace: disable preemption when recursion locked in
 arch/s390/kernel/ftrace.c
Message-ID: <20211208102008.197df008@gandalf.local.home>
In-Reply-To: <20211208151503.1510381-1-jmarchan@redhat.com>
References: <20211208151503.1510381-1-jmarchan@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This really needs to go through the s390 tree.

-- Steve


On Wed,  8 Dec 2021 16:15:03 +0100
"Jerome Marchand" <jmarchan@redhat.com> wrote:

> It looks like commit ce5e48036c9e76a2 ("ftrace: disable preemption
> when recursion locked") missed a spot in kprobe_ftrace_handler() in
> arch/s390/kernel/ftrace.c.
> Removes the superfluous preempt_disable/enable_notrace() there too.
> 
> Fixes: ce5e48036c9e76a2 ("ftrace: disable preemption when recursion locked")
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>  arch/s390/kernel/ftrace.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index 5510c7d10ddc..21d62d8b6b9a 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -290,7 +290,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		return;
>  
>  	regs = ftrace_get_regs(fregs);
> -	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (unlikely(!p) || kprobe_disabled(p))
>  		goto out;
> @@ -318,7 +317,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	}
>  	__this_cpu_write(current_kprobe, NULL);
>  out:
> -	preempt_enable_notrace();
>  	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);

