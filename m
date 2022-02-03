Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC74A85A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350955AbiBCOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBCOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:01:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Odwijx+uKepyk3NIvR5q7W0APreC/+JRwRuUWvXRhFA=; b=PxhtkCXk4Aa8m8wjxB18DGyPsi
        ZXwdCYIl74iDvMUxCKeL9VuCOJUZ8efn2MRPJAaOzguR1Hq1UsGTg/nbrsh4xghpTqehBbMkXPszS
        Hw7sVylgF3WjJoy/k+uisKD/bQr+N8+eFnX64ZMZIpF6QORUSsAovUYyUm7wY/2NoSpmAN0ksY7cw
        Dc0HHP4U6wjlgi/8MfX0/mY9Ss0Ra7oSEVv1iDtQMS02ujXz+4+tQmXiI3l5cxblZ+jKJImqS2uXY
        wt7Nx9H/710EW4iBtEE/4xHCCjuMjDLkOD1MIlWA4vptpiSV9TiYmiJ7PMztfa5YSBnWmtf1prlpz
        F8gUhT3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFcg4-001Vjb-Nr; Thu, 03 Feb 2022 14:01:36 +0000
Date:   Thu, 3 Feb 2022 06:01:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <YfvgQHewEbN3lR33@infradead.org>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203093232.572380-5-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:32:32AM -0800, John Hubbard wrote:
> There is only one caller of get_user_pages_locked(). The purpose of
> get_user_pages_locked() is to allow for unlocking the mmap_lock when
> reading a page from the disk during a page fault (hidden behind
> VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
> mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
> fact I've used some of his wording here.)
> 
> However, it is unlikely for lookup_node() to take a page fault. With
> that in mind, change over to calling get_user_pages_fast(). This
> simplifies the code, runs a little faster in the expected case, and
> allows removing get_user_pages_locked() entirely.

Maybe split the lookup_node changes into a separate patch, as that
allows to document that change even better.
