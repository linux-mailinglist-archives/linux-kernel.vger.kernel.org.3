Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F78494671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiATE1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiATE1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:27:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HHu2vcmAMjyZdp5l/HlaIQrYa0nqInGDI16V4wpDZxE=; b=kM8gwlss+dLkoAyh97n4QxGefg
        W3ayn98v6j7vqXuUf2HdhOVDe/4Pw1IEe9C6K7cj/vR4tvnJz4g2iWeHPGS5n4uSG4V07nzyZmDmD
        vlmxnrh51bIlgl62OXy81cYaqtCxb5w19Pa9y2T9y6FtI359xkpwv/yoT5fSHQRLWxAPdafyAjlOR
        vspfKJn7E3AyAcarQddnd5vKNG50ghktFogDYSAGeCdHJ4HqTYApThMkVc1XtHe2TUkQPFsLatAQy
        UxqxJ7woCITKqX3ZDz7gde9pPKSX8P6x+2tK9dZzRHaQvq+Wv2FdtHq2jxXBhLl8lXazb4ZY6De8X
        8lpHIEIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAP2t-00DKZK-Vb; Thu, 20 Jan 2022 04:27:36 +0000
Date:   Thu, 20 Jan 2022 04:27:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <Yejkt/dpUKsaAu4t@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <Yedgj+Lo2eru8197@casper.infradead.org>
 <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com>
 <CAAH8bW_=KtrwLpg4tx+1tdMjN2mUiuLOoZH6nvbn8qNjU6aB3A@mail.gmail.com>
 <5b62ed03-8da8-a94d-cc48-a8cac1eae1c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b62ed03-8da8-a94d-cc48-a8cac1eae1c9@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:07:11AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/19/22 10:52 PM, Yury Norov wrote:
> >> Why should not this just scan over the entire user provided struct page
> >> array and make sure that all pages there in are valid via above method,
> >> but in vmap() itself before calling vmap_pages_range(). Because seems
> >> like a single invalid page detected in vmap_pages_pte_range() will
> >> anyways abort the entire vmap(). This will also enable us to drop the
> >> existing NULL check above.
> >
> > I can do this, but why is it any better than the current approach?
> 
> Because it will just return on the first instance where the valid page
> check fails, saving us some CPU cycles and an incomplete mapping ?

The valid page check is never intended to fail!  If you're worried about
the efficiency of doing this, you have seriously confused your priorities.
