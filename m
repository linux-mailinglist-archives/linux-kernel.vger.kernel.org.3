Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9153EF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiFFT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiFFT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B458DF43
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEC0614FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA503C385A9;
        Mon,  6 Jun 2022 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654545580;
        bh=8Qcf++OOJeh9f1j7ipBSO/FN7g7O7ymNj5NhsOYgr5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSvvVLIUMvX5ajxtM38HfFvfkzKLimCNXMV6uIn+2mT+hNetxmw4UutTyVKq+/dck
         Fu9obaqGZxCzyl01icYc2+qoXjuAuru+XMVcDaqJyANlVaZkEL74st3sQslyyf52Lx
         RA4S30lF3AbS5UGS+LwnRmzSnMVIvyjTjww6q500=
Date:   Mon, 6 Jun 2022 12:59:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, ngupta@vflare.org,
        senozhatsky@chromium.org, avromanov@sberdevices.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        s.suk@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Message-Id: <20220606125939.ae37867e43b8b8b07fa06ca7@linux-foundation.org>
In-Reply-To: <Yp5ZnkYEA5xrUksX@google.com>
References: <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcas1p2.samsung.com>
        <20220603055747.11694-1-jaewon31.kim@samsung.com>
        <Yp5ZnkYEA5xrUksX@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 12:46:38 -0700 Minchan Kim <minchan@kernel.org> wrote:

> On Fri, Jun 03, 2022 at 02:57:47PM +0900, Jaewon Kim wrote:
> > The atomic page allocation failure sometimes happened, and most of them
> > seem to occur during boot time.
> > 
> > <4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
>
> ...
>
> > 
> > The kswapd or other reclaim contexts may not prepare enough free pages
> > for too many atomic allocations occurred in short time. But zram may not
> > be helpful for this atomic allocation even though zram is used to
> > reclaim.
> > 
> > To get one zs object for a specific size, zram may allocate serveral
> > pages. And this can be happened on different class sizes at the same
> > time. It means zram may consume more pages to reclaim only one page.
> > This inefficiency may consume all free pages below watmerk min by a
> > process having PF_MEMALLOC like kswapd.
> 
> However, that's how zram has worked for a long time(allocate memory
> under memory pressure) and many folks already have raised min_free_kbytes
> when they use zram as swap. If we don't allow the allocation, swap out
> fails easier than old, which would break existing tunes.

So is there a better way of preventing this warning?  Just suppress it
with __GFP_NOWARN?

