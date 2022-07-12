Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E5571AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiGLM6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiGLM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:58:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747DAA761
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdhEHYr8+2vzJ5ieaWHpDyda90wFHDOWzppwqyUC9n8=; b=Pv9rMtaJNlryzmYE7km5XCMOam
        vdHV/99a/k+NILfGven3UhK9+SDXJfEE7RVvca24Vqj2Yoj22TI8zjqQiorYc6Q24/f4eYNVJ00R7
        mft5zWm26mvW0iKvcuPGf++H0oeU4JNUnEGRp2gFWwVjveB5erlus28bF0qEHFuTTbQ+/KKSVhAZK
        st3Sz7vnbCHGUSLUA2B4ruuUA9BJWn1yggNtRQactz076eGLOcmSrW8QQcRe4ltCZz3TdFUHMKyK8
        eGufGrV7yIoJv7KnEIGXSdHogVZgqx8/0EDxDpsMKVcJ3wTtVl2aO2amUFFd3PzQKbfsJOENcmsf8
        5dJL8TCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBFSi-006w3J-0m; Tue, 12 Jul 2022 12:58:00 +0000
Date:   Tue, 12 Jul 2022 13:57:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-ID: <Ys1v1548IkSJ45F/@casper.infradead.org>
References: <000000000000eb2d6c05e35a0d73@google.com>
 <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org>
 <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
 <Ys1r06szkVi3QEai@casper.infradead.org>
 <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 02:50:50PM +0200, Dmitry Vyukov wrote:
> On Tue, 12 Jul 2022 at 14:40, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jul 12, 2022 at 08:54:28AM +0200, Dmitry Vyukov wrote:
> > > On Mon, 11 Jul 2022 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Jul 11, 2022 at 01:38:08PM -0700, Andrew Morton wrote:
> > > > > On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > > > > >
> > > > > > 2022/07/05 05:22:17 executed programs: 828
> > > > > > 2022/07/05 05:22:23 executed programs: 846
> > > > > > 2022/07/05 05:22:30 executed programs: 866
> > > > > > 2022/07/05 05:22:37 executed programs: 875
> > > > > > BUG: memory leak
> > > > >
> > > > > Thanks.  Presumably due to khugepaged changes.
> > > >
> > > > Huh, I was expecting it to be something I'd messed up.  I've been
> > > > looking at it today, but no luck figuring it out so far.
> > > >
> > > > > Can we expect a bisection search?
> > > >
> > > > We only have a syz reproducer so far, and if I understand correctly,
> > > > it's probably because this is a flaky test (because it's trying to
> > > > find something that's a race condition).
> > > >
> > > > I expect a bisection search to go badly wrong if this is true.
> > >
> > > Is it possible that parts of xas are not freed on the error paths?
> > > I don't immediately see where anything is freed on these error paths:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n681
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n721
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1675
> >
> > There's nothing to free; if a node is allocated, then it's stored in
> > the tree where it can later be found and reused.
> 
> What I was thinking of is:
> 
> The leaked memory is allocated with:
> xas_create_range(&xas);
> here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1670
> 
> So I assumed the nodes stored in the xas object, which is local to the
> collapse_file() function.

Yes, that's a reasonable thing to think, but it's actually not how
it works.  When we allocate a node in xas_create(), we put it straight
into the tree without storing it in xas->xa_alloc.  We may then end
up not using it, but the node isn't leaked because it's in the tree.

If the GFP_NOWAIT allocation fails (it didn't in these stack traces),
we call xas_nomem(), which sees an -ENOMEM, allocates a node and stores
it in xas->xa_alloc; then we go round the loop again where xas_create()
will take the node from xas->xa_alloc.  But the backtraces here don't
implicate xas_nomem().

> So if we do "goto out" here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1676
> 
> There does not seem to be anything that frees anything stored in the xas:
> 
> out:
>     VM_BUG_ON(!list_empty(&pagelist));
>     if (!IS_ERR_OR_NULL(*hpage))
>         mem_cgroup_uncharge(page_folio(*hpage));
>     /* TODO: tracepoints */
> }
> 
