Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7264FE932
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiDLUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiDLUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D82E7DE1D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649793236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ktu/FmbfdAxFSlIYnoKvOmDiTJHsefITneobmc6G+mM=;
        b=YPctwdO0NOyq5PvBu7HQ4eprtsDe0sfvJavZPGzdmVT9RbJGCrK38Mghjl1ZOYjui6P/0H
        DzyLDUOZhS76kDNxwLP7rEeJQL9F2X7c/35VhlZykDLY741gUSJXGdXMNx5M5rY31G4FD9
        9YJgM5d18sezJRLqrO4slV1k5p//8oI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-Fo9b__GvOa6MVD1PMfv-dA-1; Tue, 12 Apr 2022 15:53:53 -0400
X-MC-Unique: Fo9b__GvOa6MVD1PMfv-dA-1
Received: by mail-il1-f199.google.com with SMTP id x6-20020a923006000000b002bea39c3974so13324692ile.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ktu/FmbfdAxFSlIYnoKvOmDiTJHsefITneobmc6G+mM=;
        b=PXrT3gNwbVqrwD58m6o3wzNtdyxcLIpgmP2g0y/dZobZFjYN50pKubX3wFM+m1d4Xi
         pmyNlAYGs7vAjzT76gezkWpSRWLRL9Fl99Mfc8xiqYXHsirgHetYATApuqkLgOGxJbbY
         hzClK1J1azlmp2bKG1teLIx4cj6D81B+I6EP/famN0aarGrstpBVpXFdmxTxdinRTcSA
         042HsOCwyEWKsxrsFT1iHXWOLUF/mHrcR8dWTFdEPz2iQn80dZANMODsVtghD9Jophcb
         VHCWwq0msad21OpQQNHgIzXlwlNEu5E7Wq1cIWq+xe5JkWSOgdmJKLfwXpXeFRXwKsuM
         TTuQ==
X-Gm-Message-State: AOAM532bvcnVEzMkHoiUm7Edv4sHLixMZsaob/1jda3iALlOp+e2SRbF
        zr6DOALyjD12q6P6pZedUFBi6oAp4Jkn5bi6W86jT/3PlXhaekvxZvJPn32dRWiTsc8v2Lq4veB
        uoQnMafTvier5yw/Hdo/mWZNN
X-Received: by 2002:a05:6638:d51:b0:326:4f60:f2c4 with SMTP id d17-20020a0566380d5100b003264f60f2c4mr1666117jak.211.1649793232579;
        Tue, 12 Apr 2022 12:53:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKhc8KBBIu03VM32gpa8Lhg+/5hy0VZsV9Ah94tlicv6v7mtbET3C3fQCFaTOhFxemxsAnjw==
X-Received: by 2002:a05:6638:d51:b0:326:4f60:f2c4 with SMTP id d17-20020a0566380d5100b003264f60f2c4mr1666114jak.211.1649793232373;
        Tue, 12 Apr 2022 12:53:52 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d16-20020a056e020bf000b002ca51236f60sm15162919ilu.9.2022.04.12.12.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:53:52 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:53:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v8 02/23] mm: Teach core mm about pte markers
Message-ID: <YlXYzpcTQW8NdTTm@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014833.14015-1-peterx@redhat.com>
 <87a6crawzy.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6crawzy.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alistair,

On Tue, Apr 12, 2022 at 11:22:01AM +1000, Alistair Popple wrote:
> I've been reviewing existing pte_none() call sites and noticed the following:
> 
> From khugepaged_scan_pmd():
> 
> pte_t pteval = *_pte;
> if (is_swap_pte(pteval)) {
>     if (++unmapped <= khugepaged_max_ptes_swap) {
>         /*
> * Always be strict with uffd-wp
> * enabled swap entries.  Please see
> * comment below for pte_uffd_wp().
>          */
>         if (pte_swp_uffd_wp(pteval)) {
>             result = SCAN_PTE_UFFD_WP;
>             goto out_unmap;
>         }
>         continue;
>     } else {
>         result = SCAN_EXCEED_SWAP_PTE;
>         count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>         goto out_unmap;
>     }
> }
> if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>     if (!userfaultfd_armed(vma) &&
>         ++none_or_zero <= khugepaged_max_ptes_none) {
>         continue;
>     } else {
>         result = SCAN_EXCEED_NONE_PTE;
>         count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>         goto out_unmap;
>     }
> }
> 
> I think the above could encounter a marker PTE right? So the behviour would be
> wrong in that case. As I understand things the is_swap_pte() path will be taken
> rather than pte_none() but in the absence of any special handling shouldn't
> marker PTE's mostly be treated as pte_none() here?
> 
> I think you need to s/pte_none/pte_none_mostly/ here and swap the order of
> conditionals around.

Isn't khugepaged_scan_pmd() only for anonymous?

The shmem side is covered by khugepaged_scan_file(), imho.  We definitely
don't want to collapse shmem vma ranges that has uffd-wp registered, and
that's actually handled explicilty in "mm/khugepaged: Don't recycle vma
pgtable if uffd-wp registered".  Please feel free to have a look.

Thanks,

-- 
Peter Xu

