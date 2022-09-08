Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC945B2533
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiIHRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiIHRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:54:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599252469
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:54:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3457bc84d53so95039987b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4o6pEGvC0xR1WYCpAN/WgF7OkvsbjOlTp/AoxTDmWXU=;
        b=MoqgM7jyFVT39XmQ2SFHCSX5yFBGlrr6am1GQA+mo3OH3ZfqZJ0X2qIYszdvXX50bh
         oRtOzmvY0g9j67TavgJWauoVX88NWkSRVbmNaED64NML/RMlVtggHX466sFYVWRdyGzy
         xBvrKC60nBUE78KNd5CqrmtjS18ycsR5mWoCiuiHS77pWfU5z160zeGXUM9nAZ1cXyqz
         5KiRD1U+/uREhHhVxLO2kCi9T+MdbGZcdqiTb0wE9/5NvWF5cU82QMcZRtu50Vf+H/gC
         BMNY4l1gP/OIqU4CY3zaz/789iSGF9/yuISlNQ2Bf8vQ7QXt7MW2hvUcorwffvEYMRhz
         bqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4o6pEGvC0xR1WYCpAN/WgF7OkvsbjOlTp/AoxTDmWXU=;
        b=7JCw2UmEtqejEKgZtF7RbEgQrdwizWSnQMXgICwIuyBuHIczAfl6T4bhWc18VUvbfu
         7wEmpxTKdVlQt+FH/N4RKTlHbN1MuJ0IdU+zGNzimkmLzaUlydMJ88r7LAklt83cdNAc
         ZCOeZt2hTga080/gAfMdkGET2y29EPHPdvy+LpT1wrNUQHam5BB3nbw4uUhk0DRx1DI1
         QyyCDCgCuoBe4SL+W/aDWeN5xR04IFeoa6iC3BOQ60ibBPlO9tzBn6F1lvEjPGDpC3tt
         V6l5WUHLZdSCkn2/IfLslRyDmooDf5Zd/g5nAVm7XXIahNQQHumSyeG/Yks5oVLthEce
         2hrQ==
X-Gm-Message-State: ACgBeo2ONV/Czwz7kKqPB4RJlgWFTIItoct3Avd7s71lVT1wjXn02p+B
        ofuKo7sT+HMEZMhWWipiyWYDwYLSkejQ4RboFCCSzg==
X-Google-Smtp-Source: AA6agR64MqWStEy43/wInEWWHQqJckl2u3w2fnpuKGZdtvM772eO0H6J4oJPu9XUFZhQcbsuxiooxwVtHUPCgyJqgbE=
X-Received: by 2002:a81:5790:0:b0:348:9584:bf4b with SMTP id
 l138-20020a815790000000b003489584bf4bmr3154763ywb.483.1662659689250; Thu, 08
 Sep 2022 10:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com> <Yxool80IgkXnqS5Y@xz-m1.local>
In-Reply-To: <Yxool80IgkXnqS5Y@xz-m1.local>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 8 Sep 2022 10:54:37 -0700
Message-ID: <CADrL8HUNs8UgHE4MJ4ciX_uDaizAcA8OysJzQN=OTWJ8JJQ53w@mail.gmail.com>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 10:38 AM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Fri, Jun 24, 2022 at 05:36:37PM +0000, James Houghton wrote:
> > +static inline
> > +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +
> > +     BUG_ON(!hpte->ptep);
> > +     // Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> > +     // the regular page table lock.
> > +     if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> > +             return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> > +                             mm, hpte->ptep);
> > +     return &mm->page_table_lock;
> > +}
>
> Today when I re-read part of this thread, I found that I'm not sure whether
> this is safe.  IIUC taking different locks depending on the state of pte
> may lead to issues.
>
> For example, could below race happen where two threads can be taking
> different locks even if stumbled over the same pmd entry?
>
>          thread 1                          thread 2
>          --------                          --------
>
>     hugetlb_pte_lockptr (for pmd level)
>       pte_none()==true,
>         take pmd lock
>     pmd_alloc()
>                                 hugetlb_pte_lockptr (for pmd level)
>                                   pte is pgtable entry (so !none, !present_leaf)
>                                     take page_table_lock
>                                 (can run concurrently with thread 1...)
>     pte_alloc()
>     ...

Thanks for pointing out this race. Yes, it is wrong to change which
lock we take depending on the value of the PTE, as we would need to
lock the PTE first to correctly make the decision. This has already
been fixed in the next version of this series :). That is, we choose
which lock to grab based on the PTE's page table level.

- James

>
> --
> Peter Xu
>
