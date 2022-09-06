Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BF5AE96E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiIFNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiIFNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E105670E5F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5D16153C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBDC433B5;
        Tue,  6 Sep 2022 13:23:58 +0000 (UTC)
Date:   Tue, 6 Sep 2022 14:23:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Message-ID: <YxdJ684ypgAy8k98@arm.com>
References: <0000000000004387dc05e5888ae5@google.com>
 <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Mon, Sep 05, 2022 at 11:39:24PM +0200, Andrey Konovalov wrote:
> Syzbot reported an issue with MTE tagging of user pages, see the report below.
> 
> Possibly, it's related to your "mm: kasan: Skip unpoisoning of user
> pages" series. However, I'm not sure what the issue is.
[...]
> On Sat, Aug 6, 2022 at 3:31 AM syzbot
> <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com> wrote:
> > BUG: KASAN: invalid-access in copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
> > Read at addr f5ff000017f2e000 by task syz-executor.1/2218
> > Pointer tag: [f5], memory tag: [f2]
[...]
> > The buggy address belongs to the physical page:
> > page:000000003e6672be refcount:3 mapcount:2 mapping:0000000000000000 index:0xffffffffe pfn:0x57f2e
> > memcg:fbff00001ded8000
> > anon flags: 0x1ffc2800208001c(uptodate|dirty|lru|swapbacked|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)

It looks like a copy-on-write where the source page is tagged
(PG_mte_tagged set) but page_kasan_tag() != 0xff (kasantag == 0xa). The
page is also swap-backed. Our current assumption is that
page_kasan_tag_reset() should be called on page allocation and we should
never end up with a user page without the kasan tag reset.

I was hoping we can catch such condition with the diff below but it
never triggered for me even when swapping tagged pages in and out:

-------------8<-------------------------------------------
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index b2b730233274..241c616e3685 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -62,6 +62,9 @@ void mte_sync_tags(pte_t old_pte, pte_t pte)
 	if (!check_swap && !pte_is_tagged)
 		return;
 
+	/* Pages mapped in user space should have had the kasan tag reset */
+	WARN_ON_ONCE(page_kasan_tag(page) != 0xff);
+
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
------------------------8<-------------------------------

Does it take long to reproduce this kasan warning? If not, it may be
worth adding the above hunk, hopefully we can identify where that page
is coming from before it ends up in copy_page().

-- 
Catalin
