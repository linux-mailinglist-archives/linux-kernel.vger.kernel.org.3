Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2452F83E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiEUEI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiEUEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:08:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65161957BA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ep/HlQahuRcVVZzIJ7PCmW4pLZjACil5uuEGryHFqyA=; b=GZtsc0BNl+Dmf8evJeJ01QEF5B
        3j/Yo3DDYSP9FfB7qKwhW6IuMJey0bssC1BPX5oLpJllbfx/cQN+W7X811hgZWSqYbg34xBGzn9gc
        FELENlxos/j0OYOLMzptkcKh9r8vr6MJIRLyeY5rMo0gqH/Pdp8TbN/prR5aD6SHv5KNZ/qM70NMK
        m3glK6Fv9rLvfoWxAvZby01Fld4BwA+/diZL6TRpRvg+WC/xkpoq5P1pG6p80BrL4CLFJLb2uo8lU
        RQLLNyfE5dt6maeD8vOiDbcOiHXbHXmAXUmtwNMpg72MUFhLQbab3s2clLiCKXBKY/JOX/b8Dag8f
        qFSQfX+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsGPR-00EMUQ-1M; Sat, 21 May 2022 04:08:09 +0000
Date:   Sat, 21 May 2022 05:08:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chih-En Lin <shiyn.lin@gmail.com>
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
Message-ID: <YohlqalOBlJHAT1u@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-6-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519183127.3909598-6-shiyn.lin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:31:26AM +0800, Chih-En Lin wrote:
> +++ b/include/linux/mm_types.h
> @@ -221,6 +221,7 @@ struct page {
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>  	int _last_cpupid;
>  #endif
> +	atomic_t cow_pgtable_refcount; /* COW page table */
>  	pmd_t *cow_pte_owner; /* cow pte: pmd */
>  } _struct_page_alignment;

Oh.  You need another 4 bytes.  Hmm.

Can you share _refcount?

Using _pt_pad_2 should be possible, but some care will be needed to make
sure it's (a) in a union with an unsigned long to keep the alignment
as expected, and (b) is definitely zero before the page is freed (or
the page allocator will squawk at you).
