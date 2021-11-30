Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6046393E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbhK3PI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:08:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37184 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbhK3O7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:59:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D05A021763;
        Tue, 30 Nov 2021 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638284143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdzfWKzBScnKtJrNQNhMuivymCI1aB6mWrLCVK0CgUE=;
        b=N6w0jOv4SGgGGjGTZUmfKwzelHzWGrR1lmvA2rsejdsPYOreud4ksfRgj7J/MIx9ftTA9p
        L6h+uega9b6+pmS8xRrAlwxeKQ/8uKCR7tv7zR2bRTnfDkHX13n6i8GWJ5hFvz8qNfDXPB
        O/CAm6JrpIdwZAusvUudTKh+zz3hzbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638284143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdzfWKzBScnKtJrNQNhMuivymCI1aB6mWrLCVK0CgUE=;
        b=Bht19QAp3pYiPbi8TVyu1yuQkSHqxRw3ZHQMFGhKEuqAm/JMNunaHZE/yR4h5oVk+L5R/8
        HRxtQBW79Nb6x3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8046113D4E;
        Tue, 30 Nov 2021 14:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y/0VHm87pmGVRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 Nov 2021 14:55:43 +0000
Message-ID: <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
Date:   Tue, 30 Nov 2021 15:55:43 +0100
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 11:18, David Laight wrote:
> From: Vlastimil Babka
>> Sent: 22 November 2021 10:46
>> 
>> On 11/22/21 11:36, Christoph Lameter wrote:
>> > On Mon, 22 Nov 2021, Vlastimil Babka wrote:
>> >
>> >> But it seems there's no reason we couldn't do better? I.e. use the value of
>> >> SLOB_HDR_SIZE only to align the beginning of actual object (and name the
>> >> define different than SLOB_HDR_SIZE). But the size of the header, where we
>> >> store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
>> >> 64bit. The address of the header shouldn't have a reason to be also aligned
>> >> to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
>> >> it and not the slab consumers which rely on those alignments?
>> >
>> > Well the best way would be to put it at the end of the object in order to
>> > avoid the alignment problem. This is a particular issue with SLOB because
>> > it allows multiple types of objects in a single page frame.
>> >
>> > If only one type of object would be allowed then the object size etc can
>> > be stored in the page struct.
> 
> Or just a single byte that is the index of the associated free list structure.
> For 32bit and for the smaller kmalloc() area it may be reasonable to have
> a separate array indexed by the page of the address.
> 
>> > So I guess placement at the beginning cannot be avoided. That in turn runs
>> > into trouble with the DMA requirements on some platforms where the
>> > beginning of the object has to be cache line aligned.
>> 
>> It's no problem to have the real beginning of the object aligned, and the
>> prepended header not.
> 
> I'm not sure that helps.
> The header can't share a cache line with the previous item (because it
> might be mapped for DMA) so will always take a full cache line.

So if this is true, then I think we already have a problem with SLOB today
(and AFAICS it's not even due to changes done by my 2019 commit 59bb47985c1d
("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)" but
older).

Let's say we are on arm64 where (AFAICS):
ARCH_KMALLOC_MINALIGN = ARCH_DMA_MINALIGN = 128
ARCH_SLAB_MINALIGN = 64

The point is that ARCH_SLAB_MINALIGN is smaller than ARCH_DMA_MINALIGN.

Let's say we call kmalloc(64) and get a completely fresh page.
In SLOB, alloc() or rather __do_kmalloc_node() will calculate minalign to
max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN) thus 128.
It will call slob_alloc() for size of size+minalign=64+128=192, align and
align_offset = 128
Thus the allocation will use 128 bytes for the header, 64 for the object.
Both the header and object aligned to 128 bytes.
But the remaining 64 bytes of the second 128 bytes will remain free, as the
allocated size is 192 bytes:

| 128B header, aligned | 64B object | 64B free | rest also free |

If there's another kmalloc allocation, the 128 bytes aligment due to
ARCH_KMALLOC_MINALIGN will avoid it from using these 64 bytes, so that's
fine. But if there's a kmem_cache_alloc() from a cache serving <=64B
objects, it will be aligned to ARCH_SLAB_MINALIGN and happily use those 64
bytes that share the 128 block where the previous kmalloc allocation lies.

So either I missed something or we violate the rule that kmalloc() provides
blocks where ARCH_KMALLOC_MINALIGN is not just the alignment of their
beginning but also nothing else touches the N*ARCH_KMALLOC_MINALIGN area
containing the allocated object.

> There might me some strange scheme where you put the size at the end
> and the offset of the 'last end' into the page struct.
> The DMA API should let you safely read the size from an allocated
> buffer - but you can't modify it.
> 
> There is also all the code that allocates 'power of 2' sized buffers
> under the assumption they are efficient - as soon as you add a size
> field that assumption just causes the sizes of item to (often) double.
> 
> 	David
> 
>> The code already does that before this patch for the
>> kmalloc power-of-two alignments, where e.g. the object can be aligned to 256
>> bytes, but the prepended header to a smaller ARCH_KMALLOC_MINALIGN /
>> ARCH_SLAB_MINALIGN.
>> 
>> > I dont know but it seems that making slob that sophisticated is counter
>> > productive. Remove SLOB?
>> 
>> I wouldn't mind, but somebody might :)
>> 
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

