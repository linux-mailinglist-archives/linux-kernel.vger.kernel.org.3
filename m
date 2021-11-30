Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36942462D43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhK3HDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhK3HDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:03:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E62C061574;
        Mon, 29 Nov 2021 23:00:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so16357480pjb.1;
        Mon, 29 Nov 2021 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ik+pTXtKv34fQ1UUZbZJZdZn+WHDSuZ6kofV1okOnA=;
        b=NtO9cgLQf2lht5QwgP5kQgfCy5TEkHwrUsWgpMxpT6RZnIs06XfDoQh+g5LCAuPsM/
         9CB+5N+wqlhv2psXcvx6zupEp0KM6NLmb0UBTwj+p+TkY30FcwS5zuRk9Vh/jHowwoe7
         eBz6yS0AbjU0zC/RW6XtnOEdKhlllYTnXH3+qiGXFHCPXaNdD1gTU1R1DWR8053P8Xbj
         gMnS89BNfqXU15vxaDFyl2+vOaMk5qrVsM6PkPXT9NyOrn/mJPIoCZKJEnvduckGUJa1
         IFoAjJb8L6N3iQ/GiAxpM/BWRHtjUyKLAGRTm9XDUDKvwWbbFeExS0cpIL31FeVROvN7
         mSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ik+pTXtKv34fQ1UUZbZJZdZn+WHDSuZ6kofV1okOnA=;
        b=Y6lZuPhchVM33Ohe0jIuBtMTVoUKoKbwEwfrII+mKAzgJO6bE9RoKvgEcdHGpR+2cJ
         BjMQBdEmVusdNhhvoE1Sh1Sl4FGxhLpT9zizdtKR6poB7cx1/IFNAijv08AzljUAXwMQ
         XtMXxlQZv7ppUd3wB6K0JKtwdIWNDFiAbgAlPyeyZCTmB0U93zp9YrMbtBgic1mypar6
         M3suRyiAOFFeQLsa+Gq1Aq8r9m1mVy7yjVU2vtD056CHxmjCykwuKciDqCNhunZUy+8Q
         pSS1qyIYvty5YhNV7aY3BymMs1+gQ0hmInIoOdpGvBKnABZtgdiL4MumqE1HgGtAp9gV
         CpDg==
X-Gm-Message-State: AOAM532r3YUd2HtMcdSyDzZaVxURrMLAptCU1Nt6+pcF4wdWjdEuPTOM
        gZLfaaOACqpiHbHOg7lar6I=
X-Google-Smtp-Source: ABdhPJw6XOKgF2a0sxCetttKNHnczXGM4q8FxPI8/XTkSBCL/Jv1sQ8rxU5o9mf9sC4eADXgnpNEbA==
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr3835435pjb.113.1638255624984;
        Mon, 29 Nov 2021 23:00:24 -0800 (PST)
Received: from nuc10 (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id t38sm20093098pfg.218.2021.11.29.23.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 23:00:24 -0800 (PST)
Date:   Mon, 29 Nov 2021 23:00:22 -0800
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Vlastimil Babka' <vbabka@suse.cz>,
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
Subject: Re: [PATCH v4] slob: add size header to all allocations
Message-ID: <YaXMBm4zUSTRUGx1@nuc10>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
 <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:18:27AM +0000, David Laight wrote:
> From: Vlastimil Babka
> > Sent: 22 November 2021 10:46
> > 
> > On 11/22/21 11:36, Christoph Lameter wrote:
> > > On Mon, 22 Nov 2021, Vlastimil Babka wrote:
> > >
> > >> But it seems there's no reason we couldn't do better? I.e. use the value of
> > >> SLOB_HDR_SIZE only to align the beginning of actual object (and name the
> > >> define different than SLOB_HDR_SIZE). But the size of the header, where we
> > >> store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
> > >> 64bit. The address of the header shouldn't have a reason to be also aligned
> > >> to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
> > >> it and not the slab consumers which rely on those alignments?
> > >
> > > Well the best way would be to put it at the end of the object in order to
> > > avoid the alignment problem. This is a particular issue with SLOB because
> > > it allows multiple types of objects in a single page frame.
> > >
> > > If only one type of object would be allowed then the object size etc can
> > > be stored in the page struct.
> 
> Or just a single byte that is the index of the associated free list structure.
> For 32bit and for the smaller kmalloc() area it may be reasonable to have
> a separate array indexed by the page of the address.
> 
> > > So I guess placement at the beginning cannot be avoided. That in turn runs
> > > into trouble with the DMA requirements on some platforms where the
> > > beginning of the object has to be cache line aligned.
> > 
> > It's no problem to have the real beginning of the object aligned, and the
> > prepended header not.
> 
> I'm not sure that helps.
> The header can't share a cache line with the previous item (because it
> might be mapped for DMA) so will always take a full cache line.

I thought that DMA API allocates buffers that are larger than page size.
DMA pool seems to be able to give out smaller buffers, but underneath it
seems to be calling page allocator.
The SLOB objects that have this header are all less than page size, and
they cannot end up in DMA code paths, or can they?

> 
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
> > The code already does that before this patch for the
> > kmalloc power-of-two alignments, where e.g. the object can be aligned to 256
> > bytes, but the prepended header to a smaller ARCH_KMALLOC_MINALIGN /
> > ARCH_SLAB_MINALIGN.
> > 
> > > I dont know but it seems that making slob that sophisticated is counter
> > > productive. Remove SLOB?
> > 
> > I wouldn't mind, but somebody might :)
> > 
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
