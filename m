Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73952F87D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiEUEWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiEUEWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:22:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95E419591A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:22:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so9258342pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ikfQc/ZOG7EJokBAFYccHiaAA1f4v5zShuvB/Kv0HFo=;
        b=S8c1LgySUO1SkmryhkzPJ3RvfXMRba+mg9/9xI+hvcBVKrUQPLH0gTxcsz3RvmzOnF
         y9jwVOkN/aw7fivKVtZbStb4mmKayCfLzWRtRtdPh8hwcbU+9RsBbGpxB+qlFE8pxDNa
         NwY+1oDT0JXMwIOwUDk3yOJ9e/nTEjM7E6dYJUQ9SQ1GV6lUklSRidG7NudQrGcopR95
         Xc5rez12atmEBrQ1JxDZNFIBOHNDHc0zirX+s9pRTZKxA79r3lkaz7luO2UV42cNTOLv
         TIslk8+TY0UGEJOLY3ZFl6fGB7dexSWc9qPbzu3OVTqAM+vgney4Rf78y4GNZhZ30UU/
         SvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ikfQc/ZOG7EJokBAFYccHiaAA1f4v5zShuvB/Kv0HFo=;
        b=usXm7MTHde3Bf1HP9WzSIzBjHLX0zPDgsCqDgE03qEDCZfVoqzOcAOERjvzWN9Ev2D
         9po5FexJah452t3n2df5KqkKbLllQ/HF83ilpgD/pqpKV1WcW3tudepsG6WWNrt4LYfR
         BdM+hpkN35p7mADCAheYQ2VFHopLLky7pi9n9VGTNKHuDrpGF5PaN7Jt5Z64d/cqJUyC
         2sxdYPckCC7VWhulxwv3HJYtIVVPcNpm6nORMLyT/coP+hJGo287Xg8/UBjrOipoirQ1
         b2acTpm32+bAvaqd+cQN5hRsQG4UdRodfoRH1jFBYduRgmbeoysNjHfqiVnD7QWDsxNd
         xXKg==
X-Gm-Message-State: AOAM533/JZ4iS/os/M5/gOytndOrg6T+mYx79TAWSnq7VbTQu7+A7ZI8
        6ZGq3eKfVu4B7mMum7lNKIE=
X-Google-Smtp-Source: ABdhPJzC5CTTqYDCd+XR2nrxRX2wUxCcyZJB323gUU3hN1BZrHGT7mhZQ09MVvVpmCcLuqQFm7zHcA==
X-Received: by 2002:a05:6a00:1254:b0:517:c9ef:bdaf with SMTP id u20-20020a056a00125400b00517c9efbdafmr13401028pfi.14.1653106954379;
        Fri, 20 May 2022 21:22:34 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id jb11-20020a17090b408b00b001dcf9fe5cddsm2651420pjb.38.2022.05.20.21.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 21:22:33 -0700 (PDT)
Date:   Sat, 21 May 2022 12:22:25 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 5/6] mm, pgtable: Add the reference counter for COW
 PTE
Message-ID: <20220521042225.GB1508515@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-6-shiyn.lin@gmail.com>
 <3ac4823b-8f44-c2d8-e550-7d3abf49a87e@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ac4823b-8f44-c2d8-e550-7d3abf49a87e@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:30:29PM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/05/2022 à 20:31, Chih-En Lin a écrit :
> > Add the reference counter cow_pgtable_refcount to maintain the number
> > of process references to COW PTE. Before decreasing the reference
> > count, it will check whether the counter is one or not for reusing
> > COW PTE when the counter is one.
> > 
> > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > ---
> >   include/linux/mm.h       |  1 +
> >   include/linux/mm_types.h |  1 +
> >   include/linux/pgtable.h  | 27 +++++++++++++++++++++++++++
> >   mm/memory.c              |  1 +
> >   4 files changed, 30 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 221926a3d818..e48bb3fbc33c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2329,6 +2329,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
> >          __SetPageTable(page);
> >          inc_lruvec_page_state(page, NR_PAGETABLE);
> >          page->cow_pte_owner = NULL;
> > +       atomic_set(&page->cow_pgtable_refcount, 1);
> >          return true;
> >   }
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5dcbd7f6c361..984d81e47d53 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -221,6 +221,7 @@ struct page {
> >   #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >          int _last_cpupid;
> >   #endif
> > +       atomic_t cow_pgtable_refcount; /* COW page table */
> >          pmd_t *cow_pte_owner; /* cow pte: pmd */
> >   } _struct_page_alignment;
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index faca57af332e..33c01fec7b92 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -604,6 +604,33 @@ static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
> >                  true : false;
> >   }
> > 
> > +extern void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr);
> 
> 'extern' keyword is pointless for fonction prototypes. No new ones 
> should added.

I see.
It totally does not need the extern to the non-static function.

> > +
> > +static inline int pmd_get_pte(pmd_t *pmd)
> > +{
> > +       return atomic_inc_return(&pmd_page(*pmd)->cow_pgtable_refcount);
> > +}
> > +
> > +/* If the COW PTE page->cow_pgtable_refcount is 1, instead of decreasing the
> > + * counter, clear write protection of the corresponding PMD entry and reset
> > + * the COW PTE owner to reuse the table.
> > + */
> > +static inline int pmd_put_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr)
> > +{
> > +       if (!atomic_add_unless(&pmd_page(*pmd)->cow_pgtable_refcount, -1, 1)) {
> > +               cow_pte_fallback(vma, pmd, addr);
> > +               return 1;
> > +       }
> > +       return 0;
> 
> I would do something more flat by reverting the test:
> 
> {
> 	if (atomic_add_unless(&pmd_page(*pmd)->cow_pgtable_refcount, -1, 1))
> 		return 0;
> 
> 	cow_pte_fallback(vma, pmd, addr);
> 	return 1;
> }
> 

Thanks!
