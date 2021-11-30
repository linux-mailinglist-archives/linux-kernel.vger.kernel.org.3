Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E852D463A45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhK3Pmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:42:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhK3Pmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:42:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7419A1FD58;
        Tue, 30 Nov 2021 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638286769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khmf46apnivc3rCeZIcafDkb2T/c/9M5GdnPaCE3bn8=;
        b=NfREQeTLTbuZnKajctFLJiZDGy1q930Z0dbkjKXRLJd2IuU2XnXKlr7FKAPCSKS074SSP0
        /AaW3s5EOOT6UgNXc2eTOD+yQp7h8hBKdtBO3WrCO0at1sppLKa1a6k41gmridS24w4v3y
        Pt1BI1RJ8becE6ZS32RzvDDPx60p/3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638286769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khmf46apnivc3rCeZIcafDkb2T/c/9M5GdnPaCE3bn8=;
        b=f+8zvaHsFv6F6UQ6tZGcRyIOSueiHJ4BNz4UWIKEjK80IQIAD08pUcuKXHl7r+Ek9SAUhY
        UmfRDNJh2h0m/EBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3658E13D5A;
        Tue, 30 Nov 2021 15:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QFKBDLFFpmHWWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 Nov 2021 15:39:29 +0000
Message-ID: <b01c9f31-4336-dfe7-9042-41339ea9cc0d@suse.cz>
Date:   Tue, 30 Nov 2021 16:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Christoph Lameter <cl@gentwo.org>
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dvyukov@google.com" <dvyukov@google.com>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
 <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
 <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
 <e79cd6da011a412f8c68e132ba74dc5c@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <e79cd6da011a412f8c68e132ba74dc5c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 16:21, David Laight wrote:
> From: Vlastimil Babka
>> Sent: 30 November 2021 14:56
>> 
>> On 11/23/21 11:18, David Laight wrote:
>> > From: Vlastimil Babka
>> >
>> > Or just a single byte that is the index of the associated free list structure.
>> > For 32bit and for the smaller kmalloc() area it may be reasonable to have
>> > a separate array indexed by the page of the address.
>> >
>> >> > So I guess placement at the beginning cannot be avoided. That in turn runs
>> >> > into trouble with the DMA requirements on some platforms where the
>> >> > beginning of the object has to be cache line aligned.
>> >>
>> >> It's no problem to have the real beginning of the object aligned, and the
>> >> prepended header not.
>> >
>> > I'm not sure that helps.
>> > The header can't share a cache line with the previous item (because it
>> > might be mapped for DMA) so will always take a full cache line.
>> 
>> So if this is true, then I think we already have a problem with SLOB today
>> (and AFAICS it's not even due to changes done by my 2019 commit 59bb47985c1d
>> ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)" but
>> older).
>> 
>> Let's say we are on arm64 where (AFAICS):
>> ARCH_KMALLOC_MINALIGN = ARCH_DMA_MINALIGN = 128
>> ARCH_SLAB_MINALIGN = 64
> 
> Is that valid?
> Isn't SLAB being used to implement kmalloc() so the architecture
> defined alignment must apply?

SLAB is used to implement kmalloc() yes, but that's an implementation
detail. I assume that we provide these DMA guarantees to all kmalloc() users
as we don't know which will use it for DMA and which not, but if somebody
creates their specific SLAB cache, they have to decide explicitly if they
are going to use DMA with those objects, and request such alignment if yes.
If not, we can use smaller alignment that's only required by e.g. the CPU.

>> The point is that ARCH_SLAB_MINALIGN is smaller than ARCH_DMA_MINALIGN.
>> 
>> Let's say we call kmalloc(64) and get a completely fresh page.
>> In SLOB, alloc() or rather __do_kmalloc_node() will calculate minalign to
>> max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN) thus 128.
>> It will call slob_alloc() for size of size+minalign=64+128=192, align and
>> align_offset = 128
>> Thus the allocation will use 128 bytes for the header, 64 for the object.
>> Both the header and object aligned to 128 bytes.
>> But the remaining 64 bytes of the second 128 bytes will remain free, as the
>> allocated size is 192 bytes:
>> 
>> | 128B header, aligned | 64B object | 64B free | rest also free |
> 
> That is horribly wasteful on memory :-)

Yes. I don't know how this historically came to be for SLOB, which was
supposed to minimize memory usage (at the expense of cpu efficiency). But
the point raised in this thread that if we extend this to all
kmem_cache_alloc() allocations to make them possible to free with kfree(),
we'll make it a lot worse :/

>> If there's another kmalloc allocation, the 128 bytes aligment due to
>> ARCH_KMALLOC_MINALIGN will avoid it from using these 64 bytes, so that's
>> fine. But if there's a kmem_cache_alloc() from a cache serving <=64B
>> objects, it will be aligned to ARCH_SLAB_MINALIGN and happily use those 64
>> bytes that share the 128 block where the previous kmalloc allocation lies.
> 
> If the memory returned by kmem_cache_alloc() can be used for DMA then
> ARCH_DMA_MINALIGN has to apply to the returned buffers.
> So, maybe, that cache can't exist?

See above, I assume that cache cannot be used for DMA. But if we are trying
to protect the kmalloc(64) DMA guarantees, then that shouldn't depend on the
guarantees of the second, unrelated allocation?

> I'd expect that ARCH_DMA_MINALIGN forces allocations to be a multiple
> of that size.

Doesn't seem so. That would indeed fix the problem, assuming it really is a
problem (yet seems nobody reported it occuring in practice).

> More particularly the rest of the area can't be allocated to anything else.
> So it ought to be valid to return the 2nd half of a 128 byte cache line
> provided the first half isn't written while the allocation is active.

As the allocator cannot know when the first half will be used for DMA by
whoever allocated it, we can only assume it can happen at any time, and not
return the 2nd half, ever?

> But that ARCH_KMALLOC_MINALIGN only applies to 'large' items?
> Small items only need aligning to the power of 2 below their size.
> So 8 bytes items only need 8 byte alignment even though a larger
> item might need (say) 64 byte alignment.

But if we never defined such threshold (that would probably have to be arch
independent) then we can't start making such assumptions today, as we don't
know which kmalloc() users do expect DMA and which not? It would have to be
a flag or something. And yeah there is already a __GFP_DMA flag, but it
means something a bit different...

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

