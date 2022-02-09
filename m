Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE414AE872
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347422AbiBIEKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347395AbiBIDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:47:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB47C0613CA;
        Tue,  8 Feb 2022 19:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4FNyD7FBlj7mRyeBDsT28ONQDcfnipyspBXex6GKTiM=; b=jgEE2R6QBEb3QRI2GNqg6BZ0Wz
        Yj2Sa55DzA6YkgxGZgWcAG+WM9st42nb3drftf6sGaRs8X87U0FpJ1WY9oqKzJr+CXBDLfICyTex2
        xV8sWG05+3+eQuiSKHuUhWHbw3ShulDr85lELta/6SWKxOvz5FUVoZcgkAygNa7il2KJdETyYd64q
        d1i2lABoxedJEpiUNnF60MEp1P8VqlMNxCLmgrwBRHJtnZ0yBrEgcL9BdxIIdb03WtRfYBfh6PRMS
        rgGf0L2FYWCzgJyjlp3LJmBSNuEge6+AEhE7uQEC82jo5a0pq7a6DzaicZzCuJ1mMF/fsvrRMMoFF
        2TXn+Iew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHdxH-006bl4-Tu; Wed, 09 Feb 2022 03:47:43 +0000
Date:   Wed, 9 Feb 2022 03:47:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the folio tree
Message-ID: <YgM5XzWoPI1NVdIU@casper.infradead.org>
References: <20220207150621.0273b095@canb.auug.org.au>
 <20220209143804.33b5f08a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209143804.33b5f08a@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:38:04PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 7 Feb 2022 15:06:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the folio tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
> > mm/page_vma_mapped.c:219:48: error: implicit declaration of function 'pmd_pfn'; did you mean 'pmd_off'? [-Werror=implicit-function-declaration]
> >   219 |                                 if (!check_pmd(pmd_pfn(pmde), pvmw))
> >       |                                                ^~~~~~~
> >       |                                                pmd_off
> > 
> > Caused by commit
> > 
> >   02ecfe9b9580 ("mm: Convert page_vma_mapped_walk to work on PFNs")
> > 
> > Presumably you need to explicitly include <linux/pgtable.h>?
> > 
> > I have used the folio tree from next-20220204 for today.
> 
> I am still getting this build failure.

I have it fixed in my tree, but haven't pushed it out yet.
There's going to be a giant pile of conflicts between Hugh's rework
of mlock which just landed in mm and my folioisation of mlock, which
I haven't even started trying to redo yet.

We're back to the "it's hard to work with the mm tree" problem.
Tempted to resolve it by taking Hugh's patches into my tree since
there's no other way to create a stable base to work against.

