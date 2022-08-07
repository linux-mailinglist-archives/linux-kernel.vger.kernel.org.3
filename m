Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550B58B8F1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiHGBmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHGBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4535B7D3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659836534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRa3p/29F3baYB0BuqQ0MuKQVUhJE1CPCIoS8bSSmmI=;
        b=CzTyzgfxhD0O+aVQpB5bvLoG6F7CkuVA3ufEJxhTsJWCthM2cTQxWU9CbjYpkJnh/35Uei
        gYDHizm7gGPFLzeyyBeUsWswPm6RxBf0WtDaOQH3wcBbW01fPaDNfsUU2p3YVT6/Wfmw7M
        UH39nWoSlZHG1n2MRhFrTnIt7zqYh9I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-oSUK6zFtMjOJwmjt0oW7HA-1; Sat, 06 Aug 2022 21:42:11 -0400
X-MC-Unique: oSUK6zFtMjOJwmjt0oW7HA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4097D3C025C2;
        Sun,  7 Aug 2022 01:42:11 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5290F403167;
        Sun,  7 Aug 2022 01:42:09 +0000 (UTC)
Date:   Sun, 7 Aug 2022 09:42:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Message-ID: <20220807014206.GA416711@MiWiFi-R3L-srv>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
 <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
 <Yu4mYxpV0GWRTjQp@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yu4mYxpV0GWRTjQp@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/22 at 10:29am, Alexander Gordeev wrote:
> On Sat, Aug 06, 2022 at 10:29:03AM +0800, Kefeng Wang wrote:
> > 
> > On 2022/8/4 23:42, Alexander Gordeev wrote:
> > > On Mon, Aug 01, 2022 at 10:40:19PM +0800, Baoquan He wrote:
> > > 
> > > Hi Baoquan,
> > > 
> > > > --- a/arch/arm64/mm/ioremap.c
> > > > +++ b/arch/arm64/mm/ioremap.c
> > > > @@ -3,19 +3,20 @@
> > > >   #include <linux/mm.h>
> > > >   #include <linux/io.h>
> > > > -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > > > +void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > > >   {
> > > >   	unsigned long last_addr = phys_addr + size - 1;
> > > > +	int ret = -EINVAL;
> > > If ret variable is really needed?
> > > 
> > > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > > index 72974cb81343..d72eb310fb3c 100644
> > > > --- a/include/asm-generic/io.h
> > > > +++ b/include/asm-generic/io.h
> > > > @@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
> > > >   /*
> > > >    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> > > >    * ioremap_allowed() return a bool,
> > > > - *   - true means continue to remap
> > > > - *   - false means skip remap and return directly
> > > > + *   - IS_ERR means return an error
> > > > + *   - NULL means continue to remap
> > > > + *   - a non-NULL, non-IS_ERR pointer is returned directly
> > > If ioremap_allowed() returns a valid pointer, then the function name
> > > is not as precise anymore.
> > 
> > Maybe use arch_ioremap/unmap as before, or some better name.
> > 
> > > 
> > > > @@ -28,8 +29,11 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> > > >   	phys_addr -= offset;
> > > >   	size = PAGE_ALIGN(size + offset);
> > > > -	if (!ioremap_allowed(phys_addr, size, prot))
> > > > +	base = ioremap_allowed(phys_addr, size, prot);
> > > > +	if (IS_ERR(base))
> > > >   		return NULL;
> > > > +	else if (base)
> > > > +		return base;
> > > It is probably just me, but the base name bit misleading here.
> > We could reuse vaddr, not add new base.
> 
> vaddr name is wrong AFAICT. ioremap_allowed() returns __iomem address,
> not the virtual one.

Thanks a lot for reviewing, both.

Here, I tend to agree with Alexander. ioremap_allowed() returns
__iomem*. How about naming it io_addr here. While I don't have strong
opinion about it, reusing vaddr and casting it to (__iomem*) when return
is also OK to me.

> 
> > > 
> > > > @@ -50,9 +54,9 @@ EXPORT_SYMBOL(ioremap_prot);
> > > >   void iounmap(volatile void __iomem *addr)
> > > >   {
> > > > -	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> > > > +	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
> 
> Same here.


> 
> > > > -	if (!iounmap_allowed(vaddr))
> > > > +	if (iounmap_allowed(vaddr))
> > > I guess, iounmap_allowed() should accept void __iomem *, not void *.
> > > Then addr needs to be passed to iounmap_allowed() not vaddr.
> > 
> > The following is_vmalloc_addr()  and vunmap() in iounmap() use void *,
> > 
> > so we could simply use void* for iounmap_allowed().
> 
> iounmap_allowed() accepts void __iomem * and I that looks correct to me.
> 
> Passing void * on the other hand means you pass a pointer that
> in theory differs from what architecture previously returned
> with ioremap_allowed() and "knows" nothing about.
> 
> I think you need to pass addr to iounmap_allowed() as is.

OK, I will change to pass (__iomem*) to iounmap_allowed() directly.
Thanks.

