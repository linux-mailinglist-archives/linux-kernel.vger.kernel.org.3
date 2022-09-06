Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6475AF0ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiIFQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiIFQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FBE0D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A85A614AA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04CEC433D6;
        Tue,  6 Sep 2022 16:23:42 +0000 (UTC)
Date:   Tue, 6 Sep 2022 17:23:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <Yxd0C7ndn+iPAGcj@arm.com>
References: <0000000000004387dc05e5888ae5@google.com>
 <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com>
 <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
 <YxdZXvsWr37RrFRk@arm.com>
 <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:39:57PM +0200, Andrey Konovalov wrote:
> On Tue, Sep 6, 2022 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > Does it take long to reproduce this kasan warning?
> > >
> > > syzbot finds several such cases every day (200 crashes for the past 35 days):
> > > https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> > > So once it reaches the tested tree, we should have an answer within a day.
> 
> To be specific, this syzkaller instance fuzzes the mainline, so the
> patch with the WARN_ON needs to end up there.
> 
> If this is unacceptable, perhaps, we could switch the MTE syzkaller
> instance to the arm64 testing tree.

It needs some more digging first. My first guess was that a PROT_MTE
page was mapped into the user address space and the task repainted it
but I don't think that's the case.

> > That's good to know. BTW, does syzkaller write tags in mmap'ed pages or
> > only issues random syscalls?
> 
> syzkaller doesn't write tags. Or, at least, shouldn't. Theoretically
> it could come up with same way to generate instructions that write
> tags, but this is unlikely.

Yeah. And colouring an entire page with the same tag is even less
likely.

> > I'm trying to figure out whether tag 0xf2
> > was written by the kernel without updating the corresponding
> > page_kasan_tag() or it was syzkaller recolouring the page.
> 
> Just in case, I want to point out that the kasantag == 0xa from the
> page flags matches the pointer tag 0xf5 in the report. The tag value
> is stored bitwise-inverted in the page flags. Not that this matters in
> this case though.

Yes, I'm aware of this. So copy_page() tries to read from
page_address(src) with kasantag == 0xa (real tag 0xf5) while the
in-memory tag is 0xf2. Since the user didn't repaint the page, I'm
trying to figure out what set the tags to 0xf2 while leaving the
page_kasan_tag() to 0xf5. Some of the page_kasan_tag_reset() calls in
the past could have hidden a different issue.

Since I can't find the kernel boot log for these runs, is there any kind
of swap enabled? I'm trying to narrow down where the problem may be.

-- 
Catalin
