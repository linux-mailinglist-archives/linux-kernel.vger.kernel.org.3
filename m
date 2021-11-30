Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0854639AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhK3PTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbhK3PP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:15:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BCC08E867
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CrtvFVO4bzb7EHtHJr/l5tavV6LHAtf/pbvHToYKOcw=; b=Z8PTT9xfQTkO/ve7FB5E4aCFVr
        I0D7kgVdzDbUD6qk80Yzmyga6gRDLXQL9hw38K4RPFwIBFX5SLfjPBZbUKGmZCXCK+0f8/PSCBtwK
        zStqYpWnJ2ty8GQW6TTCVffc+e8iRaFhSCFAvVInM3O/AsW/Lq9HrtZZE4Va2dvtOn0qDRKUxX3A7
        LNR4ik6lmXu0IvvxTFMVHU0lX1caVQJNfoHwR3hhLa4eTv2TMWj/c6uHobu58wyPY1xmXqh9tUwPD
        HjtJ9qmt9/5dju37rwoTlOlTYqtwDvP0w9xaM/gib+qKgkO8gqEq7iBX9j+eJj7Ty1qvhsFbklb+p
        dL/fb8LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms4iu-00CjJ9-VG; Tue, 30 Nov 2021 15:07:13 +0000
Date:   Tue, 30 Nov 2021 15:07:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix math.h breakage
Message-ID: <YaY+IFrgBOUGomW6@casper.infradead.org>
References: <20211130141316.2987986-1-willy@infradead.org>
 <YaY3hKLejcy09bZk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaY3hKLejcy09bZk@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:39:00PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 02:13:16PM +0000, Matthew Wilcox (Oracle) wrote:
> > Commit 98e1385ef24b broke the radix tree test suite in two different ways;
> > first by including math.h which didn't exist in the tools directory, and
> > second by removing an implicit include of spinlock.h before lockdep.h.
> > Fix both issues.
> 
> Sorry for that and thank you for the fix.
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I'm wondering if there is a way of not copying kernel headers manually,
> otherwise we always will have such breakages.

It's not necessarily that these are _copies_ of kernel headers, so much as
they're ways of mocking kernel interfaces when building userspace code.
We could separate out pieces and include them from each direction, but
that has its own problems, and doesn't necessarily solve these kinds of
problems either.

I think the only way to prevent these kinds of breakages is to make sure
the build bots are also building things.
