Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619284F81FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiDGOmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbiDGOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:42:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B309B1B98BE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:40:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EDF6210DD;
        Thu,  7 Apr 2022 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649342416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIw+D622mQPfSgx0d0IzrPiQruhgcrPNTzhosBS+zos=;
        b=1oPdNRdewnCBIETwE3fXVi+UbYpLm+Dm/YntLvvkIB48ulsCrBkURZkZ8YMJ+zRWwtAJHi
        I0Aozya2BNDP8USELjkCAmAsmfiOKOm2QXZViNc1g9FlK5gX/B3KtMfC++eieuG2t6U6Kg
        7FiKJvWMr08gV7pZnZe0mbZmswQcQUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649342416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIw+D622mQPfSgx0d0IzrPiQruhgcrPNTzhosBS+zos=;
        b=vOyqGqKr7m9oLnMU0jp81Pej9wgPvf/g4yJ9oeOcvYIub0JBr2PTFrY9T0oxpguj1nkJ95
        xn0XU3sHZeu6AMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE96713485;
        Thu,  7 Apr 2022 14:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AClwKc/3TmKiWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Apr 2022 14:40:15 +0000
Message-ID: <0966c4b0-6fff-3283-71c3-2d4e211f7385@suse.cz>
Date:   Thu, 7 Apr 2022 16:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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
        David Laight <David.Laight@ACULAB.COM>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
 cache line size
In-Reply-To: <20220405135758.774016-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 15:57, Catalin Marinas wrote:
> Hi,
> 
> On arm64 ARCH_DMA_MINALIGN (and therefore ARCH_KMALLOC_MINALIGN) is 128.
> While the majority of arm64 SoCs have a 64-byte cache line size (or
> rather CWG - cache writeback granule), we chose a less than optimal
> value in order to support all SoCs in a single kernel image.
> 
> The aim of this series is to allow smaller default ARCH_KMALLOC_MINALIGN
> with kmalloc() caches configured at boot time to be safe when an SoC has
> a larger DMA alignment requirement.
> 
> The first patch decouples ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
> with the aim to only use the latter in DMA-specific compile-time
> annotations. ARCH_KMALLOC_MINALIGN becomes the minimum (static)
> guaranteed kmalloc() alignment but not necessarily safe for non-coherent
> DMA. Patches 2-7 change some drivers/ code to use ARCH_DMA_MINALIGN
> instead of ARCH_KMALLOC_MINALIGN.
> 
> Patch 8 introduces the dynamic arch_kmalloc_minalign() and the slab code
> changes to set the corresponding minimum alignment on the newly created
> kmalloc() caches. Patch 10 defines arch_kmalloc_minalign() for arm64
> returning cache_line_size() together with reducing ARCH_KMALLOC_MINALIGN
> to 64. ARCH_DMA_MINALIGN remains 128 on arm64.
> 
> I don't have access to it but there's the Fujitsu A64FX with a CWG of
> 256 (the arm64 cache_line_size() returns 256). This series will bump the
> smallest kmalloc cache to kmalloc-256. The platform is known to be fully
> cache coherent (or so I think) and we decided long ago not to bump
> ARCH_DMA_MINALIGN to 256. If problematic, we could make the dynamic
> kmalloc() alignment on arm64 min(ARCH_DMA_MINALIGN, cache_line_size()).
> 
> This series is beneficial to arm64 even if it's only reducing the
> kmalloc() minimum alignment to 64. While it would be nice to reduce this
> further to 8 (or 16) on SoCs known to be fully DMA coherent, detecting
> this is via arch_setup_dma_ops() is problematic, especially with late
> probed devices. I'd leave it for an additional RFC series on top of
> this (there are ideas like bounce buffering for non-coherent devices if
> the SoC was deemed coherent).

Oh that sounds great, and perhaps should help with our SLOB problem as
detailed in this subthread [1]. To recap:

- we would like kfree() to work on allocations done by kmem_cache_alloc(),
in addition to kmalloc()
- for SLOB this would mean that kmem_cache_alloc() objects have to store
their alloc size (prepended to the allocated object) which is now done for
kmalloc() objects only - we don't have to store the size if
kmem_cache_free() gives us the kmem_cache pointer which contains the
per-cache size.
- due to ARCH_KMALLOC_MINALIGN and dma guarantees we should return
allocations aligned to ARCH_KMALLOC_MINALIGN and the prepended size header
should also not share their ARCH_KMALLOC_MINALIGN block with another
(shorter) allocation that has a different lifetime, for the dma coherency
reasons
- this is very wasteful especially with the 128 bytes alignment, and seems
we already violate it in some scenarios anyway [2]. Extending this to all
objects would be even more wasteful.

So this series would help here, especially if we can get to the 8/16 size.
But now I also wonder if keeping the name and meaning of "MINALIGN" is in
fact misleading and unnecessarily constraining us? What this is really about
is "granularity of exclusive access", no? Let's say the dma granularity is
64bytes, and there's a kmalloc(56). If SLOB find a 64-bytes aligned block,
uses the first 8 bytes for the size header and returns the remaining 56
bytes, then the returned pointer is not *aligned* to 64 bytes, but it's
still aligned enough for cpu accesses (which need only e.g. 8), and
non-coherent dma should be also safe because nobody will be accessing the 8
bytes header, until the user of the object calls kfree() which should happen
only when it's done with any dma operations. Is my reasoning correct and
would this be safe?

[1] https://lore.kernel.org/all/20211122013026.909933-1-rkovhaev@gmail.com/
[2] https://lore.kernel.org/all/d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz/
