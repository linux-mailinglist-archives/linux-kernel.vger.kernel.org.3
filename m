Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA84B5946
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357336AbiBNSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357325AbiBNSAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:00:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3762160DBF;
        Mon, 14 Feb 2022 10:00:30 -0800 (PST)
Date:   Mon, 14 Feb 2022 19:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644861628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak1sKXz8pqU5OXOTa42NjAvCBxTswiY6RDJ/LZK1LYo=;
        b=IkWRLBdSRZj83mEOuD+098n0EuZsx/eavbjdr7gD7itzpWuyFy+ZXINbIFdLB6qJIgfvy8
        p+/vLnXLLJtUSPYETWvWAhUDYRONrPwqwZiW0cWImcagv5IFo0JV1EXKB9VhPpuctsMWij
        iwvRW4evO/jVY0Btm+rEsVsUOmPoFJ6ZAnrJBYn6t91baAJ+ujS+74kW5PN3PteLzuF0LJ
        CgFcgnT5lHoRcq1oyKEwtmagIraZs6xrKZA+OEM/wXTGM0KuuDYp1y0cIXWaY3GJWCwCSX
        xq+Y456QSgcwye2zxWHe2A8k0s3/NB+gSaOt4XQuMUdlQ8BWF+N/wfZ+n35EGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644861628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak1sKXz8pqU5OXOTa42NjAvCBxTswiY6RDJ/LZK1LYo=;
        b=YOlChkc5IdQ9d+u21n+PvI+cZ9v++88raxyykO07BA6aOs1XV7nkn6VHvDSCMtGKeq3HU6
        rUvmFqmchHoa4GAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/8] kernel/fork, IA64: Provide a
 alloc_thread_stack_node() for IA64.
Message-ID: <YgqYun8tmIJQZmuN@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220125152652.1963111-4-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 16:26:47 [+0100], To linux-kernel@vger.kernel.org wrote:
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c47dcba5d66d2..a0d58ae6fac76 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -330,6 +330,22 @@ void thread_stack_cache_init(void)
=E2=80=A6
> =20
> +static void free_thread_stack(struct task_struct *tsk, bool cache_only)

This cache_only parameter shouldn't be here=E2=80=A6

> +{
> +	arch_free_thread_stack(tsk);
> +}
> +
>  #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
> =20
>  /* SLAB cache for signal_struct structures (tsk->signal) */

Sebastian
