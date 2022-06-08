Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A3543038
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiFHMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbiFHMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:23:53 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79A11CB732
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:23:48 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C9AE5B0029F; Wed,  8 Jun 2022 14:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1654691025; bh=Dqp3UNZj24AihPQbByxI29k6/zx3njIxMdo6IGXPy4A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ujq/NsBN4f0T6gznoVp6PlGaQMBDlQVXP0U56PC162ToLv7txeNrHW2UW73VPeUT1
         ne7iMf0eYih60b1+yMn/0VP8aTcN2ELBvVUrsFUiIk/hY6qzZDGJzuijhBdybh4cRd
         6/L8sReQ6x+ekTtn+OceroBP+uOfCIVDM4TQvjhtyZrhsp87MqSyQYhDyr5rNRijko
         WHzO7LZYFHlSP8rXs91vP9MPFR09gQXLH+lMpPqlRZIWnsU4q4eyFEgWPltUgtzL8R
         KTabq93Yc+y4Bik++2awsEha6MLGP0N9rQZov/NbLU7B2Kyi4tPQm2iwHV+6tZ7Wxl
         XE7qEQKuG/0JQ==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C5DACB0005A;
        Wed,  8 Jun 2022 14:23:45 +0200 (CEST)
Date:   Wed, 8 Jun 2022 14:23:45 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com> <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com> <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de> <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022, Rongwei Wang wrote:

> If available, I think document the issue and warn this incorrect behavior is
> OK. But it still prints a large amount of confusing messages, and disturbs us?

Correct it would be great if you could fix this in a way that does not
impact performance.

> > are current operations on the slab being validated.
> And I am trying to fix it in following way. In a short, these changes only
> works under the slub debug mode, and not affects the normal mode (I'm not
> sure). It looks not elegant enough. And if all approve of this way, I can
> submit the next version.


>
> Anyway, thanks for your time:).
> -wrw
>
> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s,
struct
> slab *slab,
>
>  {
>         void *prior;
> -       int was_frozen;
> +       int was_frozen, to_take_off = 0;
>         struct slab new;

to_take_off has the role of !n ? Why is that needed?

> -       do {
> -               if (unlikely(n)) {
> +               spin_lock_irqsave(&n->list_lock, flags);
> +               ret = free_debug_processing(s, slab, head, tail, cnt, addr);

Ok so the idea is to take the lock only if kmem_cache_debug. That looks
ok. But it still adds a number of new branches etc to the free loop.

Some performance tests would be useful.

