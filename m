Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BC5AB5A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiIBPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiIBPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:48:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7175927A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:37:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l65so2239923pfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wxuJKVL4TdrpBfaqB67ZFhkoV3FR0V/WApM6+UkhSDY=;
        b=logBeReqwhiMPJ+9Et4jQQRif3S4/EFNghg66d1akxtF4CgpHkr2/2eH0P+FOUZ8YW
         ni5I1humC6Jpi8wTov8hh67azGrQl7qqeyqH/+M4EJWbGfzc8+ixDdOTRBAxyvkRCUQ+
         vha6jR73f3AKIaAMoa+mrNwkUhL5RkCVw/Yc0JOwd4hGzJJB5iQ+t1a9J0J9YIxmpVwQ
         VCIO9ZaG/moxpcrb+UXJIVwFUKVVGER3GTv/w2xgIyG+EyPLqqWzogh80kg+zp6MQEy6
         JWAFV7lWdn75iIyxFMgGpp5alFnb+X6oQeP4z7wgCiEHVQN2D76SgznaxasS5criYUwV
         7/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wxuJKVL4TdrpBfaqB67ZFhkoV3FR0V/WApM6+UkhSDY=;
        b=4bvsIx0q8JI4iYtJSEFarwf1t3BE6r/kufX9W+i8yE4DJ4C5EyXpB22KeLWHOC3RlL
         ICgzQ7H4Jxq0lf/mUBgIj2n9ovfN4uo2EH4ZzzxDVsTw4Lt8QWXhEto9knQYm2LcFqFP
         aBJ8GKHneOim1JFc1uqNUmDnvGZ7mXTtKIhsf/6q4UhZ0r6cQccF1ELgtukMAQdw2ldr
         /k7m8cjs7Pq9UWqsOf95ypfzXWP87JnstdY7PlWAT+ZRi4D5tlZ9fBeZz482Tj+NlKoX
         P742DTs3QpHWWRxf/D7d+KsOf+AIj6vSMzCVJ1pwO3WJtyYXAonqToDR1Umz3PdNZ3bh
         pYgA==
X-Gm-Message-State: ACgBeo15yuR930Kte/jMjiH0IDGX7R1minfPTkohLErPeO8dqAC87qzs
        Lv5Tt3gd6wfr4KndLpp3csf+izMnVsauzYeuil4=
X-Google-Smtp-Source: AA6agR73Ctcqg5Eu+vup07FNPO1+IPQ12OI47E1xnwJpeMPLt6l9qFgI30lW0WWHlbFLAtBMFoVHJEjBLxucssvaGc0=
X-Received: by 2002:a63:de01:0:b0:42b:31f7:b6ea with SMTP id
 f1-20020a63de01000000b0042b31f7b6eamr30333941pgg.587.1662133067862; Fri, 02
 Sep 2022 08:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220901072119.37588-1-david@redhat.com> <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com> <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com> <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local> <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
 <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
In-Reply-To: <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 2 Sep 2022 08:37:35 -0700
Message-ID: <CAHbLzkokbqhf2Q7BptHBpENjQGNBt19ot+wvSp=_f7oOBKgiXA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 11:32 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.09.22 20:35, Yang Shi wrote:
> > On Thu, Sep 1, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
> >>
> >> On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
> >>> Yeah, because THP collapse does copy the data before clearing pte. If
> >>> we want to remove pmdp_collapse_flush() by just clearing pmd, we
> >>> should clear *AND* flush pte before copying the data IIRC.
> >>
> >> Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
> >> still be working (with the pte level flushing there) but it should just
> >> start to work for all archs, so potentially we could drop the arch-specific
> >> pmdp_collapse_flush()s, mostly the ppc impl.
> >
> > I'm don't know why powperpc needs to have its specific
> > pmdp_collapse_flush() in the first place, not only the mandatory IPI
> > broadcast, but also the specific implementation of pmd tlb flush. But
> > anyway the IPI broadcast could be removed at least IMO.
> >
>
> pmdp_collapse_flush() is overwritten on book3s only. It either translates
> to radix__pmdp_collapse_flush() or hash__pmdp_collapse_flush().
>
>
> radix__pmdp_collapse_flush() has a comment explaining the situation:
>
>
> +       /*
> +        * pmdp collapse_flush need to ensure that there are no parallel gup
> +        * walk after this call. This is needed so that we can have stable
> +        * page ref count when collapsing a page. We don't allow a collapse page
> +        * if we have gup taken on the page. We can ensure that by sending IPI
> +        * because gup walk happens with IRQ disabled.
> +        */
>
>
> The comment for hash__pmdp_collapse_flush() is a bit more involved:
>
>         /*
>          * Wait for all pending hash_page to finish. This is needed
>          * in case of subpage collapse. When we collapse normal pages
>          * to hugepage, we first clear the pmd, then invalidate all
>          * the PTE entries. The assumption here is that any low level
>          * page fault will see a none pmd and take the slow path that
>          * will wait on mmap_lock. But we could very well be in a
>          * hash_page with local ptep pointer value. Such a hash page
>          * can result in adding new HPTE entries for normal subpages.
>          * That means we could be modifying the page content as we
>          * copy them to a huge page. So wait for parallel hash_page
>          * to finish before invalidating HPTE entries. We can do this
>          * by sending an IPI to all the cpus and executing a dummy
>          * function there.
>          */
>
> I'm not sure if that implies that the IPI is needed for some other hash-magic.

They do issue IPI broadcast to call a dummy function in order to
serialize against fast GUP, please see serialize_against_pte_lookup(),
and it does full memory barrier too.

I think the IPI broadcast could be removed once my fix is merged and
the common pmd clear and memory barrier could be consolidated, now it
is duplicated in both radix and hash.

>
> Maybe Aneesh can clarify.
>
> >>
> >> This also reminded me that the s390 version of pmdp_collapse_flush() is a
> >> bit weird, since it doesn't even have the tlb flush there.  I feel like
> >> it's broken but I can't really tell whether something I've overlooked.
> >> Worth an eye on.
> >
> > I don't know why. But if s390 doesn't flush tlb in
> > pmdp_collapse_flush(), then there may be data integrity problem since
> > the page is still writable when copying the data because pte is
> > cleared after data copying. Or s390 hardware does flush tlb
> > automatically?
>
> s390x does a pmdp_huge_get_and_clear().
>
> pmdp_huge_get_and_clear() does an pmdp_xchg_direct().
>
> pmdp_xchg_direct() does an pmdp_flush_direct().
>
> pmdp_flush_direct() issues an IDTE, which is a TLB flush.

Aha, thanks, I didn't look that deep... I stopped looking once I saw
pmdp_huge_get_and_clear(), I thought it just does clear...

>
>
> Note that this matches ptep_get_and_clear() behavior on s390x. Quoting the comment in there:
>
>
> /*
>  * This is hard to understand. ptep_get_and_clear and ptep_clear_flush
>  * both clear the TLB for the unmapped pte. The reason is that
>  * ptep_get_and_clear is used in common code (e.g. change_pte_range)
>  * to modify an active pte. The sequence is
>  *   1) ptep_get_and_clear
>  *   2) set_pte_at
>  *   3) flush_tlb_range
>  * On s390 the tlb needs to get flushed with the modification of the pte
>  * if the pte is active. The only way how this can be implemented is to
>  * have ptep_get_and_clear do the tlb flush. In exchange flush_tlb_range
>  * is a nop.
>  */
>
> --
> Thanks,
>
> David / dhildenb
>
