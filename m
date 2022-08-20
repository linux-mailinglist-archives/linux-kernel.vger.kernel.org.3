Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092259AA49
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiHTAty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiHTAtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51C101C57
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660956590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPu0DQxVRwEmhdXyi4XLwQIkOlrmj+flVHHMJnG7VVM=;
        b=bSv4+t+rfoLjj4mO16YwkfokK1d0sYMRoEshthNO9/+nDuGb/pPgXmF3vqG+bpTJeXusGM
        tlUJ5VpEbj2zFlpIMWWYPm8eucQlDOe4F65iHFDyeI7X0Njtxo0lxF9wwzj4rhczsvuo8V
        vBXW+CLzhQs33ip9fvZgKHSagYaJZdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-ekivVkyVM0izy3AZ4RrpYQ-1; Fri, 19 Aug 2022 20:49:45 -0400
X-MC-Unique: ekivVkyVM0izy3AZ4RrpYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9F9185A794;
        Sat, 20 Aug 2022 00:49:45 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 607DA90A04;
        Sat, 20 Aug 2022 00:49:44 +0000 (UTC)
Date:   Sat, 20 Aug 2022 08:49:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] mm: ioremap: fixup the physical address
Message-ID: <YwAvpa9odnkhBPXa@MiWiFi-R3L-srv>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-3-bhe@redhat.com>
 <YuvthDzuPlAwD/LA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuvthDzuPlAwD/LA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/22 at 06:02pm, Alexander Gordeev wrote:
> On Mon, Aug 01, 2022 at 10:40:20PM +0800, Baoquan He wrote:
> > This is a preparation patch, no functionality change.
> 
> There is, please see below.
> 
> > @@ -3,11 +3,17 @@
> >  #include <linux/mm.h>
> >  #include <linux/io.h>
> >  
> > -void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > +void __iomem *
> > +ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >  {
> > -	unsigned long last_addr = phys_addr + size - 1;
> > +	unsigned long last_addr, offset, phys_addr = *paddr;
> >  	int ret = -EINVAL;
> >  
> > +	offset = phys_addr & (~PAGE_MASK);
> > +	phys_addr -= offset;
> 
> FWIW, phys_addr &= PAGE_MASK looks much more usual.
> 
> > @@ -11,13 +11,20 @@
> >  #include <linux/io.h>
> >  #include <linux/export.h>
> >  
> > -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> > +void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
> >  			   unsigned long prot)
> >  {
> >  	unsigned long offset, vaddr;
> > -	phys_addr_t last_addr;
> > +	phys_addr_t last_addr, phys_addr = paddr;
> >  	struct vm_struct *area;
> >  	void __iomem *base;
> > +	unsigned long prot_val = prot;
> 
> Why prot_val is needed?
> 
> > +	base = ioremap_allowed(&phys_addr, size, &prot_val);
> > +	if (IS_ERR(base))
> > +		return NULL;
> > +	else if (base)
> > +		return base;
> 
> By moving ioremap_allowed() here you allow it to be called
> before the wrap-around check, including architectures that
> do not do fixups.
> 
> And now ioremap_allowed() semantics, prototype and name turn
> less than obvious. Why not introduce a separate fixup callback?

I finally renamed ioremap_allowed()/iounmap_allowed() to arch_ioremap()
and arch_iounmap(). I didn't introduce a separate fixup callback, and
have added more explanation to log of patch 1~2, please check that.

