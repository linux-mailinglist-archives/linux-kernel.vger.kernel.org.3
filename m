Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BB54C289
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiFOHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiFOHSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925243AC3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:18:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8E0121BB0;
        Wed, 15 Jun 2022 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655277490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMt3oJA4fSKsh4xSwi7sRKev87Zd3pbM/uv1RnkK/Ds=;
        b=V0ZB6Sbr3/hC7OlvGxVHsCeQOidkA+pkG15bb6JObSN+fLpuDU7zUPeZEhtDdm+1VkKfhr
        E5wdyAQw2QFmcRhSsU8DIw+L7+nNVs4Kj5e6nv2GwNxJWUsOCdecw5aTm3TD5P90k1e6J3
        yBf42fXKsTWoM8ERDzQR+83voXiiUEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655277490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMt3oJA4fSKsh4xSwi7sRKev87Zd3pbM/uv1RnkK/Ds=;
        b=LmuvlO6/7J0n30vBveW0eSdWZX56kA4RpwSmOiJzVIB5lKgsW97LJJCNTJjw/RgzPsPD90
        xv9QjL33B3x6jWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5DF9139F3;
        Wed, 15 Jun 2022 07:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tGunK7KHqWKMAQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Jun 2022 07:18:10 +0000
Message-ID: <8fa5bba6-b48c-9cb5-2051-2d986a9d653b@suse.cz>
Date:   Wed, 15 Jun 2022 09:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220608182205.2945720-1-jannh@google.com>
 <95a9f679-93d9-548a-fc26-985ec605e7f8@suse.cz>
 <CAG48ez2grcFO9FUApstmmr6QcVxbx=68MDXRtP_hQqAmYWn17w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG48ez2grcFO9FUApstmmr6QcVxbx=68MDXRtP_hQqAmYWn17w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 17:54, Jann Horn wrote:
> On Tue, Jun 14, 2022 at 10:23 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> >               stat(s, DEACTIVATE_BYPASS);
>> >               goto new_slab;
>> > @@ -2968,6 +2969,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> >       freelist = c->freelist;
>> >       c->slab = NULL;
>> >       c->freelist = NULL;
>>
>> Previously these were part of deactivate_slab(), which does that at the very
>> end, but also without bumping tid.
>> I just wonder if it's necessary too, because IIUC the scenario you described
>> relies on the missing bump above. This alone doesn't cause the c->slab vs
>> c->freelist mismatch?
> 
> It's a different scenario, but at least in the current version, the
> ALLOC_NODE_MISMATCH case jumps straight to the deactivate_slab label,
> which takes the local_lock, grabs the old c->freelist, NULLs out
> ->slab and ->freelist, then drops the local_lock again. If the
> c->freelist was non-NULL, then this will prevent concurrent cmpxchg
> success; but there is no reason why c->freelist has to be non-NULL
> here. So if c->freelist is already NULL, we basically just take the
> local_lock, set c->slab to NULL, and drop the local_lock. And IIUC the

Ah, right. Thanks for the explanation.

> local_lock is the only protection we have here against concurrency,
> since the slub_get_cpu_ptr() in __slab_alloc() only disables
> migration?

On PREEMPT_RT it disables migration, but on !PREEMPT_RT it's a plain
get_cpu_ptr() that does preempt_disable(). But that's an implementation
detail, disabling migration would be sufficient on !PREEMPT_RT too, but
right now it's cheaper to disable migration.

> So again a concurrent fastpath free should be able to set
> c->freelist to non-NULL after c->slab has been set to NULL.
> 
> So I think this TID bump is also necessary for correctness in the
> current version.

OK.

> And looking back at older kernels, back to at least 4.9, the
> ALLOC_NODE_MISMATCH case looks similarly broken - except that again,
> as you pointed out, we don't have the fine-grained locking, so it only
> becomes racy if we hit new_slab_objects() -> new_slab() ->
> allocate_slab() and then either we do local_irq_enable() or the
> allocation fails.
> 
>> Thanks. Applying to slab/for-5.19-rc3/fixes branch.
> 
> Thanks!

