Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F24E5D20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbiCXCVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiCXCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:21:05 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D093990
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:19:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e592e700acso37410167b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwQumeVhitVTx1gzhu5Yibhw++mrfhREWTZTV9Nodsg=;
        b=ZPif13Uq9RKZbjZ4VM4PpzdmB9hHh2C4RXgHMIiiqDJH5eRg8DG3jYVz2lOygH/Qz4
         OaUfBGP8ZFuq1XLo9c9w4gcQ8n5hpMHvhfFKz9bB9/TSLyAuqiPsVLAbECiN4sLUrcmK
         +4J+hEi5KM8JmBDbPXDqj26CXkCeqIKv3aAzkEF0WlZwH4G6O3J8S45wh+xUx6rx2WCz
         qbW4cjzuY+PHqv2TVOq8+Jnftmk5VdjWo+BULIq5Z31C/C1K/MgMkMNQc5u8Pq+hJd1A
         EdllO3ZOLVD48b5782osvvbyLzVIIH+XGD97ZBr2TiGLHS9JGQXXG/BVxPEA/H0oCDn6
         9eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwQumeVhitVTx1gzhu5Yibhw++mrfhREWTZTV9Nodsg=;
        b=FOcogoCSuBpPbv+vjLtxDYKR5KG2n9EfZX8TU1tzj3Mbumkk5ajbZwJfUTiPEoUCik
         HUbFzsrm+kDPke6h7O172STr9NVvoxvZ5Ad8kBGxKtFO3qsBQvanLWMNjkVmBxiSTEK9
         rhmnjYworiXmUJzcTYoMDL2oJQ3+Xg18rdqKELYKobdq0dRjYjZvX+xe2Zi4sL0uLwpH
         mW6piDlRseBVJ3+Z+g4Prp5lGdhhyhvYGRBwRRC3yHWCYBtu/sHeImMG3vFGzCnJfYxM
         UPRQYwHmLuEMCl7L0bcvx0SYhM0oZAwJi8tZcVnJXCwp1C8lKKzvsVZ2I6THyTiBbDKs
         FfOA==
X-Gm-Message-State: AOAM531zAWFh+jiL8w4dSOvmjn4qOFJz0CiKcg3WsEeo+xScnL+pZKqL
        OX0FYlGs3sW5RWu0NJhkmANonVxJM164nE/vAlX6yQ==
X-Google-Smtp-Source: ABdhPJy2h0jw3pY7I5dYmkisgdyu5xSuI4s3EEkqY4Cry3maUl3/XXFbGdG0GhbgeCG8JhFRa9/qcP+PnUAzUu9/Mz4=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr2931553ywf.418.1648088373753; Wed, 23
 Mar 2022 19:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
In-Reply-To: <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Mar 2022 10:18:57 +0800
Message-ID: <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
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

On Thu, Mar 24, 2022 at 7:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Muchun,
>  mind taking a look at this asap? This seems like a pretty core thing,
> and the fact that it oopses on that

Sorry for this. I am looking at this now.

>
> > RIP: 0010:list_add_tail include/linux/list.h:102 [inline]
> > RIP: 0010:list_lru_add+0x277/0x510 mm/list_lru.c:129
> >  d_lru_add fs/dcache.c:431 [inline]
> >  retain_dentry fs/dcache.c:685 [inline]
> >  dput+0x7a7/0xdb0 fs/dcache.c:908
>
> just worries me a lot.
>
> The dentry lru list rules are odd but not outrageously so. The main
> oddity is that the DCACHE_LRU_LIST bit in the dentry flags indicate
> whether the dentry is on a LRU list or not.
>
> And it's not one single list - it can be *either* the usual
> sb->lists_dentry_lru list, or the special "shrink list".
>
> But this oops is for the regular d_lru_add() path that adds the dentry
> to the sb->s_dentry_lru list as the dentry count goes down to zero
> (and it's not one of the dentries that get insta-free'd).

After this commit, the rules of dentry allocations changed.
The dentry should be allocated by kmem_cache_alloc_lru()
to set up the dentry reclaim context correctly (e.g. allocating
its list_lru_one). This issue seems that list_lru_one wasn't
allocated, then NULL pointer reference.

I'm trying to reproduce this and looking for the root cause.

Thanks.
