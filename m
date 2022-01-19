Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69872493E45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356056AbiASQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiASQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:27:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E522BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y+niaJZsQwGraQM2Scy9GSfhLJjB89yjTH8KmflesUE=; b=hs7gAhpAa0jbycG+pHIUD140H9
        MEc+Hhq9eXKkyB0ZBoX20pZhcH702XDPdl5aDHEgFlg7mw328ff9uPl/On17vMLICS7HNqXgYJj9p
        HkkRkhyAQLTk3OaC+Kj0EivULkAFGsg+VVrlLX+gsKLAwbCbbo4R9hfYu4l+U++XbGuNCxfGtNM9C
        RG8WwC6bGESqC7Io4ngPhQcqcVUodlUVvf6g88ntU95gCwbxj0HskVMh0IvZxrGp11RwR1LUoo+v/
        +yVHv5m8ZevAwlTKx1WW+yL36OKShVEA9sHg+xOpGXMj5oyKLrF/4iWVSrbhD1orgxvNKPndmPDkS
        G0OQRXGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nADo4-00BMnH-Eq; Wed, 19 Jan 2022 16:27:32 +0000
Date:   Wed, 19 Jan 2022 16:27:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <Yeg79CcofyNuVLid@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> > +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> 
> Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> true...

Even if it does blow up, at least it's blowing up here where someone
can start to debug it, rather than blowing up on first access, where
we no longer have the invlid struct page pointer.

I don't think we have a 'page_valid' function which will tell us whether
a random pointer is actually a struct page or not.
