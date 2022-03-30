Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AE4ECEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbiC3Vo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiC3Voz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:44:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBEC6A419
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:43:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1798F1F869;
        Wed, 30 Mar 2022 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648676588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUt1tOpM1tvjVQbAHVKSiWMh6OyKILyACsC9XxuklHM=;
        b=x+/CnsSHUCSoN/1QswMy7TtD1tGhGvFxPkHu0RS4Vnc5FHLWFUZv/JhuY5ckgPBQvlNX16
        sgHP/9HwgjoNEsvndyHe75w6rSp3xStPXyi8lsyJqwCNR5eos2A7O+3XqV7KLMdY/PTcbM
        odPBuqlKLYCrB0wOhAdgIoqTYV46BFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648676588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUt1tOpM1tvjVQbAHVKSiWMh6OyKILyACsC9XxuklHM=;
        b=EWEgVUbIVKUG+Y/E53ILq82LnkEL9Y2nB4SMYPysmXdnVQjt1lox+Ivkv2CoK3dQ7WNV15
        XqiHgyegL/SiMUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8EDB13AF3;
        Wed, 30 Mar 2022 21:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YRmbM+vORGKXHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 30 Mar 2022 21:43:07 +0000
Message-ID: <27ff69f9-60c5-9e59-feb2-295250077551@suse.cz>
Date:   Wed, 30 Mar 2022 23:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 22:05, Linus Torvalds wrote:
> On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> I started testing new patches and it crashed when doing the x86-32 test on
>> boot up.
>>
>> Initializing HighMem for node 0 (000375fe:0021ee00)
>> BUG: kernel NULL pointer dereference, address: 00000878
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> *pdpt = 0000000000000000 *pde = f0000000f000eef3
>> Oops: 0000 [#1] PREEMPT SMP PTI
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
>> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>> EIP: get_pfnblock_flags_mask+0x2c/0x36
>> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb ff ff 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 90 d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1
> 
> The whole function is in that Code: thing, and it decodes to:
> 
>    0: 55                    push   %ebp
>    1: 89 e5                mov    %esp,%ebp
>    3: 56                    push   %esi
>    4: 89 ce                mov    %ecx,%esi
>    6: 53                    push   %ebx
>    7: 8b 18                mov    (%eax),%ebx
>    9: 89 d8                mov    %ebx,%eax
>    b: c1 eb 1e              shr    $0x1e,%ebx
>    e: e8 f7 fb ff ff        call   0xfffffc0a
>   13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
>   19: 89 c1                mov    %eax,%ecx
>   1b: 89 c2                mov    %eax,%edx
>   1d: c1 ea 05              shr    $0x5,%edx
>   20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
>   26: 5b                    pop    %ebx
>   27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping instruction
>   2a: d3 e8                shr    %cl,%eax
>   2c: 21 f0                and    %esi,%eax
>   2e: 5e                    pop    %esi
>   2f: 5d                    pop    %ebp
>   30: c3                    ret
> 
> with '%eax' being NULL, and %edx being 0x21e.
> 
> (The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler does
> similar code generation, so it's out-of-lined part of pfn_to_bitidx()
> despite being marked inline)
> 
> So that oops is that
> 
>         word = bitmap[word_bitidx];
> 
> line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').
> 
> Looking around, your 'config-bad' doesn't even have
> CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is this
> part of the change:
> 
> -               if (unlikely(has_isolate_pageblock(zone))) {
> 
> which used to always be false for that config, and now the code is
> suddenly enabled.

If CONFIG_MEMORY_ISOLATION was enabled then the zone layout would be the
same, so I think it's not simply that. I think it's the timing -
has_isolate_pageblock(zone) would only be possible to become true later
in runtime when some isolation is ongoing, but here it seems we are
still in the early boot. Probably at a boundary of highmem with another
zone that doesn't have the pageblock bitmap yet initialized? While later
it would have, and all would be fine.

As Zi Yan said, the usual merging code will, through page_is_buddy()
find safely enough the buddy is not applicable, so I agree with his
patch direction. Seems this also shows the code tried to become too
smart and for the next merge window we should try just move the
migratetype checks into the main while loop (under something like "if
(order >= max_order)") and simplify the function a lot, hopefully with
negligible perf impact.

> Alternatively, that code just can't deal with highmem properly.
> 
> But I didn't really analyze things, I'm mainly doing pattern matching here.
> 
> Zi Yan - and all the people who ack'ed and reviewed this - please take
> a deeper look..
> 
>                 Linus

