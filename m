Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A152CB77
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiESFSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiESFSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:18:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6DEAFB1D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:18:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so7146680lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axllb5GQqP++J06UNyAiJmRp6CQfVYprVks5whWT5bo=;
        b=izAK16ZJP5ozUEzyLhMtwLpyzqAcQI2KduMxRpsnDVThZcxACDGD927tVmR9Czk93Y
         jByIRhqmX1JUXCvn+MfkZjNjhsJYccZXme5EOing8BpT9VxXn6QoUAAPHJv4/Nmt0q4N
         w7vAKq7WpVgjRHns9BiIvvXBhPVk6BC56ebpWcEKstr9C58RkjxK2G8zi5AyNHuXvFnx
         5QES/ORD6gZGYsFJCmoMhZtrR0J57QdLahNP4zjttENIefN7bueevlTo5ToWrT6I237a
         qijE3KFdS7Pw3ZTnkzXkzbE9cNdqoEg9Lq7hd8BgjFKGlYRW07JlATZK/TrPkdCnUr+q
         4iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axllb5GQqP++J06UNyAiJmRp6CQfVYprVks5whWT5bo=;
        b=mVZn5ZM0q3Ji7f7gQdC+19zaDZQ50nUtsoWxxyDvQ+CThxGv51TncL0ynZn+/53dpS
         9x4+mMR4nndzvVIJbD+Nx3mT8tiVMNi4WA1wO+Ks8VYHk29pkBj6jrkX6GkrjWSyxKuz
         cQyKlaAMMMaO2A+RUP35OyVKvtP8zx2CvvOdUMImS3TJG4ae1nRcHDW7Z8yQgbBEWV5h
         VsERWVt89JgbcpI+oivPAayAA6zwXzGgIjE1tpqytHDG3T2Dgdyq4U5mVQpV6lLXmolw
         30La9JIPfAhEXA2PBoWQYcS9VM2wjfGzQTUyhZjdFb6cSfcE9pILGIQIC4u2FtO6V7AS
         5kcQ==
X-Gm-Message-State: AOAM53368J4E2SBzZsFvJOCNhicqiF6fhyASy0R1et8+f42Bo5PxAWdg
        XluFuiaaGfRWf033r2s0c4DwSpUvHFMJ0rjhWkWMzQ==
X-Google-Smtp-Source: ABdhPJyYDq726ALmgi3t1wi5/7kN7ID6ifbL3RSeRN35Y1BJu+kseeVPMRg/DzwKNGbujMlUUYWnbV488qXzGZalHoc=
X-Received: by 2002:a05:6512:3c94:b0:477:ba25:de54 with SMTP id
 h20-20020a0565123c9400b00477ba25de54mr2041366lfv.137.1652937515208; Wed, 18
 May 2022 22:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007f31db05de0638f0@google.com> <00000000000057d2f405defe7e00@google.com>
 <20220514135010.2528f75eb053a7b38d80584b@linux-foundation.org>
 <20220516175958.cswumupmeddptzdb@revolver> <20220519020341.rr3s6b4dr7o36cqb@revolver>
In-Reply-To: <20220519020341.rr3s6b4dr7o36cqb@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 May 2022 07:18:23 +0200
Message-ID: <CACT4Y+aPh_05ZwVb-yGC-BcDHkB9qcrxh5x_ffmVJJ5u_EU4MA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
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

On Thu, 19 May 2022 at 04:04, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220516 13:59]:
> > * Andrew Morton <akpm@linux-foundation.org> [220514 16:50]:
> > > On Sat, 14 May 2022 13:18:26 -0700 syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com> wrote:
> > >
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11da21b9f00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ee1fdd8dcc770a3a169a
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142757f1f00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cf0966f00000
> > >
> > > Thanks.
> > >
> > > So it was there on April 28 and it's there now.  Liam, do you think
> > > anything in the mapletree changes could have perturbed the interval
> > > tree handling?
> >
> > It is certainly possible, these two trees are intertwined so much.  One
> > area that sticks out as a possibility is vma_expand().  I created a
> > vma_expand() function to handle growing a vma and potentially removing
> > the next vma.  I do some interval tree modifications in there.
> >
> > I'll add it to my list of items to look at.
>
> This was my bug.  I reused a pointer that wasn't reused in this function
> until I altered the error path in this commit.
>
> Please apply this patch to the maple tree series to fix "mm/mmap: use
> advanced maple tree API for mmap_region()"

Please add this tag to the fix:

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com
