Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA45362D2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbiE0MnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352853AbiE0Mms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:42:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E04E4E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:35:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q1so4811393ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v77/8KLMNhv2xq/PJzu8aCKip9eUbdpW7juv6ttcFs=;
        b=PCdMw2RHcL8HLV4YXIEySWPvqLtdk9MUdIdJYOeY/MAy2+bqO58mmCLE6YU8g7c+cS
         t6w99JGmv9yXn2jP1ERk3VQmn57ySmppfBKitZieSsd9vYZj+YhXORzjjqbE6INocXL2
         sk2oJE31a3Ky2ZspQNdrXaSRAhvZ6HrjhmEDMHJJCWNwiGgdaq+z3Eej3tC0GFTMtJwC
         l30m/45Fj2U6Jo5WCSZOcFgwAw7Cz/eoIK6QNZtk4RZkwqR+U9KyHB1rzZ3AMSACtDfT
         I0TbNdfQdmJDEofItj7RWSu+EhRTVdzHNSE3XpbWKC0dR9Wa4L55novvUTSFxKw7X07F
         rEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v77/8KLMNhv2xq/PJzu8aCKip9eUbdpW7juv6ttcFs=;
        b=r6uGkL2w5l36NcC2rnxVxfV3BZXrJj3C/rY1XIZR/j0KKUAgDV58ugCyjeSt0PXAkO
         jdQQOYd14f1F7p3+fd4W/tRsgSXr61LOBhwaPfauP4+oJ65gF9+RzdLl+oZEdbPw7Xdm
         VKqmAAubOu5ClGcl1se4XTsZLQKUATRwStu6BVMVWaypRspjLbWM+7SgIKpdpuxPszVK
         yr/RMMWUOGpx/eHAI3D7RDvejVy5ZHLgDwoO+PI/nP3LWiomfbLbWwRNFVizwn+mz7r8
         pbqtnWvx+ATBj1F7GrId//oCZ1nb7lJaFJBRIR/7xcABQUIGXBaWzs23AEl1LzTu1kbM
         ef4A==
X-Gm-Message-State: AOAM531xkm64rvEQsCnUnYnzgFMVn68Cq5uM8Gc+XB3BW1YRDt3V/Syl
        GkiPLmAKrSM6CH9L1BtTdCgQJ+JottNQ2vWrqUpDszif4y/J8w==
X-Google-Smtp-Source: ABdhPJxI00S6kh8PN1nm9dcfLgIcRs4ASzpqJiycIJka/MjX2iz0yfke9C1ZRTCz3FcvTAhxRPAGFk6QHfUnrteu444=
X-Received: by 2002:a05:651c:1797:b0:254:1a3a:801a with SMTP id
 bn23-20020a05651c179700b002541a3a801amr5806733ljb.363.1653654957603; Fri, 27
 May 2022 05:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008cfbca05dfd6db81@google.com> <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
 <Yo5uI9w7lll5B93r@casper.infradead.org> <Yo52gzYYOpU0NwDo@casper.infradead.org>
In-Reply-To: <Yo52gzYYOpU0NwDo@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 14:35:46 +0200
Message-ID: <CACT4Y+Zyfgr6KzFJ3r3df1EKyfXiYf9LHac4_MgLmD-B9uGhAQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

On Wed, 25 May 2022 at 20:33, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 25, 2022 at 06:57:55PM +0100, Matthew Wilcox wrote:
> >
> > Ohh, that makes sense.  We unlocked the mmap_sem, so the file is
> > pinned, but the VMA isn't.  I'll whip up a patch.
>
> #syz test

This bug doesn't have a reproducer, so unfortunately it can't be tested.
But it would also need kernel repo/branch to apply the patch, e.g.
something like #syz  test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

> From 01a4917c4cfe400eb310eba4f2fa466d381623c1 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Wed, 25 May 2022 14:23:45 -0400
> Subject: [PATCH] mm/filemap: Cache the value of vm_flags
>
> After we have unlocked the mmap_lock for I/O, the file is pinned, but
> the VMA is not.  Checking this flag after that can be a use-after-free.
> It's not a terribly interesting use-after-free as it can only read one
> bit, and it's used to decide whether to read 2MB or 4MB.  But it
> upsets the automated tools and it's generally bad practice anyway,
> so let's fix it.
>
> Reported-by: syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9a1eef6c5d35..61dd39990fda 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2991,11 +2991,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>         struct address_space *mapping = file->f_mapping;
>         DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>         struct file *fpin = NULL;
> +       unsigned long vm_flags = vmf->vma->vm_flags;
>         unsigned int mmap_miss;
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         /* Use the readahead code, even if readahead is disabled */
> -       if (vmf->vma->vm_flags & VM_HUGEPAGE) {
> +       if (vm_flags & VM_HUGEPAGE) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>                 ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
>                 ra->size = HPAGE_PMD_NR;
> @@ -3003,7 +3004,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>                  * Fetch two PMD folios, so we get the chance to actually
>                  * readahead, unless we've been told not to.
>                  */
> -               if (!(vmf->vma->vm_flags & VM_RAND_READ))
> +               if (!(vm_flags & VM_RAND_READ))
>                         ra->size *= 2;
>                 ra->async_size = HPAGE_PMD_NR;
>                 page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> @@ -3012,12 +3013,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  #endif
>
>         /* If we don't want any read-ahead, don't bother */
> -       if (vmf->vma->vm_flags & VM_RAND_READ)
> +       if (vm_flags & VM_RAND_READ)
>                 return fpin;
>         if (!ra->ra_pages)
>                 return fpin;
>
> -       if (vmf->vma->vm_flags & VM_SEQ_READ) {
> +       if (vm_flags & VM_SEQ_READ) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>                 page_cache_sync_ra(&ractl, ra->ra_pages);
>                 return fpin;
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Yo52gzYYOpU0NwDo%40casper.infradead.org.
