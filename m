Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2549B965
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1586864AbiAYQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586721AbiAYQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:50:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA09C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VrBKWP0akaG4dIR083DmtTNeX0gnAazEE+UlofwJtug=; b=G47DpRhQzRKnkRExVce/bUy461
        Jgz4K6JpXmFTSsjjSe0zJnvC9QTgJaXueYe6LFLVjds6/Wl/IxEmFpQUy+cg0HSFE11QewCZmMK9G
        VwLAvsOo5GqTyvHeTryUXb3x9Hj7Qk/AP6q9wkUi0h6mB83BJj2p5r74CRqwrREy1WOpFg5WYaVyv
        HQKyJoF4v9/03plFZqfs5BI5osKC2QcXq/VaSZaKgfA6iEIJ9dA93ITE/TqzTls/m71S+K5VprCTx
        bqcK75gtqUrjNgzKE+qAEC0eLcH0HCEcpov9zt27oAubhQ9RyYrq1eZEkcbZnDDArW3jv86+SK10g
        gxT8P/eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCP1K-0035c0-8b; Tue, 25 Jan 2022 16:50:14 +0000
Date:   Tue, 25 Jan 2022 16:50:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <YfAqRrGD2UKrZHfJ@casper.infradead.org>
References: <20220125163912.2809-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125163912.2809-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 05:39:12PM +0100, Uladzislau Rezki (Sony) wrote:
> @@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  
>  	/* After this point, we may free va at any time */
>  	if (unlikely(nr_lazy > lazy_max_pages()))
> -		try_purge_vmap_area_lazy();
> +		if (!atomic_xchg(&drain_vmap_work_in_progress, 1))
> +			schedule_work(&drain_vmap_work);
>  }

Is it necessary to have drain_vmap_work_in_progress?  The documentation
says:

 * This puts a job in the kernel-global workqueue if it was not already
 * queued and leaves it in the same position on the kernel-global
 * workqueue otherwise.

and the implementation seems to use test_and_set_bit() to ensure this
is true.
