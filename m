Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354D75AEB45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiIFN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbiIFNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:54:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B07DF4A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:41:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x14so2071264lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4eoG5o1/o/cDQc5d6B6txMUL3euvxIxbYDIIkvInIAw=;
        b=A4wn9lx1lcwABPoTpUyayJvgxPQW3tUkhVk7viKkKXWpSxo7kIwl8oA4Low7EUD/9u
         jLe8WUOHFCLpT1u02mXJg58OysAPz1o0Np7SR0dlo2tld6pbUNaa5h+m5U8AXNoOnT5N
         mhVbY06QYAsImVSe5vIVHPyKrK7QGafEy2tC/Rn/ixxP4H1MlTGVVxGlknJq+PtWr+YJ
         3/aebt9ofW1cNuXolIuABXfloqlTZ54rJgo2o5RlRRDOxLXcWHuOIeQYpxmBD3qgnZMW
         lACN18SnL9WiVqjh1wbG4KXW+6wJroJqhcqG3Jvvt9kKTS9V4Q3YNWCMKsyI5steTU0u
         y2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4eoG5o1/o/cDQc5d6B6txMUL3euvxIxbYDIIkvInIAw=;
        b=XsMK9cEagmY+VykLBuFa86Zkm3scf4hXEKJ7vRDbYRP1pC2lHGx0XVjiFln3gAhmFR
         f0xZtSxjJKBsOWO5Yq76j6aG7KdYAnHUrUkbmhTbNapgA9hqSzMAIbNb/91sqjxj9gS4
         BkLncdXDm98DRAhGopM7D24dYYHs3gDy6r+4QiHysDIiAcKEh+fKtwtd5/4OnCp2gs8w
         i0kcbNHoviSWi6qdbgQm1QzKLoiJ2+H++c/g5jawpmpdwSKC55qPZVJ99nU1EOj8bSA0
         mr0HQrzdTeBQ8/5NRKTyHbnzZ2uCDIFpM57xS0fnHgUEw4ywTeRpFoYZKiiKr+yh3Mah
         SREQ==
X-Gm-Message-State: ACgBeo1akQZTMlb7QDu8Jsw6UTypkbCxqTgdqQ0PGxb8+a7+vQRXmg45
        4qs22h49KsjAJRXpSbNe4AoPLnQFh6dX7+dAFTJtug==
X-Google-Smtp-Source: AA6agR5cPceOY8Mq5DyzvRQx6Zv3mWnQuLj7fVw9q5rqfekrEOtEUDBMOBHyxcmAzTvN5FuW74eb/4k8Cvclpno9OX4=
X-Received: by 2002:a05:6512:110f:b0:494:a534:981d with SMTP id
 l15-20020a056512110f00b00494a534981dmr7612905lfg.376.1662471670498; Tue, 06
 Sep 2022 06:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004387dc05e5888ae5@google.com> <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com>
In-Reply-To: <YxdJ684ypgAy8k98@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Sep 2022 15:40:59 +0200
Message-ID: <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 15:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Andrey,
>
> On Mon, Sep 05, 2022 at 11:39:24PM +0200, Andrey Konovalov wrote:
> > Syzbot reported an issue with MTE tagging of user pages, see the report below.
> >
> > Possibly, it's related to your "mm: kasan: Skip unpoisoning of user
> > pages" series. However, I'm not sure what the issue is.
> [...]
> > On Sat, Aug 6, 2022 at 3:31 AM syzbot
> > <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com> wrote:
> > > BUG: KASAN: invalid-access in copy_page+0x10/0xd0 arch/arm64/lib/copy_page.S:26
> > > Read at addr f5ff000017f2e000 by task syz-executor.1/2218
> > > Pointer tag: [f5], memory tag: [f2]
> [...]
> > > The buggy address belongs to the physical page:
> > > page:000000003e6672be refcount:3 mapcount:2 mapping:0000000000000000 index:0xffffffffe pfn:0x57f2e
> > > memcg:fbff00001ded8000
> > > anon flags: 0x1ffc2800208001c(uptodate|dirty|lru|swapbacked|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)
>
> It looks like a copy-on-write where the source page is tagged
> (PG_mte_tagged set) but page_kasan_tag() != 0xff (kasantag == 0xa). The
> page is also swap-backed. Our current assumption is that
> page_kasan_tag_reset() should be called on page allocation and we should
> never end up with a user page without the kasan tag reset.
>
> I was hoping we can catch such condition with the diff below but it
> never triggered for me even when swapping tagged pages in and out:
>
> -------------8<-------------------------------------------
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index b2b730233274..241c616e3685 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -62,6 +62,9 @@ void mte_sync_tags(pte_t old_pte, pte_t pte)
>         if (!check_swap && !pte_is_tagged)
>                 return;
>
> +       /* Pages mapped in user space should have had the kasan tag reset */
> +       WARN_ON_ONCE(page_kasan_tag(page) != 0xff);
> +
>         /* if PG_mte_tagged is set, tags have already been initialised */
>         for (i = 0; i < nr_pages; i++, page++) {
>                 if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> ------------------------8<-------------------------------
>
> Does it take long to reproduce this kasan warning? If not, it may be
> worth adding the above hunk, hopefully we can identify where that page
> is coming from before it ends up in copy_page().

syzbot finds several such cases every day (200 crashes for the past 35 days):
https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
So once it reaches the tested tree, we should have an answer within a day.
