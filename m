Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE446D592
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhLHO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLHO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:27:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 06:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OIge18wNGaV2CWmt7HmDIw7i2OCIURDyrD7/XMqGt5o=; b=OTs5QqZiTM8mzuF2H5EqzIQGH2
        ZDfaaUQztY29HiGcDGy4OkeDiHusfpzl8jDwdJYkDiw3H1zfT9piOIskUz/2qyEr/pNp5JkY1Qi2A
        L0QIJ4H+ZuK4rh7uYR3o9cqeY/9QDHAsM8e1DPHvZdODd6zZwa/ahr8K0PjdoNg+Enl0ILgQXz5P3
        ThYHQWCtwJe7CwuzL/rcuPJgu7NcqF1sY2pYqLqjka1udUgBHDHwVSK6R5h63lhSewhyMoLtPKICo
        RtIpMR+puPxfVZvUmgLy5Gt/maVxtROvgpfWzjDdjFyHtdYo+lRP+ZjjvJ4yoZlNs2txkHTFrbgZF
        hMWcyyMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muxrf-008UKQ-1Z; Wed, 08 Dec 2021 14:24:11 +0000
Date:   Wed, 8 Dec 2021 14:24:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm: introduce page pinner
Message-ID: <YbDAC1Ab/2bnI+Mz@casper.infradead.org>
References: <20211206184730.858850-1-minchan@kernel.org>
 <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208115250.GA17274@DESKTOP-N4CECTO.huww98.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:54:35PM +0800, 胡玮文 wrote:
> @@ -406,6 +409,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>         xas_lock_irq(&xas);
>         if (!folio_ref_freeze(folio, expected_count)) {
>                 xas_unlock_irq(&xas);
> +               page_pinner_failure(&folio->page);
>                 return -EAGAIN;
>         }
> 
> I'm not sure what to do with the new folio, it seems using folio->page in new
> codes is not correct.

It's a transitional measure.  Once everything that should be converted
to folios has been converted, it can go away.

Tail pages don't have their own refcounts, so the page pinner should
actually be the folio pinner.  I hadn't bothered to point this out
because we're in the early days of the folio transition and it'd be
unreasonable to criticise Minchan for not converting his patch from
pages to folios.
