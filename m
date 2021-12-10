Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B0470CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbhLJVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhLJVj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:39:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DDC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xLcTRcfeExjVcb0aDcdTvIV4ZyO1h30v0m+obLMYKyk=; b=nRJqOqgt0o8kaioB+bITWEQZoP
        lB4pu53lY451eCDKpjRtMzsMTvwOTgBNF5Q+yHN4eFFLXb+3sWJcetdKp+WYmDVFnu8JpXwMRzAqh
        q3kzrWgUEUxg9gWWSOR+dZ8aVsmCz0/xAmUpixsHmJERqZlB7qm9UNsxs2iPfemRsRGG4x8wNiedx
        ZvvGUxkiqw/6yD7WwigKNdneKkcbsWaBLfknP24gD4Tsbqa+WunxIyoiP10v0kNIX2B5erZWmuq8y
        hrL4faJrQKNn0+VbchT+jROXHNhJyRSH+ZB1UjB1XAvz9PZnkjn49V7IIvqC13YyFufuaax4Ie9ax
        PBRC477w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvnYJ-000cva-DW; Fri, 10 Dec 2021 21:35:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5C433002C5;
        Fri, 10 Dec 2021 22:35:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90A952C555173; Fri, 10 Dec 2021 22:35:37 +0100 (CET)
Date:   Fri, 10 Dec 2021 22:35:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Manjong Lee <mj0123.lee@samsung.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Message-ID: <YbPIKW/yCo5lErwE@hirez.programming.kicks-ass.net>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
 <20211021161942.5983-1-mj0123.lee@samsung.com>
 <YXFMJJ3u+x34iNy0@infradead.org>
 <YXFWmo9v65kJWVWC@casper.infradead.org>
 <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
 <YXIoxefk8UDDCt0M@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXIoxefk8UDDCt0M@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 03:58:13AM +0100, Matthew Wilcox wrote:
> On Thu, Oct 21, 2021 at 07:45:30PM -0700, Andrew Morton wrote:
> > On Thu, 21 Oct 2021 13:01:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
> > > > On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> > > > > Because when sdcard is removed, bdi_min_ratio value will remain.
> > > > > Currently, the only way to reset bdi_ min_ratio is to reboot.
> > > > 
> > > > But bdis that are unregistered are never re-registered.  What is
> > > > the problem you're trying to solve?
> > > 
> > > The global bdi_min_ratio needs to be adjusted.  See
> > > bdi_set_min_ratio() in mm/page-writeback.c.
> > 
> > I added cc:stable to this and tweaked the comment & coding style a bit:
> 
> Definitely improvements on that front.
> 
> I don't know the BDI code particularly well, and the implementation of
> bdi_set_min_ratio() confuses me, so I can't say whether the original
> patch is clearly correct or not.

Looks like something I might've written :-)

I'm thinking the part:

	min_ratio -= bdi->min_ratio;
	if (bdi_min_ratio + min_ratio < 100) {
		bdi_min_ratio += min_ratio;
		bdi->min_ratio += min_ratio;
	}

is what confuses? particularly when min_ratio < bdi->min_ratio?

Anyway, two cases: bdi->min_ratio < min_ratio and bdi->min_ratio >
min_ratio, let's do both with 0 and 10.

bdi->min_ratio = 0, min_ratio = 10 gives us:

min_ratio -= bdi->min_ratio;		// 10 -= 0 == 10
if (bdi_min_ratio + min_ratio < 100) {	// x + 10 < 100
	bdi_min_ratio += min_ratio;	// x += 10
	bdi->min_ratio += min_ratio	// 0 += 10 == 10
}

The other way around, bdi->min_raito = 10, min_ratio = 0:

min_ratio -= bdi->min_ratio;		// 0 -= 10 == -10
if (bdi_min_ratio + min_ratio < 100) {	// x + -10 < 100
	bdi_min_ratio += min_ratio;	// x += -10
	bdi->min_ratio += min_ratio;	// 10 += -10 == 0
}

Makes sense?
