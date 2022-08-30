Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D55A60B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiH3KYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiH3KYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:24:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D671ADBF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:24:32 -0700 (PDT)
Date:   Tue, 30 Aug 2022 12:24:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661855071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUH+ZpuDeiFABhrLrRpOqKqhbAcqK/Lcv9H+mHNqG2Y=;
        b=z1xmTM4ha8NYL4Pj7YkC4XzfLdL8pKnTm/+FfPTCZhm515H6H+TBsj7Mv2HI5Ne6VMOti4
        kZk3Do2phz+tu+BK6nS3SK185Y2UT/q8QCHxrZ2bw3A9RFoLyrJfaJ/G6XdNH2j6khsrc4
        RE7enFnCpkQapljR+VoLVz4LuLUjWCupYsdbgdQ/oHeXyGmJqIh7+3qcK8ON1UdhAidtdb
        OxNFFXJkwCTfVNNUCXignPQzAvGWXFlxPywEEvbZiGhtGfUWFWOcDLqm7F9s1dScNrcSIF
        fYbuV4mXzhYCXM4EXQoudL5WQn+KweR4DSM7ommmqPPHqXXnAE7Gvqxd5CWGFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661855071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUH+ZpuDeiFABhrLrRpOqKqhbAcqK/Lcv9H+mHNqG2Y=;
        b=/SkBUZOPBbawnhtG4VKOA1wPBgAOGegOM0sIKXRV1R6jLMVLoi/V317dbYxd1VTMrD21Pq
        Z5nl7yTZSWfauDDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     vbabka@suse.cz, linux-mm@kvack.org, rientjes@google.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH RFC] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <Yw3lXaDTfvJcEM4Q@linutronix.de>
References: <20220829154805.1205507-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220829154805.1205507-1-mlombard@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-29 17:48:05 [+0200], Maurizio Lombardi wrote:
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..d46ee90651d2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2681,30 +2681,34 @@ struct slub_flush_work {
>  	bool skip;
>  };
> =20
> +static void flush_cpu_slab(void *d)
> +{
> +	struct kmem_cache *s =3D d;
> +	struct kmem_cache_cpu *c =3D this_cpu_ptr(s->cpu_slab);
> +
> +	if (c->slab)
> +		flush_slab(s, c);
> +
> +	unfreeze_partials(s);
> +}
=E2=80=A6
> @@ -2721,13 +2725,18 @@ static void flush_all_cpus_locked(struct kmem_cac=
he *s)
>  	lockdep_assert_cpus_held();
>  	mutex_lock(&flush_lock);
> =20
> +	if (in_task()) {
> +		on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);

This blocks with disabled preemption until it completes flush_cpu_slab()
on all CPUs. That function acquires a local_lock_t which can not be
acquired from in-IRQ which is where this function will be invoked due to
on_each_cpu_cond().

Couldn't we instead use a workqueue with that WQ_MEM_RECLAIM bit? It may
reclaim memory after all ;)

Sebastian
