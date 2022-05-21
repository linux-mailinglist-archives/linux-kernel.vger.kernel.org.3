Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C052F855
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354511AbiEUEPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354463AbiEUEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:15:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B90E8BA0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:15:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so9243271pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvqZuUDd3j9qH8hOp3q7NeqsJCSoxp+zweinHOB8N7M=;
        b=f9o6lYyKDURKBrwbdpoqADKlolYi25CCJD7H+jhGcvf9GazBsV+UuXzUeLTOkJXO3K
         WoBHR6Gq+kjIpgQCAIc8qUmJB30HDSMKJ2qYPCgyFm5zk3GC5GxihvKVQ5c5TI4HYK24
         vz0/UXOQn4og6wS2XPrezX++kQAmcIOp7FgnKdLmcqUtOd0lQ+m7bPr5mZxvonYU+ivc
         G0LRqLDylRtVBhxJRmO1bbJ5Z2gHKeR27ucvx1s2dBiKeKbzsWg+o0nwCOt/vZ/efHNw
         q33SsesuJfYybA2bLWN+vykt5PkBA5cMWsGS5+CbvVaAQ4+Rd3tFwMta7Jmt94ou9MSQ
         RDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvqZuUDd3j9qH8hOp3q7NeqsJCSoxp+zweinHOB8N7M=;
        b=GR2FvqgmedOro7E5a2C1QvFZnA8I/4NEnUeGpPdKejnWgMl2GxCbuL0L8T8snHFUSC
         HsrwAgjMDFhqpWi3VcxGD/kAh5qERJZuvuy44lD9DUNAWvo7tC3fIoM5tsEx+iVXOfQV
         E69k0fU8tAqDpnT3GCJtTj/wkt66sYSS001HGUZK18vC2FChQaUF5Z9KOyFwo2HR4w+5
         K+5mNzY/TkDT082lpv77XZu5+5WWyMF1oexB4qULaP3pxo0/sNWfBXq0/j7KQHC0fKHW
         dLLvn/02mc5jKDj29ju4LO9/05mdH+gfSBh67Pw0bNAzkasRfaH/GNfZc6lIgS113TfD
         vk0g==
X-Gm-Message-State: AOAM530dxbA5UnieusHN2LYj9uxWXHMiqJeoir7FVc+7ACAhHk/5jInx
        0W18RlS6nJ2/GiHH9JuyJoY=
X-Google-Smtp-Source: ABdhPJxT2WWNqx6XXUWSjUNgUPJ/mCBU75/qlfCLZpyaVxju1hSnFDKRKE1k3Ns+xB+UwJfpwCLdug==
X-Received: by 2002:a65:63d1:0:b0:3c6:25b2:22ba with SMTP id n17-20020a6563d1000000b003c625b222bamr11167737pgv.360.1653106517064;
        Fri, 20 May 2022 21:15:17 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b0015e8d4eb273sm495371plg.189.2022.05.20.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 21:15:16 -0700 (PDT)
Date:   Sat, 21 May 2022 12:15:08 +0800
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
Subject: Re: [RFC PATCH 4/6] mm: Add COW PTE fallback function
Message-ID: <20220521041508.GA1508515@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-5-shiyn.lin@gmail.com>
 <68c8a99e-52b5-9bbf-4847-3337165d99a8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c8a99e-52b5-9bbf-4847-3337165d99a8@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:21:54PM +0000, Christophe Leroy wrote:
> > +/* COW PTE fallback to normal PTE:
> > + * - two state here
> > + *   - After break child :   [parent, rss=1, ref=1, write=NO , owner=parent]
> > + *                        to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
> > + *   - After break parent:   [child , rss=0, ref=1, write=NO , owner=NULL  ]
> > + *                        to [child , rss=1, ref=1, write=YES, owner=NULL  ]
> > + */
> > +void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr)
> 
> There should be a prototype in a header somewhere for a non static function.
> 
> You are encouraged to run 'make mm/memory.o C=2' to check sparse reports.
> 

I will do all the above checking before sending the next version.

> > +{
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       unsigned long start, end;
> > +       pmd_t new;
> > +
> > +       BUG_ON(pmd_write(*pmd));
> 
> You seem to add a lot of BUG_ONs(). Are they really necessary ? See 
> https://docs.kernel.org/process/deprecated.html?highlight=bug_on#bug-and-bug-on
> 
> You may also use VM_BUG_ON().
> 

Sure.
I added BUG_ON() when doing the debug.
I will consider again which one is necessary.
And change to use VM_BUG_ON().

Thanks.
