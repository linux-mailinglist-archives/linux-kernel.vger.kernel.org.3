Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E46492DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiARS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348466AbiARS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:56:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013CC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=buLSziE+PLhgNnjtRVbSu//iVCKOoSKF7pWZHUatP3A=; b=edvtn1ru0VhuMFSJ5AkoESmZ4I
        icHI+AujsNL5PHO3zyc/Dy6kT4Kh1qqcusq8p6FDO0dvuouWhUvLwG2TGMQmYhsjXlnLRvslVx8N8
        UmxlKDx2g/pj8IeLrS4x2SGRfuc1+CmTaPR2PUtUcZ7EBc8Qwtdv9z075tCqN22kYuuj5jSQED+MN
        sfl55iwLHl5t5ekTbSyEb+VDZ4rWTi5rfyd3PU7x2DpMVBIMHQiNMUr4rmRs93tlrXuei9H7eZSfF
        /VPjcEoy5zTa26AmHzANeai/0536NUFULdHhzZCRXpOcGJnpIXtRBUXNrQ66q9SZtxH1R2Vvk2yeh
        uVGR9z3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9teO-009T6U-5l; Tue, 18 Jan 2022 18:56:12 +0000
Date:   Tue, 18 Jan 2022 18:56:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] arm64: don't vmap() invalid page
Message-ID: <YecNTJNIfAd/D9GG@casper.infradead.org>
References: <20220118185354.464517-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118185354.464517-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:53:54AM -0800, Yury Norov wrote:
> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer, which would lead to DABT at address translation later.
> Currently, kernel checks the pages against NULL. In my case, however, the
> address was not NULL, and was big enough so that the hardware generated
> Address Size Abort.
> 
> Interestingly, this abort happens even if copy_from_kernel_nofault() is used,
> which is quite inconvenient for debugging purposes. 
> 
> This patch adds an arch_vmap_page_valid() helper into vmap() path, so that
> architectures may add arch-specific checks of the pointer passed into vmap.
> 
> For arm64, if the page passed to vmap() corresponds to a physical address
> greater than maximum possible value as described in TCR_EL1.IPS register, the
> following table walk would generate Address Size Abort. Instead of creating
> the invalid mapping, kernel will return ERANGE in such situation.

This seems like a very elaborate way of spelling:

	pfn_valid(page_to_pfn(page));

which doesn't require any architecture hook.  No?
