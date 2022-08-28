Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C65A3D12
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH1J6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH1J4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 05:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F263D4CA16
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661680561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmoVkJKn7sDlJ8XCXp6Z2DlsC39Vq8jBiod6jjguAyk=;
        b=B7/KTyOrewLL6TOj0YQCKPfVy4cy38hotDl0AEEE8AWhLqgSua5ai5/TC832YakEBTznbq
        3ULPsEOyq7o/hFCwRZCkNtLIz8MokFyL5WrnhNuakJVWWgnLAjXyr/T7i3/b0aOnJ7C3+r
        sdevlVyQdlEaVquI7WMyZjNCqDarfGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378--Y5_IFOCNa6f2P_lc1v6tA-1; Sun, 28 Aug 2022 05:55:57 -0400
X-MC-Unique: -Y5_IFOCNa6f2P_lc1v6tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB3780029D;
        Sun, 28 Aug 2022 09:55:57 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F5794010D43;
        Sun, 28 Aug 2022 09:55:55 +0000 (UTC)
Date:   Sun, 28 Aug 2022 17:55:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <Yws7qGmhFG0ig/tz@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <YwspB8OP8/Phv+tO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwspB8OP8/Phv+tO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/22 at 10:36am, Alexander Gordeev wrote:
> On Sat, Aug 20, 2022 at 08:31:15AM +0800, Baoquan He wrote:
> 
> Hi Baoquan,
> 
> >  arch_ioremap() return a bool,
> >    - IS_ERR means return an error
> >    - NULL means continue to remap
> >    - a non-NULL, non-IS_ERR pointer is returned directly
> >  arch_iounmap() return a bool,
> >    - 0 means continue to vunmap
> >    - error code means skip vunmap and return directly
> 
> It would make more sense if the return values were described
> from the prospective of an architecture, not the caller.
> I.e true - unmapped, false - not supported, etc.

Yes, sounds reasonable to me, thanks.

While ChristopheL suggested to take another way. Please see below link.
I will reply to Christophe to discuss that.

https://lore.kernel.org/all/8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu/T/#u

If the current arch_ioremap() way is taken, I will change the
description as you said.

> 
> > diff --git a/mm/ioremap.c b/mm/ioremap.c
> > index 8652426282cc..99fde69becc7 100644
> > --- a/mm/ioremap.c
> > +++ b/mm/ioremap.c
> > @@ -17,6 +17,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> >  	unsigned long offset, vaddr;
> >  	phys_addr_t last_addr;
> >  	struct vm_struct *area;
> > +	void __iomem *ioaddr;
> > +
> > +	ioaddr = arch_ioremap(phys_addr, size, prot);
> > +	if (IS_ERR(ioaddr))
> > +		return NULL;
> > +	else if (ioaddr)
> > +		return ioaddr;
> 
> It seems to me arch_ioremap() could simply return an address
> or an error. Then IOMEM_ERR_PTR(-ENOSYS) if the architecture
> does not support it reads much better than the cryptic NULL.

I may not follow. Returning NULL means arch_ioremap() doesn't give out a
mapped address and doesn't encounter wrong thing. NULL is a little
twisting, maybe '0' is better?

> 
> Probably arch_iounmap() returning error would look better too,
> though not sure about that.

Don't follow either. arch_iounmap() is returning error now. 

