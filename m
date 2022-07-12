Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF6571A30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiGLMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiGLMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:40:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B453D11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UWhG7Ip5SnXCg0duAf4R5ZOj7EMneuDd+1yKd/aFWAs=; b=fv4XW2pRMy0PdgxwGCr0TsIHbn
        XWir5GR5Hs4ppNE6ep6q+EZFeqCWHyXssIvbgQiEh2h+kmg4Ma2NjHE7dnRcwvBv/sS+sklZiKanb
        KvZ0qcF5V60kmOhbT1OPGHJcbcdrr7Nj7uVA7idTDyKRnKJ3ud1e7sqxHrHAsHO5ODNba2Po+6L6/
        vRwzPY3mGdtuY0PK5am+2dyPR9m7wOW+JSYTGt+Cj1fYI++WQvNt4qyWLmfdCKDXUHzLWWxVzXHow
        8tpCuUKmmDI20UkM9Xd9IKPzm+cUVVa8c43hP1/73sxQVF93aOP3s8g/FW9+y2CrePR5L2BueW5Hh
        FHD4YBuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBFC7-006uQ1-BW; Tue, 12 Jul 2022 12:40:51 +0000
Date:   Tue, 12 Jul 2022 13:40:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-ID: <Ys1r06szkVi3QEai@casper.infradead.org>
References: <000000000000eb2d6c05e35a0d73@google.com>
 <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org>
 <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:54:28AM +0200, Dmitry Vyukov wrote:
> On Mon, 11 Jul 2022 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jul 11, 2022 at 01:38:08PM -0700, Andrew Morton wrote:
> > > On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > > >
> > > > 2022/07/05 05:22:17 executed programs: 828
> > > > 2022/07/05 05:22:23 executed programs: 846
> > > > 2022/07/05 05:22:30 executed programs: 866
> > > > 2022/07/05 05:22:37 executed programs: 875
> > > > BUG: memory leak
> > >
> > > Thanks.  Presumably due to khugepaged changes.
> >
> > Huh, I was expecting it to be something I'd messed up.  I've been
> > looking at it today, but no luck figuring it out so far.
> >
> > > Can we expect a bisection search?
> >
> > We only have a syz reproducer so far, and if I understand correctly,
> > it's probably because this is a flaky test (because it's trying to
> > find something that's a race condition).
> >
> > I expect a bisection search to go badly wrong if this is true.
> 
> Is it possible that parts of xas are not freed on the error paths?
> I don't immediately see where anything is freed on these error paths:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n681
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n721
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1675

There's nothing to free; if a node is allocated, then it's stored in
the tree where it can later be found and reused.

