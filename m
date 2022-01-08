Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967FB487FD8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiAHAI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAHAI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:08:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:08:28 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D557B61FFF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:08:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E047060F59;
        Sat,  8 Jan 2022 00:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641600507;
        bh=S0OAIUS2YGgbOt1PH5LgUdKQjhfpiQvx9k8KtXkjS1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dUYNV8q3CdxNgS5+By8xUIKeoeayCRnCzsrSbsgLbPXllVHT70pBLRHlIOglj6ys4
         OSsfDmaNivej7gsOueuMtL6aydb9t7EV4L/BmVH/UqfbrNLy+IbjFj4MKzJBGJ7ev+
         Omo7VopC/rBVDkudnpvGcPZPq0YwL5b25xny0iWg=
Date:   Fri, 7 Jan 2022 16:08:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        vbabka@suse.cz, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-Id: <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
In-Reply-To: <Ydi6iMbSZ/FewYPT@casper.infradead.org>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
        <Yde6hZ41agqa2zs3@casper.infradead.org>
        <20220107134059.flxr2hcd6ilb6vt7@master>
        <Ydi6iMbSZ/FewYPT@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jan 07, 2022 at 01:40:59PM +0000, Wei Yang wrote:
> > On Fri, Jan 07, 2022 at 03:59:01AM +0000, Matthew Wilcox wrote:
> > >On Thu, Jan 06, 2022 at 11:52:54PM +0000, Wei Yang wrote:
> > >> FOLIO_MATCH() is used to make sure struct page and folio has identical
> > >> layout for the first several words.
> > >> 
> > >> The comparison of offset between page->compound_head and folio->lru is
> > >> more like an internal check in struct page.
> > >> 
> > >> This patch just removes it.
> > >> 
> > >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > >
> > >No.
> > 
> > Hi, Matthew
> > 
> > Would you mind sharing some insight on this check?
> 
> It's right there in the comments.

Well I can't figure out which comment you're referring to?

> If you can't be bothered to read, why should I write?

I don't think the punishment comes close to fitting the crime here :(
