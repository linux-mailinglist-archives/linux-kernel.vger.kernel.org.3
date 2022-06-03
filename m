Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5553CA22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiFCMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiFCMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759B3A5EB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=prHzuJSdGpXr6LjPnJTEpBNy5odArLyBYR2PLFVZaIM=; b=nNv1FpDeC/fFG0CJOJCWZ+P397
        4zUtZVcvttb8/mnnEHWzmbrMbhPB0X0OxVPwS1Ya6QHS3YIo+QvL0n5uPH/hMaYdlOxOlEzEClyJ2
        y+p8YmqIgQkW8+mygDdL26+KVmZydN5xBiqt0QY/pzrjjT3o6WWYim0SAOvO5tfo7E5kKPF7CwW4z
        8fiegG1fkthos8v9G1bqDslNFUyL/tgQbfvCSVe1lPv/GwuUGFucf6pxG6i8VAG3ZTCEQSanvzJLN
        1xL458Ulx70RperxceADPp1+95D3dVTsDgdaCbJfrFUlR1FO49hQhbKn16ckmjwaI+2lG7CE4irRU
        Th6aodcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx6fU-007tzV-OM; Fri, 03 Jun 2022 12:44:44 +0000
Date:   Fri, 3 Jun 2022 13:44:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Update comments in filemap_fault()
Message-ID: <YpoCPIdsDrBLdIsV@casper.infradead.org>
References: <20220603071233.2296100-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603071233.2296100-1-apopple@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:12:33PM +1000, Alistair Popple wrote:
> +++ b/mm/filemap.c
> @@ -3168,8 +3168,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
>  
>  	/*
> -	 * We have a locked page in the page cache, now we need to check
> -	 * that it's up-to-date. If not, it is going to be due to an error.
> +	 * We have a locked page in the page cache. Check that it's up-to-date.
> +	 * If not it is because there was no page in the page cache (only likely
> +	 * in the case of MADV_RANDOM) or due to error.

The comment is correct, but the code is buggy!

We should be calling page_cache_ra_order() in do_sync_mmap_readahead(),
even if VM_RAND_READ is set (or !ra_pages, or mmap_miss is high).
At least for one page.  That would allow us to drop the FGP_FOR_MMAP
flag as page_cache_ra_order() will instantiate a folio for us.

Do you want to write that patch or should I do it?
