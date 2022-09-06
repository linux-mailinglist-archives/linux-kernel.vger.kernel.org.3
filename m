Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7635AEE80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiIFPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiIFPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569BBADB9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7629FB8164A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D93C433C1;
        Tue,  6 Sep 2022 14:29:53 +0000 (UTC)
Date:   Tue, 6 Sep 2022 15:29:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
Message-ID: <YxdZXvsWr37RrFRk@arm.com>
References: <0000000000004387dc05e5888ae5@google.com>
 <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com>
 <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:40:59PM +0200, Dmitry Vyukov wrote:
> On Tue, 6 Sept 2022 at 15:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Sep 05, 2022 at 11:39:24PM +0200, Andrey Konovalov wrote:
> > > Syzbot reported an issue with MTE tagging of user pages, see the report below.
> > >
> > > Possibly, it's related to your "mm: kasan: Skip unpoisoning of user
> > > pages" series. However, I'm not sure what the issue is.
> > [...]
> > > On Sat, Aug 6, 2022 at 3:31 AM syzbot
> > > <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com> wrote:
> > > > BUG: KASAN: invalid-access in copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
> > > > Read at addr f5ff000017f2e000 by task syz-executor.1/2218
> > > > Pointer tag: [f5], memory tag: [f2]
> > [...]
> > > > The buggy address belongs to the physical page:
> > > > page:000000003e6672be refcount:3 mapcount:2 mapping:0000000000000000 index:0xffffffffe pfn:0x57f2e
> > > > memcg:fbff00001ded8000
> > > > anon flags: 0x1ffc2800208001c(uptodate|dirty|lru|swapbacked|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)
> >
> > It looks like a copy-on-write where the source page is tagged
> > (PG_mte_tagged set) but page_kasan_tag() != 0xff (kasantag == 0xa). The
> > page is also swap-backed. Our current assumption is that
> > page_kasan_tag_reset() should be called on page allocation and we should
> > never end up with a user page without the kasan tag reset.
[...]
> > Does it take long to reproduce this kasan warning?
> 
> syzbot finds several such cases every day (200 crashes for the past 35 days):
> https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> So once it reaches the tested tree, we should have an answer within a day.

That's good to know. BTW, does syzkaller write tags in mmap'ed pages or
only issues random syscalls? I'm trying to figure out whether tag 0xf2
was written by the kernel without updating the corresponding
page_kasan_tag() or it was syzkaller recolouring the page.

-- 
Catalin
