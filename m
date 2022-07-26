Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C6581A21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiGZTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiGZTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:11:47 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE727B37;
        Tue, 26 Jul 2022 12:11:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B6D5440B22;
        Tue, 26 Jul 2022 15:11:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id F-v6hklY4CT4; Tue, 26 Jul 2022 15:11:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 89428440B21;
        Tue, 26 Jul 2022 15:11:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 89428440B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1658862705;
        bh=vN9ARZK+WvtXE9yychMGzpzNLo2B1FEaXvJk8aAC00M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pSOb7aoADAZMbnJFkOkQ11mqxhZPP4gFbWWmRjvseIWyp2m6snVatqWu+XaMvLhYd
         MetezN1GIWjfNV9Urs2Z7wtb7JjQwKSkEO3j41y9VQldhGOh0FuDdKL76We26RQbI7
         j+5rwXsGgdOdbF82qwnQfuafnmcYeR4tNuL8mloEZVZb5ImVBuZP4K2KUJU0JGmkIf
         Bg1OJMzmCVVUxSFAAu97wQo9bBBT26Snt9fLZssAiZRiNevnH0p/BBf5X5HiDUMAkn
         iSCfMvqz61VD/0zAL3V5LUN9zKI5cAK2KgkLUKk+fHVoGqmgYrGzecXYLxbsyxgJi4
         xB/5tNGwIdg/w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D6o0RAAckapU; Tue, 26 Jul 2022 15:11:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7A826440CA1;
        Tue, 26 Jul 2022 15:11:45 -0400 (EDT)
Date:   Tue, 26 Jul 2022 15:11:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <1021959527.83217.1658862705489.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com> <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: rseq: Kill process when unknown flags are encountered in ABI structures
Thread-Index: XBYLrKi9cAv8nErblMXcBK4sHvOViA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 22, 2022, at 3:46 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> rseq_abi()->flags and rseq_abi()->rseq_cs->flags 29 upper bits are
> currently unused.
> 
> The current behavior when those bits are set is to ignore them. This is
> not an ideal behavior, because when future features will start using
> those flags, if user-space fails to correctly validate that the kernel
> indeed supports those flags (e.g. with a new sys_rseq flags bit) before
> using them, it may incorrectly assume that the kernel will handle those
> flags way when in fact those will be silently ignored on older kernels.
> 
> Validating that unused flags bits are cleared will allow a smoother
> transition when those flags will start to be used by allowing
> applications to fail early, and obviously, when they attempt to use the
> new flags on an older kernel that does not support them.

Hi Peter, as for the prior patch, would you consider pulling this through
the tip tree ?

Thanks,

Mathieu

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> kernel/rseq.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 81d7dc80787b..bda8175f8f99 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32
> cs_flags)
> 	u32 flags, event_mask;
> 	int ret;
> 
> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
> 		return -EINVAL;
> 
> 	/* Get thread flags. */
> @@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32
> cs_flags)
> 	if (ret)
> 		return ret;
> 
> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
> +	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
> 		return -EINVAL;
> 
> 	/*
> --
> 2.30.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
