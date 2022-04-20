Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B708508C96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350606AbiDTP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbiDTP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE32DD63
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:56:55 -0700 (PDT)
Date:   Wed, 20 Apr 2022 17:56:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650470213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVj4PC9oWNqvYVPXKPf4qEimB9W75/+kwVZ5tR23GpI=;
        b=XuI+FMLzOWNK0frrgUoXV8NElncf/dmQtHo1wQaRoKrXtriVicAAu+eLQUn1NfTcc+5Uoc
        Aza3nXF97Gr+bhoQQoA/IrJY0ijOjUeVkF9AzThgV10uVH7zw3yetKIKELAJkt8KBZcbLa
        bja5awR4dB67a6gVmtqf85vRn8776HmZG4K4X0o4fg1SCZ708Q4Bk5ovBH5kZgR9vSgEum
        GlxBeKxRguORhDYuLZ14CdSNjbL3UPS/uzGu2o04V+tlIRi3MJ1EpP0YHaGu1EWz3fpDuI
        grxhHufQFSVM6l1JVJSy4ql7q4W02dqsi1kMtdS9Vnt1eAtMe43Gj4J15YUrAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650470213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVj4PC9oWNqvYVPXKPf4qEimB9W75/+kwVZ5tR23GpI=;
        b=DM27W01wqlcTieEjBDOGN84ro76MphENbP1EauMN0mtTmhqZ11Gx0bhVQyGZkx0Q/eZjBS
        P2fqeYCSvVI6BjAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V5 3/3] smp: Make softirq handling RT safe in
 flush_smp_call_function_queue()
Message-ID: <YmAtQZHSbcqbwGj4@linutronix.de>
References: <20220413132836.099363044@linutronix.de>
 <20220413133024.356509586@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220413133024.356509586@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-13 15:31:05 [+0200], Thomas Gleixner wrote:
=E2=80=A6
> +#ifdef CONFIG_PREEMPT_RT
> +extern void do_softirq_post_smp_call_flush(unsigned int was_pending);
> +#else
> +static inline void do_softirq_post_smp_call_flush(unsigned int unused)
> +{
> +	do_softirq();
> +}
> +#endif
> +
=E2=80=A6
> +void softirq_post_smp_call_flush(unsigned int was_pending)
> +{
> +	if (WARN_ON_ONCE(was_pending !=3D local_softirq_pending()))
> +		invoke_softirq();
> +}
> +
>  #else /* CONFIG_PREEMPT_RT */

fold, please.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1682586a69139..5b36ebe5e20de 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -301,7 +301,7 @@ static inline void invoke_softirq(void)
  * get raised which haven't been raised before the flush, warn so it can be
  * investigated.
  */
-void softirq_post_smp_call_flush(unsigned int was_pending)
+void do_softirq_post_smp_call_flush(unsigned int was_pending)
 {
 	if (WARN_ON_ONCE(was_pending !=3D local_softirq_pending()))
 		invoke_softirq();

Sebastian
