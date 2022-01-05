Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F448576E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiAERlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbiAERkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:40:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A6C061201;
        Wed,  5 Jan 2022 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTJxwLl+pm7Ff+UKXl9jyuyYhU7kQqFATFz9yxORmSQ=; b=Waxs5JjT7qV1ScF1HUqjEizvXw
        1uci335s6o4lX2mbH1hheG8Bwf8imBq1QkvGBzCw8pNVudtKHFmSKDcAtg4Rqt7o5ySRsHAgT8rjQ
        zxJM+XaEPF/Hu8YRNx1743hkvJt43+eRjH2JsusfZLnxxCLVbSKierPUQaUcuRKTMpZ1LO6+sqQiU
        r2PAjVgYiGbDrlMMjf4uLKfLMKlwxVZ+QjImY+sGMRdIH6VdYD14sdo51FC1QvVO2XtNMyg9MtDZb
        bl1CcTFr71a+GJbVEwBV6mU0v6adS4mZBnf2/tfepLUiWn2MxaVb6PjdniklXECmmkCDcvsYJjsFN
        Lq1+uHCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5AHE-00ElOm-RT; Wed, 05 Jan 2022 17:40:44 +0000
Date:   Wed, 5 Jan 2022 17:40:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Juergen Gross <jgross@suse.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        lkft-triage@lists.linaro.org
Subject: Re: [next] mm/shmem.c:3993:5: error: conflicting types for
 'shmem_unuse'; have 'int(unsigned int, long unsigned int *)'
Message-ID: <YdXYHP5gPMRzmv0B@casper.infradead.org>
References: <CA+G9fYvXfD3wS8eJV6A6GygqhJb3AUF9OROQAkBRRTN+thVo-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvXfD3wS8eJV6A6GygqhJb3AUF9OROQAkBRRTN+thVo-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:01:19PM +0530, Naresh Kamboju wrote:
> mm/shmem.c:3993:5: error: conflicting types for 'shmem_unuse'; have
> 'int(unsigned int,  long unsigned int *)'
>  3993 | int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
>       |     ^~~~~~~~~~~
> In file included from include/linux/khugepaged.h:6,
>                  from mm/shmem.c:37:
> include/linux/shmem_fs.h:86:5: note: previous declaration of
> 'shmem_unuse' with type 'int(unsigned int)'
>    86 | int shmem_unuse(unsigned int type);
>       |     ^~~~~~~~~~~

This is "mm: simplify try_to_unuse" in akpm's tree.

It needs a fix that looks something like this:

+++ b/mm/shmem.c
@@ -3990,7 +3990,7 @@ int __init shmem_init(void)
        return 0;
 }

-int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
+int shmem_unuse(unsigned int type)
 {
        return 0;
 }

