Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE44576556
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiGOQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BC7C31DC6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657902931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbKyrXjYLCzg3wZ9PZeUdCqdnt+jGnJCesOG5YLa6eU=;
        b=Fm5YNeC8EtLEu3+aidG6vskpZnQ7r9i4SAnybxUWdC+ltSUN5FKSgi5mEsmZeHDNAREGZp
        Xgx2T7IjKCtBHT0/nal3dOJeIqz55pazHE2UFuT0kGG+KJhapSdIjH2AvnNdfCcMENxYk+
        KY5Nsb3n9jamEtTMCQRCB3dW6TL3tUc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-vxJu1kuXNWexLX_5YsY5ZA-1; Fri, 15 Jul 2022 12:35:30 -0400
X-MC-Unique: vxJu1kuXNWexLX_5YsY5ZA-1
Received: by mail-qk1-f199.google.com with SMTP id u18-20020a05620a455200b006b5d08c0ee7so1333036qkp.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbKyrXjYLCzg3wZ9PZeUdCqdnt+jGnJCesOG5YLa6eU=;
        b=gmamt0dQRAHGuapiNgAXSHxCuYtr0tWXPlzxC1wdupfp4UuAdk/flDXdzYQsBPIZN9
         SJrhwJxHas+pOeZvxXFQ7oy2cWuuupOtC/9tsM1lHidsBWURjhQ++eQXVD3EoKaZU4hd
         qwgAjOA0qohUEhs5u/qeWpiAlNFWNhhdpOil7dLaKAtnwGMl8RYWaiwFU+qLSB0pnX5C
         6I5RLacMit86J5sC7S7ppuMWgFnyMAtxdr7nmhdoTTm/Qx2I9cR9kc5VQU+9sCNoDxDi
         t9kEsQKJb9VA7sMgREVg3qvabJGv3PRf1P2h67UoNKYFoFunmSJAGFHPljmMyYW21Fsx
         2Q5A==
X-Gm-Message-State: AJIora/armEg3qFWmQ4edQhe9iIjvN04FEQ0AIeCgF+Dd1+JNb6HIII1
        C/YmN0CIRS34Xhb0hjHTwPnLNzQDqtAPE8DR3onpG3XzO+AFHFo4mIqIsI6y0IW+U99L9r6Vhrf
        TJfzeBZnpUw/JRsFUGZNHaRAH
X-Received: by 2002:a05:620a:25c6:b0:6ae:2408:6e05 with SMTP id y6-20020a05620a25c600b006ae24086e05mr9854573qko.240.1657902929677;
        Fri, 15 Jul 2022 09:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uM91supN2njnue234jkDW7W3Aj6JhU4hnWcoyNJTPy9B5v1i6uw/W0GfbjAR5yvUPKxUPfEA==
X-Received: by 2002:a05:620a:25c6:b0:6ae:2408:6e05 with SMTP id y6-20020a05620a25c600b006ae24086e05mr9854556qko.240.1657902929352;
        Fri, 15 Jul 2022 09:35:29 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id t13-20020ac8760d000000b0031eb5648b86sm3834603qtq.41.2022.07.15.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:35:27 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:35:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <YtGXTlyRs3oVVPA5@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
 <YsyzGMS+MS0kZoP8@monkey>
 <Ys1B+fXo2uSPd46B@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys1B+fXo2uSPd46B@work-vm>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:42:17AM +0100, Dr. David Alan Gilbert wrote:
> * Mike Kravetz (mike.kravetz@oracle.com) wrote:
> > On 06/24/22 17:36, James Houghton wrote:
> > > After high-granularity mapping, page table entries for HugeTLB pages can
> > > be of any size/type. (For example, we can have a 1G page mapped with a
> > > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > > PTE after we have done a page table walk.
> > 
> > This has been rolling around in my head.
> > 
> > Will this first use case (live migration) actually make use of this
> > 'mixed mapping' model where hugetlb pages could be mapped at the PUD,
> > PMD and PTE level all within the same vma?  I only understand the use
> > case from a high level.  But, it seems that we would want to only want
> > to migrate PTE (or PMD) sized pages and not necessarily a mix.
> 
> I suspect we would pick one size and use that size for all transfers
> when in postcopy; not sure if there are any side cases though.

Yes, I'm also curious whether the series can be much simplified if we have
a static way to do sub-page mappings, e.g., when sub-page mapping enabled
we always map to PAGE_SIZE only; if not we keep the old hpage size mappings
only.

> > Looking to the future when supporting memory error handling/page poisoning
> > it seems like we would certainly want multiple size mappings.

If we treat page poisoning as very rare events anyway, IMHO it'll even be
acceptable if we always split 1G pages into 4K ones but only rule out the
real poisoned 4K phys page.  After all IIUC the major goal is for reducing
poisoned memory footprint.

It'll be definitely nicer if we can keep 511 2M pages and 511 4K pages in
that case so the 511 2M pages performs slightly better, but it'll be
something extra to me.  It can always be something worked upon a simpler
version of sub-page mapping which is only PAGE_SIZE based.

Thanks,

-- 
Peter Xu

