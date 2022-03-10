Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47164D53A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbiCJVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbiCJVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:32:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B7192CB8;
        Thu, 10 Mar 2022 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXDUTjVWZxaANyNbVmfaGwGIxc8fx/dmvUspBOucNHU=; b=SLbeJyQS9Z8zsqhg28pFcFjGF7
        a3oYJINv+p4BxZ2p8HN5twBPvAyaOwVe0+XqUDhnVIUIseDVeGziE+/gRa3g/XtwcmA/g8/bcYh+N
        aEzryAoGihBDOvkvB9aLX5ejESI/fP9fpn4zOp+Him25I7/CGgMXpCqIrX8CirdFc+spNzvkE6kB4
        ETkXANSO3Y7dJyKDM/twOCV2/WH/tMOHK9NRkIk1stL/IDSUqk7eqGLEB0Gk3+cs2c5pHi2hjw0Io
        Biy4jE4jiljSnU1kr5XunmlMFnYCdiHMR1ya2uDj5JCtb5vlho3YP5fpxSEPKWBp8Sx/sbjD3n/DI
        PnUl+NGw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSQNl-00E5UB-U1; Thu, 10 Mar 2022 21:31:37 +0000
Date:   Thu, 10 Mar 2022 13:31:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v3 1/4] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
Message-ID: <YipuORuIdxq89Lqg@bombadil.infradead.org>
References: <20220307130708.58771-1-songmuchun@bytedance.com>
 <20220307130708.58771-2-songmuchun@bytedance.com>
 <YiY0QkE+efo1hyda@bombadil.infradead.org>
 <CAMZfGtWHZgvFSE0P1LNprcjt0YAvC5XFAz=aUZw9vJFPGzUTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWHZgvFSE0P1LNprcjt0YAvC5XFAz=aUZw9vJFPGzUTbw@mail.gmail.com>
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

On Tue, Mar 08, 2022 at 01:03:08AM +0800, Muchun Song wrote:
> On Tue, Mar 8, 2022 at 12:35 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Mar 07, 2022 at 09:07:05PM +0800, Muchun Song wrote:
> > > If the size of "struct page" is not the power of two and this
> > > feature is enabled, then the vmemmap pages of HugeTLB will be
> > > corrupted after remapping (panic is about to happen in theory).
> >
> > Huh what? If a panic is possible best we prevent this in kconfig
> > all together. I'd instead just put some work into this instead of
> > adding all this run time hacks.
> 
> If the size of `struct page` is not power of 2, then those lines added
> by this patch will be optimized away by the compiler, therefore there
> is going to be no extra overhead to detect this.
> 
> >
> > Can you try to add kconfig magic to detect if a PAGE_SIZE is PO2?
> >
> 
> I agree with you that it is better if we can move this check
> into Kconfig. I tried this a few months ago. It is not easy to
> do this. How to check if a `struct page size` is PO2 in
> Kconfig? If you have any thoughts please let me know.

Can you query this with a script?

config HAS_PAGE_SIZE_PO2
	bool                                                                    
	default $(shell, scripts/check_po2_page_size.sh arguments_are_allowed)

  Luis
