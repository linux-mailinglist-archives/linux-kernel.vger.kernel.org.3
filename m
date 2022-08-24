Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2159FC62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiHXN4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiHXNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:55:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5555B7BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:54:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 204891FE9A;
        Wed, 24 Aug 2022 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661349295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YH9z4JU2bwTg40vWiFH3ozsp+vDepQBVhfttSpFUe/Q=;
        b=djF3+5E/HPbHqJyAtNKK1WLWYUZbayvBv6M6oWQ09IxwtcZUVLtQKXy3fsF0LANJB49WsK
        rYf48qkXeCM2BRLESMyBQwKwYosfZuS8qAELsKaT2stk40kLPZmywKGpIa7rP99lhpwP/1
        a8o7fX/dA5h0h7gm9X+Xpe1oUxZTwPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661349295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YH9z4JU2bwTg40vWiFH3ozsp+vDepQBVhfttSpFUe/Q=;
        b=IBhR97T2hKnM0VdB90QD6TK5aWwuVCNpM2ZDAqkdx48k4XG9pRwzkJp4ZK22DRnNPpTCNV
        L0p+6OeaxMrVgXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0CC613780;
        Wed, 24 Aug 2022 13:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0tYeKq4tBmN9dwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 Aug 2022 13:54:54 +0000
Message-ID: <e3f9bde2-7754-491a-78c0-a4a37dacbdd5@suse.cz>
Date:   Wed, 24 Aug 2022 15:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <ffb4012b-e038-a92e-c84c-bb1d061fe29f@suse.cz>
 <YwYm31FKQJh/CVBn@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YwYm31FKQJh/CVBn@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 15:25, Sebastian Andrzej Siewior wrote:
> On 2022-08-23 19:15:43 [+0200], Vlastimil Babka wrote:
>>> +#define slub_local_irq_save(flags)	local_irq_save(flags)
>>> +#define slub_local_irq_restore(flags)	local_irq_restore(flags)
>>
>> Note these won't be neccessary anymore after
>> https://lore.kernel.org/linux-mm/20220823170400.26546-6-vbabka@suse.cz/T/#u
> 
> Okay, let me postpone that one and rebase what is left on top.
> 
>>> @@ -482,7 +488,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
>>>   		void *freelist_new, unsigned long counters_new,
>>>   		const char *n)
>>>   {
>>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>> +	if (use_lockless_fast_path())
>>>   		lockdep_assert_irqs_disabled();
>>
>> This test would stay after the patch I referenced above. But while this
>> change will keep testing the technically correct thing, the name would be
>> IMHO misleading here, as this is semantically not about the lockless fast
>> path, but whether we need to have irqs disabled to avoid a deadlock due to
>> irq incoming when we hold the bit_spin_lock() and its handler trying to
>> acquire it as well.
> 
> Color me confused. Memory is never allocated in-IRQ context on
> PREEMPT_RT. Therefore I don't understand why interrupts must be disabled
> for the fast path (unless that comment only applied to !RT).

Yes that only applied to !RT. Hence why the assert is there only for !RT.

> It could be about preemption since spinlock, local_lock don't disable
> preemption and so another allocation on the same CPU is possible. But
> then you say "we hold the bit_spin_lock()" and this one disables
> preemption. This means nothing can stop the bit_spin_lock() owner from
> making progress and since there is no memory allocation in-IRQ, we can't
> block on the same bit_spin_lock() on the same CPU.

Yeah, realizing that this is true on RT led to the recent patch I 
referenced. Initially when converting SLUB to RT last year I didn't 
realize this detail, and instead replaced the irq disabling done (only 
on !RT) by e.g. local_lock_irqsave with the manual local_irq_save().

> Sebastian

