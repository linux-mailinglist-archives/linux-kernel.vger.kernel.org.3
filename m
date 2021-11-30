Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2EE462FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhK3Jog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:44:36 -0500
Received: from gentwo.de ([161.97.139.209]:50390 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235639AbhK3Jog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:44:36 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 5A0B9B0034A; Tue, 30 Nov 2021 10:41:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 56157B00058;
        Tue, 30 Nov 2021 10:41:15 +0100 (CET)
Date:   Tue, 30 Nov 2021 10:41:15 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Rustam Kovhaev <rkovhaev@gmail.com>
cc:     David Laight <David.Laight@aculab.com>,
        'Vlastimil Babka' <vbabka@suse.cz>,
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
In-Reply-To: <YaXMBm4zUSTRUGx1@nuc10>
Message-ID: <alpine.DEB.2.22.394.2111301038150.291899@gentwo.de>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz> <20211122013026.909933-1-rkovhaev@gmail.com> <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de> <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz> <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz> <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com> <YaXMBm4zUSTRUGx1@nuc10>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021, Rustam Kovhaev wrote:

> > I'm not sure that helps.
> > The header can't share a cache line with the previous item (because it
> > might be mapped for DMA) so will always take a full cache line.
>
> I thought that DMA API allocates buffers that are larger than page size.
> DMA pool seems to be able to give out smaller buffers, but underneath it
> seems to be calling page allocator.
> The SLOB objects that have this header are all less than page size, and
> they cannot end up in DMA code paths, or can they?

kmalloc slab allocations must return dmaable memory. If the underlying
hardware can only dma to a cache line border then all objects must be
aligned that way.

