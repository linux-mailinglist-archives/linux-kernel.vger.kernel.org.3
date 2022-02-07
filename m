Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FF4ABE0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384770AbiBGL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385218AbiBGLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:31:23 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7924EC02C451
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:29:42 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id b15-20020a4a878f000000b002dccc412166so13216479ooi.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdrAEtpSp9knE3dG4N9tmiah7mkkROzWWe9VwwtgIEE=;
        b=hm9BqMPBVXryDOYxjtgkzshKUBUyISC+PQUo9JZc0hU2pX+klK/9GoBimwmV4SbPbs
         Cqktu28LyobNhdW4hSKY5KtDI2UWmSNcgeBjPTEd7B4KB0hv2NV+qWzvuHN6+SkOtFu5
         TiwDUyoGDQxMO8KHFSZQJ2fIbs8XY6z6xtTOFXXwph0LDKis4tf2aBVt2bTqxORAi41k
         0mvxrR6ZwQGJIQ4JCZ1rPHseamYb5bXnm/00ermwgNFOxidmOYZNjcSWxwjAfipHHjP3
         5kb+IMCddLCjqQ0SjILaVak/wEXI3KPC55ZNGDUEu9H22th2mZrQCZFD6FlRu9EAsZ9l
         NCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdrAEtpSp9knE3dG4N9tmiah7mkkROzWWe9VwwtgIEE=;
        b=QItJaengzk2efCYw9uRCn5+QMJ0OQZBQJx53/CTh55KoFBulFuSayTE6Ut0AIwrYCe
         t46xBqesoAlZhLMFvay5Jb4sJl53xDLc8yf+Sw43K9tE0CjSrgUF0S7x8Tg8k5XWCCj6
         F4Ans+LQ2GiV+LKB9cZY+39okXIO5YEuKBFxCQEnaZ9whVSFbVKV3cBgRiLvdidkUNzD
         NJrmVGph5nWsVy5Bo+MmHTn079pSAibejqHdklQrzLiSsZiu8HVFYDPkKmaSKZC+X5ys
         kFOeR0209FfDBIcjGlYNGZc5HdxvADYHDpDrkVlQj3ZA0spDYhMMHv13ZtuOeHPfFemM
         N2Bw==
X-Gm-Message-State: AOAM532yitkYqwPuEbfwo/3r/CPkGNx02dXSpS1p0Kec0vVPqguYLxBy
        ej9GXBaOEmYm9iktfpDMpK+HW2Veq2ncTWLUhcILug==
X-Google-Smtp-Source: ABdhPJyznrMFFiZoDqOMDlGRTRqArtq67oollYysU5ym1cWQLUvuAwYKu1pUfSpdvfjbXzTs/4WO2obpDRUITFEc+0s=
X-Received: by 2002:a05:6870:7715:: with SMTP id dw21mr3643420oab.38.1644233381454;
 Mon, 07 Feb 2022 03:29:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001e0ba105d5c2dede@google.com> <000000000000fbf22d05d74d08fb@google.com>
 <20220207103009.id72sr4dtghgzp5f@work>
In-Reply-To: <20220207103009.id72sr4dtghgzp5f@work>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Feb 2022 12:29:30 +0100
Message-ID: <CACT4Y+Z-R1swsyGrdgy89zHvmAa8tsBVE=mLngsapr5qPre9ZQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in ext4_fill_super
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     syzbot <syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 at 11:30, Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Sat, Feb 05, 2022 at 02:39:06PM -0800, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit cebe85d570cf84804e848332d6721bc9e5300e07
> > Author: Lukas Czerner <lczerner@redhat.com>
> > Date:   Wed Oct 27 14:18:56 2021 +0000
> >
> >     ext4: switch to the new mount api
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14902978700000
> > start commit:   0457e5153e0e Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=16902978700000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12902978700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd57c0f940a9a1ec
> > dashboard link: https://syzkaller.appspot.com/bug?extid=138c9e58e3cb22eae3b4
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7004fb00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cf108700000
> >
> > Reported-by: syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com
> > Fixes: cebe85d570cf ("ext4: switch to the new mount api")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
>
> I believe that this has been fixed with upstream commit
>
> commit 7c268d4ce2d3761f666a9950b029c8902bfab710
> Author: Lukas Czerner <lczerner@redhat.com>
> Date:   Wed Jan 19 14:02:09 2022 +0100
>
>     ext4: fix potential NULL pointer dereference in ext4_fill_super()
>
>     By mistake we fail to return an error from ext4_fill_super() in case
>     that ext4_alloc_sbi() fails to allocate a new sbi. Instead we just set
>     the ret variable and allow the function to continue which will later
>     lead to a NULL pointer dereference. Fix it by returning -ENOMEM in the
>     case ext4_alloc_sbi() fails.
>
>     Fixes: cebe85d570cf ("ext4: switch to the new mount api")
>     Reported-by: kernel test robot <lkp@intel.com>
>     Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>     Link: https://lore.kernel.org/r/20220119130209.40112-1-lczerner@redhat.com
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>     Cc: stable@kernel.org


Let's tell syzbot then:

#syz fix: ext4: fix potential NULL pointer dereference in ext4_fill_super()

Thanks
