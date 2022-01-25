Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB549B51A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577024AbiAYN14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576594AbiAYNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:23:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59AC061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UrK514UwF7QVluUkWuRFhQwwmGxmvVhhk2lt7oj702M=; b=XSbVNORCErQnwSumGnb8HvmKD8
        pLWzdfWlODLIp+5VcWGtg6HTU/QpFXIxNJ9lUdpnRoqDkaCP7x8jw1UGE+NhPx+yfM7+2+kmoXKzT
        P48S3Z8HzmlRjl0l+gDg1dqlZJ/C3P96esPtNNMNc56VJOFg7/Uhz34LsoogYRumFdZ5nWxJADYFS
        v4M7PEqXizoIWgKC0e7SkP5hKthTikmE2Ft7OwRoc0UNyf6GoovnaysflQbLZO4ZefovZT+qSPl7O
        SG6/Fd89ihN+OE544mX2cWLGvOnUdmm2vGkQz1KmMYRHctjz0TqvMJM2PkhzOOaTyOQYJUqUqdvQp
        +1cleJDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCLn7-002q4B-S9; Tue, 25 Jan 2022 13:23:22 +0000
Date:   Tue, 25 Jan 2022 13:23:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <Ye/5yUyEqO0ws0G5@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:42:12PM +0300, Kirill A. Shutemov wrote:
> I wounder if we can get away with zero-API here: we can transparently
> create/use shared page tables for any inode on mmap(MAP_SHARED) as long as
> size and alignment is sutiable. Page tables will be linked to the inode
> and will be freed when the last of such mapping will go away. I don't see
> a need in new syscalls of flags to existing one.

That's how HugeTLBfs works today, right?  Would you want that mechanism
hoisted into the real MM?  Because my plan was the opposite -- remove it
from the shadow MM once mshare() is established.
