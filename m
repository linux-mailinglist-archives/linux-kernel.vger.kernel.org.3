Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31949FA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiA1NLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiA1NLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:11:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E2C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3qDIrPC1sd2mSZKvlKsgL9uxMifmMEKbthxfAkSx5kA=; b=u1WPBHt/xVQRP0HWO1mc1wHJGN
        5DKe/hG+F+5u3KyOeuksDGT6En82LF5qy2V7H2xlqOWTGJRx+iE7YG/bZ7TU9lnuJZcDHyqyvjtkm
        cvbYycJ2bqaQesHgp+KXus+6yWYgPhZ1uGCoNxuWoDx3Wefg4Vv98QB7ZQIsly7zRwAqYczrlCjbI
        yzIEKcMoFKxKyc8PIZplw30y68SJlrTBi+uy8Q873ffGFq3Wb5iug9vaGcii+BbNKCOIaLpc+PAns
        cBuddHt3OTYu53VrRTLVqavBhqCMdnm8V+OxkXS8e8b4L78evGCG2ei3JCWCLvtUHEOWOp+E6Ah82
        F0qO9ptw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDR2G-006Q6f-C0; Fri, 28 Jan 2022 13:11:28 +0000
Date:   Fri, 28 Jan 2022 13:11:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] memblock tests: Add skeleton of the memblock
 simulator
Message-ID: <YfPrgGpfi+ZqaBz/@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
 <YfKm0sx1JT+7IRSJ@casper.infradead.org>
 <78c62135ee4bc56ae144b266ffaabe8d2afb2928.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c62135ee4bc56ae144b266ffaabe8d2afb2928.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:25:55PM +0100, Karolina Drobnik wrote:
> On Thu, 2022-01-27 at 14:06 +0000, Matthew Wilcox wrote:
> > On Thu, Jan 27, 2022 at 02:21:28PM +0100, Karolina Drobnik wrote:
> > > +# Memblock simulator requires AddressSanitizer (libasan) and
> > > liburcu libraries
> > 
> > Stale comment?  You don't seem to actually use liburcu.
> 
> I'm using uatomic_inc and uatomic_dec in tools/lib/slab.c. But, you're
> right, memblock simulator doesn't use liburcu per se but uses code that
> requires it. I wasn't sure where and how to communicate it, so I added
> this comment here.

I thought the comment was stale because you don't link against liburcu.
Maybe you can use uatomic_inc() without adding -lurcu to the link step.
