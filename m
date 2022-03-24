Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D74E66D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbiCXQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiCXQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:20:12 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31424ECCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:18:40 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so850536oof.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvPCDj2XTNMlrGPWwVtye5ut7SMzb+xM6DqJLQvHb50=;
        b=p8dME+OYbuQou5JQ6WLL6EvTPokbw9NedF7BIxkwAc6oqWuUKkjaJCCq2GZ2GfzSfB
         gbUqHDUNmTWByxjerMXegradc7/uK4bgsQZcrJupkBAKgwbVLHUr86AvJ3xK6fiR06kC
         TTbwT/D3L2685E6NVau21m7oyx5evUC25IXsVRdCG8Z2A6IHa95sqqBrgaWYa7tv95/L
         SgDN6dUD0pymbC46CadKn9w1qU1gminXvvh4I4s1vQ2viSZJcb7vcI5HQnelHoWVFc/Y
         NArUGQwzkIhjXwkxhDlVomXtmqK2K1NILEttB5MkeUZ2Z9JnUpD1pzmDGWTGjjqbnyR1
         lFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvPCDj2XTNMlrGPWwVtye5ut7SMzb+xM6DqJLQvHb50=;
        b=RMdNN9RwoX/i5rh7U224IMYfMb0En6wMTCQvaNQJyf6nozBkOHri3wenYE4DVHpQsO
         aCIaXQyPPG0qGZ6r0kUYDPqaRQGuNYvDJ+4mPMgwPlVXjjEyhnqCi7kJLc771ndWwfoG
         Xb1JmYWSIef1WPJuGE/iFJ073aCMYp43LrXWbsXB2tzKENA7hIJIs3I1jy6OB1RVzt0S
         d4KmTNa4xtOwMUcpLkY6i3gwq6kmP9SItHOkdPOxKiB7OUfTlTSyyho1mturou+FI8SM
         mdNVDxGhQKw7vyd8c0oawe/mzFFdROFHFG2NAsXP3y+9bZpMxm92HLPSSi8HYA3KSa90
         lwzQ==
X-Gm-Message-State: AOAM532qq2VyZkCuMVf/PBYvdNOcgFpjqYlnAFKKxxp9KZGjFN4XBAK+
        WZou0XChB8NjD0Kgg2+9GVTyxvMCs/CztAIjZUxjpA==
X-Google-Smtp-Source: ABdhPJw4epBS1QQ55tacEXfe2ExBWwbSD38B5hth631QE41Q30ti5s2vLruhg9fANHclMr98ngVFZsuAI6nMg1we0s8=
X-Received: by 2002:a4a:1ec1:0:b0:324:76e1:c37f with SMTP id
 184-20020a4a1ec1000000b0032476e1c37fmr2254671ooq.53.1648138719873; Thu, 24
 Mar 2022 09:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
 <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
 <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com>
 <CACT4Y+aQOziG8LGiTdyjTTHXJ4tNy2qxJ4yTPy-aUBG9CQB3_w@mail.gmail.com> <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
In-Reply-To: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Mar 2022 17:18:28 +0100
Message-ID: <CACT4Y+Z5y8moL4ph=2uNoeJ1oZDaq9oJjEqHtrh0t0Ef7Oag2w@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Thu, 24 Mar 2022 at 17:13, Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Mar 24, 2022 at 4:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, 24 Mar 2022 at 09:44, Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Thu, Mar 24, 2022 at 11:05 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > After this commit, the rules of dentry allocations changed.
> > > > > The dentry should be allocated by kmem_cache_alloc_lru()
> > > >
> > > > Yeah, I looked at that, but I can't find any way there could be other
> > > > allocations - not only are there strict rules how to initialize
> > > > everything, but the dentries are free'd using
> > > >
> > > >         kmem_cache_free(dentry_cache, dentry);
> > > >
> > > > and as a result if they were allocated any other way I would expect
> > > > things would go south very quickly.
> > > >
> > > > The only other thing I could come up with is some breakage in the
> > > > superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
> > > > problems, but again, this is *such* core code and not some unusual
> > > > path, that I would be very very surprised if it wouldn't have
> > > > triggered other issues long long ago.
> > > >
> > > > That's why I'd be more inclined to worry about the list_lru code being
> > > > somehow broken.
> > > >
> > >
> > > I also have the same concern.  I have been trying for a few hours to
> > > reproduce this issue, but it didn't oops on my test machine.  And I'll
> > > continue reproducing this.
> >
> > syzbot triggered it 222 times in a day, so it's most likely real:
> > https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
> >
> > There are 2 reproducers, but they look completely different. May be a race.
> > You may also try to use syzbot's patch testing feature to get some
> > additional debug info.
>
> Do you know how to tell the syzbot to test the following patch?
> I found some infos from github, it says "#syz test:", is it like the following?
> Thanks.
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> master

Yes, this is correct. You can now see the request listed here:
https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965

but the patch was truncated (probably you email client messed
whitespaces). In such case it's more reliable to attach the patch as
text file.



> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index c669d87001a6..ddb2ee627d32 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -67,6 +67,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
>         struct list_lru_node *nlru = &lru->node[nid];
>         struct list_lru_one *l = &nlru->lru;
>         struct mem_cgroup *memcg = NULL;
> +       int kmemcg_id;
>
>         if (!list_lru_memcg_aware(lru))
>                 goto out;
> @@ -75,7 +76,13 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
>         if (!memcg)
>                 goto out;
>
> -       l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> +       kmemcg_id = memcg_kmem_id(memcg);
> +       l = list_lru_from_memcg_idx(lru, nid, kmemcg_id);
> +       if (!l) {
> +               pr_info("BUG: the memcg(%px)->objcg(%px), kmemcg_id: %d\n",
> +                       memcg, memcg->objcg, kmemcg_id);
> +               BUG();
> +       }
>  out:
>         if (memcg_ptr)
>                 *memcg_ptr = memcg;
