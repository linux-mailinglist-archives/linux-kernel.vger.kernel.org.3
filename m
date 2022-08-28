Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E135A3E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH1PMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiH1PMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C7F32B97
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpY/8AdUR+vNQIgjLclSZmI7zrqsvBcdHsK7fFs0Xqc=;
        b=RAOciwszWG/70BUIBp6JvnrnnfVLiEnMw0C74kdm0wjpGauud7H+ckir3i9MSRhtaADKol
        NmfuezDqxcx8so3BCUj49RpnMSUR8pYmtnmei11k+TLeYf0O3/G1MnZAy359c2rhrxGcsS
        yOxArlaWu4y0O6vhSpgEy82Y3U8ER+o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-SVZOcRTLOPy8iZh4izkDrA-1; Sun, 28 Aug 2022 11:12:12 -0400
X-MC-Unique: SVZOcRTLOPy8iZh4izkDrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0012A38005C0;
        Sun, 28 Aug 2022 15:12:11 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2861121314;
        Sun, 28 Aug 2022 15:12:10 +0000 (UTC)
Date:   Sun, 28 Aug 2022 23:12:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwuFx8S13bkfpqao@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
 <f7642f34-80a8-3215-b441-b7432f6a22b1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7642f34-80a8-3215-b441-b7432f6a22b1@csgroup.eu>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/22 at 06:38am, Christophe Leroy wrote:
> 
> 
> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> > With it, the old ioremap() and iounmap() can be perfectly removed
> > since they are duplicated with the standard functions.
> 
> I see nothing related to the preparation patches. Could this have been 
> converted without all previous patches ? In that case I think this one 
> should go in the begining of the series, it would help see which 
> architectecture really needs the changes to the generic parts.

You are right. Hexagon basically has the same implementation as standard
ioremap and iounmap code. I will move this at the beginning of patch
series in next round of post. Thanks for point this out.

> 
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org
> > ---
> >   arch/hexagon/Kconfig          |  1 +
> >   arch/hexagon/include/asm/io.h |  9 +++++--
> >   arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
> >   3 files changed, 8 insertions(+), 46 deletions(-)
> >   delete mode 100644 arch/hexagon/mm/ioremap.c
> > 
> > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > index 54eadf265178..17afffde1a7f 100644
> > --- a/arch/hexagon/Kconfig
> > +++ b/arch/hexagon/Kconfig
> > @@ -25,6 +25,7 @@ config HEXAGON
> >   	select NEED_SG_DMA_LENGTH
> >   	select NO_IOPORT_MAP
> >   	select GENERIC_IOMAP
> > +	select GENERIC_IOREMAP
> >   	select GENERIC_SMP_IDLE_THREAD
> >   	select STACKTRACE_SUPPORT
> >   	select GENERIC_CLOCKEVENTS_BROADCAST
> > diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> > index c33241425a5c..e2d3091ec9d6 100644
> > --- a/arch/hexagon/include/asm/io.h
> > +++ b/arch/hexagon/include/asm/io.h
> > @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
> >   #define writew_relaxed __raw_writew
> >   #define writel_relaxed __raw_writel
> >   
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> > -#define ioremap_uc(X, Y) ioremap((X), (Y))
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> > +		       (__HEXAGON_C_DEV << 6))
> > +
> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> >   
> >   
> >   #define __raw_writel writel
> > diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
> > deleted file mode 100644
> > index 255c5b1ee1a7..000000000000
> > --- a/arch/hexagon/mm/ioremap.c
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * I/O remap functions for Hexagon
> > - *
> > - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> > - */
> > -
> > -#include <linux/io.h>
> > -#include <linux/vmalloc.h>
> > -#include <linux/mm.h>
> > -
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
> > -{
> > -	unsigned long last_addr, addr;
> > -	unsigned long offset = phys_addr & ~PAGE_MASK;
> > -	struct vm_struct *area;
> > -
> > -	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
> > -					|(__HEXAGON_C_DEV << 6));
> > -
> > -	last_addr = phys_addr + size - 1;
> > -
> > -	/*  Wrapping not allowed  */
> > -	if (!size || (last_addr < phys_addr))
> > -		return NULL;
> > -
> > -	/*  Rounds up to next page size, including whole-page offset */
> > -	size = PAGE_ALIGN(offset + size);
> > -
> > -	area = get_vm_area(size, VM_IOREMAP);
> > -	addr = (unsigned long)area->addr;
> > -
> > -	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
> > -		vunmap((void *)addr);
> > -		return NULL;
> > -	}
> > -
> > -	return (void __iomem *) (offset + addr);
> > -}
> > -
> > -void iounmap(const volatile void __iomem *addr)
> > -{
> > -	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
> > -}

