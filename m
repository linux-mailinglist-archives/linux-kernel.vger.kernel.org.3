Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0784F983B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiDHOkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiDHOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:39:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA98AF1FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:37:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0717210DC;
        Fri,  8 Apr 2022 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649428670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBZEkkRsibMSNgojvhGAJ9Oy+w+dx/Tx3IidmWNZn9k=;
        b=UhqbkLGpbVCltuCynA5xD8omhhDZBROssnSL9jMJDG7qkqvLsreG5/Bwcsl3LSl7DqW0tv
        W7V/1z0K4s8Nkx1NXqP+vHRjOVa+ONPfM9gc8tPfOO/8lbYp4WbGRqTiertJPx5UkMw7A0
        1OV3XuQz1SwLiZEXW2VoWhmQ0DD3dgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649428670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBZEkkRsibMSNgojvhGAJ9Oy+w+dx/Tx3IidmWNZn9k=;
        b=PyNV5l9FkqlTjLV+F3ERKyhYmWbxhsJNad2xKLBEebyEDemLk5d131ccpBV5Xat0/SY+Ic
        gLlwVc5JWkkiSKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84393132B9;
        Fri,  8 Apr 2022 14:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cdCJH75IUGJoSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Apr 2022 14:37:50 +0000
Message-ID: <c603455e-89e4-c6ab-7422-630809688beb@suse.cz>
Date:   Fri, 8 Apr 2022 16:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        David Laight <David.Laight@aculab.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <0966c4b0-6fff-3283-71c3-2d4e211f7385@suse.cz> <Yk8kCQnSa0F5yIfC@arm.com>
Content-Language: en-US
Subject: Re: [PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
 cache line size
In-Reply-To: <Yk8kCQnSa0F5yIfC@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 19:48, Catalin Marinas wrote:
> On Thu, Apr 07, 2022 at 04:40:15PM +0200, Vlastimil Babka wrote:
>> On 4/5/22 15:57, Catalin Marinas wrote:
>> > This series is beneficial to arm64 even if it's only reducing the
>> > kmalloc() minimum alignment to 64. While it would be nice to reduce this
>> > further to 8 (or 16) on SoCs known to be fully DMA coherent, detecting
>> > this is via arch_setup_dma_ops() is problematic, especially with late
>> > probed devices. I'd leave it for an additional RFC series on top of
>> > this (there are ideas like bounce buffering for non-coherent devices if
>> > the SoC was deemed coherent).
> [...]
>> - due to ARCH_KMALLOC_MINALIGN and dma guarantees we should return
>> allocations aligned to ARCH_KMALLOC_MINALIGN and the prepended size header
>> should also not share their ARCH_KMALLOC_MINALIGN block with another
>> (shorter) allocation that has a different lifetime, for the dma coherency
>> reasons
>> - this is very wasteful especially with the 128 bytes alignment, and seems
>> we already violate it in some scenarios anyway [2]. Extending this to all
>> objects would be even more wasteful.
>> 
>> So this series would help here, especially if we can get to the 8/16 size.
> 
> If we get to 8/16 size, it would only be for platforms that are fully
> coherent. Otherwise, with non-coherent DMA, the minimum kmalloc()
> alignment would still be the cache line size (typically 64) even if
> ARCH_KMALLOC_MINALIGN is 8.

OK.

> IIUC your point is that if ARCH_KMALLOC_MINALIGN is 8, kmalloc() could
> return pointers 8-byte aligned only as long as DMA safety is preserved
> (like not sharing the rest of the cache line with anything other
> writers).

Yeah IIUC we now have no way to distinguish callers of kmalloc() that
actually rely on the allocations being DMA safe, so we can only assume it's
potentially all of them. Because __GFP_DMA is something different than coherency.

>> But now I also wonder if keeping the name and meaning of "MINALIGN" is in
>> fact misleading and unnecessarily constraining us? What this is really about
>> is "granularity of exclusive access", no?
> 
> Not necessarily. Yes, in lots of cases it is about granularity of access
> but there are others where the code does need the pointer returned
> aligned to ARCH_DMA_MINALIGN (currently via ARCH_KMALLOC_MINALIGN).
> Crypto seems to have such requirement (see the sub-thread with Herbert).
> Some (all?) callers ask kmalloc() for the aligned size and there's an
> expectation that if the size is a multiple of a power of two, kmalloc()
> will return a pointer aligned to that power of two. I think we need to
> preserve these semantics which may lead to some more wastage if you add
> the header (e.g. a size of 3*64 returns a pointer either aligned to 192
> or 256).

Agree, I wasn't suggesting we start ignoring the (explicit or implicit
power-of-2) alignment requests. In that case the size header would still be
in the preceding (relative to the alignment address, e.g. 64bytes) block.
But if dma safety didn't require 64byte granularity, the rest of that block
could be used by another allocation, so that would reduce the wastage.

>> Let's say the dma granularity is 64bytes, and there's a kmalloc(56).
> 
> In your example, the size is not a power of two (or multiple of), so I
> guess there's no expectation for a 64-byte alignment (it can be 8)
> unless DMA is involved. See below.

Yes, and AFAIU we cannot rule out the DMA involvement, unfortunately.

>> If SLOB find a 64-bytes aligned block, uses the first 8 bytes for the
>> size header and returns the remaining 56 bytes, then the returned
>> pointer is not *aligned* to 64 bytes, but it's still aligned enough
>> for cpu accesses (which need only e.g. 8), and non-coherent dma should
>> be also safe because nobody will be accessing the 8 bytes header,
>> until the user of the object calls kfree() which should happen only
>> when it's done with any dma operations. Is my reasoning correct and
>> would this be safe?
> 
> From the DMA perspective, it's not safe currently. Let's say we have an
> inbound DMA transfer, the DMA API will invalidate the cache line prior
> to DMA. In arm64 terms, it means that the cache line is discarded, not
> flushed to memory. If the first 8 bytes had not been written back to
> RAM, they'd be lost.

Thanks for the insight, that's what I was looking for.

> If we can guarantee that no CPU write happens to
> the cache line during the DMA transfer, we can change the DMA mapping
> operation to do a clean+invalidate (flush the cacheline to RAM) first. I
> guess this could be done with an IS_ENABLED(CONFIG_SLOB) check.
 
I see. Maybe we'll think of another solution for SLOB.
