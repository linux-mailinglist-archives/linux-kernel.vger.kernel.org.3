Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476D44FF6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiDMM2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiDMM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:28:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92C5DA3A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bWS+cFnyEmbmqc6rZj6HU0wroameTU2nroSVRaqfs/E=; b=SUdi2YLNNEAnDrA3xDEKJqL4th
        CdmHx5JXh0io1LMw0ZZm+yQG+xPrKvHz5aJA314m19WCYYRN+0tVKIUad7VCdXdc9rRVldNJb94u3
        AJ4efEN9X/GXelavnYvERM5zU5Mt/9Pcq4uq7kY67ZK6BADU19fTr8POGgXknRg+mq4YbgnNNb6zi
        zVKbG7fqaqXR4f6uLiBH09bFGV1HQqXUm2fFF+F0NgEyBb7d7iAsoylAgA9r0ZFodrZCEX6oIrZiW
        4IVdiQerlDkrwwQl58j9eRRpokBwTNMF7fYxXpNXTN0L/V5nLZX9xFwhkyUv8cQK+0iNZF9gdLRrv
        FXeEzsng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nec4U-00EFTA-Fn; Wed, 13 Apr 2022 12:26:06 +0000
Date:   Wed, 13 Apr 2022 13:26:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
Message-ID: <YlbBXiVezzVw+NZZ@casper.infradead.org>
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-9-david@redhat.com>
 <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
 <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:37:09AM +0200, David Hildenbrand wrote:
> On 12.04.22 10:47, Vlastimil Babka wrote:
> > There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
> > !compound branch. Since compound is now determined by the same check, could
> > be deleted.
> 
> Yes, eventually we could get rid of both VM_BUG_ON_PAGE() on both
> branches and add a single VM_BUG_ON_PAGE(PageTail(page), page) check on
> the compound branch. (we could also make sure that we're not given a
> hugetlb page)

As a rule of thumb, if you find yourself wanting to add
VM_BUG_ON_PAGE(PageTail(page), page), you probably want to change the
interface to take a folio.
