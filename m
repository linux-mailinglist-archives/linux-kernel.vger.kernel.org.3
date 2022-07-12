Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589AC571B65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiGLNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiGLNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:35:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE9B6545
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Md6jdHoeFnPVdoJQUXH6TznVJo5lY+mYYDDG4QrkfYo=; b=RVXeFay3fDWWaT84A2USdwmozx
        IiH4CKiXmARArCMbjzuPbYuwgytND/kwHA6nIPWlTtUMrgamo8XXaoIMiKfeMtQMQ/2vm8n3/DR5N
        pyARBKkrVNgdxPaBPrrWfivhhdk0o1Leha1S6ge6RsW71mgnyeJkP3YFEf+TndLvS36WVkQzMOhQO
        0yxs2HAbcUgqHYS1KIPCSHsmObt4wbnUsSC35FZxNJ1q0h3z6KRwA1IHxLK7Vquse2d/ZCu7n5A3P
        1kRqMk76XS6rUtPJuTlA9SxZp267MBz4XLOKZzH5TOL96hSDYKVOggm2hbtK2V8r3xX5/LK/7t09H
        To+1IGXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBG2Y-006xcN-1q; Tue, 12 Jul 2022 13:35:02 +0000
Date:   Tue, 12 Jul 2022 14:35:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-ID: <Ys14hjgqMTudMCtv@casper.infradead.org>
References: <000000000000eb2d6c05e35a0d73@google.com>
 <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org>
 <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
 <Ys1r06szkVi3QEai@casper.infradead.org>
 <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
 <Ys1v1548IkSJ45F/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1v1548IkSJ45F/@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:57:59PM +0100, Matthew Wilcox wrote:
> > So I assumed the nodes stored in the xas object, which is local to the
> > collapse_file() function.
> 
> Yes, that's a reasonable thing to think, but it's actually not how
> it works.  When we allocate a node in xas_create(), we put it straight
> into the tree without storing it in xas->xa_alloc.  We may then end
> up not using it, but the node isn't leaked because it's in the tree.
> 
> If the GFP_NOWAIT allocation fails (it didn't in these stack traces),
> we call xas_nomem(), which sees an -ENOMEM, allocates a node and stores
> it in xas->xa_alloc; then we go round the loop again where xas_create()
> will take the node from xas->xa_alloc.  But the backtraces here don't
> implicate xas_nomem().

There is actually a leak here, but it's not the one that's been found.

        do {
                xas_lock_irq(&xas);
                xas_create_range(&xas);
                if (!xas_error(&xas))
                        break;
                xas_unlock_irq(&xas);
                if (!xas_nomem(&xas, GFP_KERNEL)) {
                        result = SCAN_FAIL;
                        goto out;
                }
        } while (1);

If xas_create() fails, it sets xas error to -ENOMEM.  So we unlock the
xarray lock and call xas_nomem().  xas_nomem() sees the error is -ENOMEM
and allocates a node with GFP_KERNEL, putting the node in xas->xa_alloc.
We re-take the spinlock and call xas_create() again.  If we still need
a node, xas_alloc() will take the node stored in xas->xa_alloc.  If we
raced and don't need a node, xas_create_range() succeeds and we break out,
failing to free the xas->xa_alloc node.

We should call xas_destroy() at the out: label.  However, this does not
explain what is going on, and will not fix what is going on, since any
nodes allocated during xas_create_range() will be stored safely in the
tree and will not be freed by xas_destroy().
