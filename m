Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D504639FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhK3P3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhK3P3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:29:30 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5DC061574;
        Tue, 30 Nov 2021 07:26:10 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 328F4B001EC; Tue, 30 Nov 2021 16:26:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 30B5DB0006D;
        Tue, 30 Nov 2021 16:26:09 +0100 (CET)
Date:   Tue, 30 Nov 2021 16:26:09 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     David Laight <David.Laight@ACULAB.COM>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
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
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111301621140.6112@gentwo.de>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz> <20211122013026.909933-1-rkovhaev@gmail.com> <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de> <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz> <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz> <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com> <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021, Vlastimil Babka wrote:

> So either I missed something or we violate the rule that kmalloc() provides
> blocks where ARCH_KMALLOC_MINALIGN is not just the alignment of their
> beginning but also nothing else touches the N*ARCH_KMALLOC_MINALIGN area
> containing the allocated object.

Indeed.... The DMA API documentation in the kernel states:

Documentation/DMA-API-HOWTO.rst

2) ARCH_KMALLOC_MINALIGN

+   Architectures must ensure that kmalloc'ed buffer is
+   DMA-safe. Drivers and subsystems depend on it. If an architecture
+   isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
+   the CPU cache is identical to data in main memory),
+   ARCH_KMALLOC_MINALIGN must be set so that the memory allocator
+   makes sure that kmalloc'ed buffer doesn't share a cache line with
+   the others. See arch/arm/include/asm/cache.h as an example.


Note that this is only the case for kmalloc. Not for a slab cache setup
separately from the kmalloc array. That is why ARCH_KMALLOC_MINALIGN
exists.
