Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7652652247C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbiEJTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiEJTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:05:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92E2CC96
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E52B81ECF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACE5C385A6;
        Tue, 10 May 2022 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652209503;
        bh=yO7+tb2XdVxOhMmF9pM1uzVbDf3lGsjr7VLS4TD8Kf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gHd+nCV5Ns7YEXXTH27UZDREBKyw9P+AZTvF3tw57sa0eqDKUGnY6yYEhpvdRIu3g
         t4DD+XOX5K8Of2xTAt4eMxbzNJEXV9gwuZrVnnB7rm594BBa6rNRAfrSzb6ww/x7Jt
         AO/oWSXq5hqvRLyWaIHNcucyCuFUV41MB5q9KuhY=
Date:   Tue, 10 May 2022 12:05:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-Id: <20220510120501.8d6663d18080c20e545ab078@linux-foundation.org>
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:

> This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> write protection.

I think we've finished tossing this patchset around, so I plan to feed
it into mm-stable later this week.

A few -fixes were added:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-introduce-pte_marker-swap-entry-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-teach-core-mm-about-pte-markers-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-check-against-orig_pte-for-finish_fault-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-check-against-orig_pte-for-finish_fault-fix-checkpatch-fixes.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-uffd-pte_marker_uffd_wp-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-shmem-handle-uffd-wp-during-fork-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-enable-pte-markers-by-default-fix.patch

