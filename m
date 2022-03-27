Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAC4E85EF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiC0F3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiC0F3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:29:32 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78441FB4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:27:54 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c4so118493477b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgicqkCAvKN3gU0TpIKb4dIuI5ODIxLQrQ5+n0JgnmE=;
        b=jlGIuagyuKA21DL3+KdYHrYYfkokePE6pXILsVDiB+4HHTDI1p7HME4hzVEcno/3dS
         PELGTjLfGCih+cQ86kYVUHStNAWvNF5mYRH4fngt23A5ZvyXar7InfP5+ZAHO/Nq7GF9
         cHyLrBaA1xgBp5Ae4ok/YUDJp7XQ8ZNiwS0x2VbUEOLPB6bU1lSH/BzjNpwGcN2GXH+p
         0z5kkfW5v40Vxikp9SyJm8LiL03mUk+EQwljGFAGaTWyk7WpDyVXyXPrhRfkbZQ/7f5z
         2psHl3yMYvkz0UycClNrJUyPA1WJNBuekLf8cUTKHbvc5NrJUbiPUU1Ia4r9oPlcF+x4
         XHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgicqkCAvKN3gU0TpIKb4dIuI5ODIxLQrQ5+n0JgnmE=;
        b=WxepPSU8WiLuf/z94rzoaR1WG9VyxD068swQrYRyesj/0DUe5dAhRbnhBrMfatFKKo
         dwvrt1IIVUPZbdAQCMStQwsqpRF/mSTebhWQveCEavMYAYE20gwLJxfGC98N83yq7Sp9
         stwqjJcXH3j56bBO4Ljm6PwL8PRqUn+SpfNmGirditWvDUsjL3+x3qO3MB/UucTm7kIN
         xed0k87rqYpkeRFIp/G07m7l+iNIPSfSYwXoHBL2vNQ0+QuR4zqBOO/KcWWsN0WgfCiF
         gdjKbkXWcwCI6wJc23u5YdpfQbJIExgctazlszZ66H3IwTbk7chPlt6dsOh/eQAwyww0
         BQEA==
X-Gm-Message-State: AOAM532ty72H0zB/RG1XxGUiNfg0WhlIB9oqtVitp2n9mxX6EvNmQdMx
        iCiAcw8dMWVkg/qQ3a40NyXVwD2+kHo35JiUIIza2U2HmzhTmA==
X-Google-Smtp-Source: ABdhPJzzw/OngC7HG5Wt2z+m+5FYq1dMSef73+ak3m/Hhj9AvMAbNI0CwKPblL14NNRYzbZHr/r8zjL9kRIOPHKj/7o=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr19445727ywb.331.1648358873967; Sat, 26
 Mar 2022 22:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAMZfGtUG9GSRSp6fQ6AD6MFemX9ZS=XYWFceMPjVH7LATamUKg@mail.gmail.com>
 <CAHk-=wii1peDbW+eZipUnLmU_STXx6Vm30PiQnjhfUmgYrSd+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wii1peDbW+eZipUnLmU_STXx6Vm30PiQnjhfUmgYrSd+Q@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 27 Mar 2022 13:27:17 +0800
Message-ID: <CAMZfGtWzk2+yJd0vHWvokknBhWVfyauRZBvxbkFoDsngOK8MzA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
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

On Sat, Mar 26, 2022 at 4:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 25, 2022 at 2:52 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > We can see that we put the dentry (ffff88807ebda0f8) into
> > the list_lru (ffff888011bd47f0). But we do not allocate struct
> > list_lru_one for the memcg (ffff88801c530000).  Then it panics.
>
> Hmm.
>
> Looking at memcg_slab_pre_alloc_hook(), I note that it will return
> success without doing the LRU checking for several cases.
>
> So since you can reproduce the problem, I would suggest you add some
> debug code to __d_alloc() that prints out something big if it gets a
> dentry but you can't look up the list_lru_one() for that dentry.
>
> Hmm?
>
> The only other situation I can think of is if dentry->d_sb were to
> change during the dentry lifetime, but I don't think that can happen.
> The only assignment I can find with "git grep" is that
>
>         dentry->d_sb = sb;
>
> in __d_alloc(), and while it's possible my grep pattern was bogus, it
> sounds unlikely.
>

I have found the root cause, it was caused by kfence. Here is
the fix patch [1].

[1] https://lore.kernel.org/all/20220327051853.57647-1-songmuchun@bytedance.com/

Thanks.
