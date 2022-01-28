Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18FF49FA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiA1NKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiA1NKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:10:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3726C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dSfLUGYv4E6j5ZfEuP1bDYMKuO4xSZnMF479I4hHJhg=; b=n2L1lUt8O9GCnrz0w20k0x4D3S
        r69UE7eAcE7eZ57R4NE9e/IER0mID5oZE/5QxWUrkCLnN4Lcfw8QccCbxymFeBwvKebtd1VkZgAZs
        KPLVGcdRIvoPh0EWAb22W7DHIXUgAo74B2BW4lI7YTHTL/6E2TV8gO124GdjTTxTKJRPfFJsL1ST/
        jh7yuSmq+9MI03t2admG0M2BD+UvhV8okeJjAo/lGC2RL+koaLiYnfJhTtuRiweQC5KYZ7VboGo0o
        /WBjAQpDPJ3i73PSWUum8p3gmIOabL/5BZ/CykjJfysYW86b6gsd9Hn5TUywGvfqT75aDUjksVXPs
        4bHcjOOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDR13-006PoW-EX; Fri, 28 Jan 2022 13:10:13 +0000
Date:   Fri, 28 Jan 2022 13:10:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] tools/include: Add cache.h stub
Message-ID: <YfPrNUf9ekEpeEbv@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <fa6e6abc6a214f85089c8a10b8df72d0402c6166.1643206612.git.karolinadrobnik@gmail.com>
 <YfKlfoKXyFZxB/UD@casper.infradead.org>
 <066fa177642ce6907df06819676cd29c0745e816.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <066fa177642ce6907df06819676cd29c0745e816.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:13:54PM +0100, Karolina Drobnik wrote:
> On Thu, 2022-01-27 at 14:00 +0000, Matthew Wilcox wrote:
> > On Thu, Jan 27, 2022 at 02:21:24PM +0100, Karolina Drobnik wrote:
> > > +++ b/tools/include/linux/cache.h
> > > @@ -0,0 +1,10 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _TOOLS_LINUX_CACHE_H
> > > +#define _TOOLS_LINUX_CACHE_H
> > > +
> > > +#define L1_CACHE_SHIFT         5
> > > +#define L1_CACHE_BYTES         BIT(L1_CACHE_SHIFT)
> > > +
> > > +#define SMP_CACHE_BYTES L1_CACHE_BYTES
> > > +
> > > +#endif
> > 
> > You've added an implicit dependency on include/vdso/bits.h which
> > seems
> > unpleasant ...
> 
> I'll admit that I just tried to make checkpatch.pl happy with this
> change. But you're right, adding such a dependency is undesirable. I
> can define it as (1 << L1_CACHE_SHIFT) and ignore the warning.
> 
> Is it fine to do so for tools/testing code?

checkpatch warnings are recommendations.  Only fix checkpatch errors.
