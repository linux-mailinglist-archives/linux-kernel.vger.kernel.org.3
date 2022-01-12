Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F548BDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbiALEcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiALEcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:32:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5eLgB2WyWQPkc7m0camX6d8IeA1VEda0fgqfFrNeOtw=; b=doAYrs0dqZb/mzbDOgCE10yTcu
        +9/11AvgCj0QSAzmL7FAol0mTTNqyU4Lbk05ZQEOHL3m2s2iIZ/8wSxqiF3jW5eruSxPHDrE1jsQx
        rEG62ueGu7CgFFGPz5R8edIsnHlPsj5XcjsXZHbf0RaSmy6O9cO4DiMvMXi0kXTlvonswVQ/nOnVo
        csucgV8Rey4pHWIumO9lVyud8Q72HFTaZkFA3kHC8AOLNH2nT+HSc2gJXnnK5z7XMNk4GWYFYgNa6
        p8meXad6uYaaYixQSWvjAWgJ7KSAC7E3N7JD/2bntFxSKXLDdVGQI8ww8yL9l0joWBr66snjq3z2Z
        4gI2k9IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7VJL-003p5A-0D; Wed, 12 Jan 2022 04:32:35 +0000
Date:   Wed, 12 Jan 2022 04:32:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peng Liang <liangpeng10@huawei.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        xiexiangyou@huawei.com, zhengchuan@huawei.com,
        wanghao232@huawei.com
Subject: Re: [RFC 0/1] memfd: Support mapping to zero page on reading
Message-ID: <Yd5Z4i+67+ae68HM@casper.infradead.org>
References: <20211222123400.1659635-1-liangpeng10@huawei.com>
 <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 06:30:31PM -0800, Hugh Dickins wrote:
> But I have to say that use of ZERO_PAGE for shmem/memfd/tmpfs read-fault
> might (potentially) be very welcome.  Not as some MFD_ZEROPAGE special
> case, but as how it would always work.  Deleting the shmem_recalc_inode()
> cruft, which is there to correct accounting for the unmodified read-only
> pages, after page reclaim has got around to freeing them later.
> 
> It does require more work than you gave it in 1/1: mainly, as you call
> out above, there's a need to note in the mapping's XArray when ZERO_PAGE
> has been used at an offset, and do an rmap walk to unmap those ptes when
> a writable page is substituted - see __xip_unmap() in Linux 3.19's
> mm/filemap_xip.c for such an rmap walk.

I think putting a pointer to the zero page in the XArray would introduce
some unwelcome complexity, but the XArray has a special XA_ZERO_ENTRY
which might be usable for such a thing.  It would need some careful
analysis and testing, of course, but it might also let us remove
the special cases in the DAX code for DAX_ZERO_PAGE.

I agree with you that temporarily allocating pages has worked "well
enough", but maybe some workloads would benefit; even for files on block
device filesystems, reading a hole and never writing to it may be common
enough that this is an optimisation we've been missing for many years.
