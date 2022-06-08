Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B9543CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiFHThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiFHThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:37:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D683231CE9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NSqM+ffKAUF5O9Bq21uK4+RA2jjysF9YYfW6abSjAuM=; b=h6j+IgieKtqocKMwSMRGcUY7ww
        LBYEmC1tgh/lqPd07os+FV7gpXaxyaE7X3BQykXSVeQZ6uadV/J4OgA9pdGcf3Q1QsXzJGMivPcZQ
        4F/J9Ue2Vdn5m7IZKDQDITuRz+KfgvtM9MuR6KVymvPDrXQWIPLKmBA3hsne9wBzoAiwR1hEpTHxs
        zZOQtCsTGb+UBQ7OiRwWi6zcDkHdo9qJvYn1z7YpwRj4BEFUgPA1eQWp/gJjlEopZynvMVouqb5Ep
        hTiojVc7tyIf8P/h6lxNlDJiXt0WLkeWlMzjGhQjR7ewiQ4RWW5Bz7U+pOFo9dENzNl1z/X4xykWd
        P9/ZAq8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz1UN-00CupW-OY; Wed, 08 Jun 2022 19:37:11 +0000
Date:   Wed, 8 Jun 2022 20:37:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in xas_nomem
Message-ID: <YqD6Z7d5g8e19WO+@casper.infradead.org>
References: <00000000000036af2005e009e7e6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000036af2005e009e7e6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 08:20:21PM -0700, syzbot wrote:
> BUG: memory leak
> unreferenced object 0xffff88810cb35d80 (size 576):
>   comm "syz-executor883", pid 3623, jiffies 4294954631 (age 23.510s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     18 48 36 04 81 88 ff ff 98 5d b3 0c 81 88 ff ff  .H6......]......
>   backtrace:
>     [<ffffffff8247dfba>] xas_nomem lib/xarray.c:307 [inline]
>     [<ffffffff8247dfba>] xas_nomem+0x4a/0xd0 lib/xarray.c:299
>     [<ffffffff8157b8d0>] split_huge_page_to_list+0x26d0/0x29f0 mm/huge_memory.c:2626

#syz test: git://git.infradead.org/users/willy/pagecache.git for-next
