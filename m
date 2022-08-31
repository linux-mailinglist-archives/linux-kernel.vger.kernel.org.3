Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76F5A79A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHaJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiHaJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6072AC48
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661936407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aX/ysPy4g/ZBHpw80NPiA1D0zFDi9OYqQPxY6Pf5Q8=;
        b=hmDmmICgg9nWdJ5dycrA0ya45nAn498SLT60LqhpC27ZLLLXOppQd2ZdL9dl2FrjywVY/Z
        bOkVr5QZdj4ytRc34EgOQ/ccB8am9+5sKw32lLpEA1bPzmy8p8byBLRVxxcN8sat/RUyTn
        x8kcLP/ZPyaYpT02sYtp3Gig7ooODzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-FkZ4Wn5qMZi3r8xGJ6smAQ-1; Wed, 31 Aug 2022 05:00:03 -0400
X-MC-Unique: FkZ4Wn5qMZi3r8xGJ6smAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 732FE811E9B;
        Wed, 31 Aug 2022 09:00:02 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B6D32166B26;
        Wed, 31 Aug 2022 09:00:01 +0000 (UTC)
Date:   Wed, 31 Aug 2022 16:59:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yw8jDAyfPRt/Ip2Q@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-10-bhe@redhat.com>
 <YwHZRhpwL37yLb/o@infradead.org>
 <a381b32861b106afb209628e094260caf5fe9f7b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a381b32861b106afb209628e094260caf5fe9f7b.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/22 at 05:08pm, Niklas Schnelle wrote:
> On Sun, 2022-08-21 at 00:05 -0700, Christoph Hellwig wrote:
> > > +void __iomem *
> > > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> > >  {
> > >  	if (!static_branch_unlikely(&have_mio))
> > > +		return (void __iomem *) *paddr;
> > > +	return NULL;
> > 
> > This logic isn't new in the patch, but it could really use a comment
> > as it is rather non-obvious.
> 
> Yes, makes sense. Basically we fake MMIO addresses because the s390
> architecture doesn't have MMIO as a concept. That is until the PCI MIO
> instructions introduced pseudo-MMIO though only for specific PCI
> load/store instructions. Without those PCI BAR spaces as well as config
> space is accessed with so called function handles. As these are a bad
> fit for Linux' MMIO based APIs we create fake MMIO addresses (called
> address cookies) that encode an index into the zpci_iomap_start[] which
> can be decoded by our implementation of ioread*/iowrite*().
> 
> I don't think this is the right place to describe this overall scheme
> in detail but maybe we can leave a a good bread crumb. Maybe something
> like below?
> 
> /* 
>  * When PCI MIO instructions are unavailable the "physical" address encodes
>  * a hint for accessing the PCI memory space it represents. Just pass it 
>  * unchanged such that ioread/iowrite can decode it.
>  */

Thanks. Looks good to me, I will add these to above the code.

> 

