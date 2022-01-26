Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9215949CBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiAZONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiAZONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:13:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5134C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vqA7CRwSHoOR/tJOQAe06dY8ic7ejbAv2r4e+k8PLFc=; b=tZQcPh5gvqStAJ6jA0YK2t01Sw
        GehlWy5GlMlaFzXz0gV3+mTxYwQyZX1lWoTkRSjXVXi8IJkQS56IY0nKcTEi1Lha3CW6ziroThbE5
        fz8ZwPPj3d8iTtCawn1tdgkrtZubbb6QICbvfBoxwVjag1JYveRZ8Hk3HRbbfG1gWsM/IHvD6mtKf
        R/r44YROsqckqzmHGMQ/cybYNNdboamluoJtS7g84BqZ/IkQM3S81AHaS8QRSKKaC5erwk7J1dKYt
        FvB9p2rvqG/+Y/fkR8DjGN+3zRqo9I2kFhds9syMmemMoy6cWlpv0XI22QJ5Kegg/zjpnaRzWfL5s
        wx1AlItw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCj2Z-0046kL-Ax; Wed, 26 Jan 2022 14:12:51 +0000
Date:   Wed, 26 Jan 2022 14:12:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfFW43PT5hwPHnOz@casper.infradead.org>
References: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
 <YfFO6VyMTrW1bWuu@casper.infradead.org>
 <2190b8e2-74f2-0e31-0a40-0401fbd9966e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2190b8e2-74f2-0e31-0a40-0401fbd9966e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:55:10PM +0100, David Hildenbrand wrote:
> On 26.01.22 14:38, Matthew Wilcox wrote:
> > On Wed, Jan 26, 2022 at 11:16:42AM +0100, David Hildenbrand wrote:
> >> A while ago I talked with Peter about an extended uffd (here: WP)
> >> mechanism that would work on fds instead of the process address space.
> > 
> > As far as I can tell, uffd is a grotesque hack that exists to work around
> > the poor choice to use anonymous memory instead of file-backed memory
> > in kvm.  Every time I see somebody mention it, I feel pain.
> > 
> 
> I might be missing something important, because KVM can deal with
> file-back memory just fine and uffd is used heavily outside of hypervisors.
> 
> I'd love to learn how to handle what ordinary uffd (handle
> missing/unpopulated pages) and uffd-wp (handle write access to pages)
> can do with files instead. Because if something like that already
> exists, it would be precisely what I am talking about.

Every notification that uffd wants already exists as a notification to
the underlying filesystem.  Something like a uffdfs [1] would be able
to do everything that uffd does without adding extra crap all over the MM.

[1] acronyms are bad, mmmkay?
