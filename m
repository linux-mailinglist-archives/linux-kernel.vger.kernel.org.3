Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A7522489
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbiEJTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiEJTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:13:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08611D811E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FBF2B81ECF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A64C385C2;
        Tue, 10 May 2022 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652210023;
        bh=u0t/vwSsLdadPi1EI1J7kbn0NOaLNLclvmuuTIEZPgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuJzEOM2WWLGZZO+F65HpaNa6Sd0Zd8F8CPiVCm3wP8ZGqJ4c9ZMdgB1yaBNroIl+
         6LWc8Sezq8nnZNTW4+QqSX0OqLepkdT3IF0GqRcZ+X8SaV8XKWHwR2wl5Y1qUWKWec
         DAmHNObFUYjwKZo9pQ906gogwXZhuyTgWd6XW8TY=
Date:   Tue, 10 May 2022 12:13:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Message-Id: <20220510121342.704d3b415bf4cadb92814ce8@linux-foundation.org>
In-Reply-To: <20220510104428.152064-1-sj@kernel.org>
References: <20220504011215.661968-1-Liam.Howlett@oracle.com>
        <20220510104428.152064-1-sj@kernel.org>
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

On Tue, 10 May 2022 10:44:28 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 4 May 2022 01:12:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > This rather specialised walk can use the VMA iterator.  If this proves to
> > be too slow, we can write a custom routine to find the two largest gaps,
> > but it will be somewhat complicated, so let's see if we need it first.
> > 
> > Update the kunit test case to use the maple tree.  This also fixes an
> > issue with the kunit testcase not adding the last VMA to the list.
> > 
> > Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/vaddr-test.h | 37 +++++++++++-------------------
> >  mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
> >  2 files changed, 40 insertions(+), 50 deletions(-)
> > 
> > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > index 5431da4fe9d4..dbf2b8759607 100644
> > --- a/mm/damon/vaddr-test.h
> > +++ b/mm/damon/vaddr-test.h
> > @@ -13,34 +13,21 @@
> >  #define _DAMON_VADDR_TEST_H
> >  
> >  #include <kunit/test.h>
> > +#include "../../mm/internal.h"
> 
> V9 maple tree patchset has moved the definition of vma_mas_store() from
> internal.h to mmap.c, so inclusion of internal.h wouldn't needed here, right?
> 
> If we end up moving the definitions back to internal.h, because this file is
> under mm/damon/, we can also use shorter include path, "../internal.h".

I put the vma_mas_store() and vma_mas_remove() declarations into
include/linux/mm.h so yes, internal.h is no longer required.  I queued
a fixlet against
damon-convert-__damon_va_three_regions-to-use-the-vma-iterator.patch


--- a/mm/damon/vaddr-test.h~damon-convert-__damon_va_three_regions-to-use-the-vma-iterator-fix
+++ a/mm/damon/vaddr-test.h
@@ -13,7 +13,6 @@
 #define _DAMON_VADDR_TEST_H
 
 #include <kunit/test.h>
-#include "../../mm/internal.h"
 
 static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 			ssize_t nr_vmas)
_

