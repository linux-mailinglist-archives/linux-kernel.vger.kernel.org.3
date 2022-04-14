Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF05501941
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiDNQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiDNQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D08326E1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649953813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dS40yRI9Iu4mpulttk/yT5UkW6FhfFYXK4U+vMF3mEE=;
        b=ddHgCh+0WqFjzDKa8wsIw50w5AQBYBrc+5guymIVpcew1Oe2+UDAoQ+MsaSLxD00Ccbtxu
        wAzivf/L8vxgn7lNIApkPzPYoM8P1qFVKY4dpmRCkurAaTRvOWF86/FtftLd2w6/Rog5hP
        ei28+qZI3SdZStfwdTSM7GAg6wtWR8M=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-JlQrL9D6Pg6s5MhnPKmdxQ-1; Thu, 14 Apr 2022 12:30:11 -0400
X-MC-Unique: JlQrL9D6Pg6s5MhnPKmdxQ-1
Received: by mail-il1-f198.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so3273139ilc.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dS40yRI9Iu4mpulttk/yT5UkW6FhfFYXK4U+vMF3mEE=;
        b=RRCcas1gubGYJI0g66l99oB8IuFes6defc+suKe/kfZ/zyH4IWRug0iymALtmmHUJ4
         rt967XGPj3xqcmjA+/q5G6PtvkJWTADARuLGrmXkCA9DQaXC6RtDrGpihs+FtOsdRN9+
         NOustGyB76gJBkbPdwiyPtw1cTJAedj91SrjXmIsPpYwxMGdIZB9aTvQ3M3gYf3ixwKo
         Ygdjnbt1PUm2CpQ8datIg2sB1UNAXi+scVLcpvtNS12OtOIYAPLqmPXDH7Wc6e7EC8rc
         BKZUbt07whZEIT8ek72d61LxNPAlwr6Xy4Jr+kPqs/CC6ePdSFvXLdtaBtepiOnaeZy8
         vu2A==
X-Gm-Message-State: AOAM5328WrKSDfLlaq0uW50uEIk1AIDRudpr8edzl6CrFrB6oec19qRg
        wppsajd2Xn7V3YXqE1vGlkM4fibBoOq/eeQQskiQ0PIgSQ7qnWSNR3W4/4rxOK20tmEMvDUX2UB
        EblpDcG5gTtvl0qy28tw/mAin
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id z14-20020a05660229ce00b006094f6059cbmr1503818ioq.183.1649953809940;
        Thu, 14 Apr 2022 09:30:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9A8AHSrxgnUVEj2v/S1hhEfJFkeDyEN0WflKOfoPSETwnRHxI6kA8LxPjlmWrc/2uv8jWQg==
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id z14-20020a05660229ce00b006094f6059cbmr1503809ioq.183.1649953809695;
        Thu, 14 Apr 2022 09:30:09 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id f10-20020a05660215ca00b0064d25228248sm1525884iow.11.2022.04.14.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:30:08 -0700 (PDT)
Date:   Thu, 14 Apr 2022 12:30:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <YlhMDmko0IN82d21@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
 <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
 <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
 <Ylb9rXJyPm8/ao8f@xz-m1.local>
 <6ccf5f5f-8dc5-16cc-f06c-78401b822a54@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ccf5f5f-8dc5-16cc-f06c-78401b822a54@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:51:01AM +0200, Marek Szyprowski wrote:
> Hi Peter,
> 
> On 13.04.2022 18:43, Peter Xu wrote:
> > On Wed, Apr 13, 2022 at 04:03:28PM +0200, Marek Szyprowski wrote:
> >> On 05.04.2022 03:48, Peter Xu wrote:
> >>> We used to check against none pte in finish_fault(), with the assumption
> >>> that the orig_pte is always none pte.
> >>>
> >>> This change prepares us to be able to call do_fault() on !none ptes.  For
> >>> example, we should allow that to happen for pte marker so that we can restore
> >>> information out of the pte markers.
> >>>
> >>> Let's change the "pte_none" check into detecting changes since we fetched
> >>> orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
> >>> the pgtable we may not initialize orig_pte at all in handle_pte_fault().
> >>>
> >>> By default orig_pte will be all zeros however the problem is not all
> >>> architectures are using all-zeros for a none pte.  pte_clear() will be the
> >>> right thing to use here so that we'll always have a valid orig_pte value
> >>> for the whole handle_pte_fault() call.
> >>>
> >>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> This patch landed in today's linux next-202204213 as commit fa6009949163
> >> ("mm: check against orig_pte for finish_fault()"). Unfortunately it
> >> causes serious system instability on some ARM 32bit machines. I've
> >> observed it on all tested boards (various Samsung Exynos based,
> >> Raspberry Pi 3b and 4b, even QEMU's virt 32bit machine) when kernel was
> >> compiled from multi_v7_defconfig.
> > Thanks for the report.
> >
> >> Here is a crash log from QEMU's ARM 32bit virt machine:
> >>
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address e093263c
> >> [e093263c] *pgd=42083811, *pte=00000000, *ppte=00000000
> >> Internal error: Oops: 807 [#1] SMP ARM
> >> Modules linked in:
> >> CPU: 1 PID: 37 Comm: kworker/u4:0 Not tainted
> >> 5.18.0-rc2-00176-gfa6009949163 #11684
> >> Hardware name: Generic DT based system
> >> PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> >> LR is at handle_mm_fault+0x46c/0xbb0
> > I had a feeling that for some reason the pte_clear() isn't working right
> > there when it's applying to a kernel stack variable for arm32.  I'm totally
> > newbie to arm32, so what I'm reading is this:
> >
> > https://people.kernel.org/linusw/arm32-page-tables
> >
> > Especially:
> >
> > https://protect2.fireeye.com/v1/url?k=35bc90ac-6a27a9bd-35bd1be3-0cc47a31cdbc-b032cb1d178dc691&q=1&e=c82daefb-c86b-4ca1-8db1-cadbdc124ed2&u=https%3A%2F%2Fdflund.se%2F%7Etriad%2Fimages%2Fclassic-mmu-page-table.jpg
> >
> > It does match with what I read from arm32's proc-v7-2level.S of it, where
> > from the comment above cpu_v7_set_pte_ext:
> >
> >    * - ptep  - pointer to level 2 translation table entry
> >    *    (hardware version is stored at +2048 bytes)        <----------
> >
> > So it seems to me that arm32 needs to store some metadata at offset 0x800
> > of any pte_t* pointer passed over to pte_clear(), then it must be a real
> > pgtable or it'll write to random places in the kernel, am I correct?
> >
> > Does it mean that all pte_*() operations upon a kernel stack var will be
> > wrong?  I thought it could happen easily in the rest of mm too but I didn't
> > yet check much.  The fact shows that it's mostly possible the current code
> > just work well with arm32 and no such violation occured yet.
> >
> > That does sound a bit tricky, IMHO.  But I don't have an immediate solution
> > to make it less tricky.. though I have a thought of workaround, by simply
> > not calling pte_clear() on the stack var.
> >
> > Would you try the attached patch to replace this problematic patch? So we
> > need to revert commit fa6009949163 and apply the new one.  Please let me
> > know whether it'll solve the problem, so far I only compile tested it, but
> > I'll run some more test to make sure the uffd-wp scenarios will be working
> > right with the new version.
> 
> I've reverted fa6009949163 and applied the attached patch on top of 
> linux next-20220314. The ARM 32bit issues went away. :)
> 
> Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, Marek, for the fast feedback!

I've also verified it for the uffd-wp case so the whole series keeps
running as usual and nothing else shows up after the new patch replaced.

Andrew, any suggestion on how we proceed with the replacement patch?
E.g. do you want me to post it separately to the list?

Please let me know your preference, thanks.

-- 
Peter Xu

