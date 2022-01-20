Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B215B495493
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377390AbiATTEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377432AbiATTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:04:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC33C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jA3CkCc0pg/2NQ16pdnmk4INkOngIqZyjRj6CQv0y+c=; b=mWrA67bmZ0wgwVuAnDToH7NT5L
        tpqZLXGiB06qrUdIo/Eh+0EBZy1NY/6RkcOWEE2CSGzDZeta6FEVqX3aFaR/K/cgEzkCURbyCD9j1
        4kB5POQ3MscqS9I+15ByHaaZJrQQdTFwqoQArQr4C9zMoQ91/ydTCGyTuKibrGb7F1w2c+uKMxm8A
        cYMDAg13wAtDIWELgkBXA8gRB6lnvzC16bBEnhLcr1VCeMQ1d+zEsIuHLbk+K6pxftU2oXYyouM0o
        LjGakAXEFB6UBVZREtLN9c5XnlCUcA/KAbZGEadfng+aImnIlZUPZncJn2zA9jsFEBpk9s5mgUJXu
        Ar4ls3yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAcjS-00EcJJ-4B; Thu, 20 Jan 2022 19:04:26 +0000
Date:   Thu, 20 Jan 2022 19:04:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <YemyOsvx9+dFkICP@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
 <YehilqRvYLhryUk4@shell.armlinux.org.uk>
 <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
 <Yeldih0PHotN4/bn@shell.armlinux.org.uk>
 <e6fde086-16b9-430f-5510-5296ef74a4e7@arm.com>
 <YemTq/yGkHQ+grd1@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YemTq/yGkHQ+grd1@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:54:03PM +0000, Russell King (Oracle) wrote:
> Well, I think I've adequately explained why I believe:
> 
> 	pfn_is_valid(page_to_pfn(page))
> 
> being used as the primary check is substandard, and will likely lead to
> a future CVE. When generating an array of struct page's, I believe that
> it is the responsibility for the generator to ensure that the array
> only contains valid pages.

So you're saying that virt_to_page() should be made more expensive?
