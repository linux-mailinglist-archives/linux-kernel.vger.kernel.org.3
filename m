Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A8581A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiGZTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiGZTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:10:58 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A572C13E;
        Tue, 26 Jul 2022 12:10:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A7BEA440A5A;
        Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Re7W2pLa6O7j; Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3F7044407F1;
        Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3F7044407F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1658862655;
        bh=P0Jm8sAa/mrVBp/6VFgZCxx378vjOndqqAOWx+aDPbU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a99k/XYmoPmrZXRbMD5KV4tR3u2lKCLrERtZX6p5K32C/QJhwMhdr9RGJg1aLj+dU
         W75olxaKy5Z0pmh1DaaZdJOP9wy4FO0d9OrhnpT0qZ+N8wkx/+FZi58hr4yOS6wbBH
         IIGlPSzibaHXH2deXlRpP3YcbYELcuZmV+EzBhWE7ijsAD88PT6QgpZrCG9sYwxWc5
         hCrj7V7/Ohi8aVHdY+smwQ7uYouABVudlNFmer3VP/rPy8yndxWzVSX3dOgF6KTQm+
         njzfwlOrTcdDn1d0Yx3DVI7IkRzVeJNoVDD9L+3h6e0YRTNsBwNOZNKE4c129BmHfH
         3Wro93uZ9j69w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QxTQ8MLNlQw0; Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2F0E8440D00;
        Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
Date:   Tue, 26 Jul 2022 15:10:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <790910676.83207.1658862655138.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags
Thread-Index: okUY3mzxLKojq7TSqc3xEuNzQtQsig==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 22, 2022, at 3:46 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> The pretty much unused RSEQ_CS_FLAG_NO_RESTART_ON_* flags introduce
> complexity in rseq, and are subtly buggy [1]. Solving those issues
> requires introducing additional complexity in the rseq implementation
> for each supported architecture.
> 
> Considering that it complexifies the rseq ABI, I am proposing that we
> deprecate those flags. [2]
> 
> So far there appears to be consensus from maintainers of user-space
> projects impacted by this feature that its removal would be a welcome
> simplification. [3]
> 
> The deprecation approach proposed here is to issue WARN_ON_ONCE() when
> encountering those flags and kill the offending process with sigsegv.
> This should allow us to quickly identify whether anyone yells at us for
> removing this.

Hi Peter, would you consider pulling this patch through the tip tree ?

Thanks,

Mathieu

> 
> Link:
> https://lore.kernel.org/lkml/20220618182515.95831-1-minhquangbui99@gmail.com/
> [1]
> Link:
> https://lore.kernel.org/lkml/258546133.12151.1655739550814.JavaMail.zimbra@efficios.com/
> [2]
> Link:
> https://lore.kernel.org/lkml/87pmj1enjh.fsf@email.froward.int.ebiederm.org/ [3]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> kernel/rseq.c | 23 ++++++++---------------
> 1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 97ac20b4f738..81d7dc80787b 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -18,8 +18,9 @@
> #define CREATE_TRACE_POINTS
> #include <trace/events/rseq.h>
> 
> -#define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
> -				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
> +#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
> +				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
> +				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
> 
> /*
>  *
> @@ -175,23 +176,15 @@ static int rseq_need_restart(struct task_struct *t, u32
> cs_flags)
> 	u32 flags, event_mask;
> 	int ret;
> 
> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
> +		return -EINVAL;
> +
> 	/* Get thread flags. */
> 	ret = get_user(flags, &t->rseq->flags);
> 	if (ret)
> 		return ret;
> 
> -	/* Take critical section flags into account. */
> -	flags |= cs_flags;
> -
> -	/*
> -	 * Restart on signal can only be inhibited when restart on
> -	 * preempt and restart on migrate are inhibited too. Otherwise,
> -	 * a preempted signal handler could fail to restart the prior
> -	 * execution context on sigreturn.
> -	 */
> -	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
> -		     (flags & RSEQ_CS_PREEMPT_MIGRATE_FLAGS) !=
> -		     RSEQ_CS_PREEMPT_MIGRATE_FLAGS))
> +	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
> 		return -EINVAL;
> 
> 	/*
> @@ -203,7 +196,7 @@ static int rseq_need_restart(struct task_struct *t, u32
> cs_flags)
> 	t->rseq_event_mask = 0;
> 	preempt_enable();
> 
> -	return !!(event_mask & ~flags);
> +	return !!event_mask;
> }
> 
> static int clear_rseq_cs(struct task_struct *t)
> --
> 2.30.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
