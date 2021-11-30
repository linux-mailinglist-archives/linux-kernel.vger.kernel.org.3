Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E820462F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhK3J0y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 04:26:54 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25956 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240105AbhK3J0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:26:53 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-13-Ag_JXOyjMBuSXQrxBjFzkA-1; Tue, 30 Nov 2021 09:23:32 +0000
X-MC-Unique: Ag_JXOyjMBuSXQrxBjFzkA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 09:23:30 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 30 Nov 2021 09:23:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rustam Kovhaev' <rkovhaev@gmail.com>
CC:     'Vlastimil Babka' <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
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
Subject: RE: [PATCH v4] slob: add size header to all allocations
Thread-Topic: [PATCH v4] slob: add size header to all allocations
Thread-Index: AQHX344YYrlQE8gw8k+1+rn2N9Qq+awQ435QgArNSACAACX/IA==
Date:   Tue, 30 Nov 2021 09:23:30 +0000
Message-ID: <d8bbbf07698948bd99fff9da1198a1e6@AcuMS.aculab.com>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
 <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com> <YaXMBm4zUSTRUGx1@nuc10>
In-Reply-To: <YaXMBm4zUSTRUGx1@nuc10>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rustam Kovhaev
> Sent: 30 November 2021 07:00
> 
> On Tue, Nov 23, 2021 at 10:18:27AM +0000, David Laight wrote:
> > From: Vlastimil Babka
> > > Sent: 22 November 2021 10:46
> > >
> > > On 11/22/21 11:36, Christoph Lameter wrote:
> > > > On Mon, 22 Nov 2021, Vlastimil Babka wrote:
> > > >
> > > >> But it seems there's no reason we couldn't do better? I.e. use the value of
> > > >> SLOB_HDR_SIZE only to align the beginning of actual object (and name the
> > > >> define different than SLOB_HDR_SIZE). But the size of the header, where we
> > > >> store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
> > > >> 64bit. The address of the header shouldn't have a reason to be also aligned
> > > >> to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
> > > >> it and not the slab consumers which rely on those alignments?
> > > >
> > > > Well the best way would be to put it at the end of the object in order to
> > > > avoid the alignment problem. This is a particular issue with SLOB because
> > > > it allows multiple types of objects in a single page frame.
> > > >
...
> >
> > > > So I guess placement at the beginning cannot be avoided. That in turn runs
> > > > into trouble with the DMA requirements on some platforms where the
> > > > beginning of the object has to be cache line aligned.
> > >
> > > It's no problem to have the real beginning of the object aligned, and the
> > > prepended header not.
> >
> > I'm not sure that helps.
> > The header can't share a cache line with the previous item (because it
> > might be mapped for DMA) so will always take a full cache line.
> 
> I thought that DMA API allocates buffers that are larger than page size.
> DMA pool seems to be able to give out smaller buffers, but underneath it
> seems to be calling page allocator.
> The SLOB objects that have this header are all less than page size, and
> they cannot end up in DMA code paths, or can they?

The problem isn't dma_alloc_coherent() it is when memory allocated
elsewhere is used for DMA.
On systems with non-coherent DMA accesses the data cache has to be
flushed before all and invalidated after read DMA transfers.
The cpu must not dirty any of the cache lines associated with a read DMA.

This is on top of any requirements for the alignment of the returned address.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

