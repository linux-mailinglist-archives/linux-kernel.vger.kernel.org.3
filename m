Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC94B7157
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiBOPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:22:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiBOPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:22:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92A8A32E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CEufNPi0mf8HHPhcFQPBOMOzkgqFViDRsTOMQmjSo4=; b=JNIiCzymk35zUKtFR2HzYl9tZj
        9RCXKtLExlprEpeih1IkSb5+dI5T8lAdB4b8Mx44AxPsy5SYOcaCWKo9BFbZiG9jDnmztNfoc5+CA
        2zXllkSE5GZwZ2iA96jJxpZywgDQb1LiAyZ7MiU5MolALnSfEpFtB4xrlzgCfbBSdeXBYDApUL7GA
        vTMxCFCMS3Vy2TM6LlyJoXRSgXN1xACyFc15ivWf7/bSI4gkSm8PDji/AhhnOinxEGvsNesbCZieL
        ftoozfC885x6q+zKHMSkZOz1X5yAw9oMfumQL/KsSQxiuAp597Upw9fJMriMllDAJhxJudDoFNo2B
        ih0LzK9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJzes-00DwfC-4U; Tue, 15 Feb 2022 15:22:26 +0000
Date:   Tue, 15 Feb 2022 15:22:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/13] mm/munlock: rmap call mlock_vma_page()
 munlock_vma_page()
Message-ID: <YgvFMjWPITbD1o64@casper.infradead.org>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
 <501673c-a5a-6c5f-ab65-38545dfb723d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501673c-a5a-6c5f-ab65-38545dfb723d@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:26:39PM -0800, Hugh Dickins wrote:
> Add vma argument to mlock_vma_page() and munlock_vma_page(), make them
> inline functions which check (vma->vm_flags & VM_LOCKED) before calling
> mlock_page() and munlock_page() in mm/mlock.c.
> 
> Add bool compound to mlock_vma_page() and munlock_vma_page(): this is
> because we have understandable difficulty in accounting pte maps of THPs,
> and if passed a PageHead page, mlock_page() and munlock_page() cannot
> tell whether it's a pmd map to be counted or a pte map to be ignored.
> 
[...]
> 
> Mlock accounting on THPs has been hard to define, differed between anon
> and file, involved PageDoubleMap in some places and not others, required
> clear_page_mlock() at some points.  Keep it simple now: just count the
> pmds and ignore the ptes, there is no reason for ptes to undo pmd mlocks.

How would you suggest we handle the accounting for folios which are
intermediate in size between PMDs and PTEs?  eg, an order-4 page?
Would it make sense to increment mlock_count by HUGE_PMD_NR for
each PMD mapping and by 1 for each PTE mapping?
