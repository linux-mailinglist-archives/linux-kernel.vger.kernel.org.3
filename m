Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E24612B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhK2Koe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239729AbhK2Km3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638182351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKFytTEGQgFDdoS02K4fYtHl+AtxFknVy07vOSvGI8c=;
        b=Xq44mqlYRKNAGi2x/EmHjThMQJMpoOkC+D21T+EGDBvQkcGJTyGljmnW96bIDfevESlDAo
        VaLkUbJPLBR3G+yzG1/NwyE6UF7XjBndhR2Xx5xf2CuXpokejxEbJ3js5wMwc7UKkNUh9m
        bIqVKSEK2DuNJLhrScJ5OTiULVAkQLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-2VEt_MKjMUOhbKMFhUW3BQ-1; Mon, 29 Nov 2021 05:39:07 -0500
X-MC-Unique: 2VEt_MKjMUOhbKMFhUW3BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8C219251B8;
        Mon, 29 Nov 2021 10:39:06 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6224694D7;
        Mon, 29 Nov 2021 10:39:04 +0000 (UTC)
Message-ID: <dfdc836d4c9eb6b571a32b19cae74c0a426c5a9b.camel@redhat.com>
Subject: Re: Commit 'hugetlbfs: extend the definition of hugepages parameter
 to support node allocation' breaks old numa less syntax of reserving
 hugepages on boot.
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 12:39:03 +0200
In-Reply-To: <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
References: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com>
         <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-11-28 at 20:31 -0800, Mike Kravetz wrote:
> On 11/28/21 03:18, Maxim Levitsky wrote:
> > dmesg prints this:
> > 
> > HugeTLB: allocating 64 of page size 1.00 GiB failed.  Only allocated 0 hugepages
> > 
> > Huge pages were allocated on kernel command line (1/2 of 128GB system):
> > 
> > 'default_hugepagesz=1G hugepagesz=1G hugepages=64'
> > 
> > This is 3970X and no real support/need for NUMA, thus only fake NUMA node 0 is present.
> > 
> > Reverting the commit helps.
> > 
> > New syntax also works ( hugepages=0:64 )
> > 
> > I can test any patches for this bug.
> 
> Argh!  I think preallocation of gigantic pages on all systems with only
> a single node is broken.  The issue is at the beginning of
> __alloc_bootmem_huge_page:
> 
> int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> {
>         struct huge_bootmem_page *m = NULL; /* initialize for clang */
>         int nr_nodes, node;
> 
>         if (nid >= nr_online_nodes)
>                 return 0;
> 
> Without using the node specific syntax, nid == NUMA_NO_NODE == -1.  For the
> comparison, nid will be converted to an unsigned into to match nr_online_nodes
> so we will immediately return 0 instead of doing the allocations.
> 
> Zhenguo Yao,
> Can you verify and perhaps put together a patch?does
> 
> > Also unrelated, is there any progress on allocating 1GB pages on demand so that I could
> > allocate them only when I run a VM?
> 
> That should be possible.  Such support was added back in 2014 with commit
> 944d9fec8d7a "hugetlb: add support for gigantic page allocation at runtime".
> 
> > i don't mind having these pages to be marked as to be used for userspace only,
> > since as far as I remember its the kernel usage that makes some page unmoveable.
> > 
> 
> Of course, finding 1GB of contiguous space for a gigantic page is often
> difficult at runtime.  So, allocations are likely to fail the longer the
> system is up and running and fragmentation increases.
> 
> > Last time (many years ago) I tried to create a zone with only userspace pages
> > (I don't remember what options I used) but it didn't work.
> 
> Not too long ago, support was added to use CMA for gigantic page allocation.
> See commit cf11e85fc08c "mm: hugetlb: optionally allocate gigantic hugepages
> using cma".  This sounds like something you might want to try.

This is exactly what I had in mind and it seems to work very well.
Thank you very much!

Best regards,
	Maxim Levitsky

