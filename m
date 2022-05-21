Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912D52F8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbiEUFK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiEUFKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:10:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FC179C2F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:10:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j21so9117333pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yr9eRHTiR6xB9y+nGGcF+q6VztTDT49P0XoDm3K1gQ=;
        b=cqAJFUxnMFwHLhcqYZm9p2ALjMvK2C03vZrl8dWULTYLEepI8fiI6589IIs+lFRPbW
         rDC3EinQOYCNwoMyugPiNvICK+/iqoE0MK/V6TADEYt2hI0V8LABzFLyEtf4oj1KLakt
         vKXSU9OmFWwVUhW+j+whyYfy+4cX7xlkBkapbURzCIPUxASvKtwk1dlElOUw1m2U/kkK
         7jFoUUAYxNCspMkSOrclTvFtVOHyI3NqhoAcnoVlFiipMu93mUgCUhy1ELWbDFxWiviO
         Ov3Oy+dh+XeYC7Z7E13mo7A0pkKw/ZsehFzpREpnz6vn4wRSWDZA2Po/frjWYDKViJiC
         Cn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yr9eRHTiR6xB9y+nGGcF+q6VztTDT49P0XoDm3K1gQ=;
        b=vWX1ggQh0h/zwPYzeJgoVHg+S02OUN1+7Eetd/e4QJDuldwdFx0esVmSpflMSTuNH7
         UIl9bxKMONLF8+v57rFfYOS04NXUGNSNFksLCWZkMqAhv2qKFovZluwijq6I8pdrAg4o
         HZLq6HYQMLTbgxjXkcF4XXK0sV1DBq8p6wcq8sQA9te0aE/7LBL2r2XR6ObW7Qu4MT7k
         aMx8QzIjv5TC5eBgrKlVLwTe2VMy+ZwyzghVwVYbNY369jtO1xjxZNBK8TlK4yybIpCP
         LAkSaX5l+4j2bnY5rIaL+GAlasmK7RqoFknPk6QNvpk/ZzWoaE+DFOJXXfhi11DNXgMG
         773w==
X-Gm-Message-State: AOAM530vUxlIAs14qwoIyNizI6dBkPLCjOuROc46rMNv9PC50KctKUuc
        sOHfizFQu5hUKm38zOGzazU=
X-Google-Smtp-Source: ABdhPJy2IXOU/F2cSnDOXoQq2IUdTgwJzqaJIZYyXuvcY9bf0aq41bP6/ThVpdQT3z/vRhPN3pWpCg==
X-Received: by 2002:a05:6a00:8c5:b0:510:6eae:6fa1 with SMTP id s5-20020a056a0008c500b005106eae6fa1mr13019494pfu.12.1653109822625;
        Fri, 20 May 2022 22:10:22 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b0015e8d4eb234sm590603plg.126.2022.05.20.22.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 22:10:22 -0700 (PDT)
Date:   Sat, 21 May 2022 13:10:14 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
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
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 5/6] mm, pgtable: Add the reference counter for COW
 PTE
Message-ID: <20220521051014.GE1508515@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-6-shiyn.lin@gmail.com>
 <YohlqalOBlJHAT1u@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YohlqalOBlJHAT1u@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 05:08:09AM +0100, Matthew Wilcox wrote:
> On Fri, May 20, 2022 at 02:31:26AM +0800, Chih-En Lin wrote:
> > +++ b/include/linux/mm_types.h
> > @@ -221,6 +221,7 @@ struct page {
> >  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >  	int _last_cpupid;
> >  #endif
> > +	atomic_t cow_pgtable_refcount; /* COW page table */
> >  	pmd_t *cow_pte_owner; /* cow pte: pmd */
> >  } _struct_page_alignment;
> 
> Oh.  You need another 4 bytes.  Hmm.
> 
> Can you share _refcount?
> 
> Using _pt_pad_2 should be possible, but some care will be needed to make
> sure it's (a) in a union with an unsigned long to keep the alignment
> as expected, and (b) is definitely zero before the page is freed (or
> the page allocator will squawk at you).

_refcount may be better. I will try this at first, and if any other
thing let _refcount cannot be used, I will consider _pt_pad_2.

Thanks!
