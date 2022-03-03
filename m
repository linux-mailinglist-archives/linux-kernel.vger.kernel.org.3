Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325014CC07B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiCCPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiCCPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24FDE2F8;
        Thu,  3 Mar 2022 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRwUAybaAGZPQgyHfYMkNr65Ww6gAF8vxx97N0fO01k=; b=Eexf+bW7N0NT8TMty7sO7cm+A0
        UufwhWu+9FIfCy2G7p5948fd7tEeeEO2PrJB0z8cOlB3ZA54rZz80NuqR/DEtymr1JdwT/n1LsPhP
        swfluO79vBnQ2G2wbDFUu9t8LQCGS6cMUKPYOIHNPNVxR96jpsVYyZwBStrg6ccu4Jo+7fFJxNXfu
        fJs0bYUzWycLb6jd9jm4I9nUhsrAc5BL6L4OI4DVd52bQ5VnukjHvqTiQUAXGcXBHS9G/ArOH5nkm
        lcjxdQcRBzEcNpbTyPoKFWFaA1jQy22UdXoJMwseAfKakvOv89lx6edV31uGxh4R3rIROcG/AeUas
        8ZwHYCKw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPmvK-006jV2-Sl; Thu, 03 Mar 2022 14:59:22 +0000
Date:   Thu, 3 Mar 2022 06:59:22 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Message-ID: <YiDXypdn4ltFbHqs@bombadil.infradead.org>
References: <20220302083758.32528-1-songmuchun@bytedance.com>
 <20220302083758.32528-4-songmuchun@bytedance.com>
 <Yh/g2BRPZC3370mX@bombadil.infradead.org>
 <CAMZfGtUCPAc2Ff7Cg1oxo=JYMaX1GM3HVNvK_Nka+4j5Xg3AtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUCPAc2Ff7Cg1oxo=JYMaX1GM3HVNvK_Nka+4j5Xg3AtA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 07:15:05PM +0800, Muchun Song wrote:
> On Thu, Mar 3, 2022 at 5:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Mar 02, 2022 at 04:37:58PM +0800, Muchun Song wrote:
> > > We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> > > server to enable the feature of freeing vmemmap pages of HugeTLB
> > > pages. Rebooting usually taske a long time. Add a sysctl to enable
> > > the feature at runtime and do not need to reboot.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/vm.rst | 13 ++++++++++
> > >  include/linux/memory_hotplug.h          |  9 +++++++
> > >  mm/hugetlb_vmemmap.c                    | 42 ++++++++++++++++++++++++++++-----
> > >  mm/hugetlb_vmemmap.h                    |  4 +++-
> > >  mm/memory_hotplug.c                     |  5 ++++
> > >  5 files changed, 66 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > > index f4804ce37c58..01f18e6cc227 100644
> > > --- a/Documentation/admin-guide/sysctl/vm.rst
> > > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > > @@ -561,6 +561,19 @@ Change the minimum size of the hugepage pool.
> > >  See Documentation/admin-guide/mm/hugetlbpage.rst
> > >
> > >
> > > +hugetlb_free_vmemmap
> > > +====================
> > > +
> > > +A toggle value indicating if vmemmap pages are allowed to be optimized.
> > > +If it is off (0), then it can be set true (1).  Once true, the vmemmap
> > > +pages associated with each HugeTLB page will be optimized, and the toggle
> > > +cannot be set back to false.  It only optimizes the subsequent allocation
> > > +of HugeTLB pages from buddy system, while already allocated HugeTLB pages
> > > +will not be optimized.
> >
> > The commit log or documentation does not descrie why its safe to toggle
> > one way and not the other?
> >
> 
> I thought it was easy to handle the transition from disable to enable
> (code is simple).  I might be wrong. I'll try to handle the other side in
> the next version if it is not hard to handle.

You should do the homework and explain why something is not possible.
And if you are enabling to disable something why is it safe to do so
at runtime?

  Luis
