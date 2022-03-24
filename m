Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B594E66B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbiCXQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345791AbiCXQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:14:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614AEA2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:13:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e5827a76f4so56100987b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qD/GtOjGwOlJ7PVUx2PNL/pqrH5OmjHCrCL+mrKUoNs=;
        b=FWeKjzvOPcv4J6hpCELOZQ5cq/PWnEZySFDbQXiYNSRunZGregPPfCHQ3V1dHGkxLT
         V1sgoVBVGvr1Y3jtADkZqsHwslTHW6P9ibdTzkg++st+te2PQIG4RmqNPQVBGfnbr1dx
         h/BPUogr6i28aCYj6pXiYg/our8couw4KZUUdCppB6J/pOQ+9nJcxkZMuyZbrq4gS8Ac
         VRR7IpdEHtu1QqPoVPpeOC+GF25EEQJ4YcOJO9NPrTsLQyD/JwU4pV7DKMMJ1i753b8F
         crWlyiN2xaUhUjv9ZVM2fw1t7fvJMRHg/2WEGsb5saCviTbFM8cN1EYbtzQeUBS7/3fj
         7KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qD/GtOjGwOlJ7PVUx2PNL/pqrH5OmjHCrCL+mrKUoNs=;
        b=F/RkgnVaG/QrkECtbOH2qyyYf1jk0QF/c7r/zqcpguiIVZuRXY4UfFMsssFhsPlkRb
         GroB5QjP3slPLWr/zdo+juIAmldWGmeXTSAULhTDzQ6SPIgC861EKKGWhsYUGc0zYxbB
         +bHA5nKsXHfM3LFilysdJfmRaP3PoRxBlFJfxOt9jZkzyKKK3to1s5clXZH4ibmEdOKJ
         pY4xO62EA/c9a/5DixF5z002REb7heE7Aygx+Q7PI3wTWWJ822v14wW/2yVb8FYusJZ9
         HbwnvvykpfCOVAkb1/bCiKH88tQ3uaksUdLoRbDOOLUj4aPW3lUYzKKHJv/mMU+3Qop6
         CHJg==
X-Gm-Message-State: AOAM531kyJ9qZMzFszksitE4B9nvHTHaReH4fE30azbr5kktqjOHUI+n
        2vQUMKpfOTCfm+ixH2tAt3pTcrwGcYZ6u+Izr5A80w==
X-Google-Smtp-Source: ABdhPJyLbR0gOHQMYE2j2r5PaK0FjY4hKvE1cHqATs46KJsxpl/UXEMpJO1PdJottFtcCUT77kkjD+ZoUMXv57jRxt8=
X-Received: by 2002:a05:690c:827:b0:2e5:a53b:cffc with SMTP id
 by7-20020a05690c082700b002e5a53bcffcmr5703549ywb.31.1648138383515; Thu, 24
 Mar 2022 09:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
 <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
 <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com> <CACT4Y+aQOziG8LGiTdyjTTHXJ4tNy2qxJ4yTPy-aUBG9CQB3_w@mail.gmail.com>
In-Reply-To: <CACT4Y+aQOziG8LGiTdyjTTHXJ4tNy2qxJ4yTPy-aUBG9CQB3_w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Mar 2022 00:12:26 +0800
Message-ID: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 4:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 24 Mar 2022 at 09:44, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 11:05 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > After this commit, the rules of dentry allocations changed.
> > > > The dentry should be allocated by kmem_cache_alloc_lru()
> > >
> > > Yeah, I looked at that, but I can't find any way there could be other
> > > allocations - not only are there strict rules how to initialize
> > > everything, but the dentries are free'd using
> > >
> > >         kmem_cache_free(dentry_cache, dentry);
> > >
> > > and as a result if they were allocated any other way I would expect
> > > things would go south very quickly.
> > >
> > > The only other thing I could come up with is some breakage in the
> > > superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
> > > problems, but again, this is *such* core code and not some unusual
> > > path, that I would be very very surprised if it wouldn't have
> > > triggered other issues long long ago.
> > >
> > > That's why I'd be more inclined to worry about the list_lru code being
> > > somehow broken.
> > >
> >
> > I also have the same concern.  I have been trying for a few hours to
> > reproduce this issue, but it didn't oops on my test machine.  And I'll
> > continue reproducing this.
>
> syzbot triggered it 222 times in a day, so it's most likely real:
> https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
>
> There are 2 reproducers, but they look completely different. May be a race.
> You may also try to use syzbot's patch testing feature to get some
> additional debug info.

Do you know how to tell the syzbot to test the following patch?
I found some infos from github, it says "#syz test:", is it like the following?
Thanks.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
master

diff --git a/mm/list_lru.c b/mm/list_lru.c
index c669d87001a6..ddb2ee627d32 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -67,6 +67,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
        struct list_lru_node *nlru = &lru->node[nid];
        struct list_lru_one *l = &nlru->lru;
        struct mem_cgroup *memcg = NULL;
+       int kmemcg_id;

        if (!list_lru_memcg_aware(lru))
                goto out;
@@ -75,7 +76,13 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
        if (!memcg)
                goto out;

-       l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+       kmemcg_id = memcg_kmem_id(memcg);
+       l = list_lru_from_memcg_idx(lru, nid, kmemcg_id);
+       if (!l) {
+               pr_info("BUG: the memcg(%px)->objcg(%px), kmemcg_id: %d\n",
+                       memcg, memcg->objcg, kmemcg_id);
+               BUG();
+       }
 out:
        if (memcg_ptr)
                *memcg_ptr = memcg;
