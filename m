Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1A5A6CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH3S7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3S7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:59:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6E7755B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:59:35 -0700 (PDT)
Date:   Tue, 30 Aug 2022 20:59:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661885974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30hwmgNyab1o6UAoaSXl7ThhaGzoswkIVJZDDP581Tg=;
        b=iUIan095w7Sk0bxx8quXKIktV6pmOk2W93WIbOKcHCQaWKbFQNsJUL7tkOQdtzOW3L2RNg
        WtzgisD/H6Du/EQa6x3xmvTqjuYDESdJlNgliR8J215aYfrTQswENysVfbDt72/ZHKc9jZ
        C6WXjZmwrGkDUQaRkSwv8T4OhM5fELDKviOChlGsACKEIr/P/zow3G47egUYqkHAD5so6I
        Rcrhmq2SG60btMpFnmyoogEwEhvMqxugpoKxQv5n0FnuLKXhiRik+qHG8cTsXsRAvBkxPz
        xa3sHd7WCs4Q8/juMxZJ4XiJA+ZRbIebzhR5F/kKnZ2bXQx0blvr5rzpLfiZQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661885974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30hwmgNyab1o6UAoaSXl7ThhaGzoswkIVJZDDP581Tg=;
        b=GjPVsF1PokOV1x3eVcXX7bNwS8YjTnNRrRHgHawjZ0v01fKgNn1V9EopdVfhl1JFYIA206
        Quq2l0nFZjC0oHBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de
Subject: Re: [PATCH RFC] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <Yw5eFGRreMA0I95S@linutronix.de>
References: <20220829154805.1205507-1-mlombard@redhat.com>
 <Yw3lXaDTfvJcEM4Q@linutronix.de>
 <CAFL455=4SBhJ4LpiPQr+PmL2ShuTpR=bAo8JVfe-2x3cg85cbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFL455=4SBhJ4LpiPQr+PmL2ShuTpR=bAo8JVfe-2x3cg85cbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-30 17:48:06 [+0200], Maurizio Lombardi wrote:
> Hmm, this is not good indeed. I guess I should have used for_each_online_cpu()
> instead of on_each_cpu_cond().

But you must not invoked that function cross-CPU since the code expects
to access the per-CPU variables always from the local-CPU.

> >
> > Couldn't we instead use a workqueue with that WQ_MEM_RECLAIM bit? It may
> > reclaim memory after all ;)
> 
> That should also fix it, do you think it would be ok to allocate a workqueue in
> in kmem_cache_init() ?

I guess so. There is probably none that is already available.

> Thanks,
> Maurizio

Sebastian
