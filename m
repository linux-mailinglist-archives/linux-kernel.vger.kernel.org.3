Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB5571B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiGLN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGLN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:29:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04446B270
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:29:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d12so13920916lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ank7/+L/mHMnE+3QMD4hHykXxDa+TqpdlWx4EC12KRU=;
        b=s3RcM+j8m46/k2eVgR8woEMqkM+wqG9kPOKHBmTKXM8HC5RpdGkj+4rPp9rNd6b7Iu
         YfU3nUvqIJxVhhDo9krinLiGuuJe5iKGOiOxDsPXZ+/Xr7xWQmHfCM49OhLzO4BnQ0KW
         a+BbcdtQ1go80SMGxbqFEfw2a31DL4iBD7udY8wA9qze2opjB+WDCwZMPlF2fV3WWSf8
         fS5J673kKkrFRKSFyFWma7OSxSY7nJf8vsdQKTExjwJghv/0A9jg/bCEiNcv068Yr4LD
         RtlHd05ZTjGNkcVkEmGlE5h+Y78JCRweOo9qWgjgdql3l9oh+2Wd/NRdK7ntv4isEzD5
         dG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ank7/+L/mHMnE+3QMD4hHykXxDa+TqpdlWx4EC12KRU=;
        b=d93jSCNd8iTZqev75WdKREuT33O+oSLeKJfTdyKicSYA+aX+4SHH1pf4/lgXR3swCX
         vdwr2vDc7h6038Z245Gy7K5qtT+Dk6RZF9xriWORhNsutw8M5zX108yxtp+3UrldAtl2
         EIwCUVoURzpSswdUkqoEIC/LIkZlBE+TIteJKkcdZGFrni/qQQXa2WWCyBrDt0ixbtwj
         YVd6kDA/vRnsUz2GaKjOzeYq2fOzWQHLSbjJE2cvu7KNDXy+8Peb7RzFD+LOus/et607
         vAbglIGUnR0c6OsAeZ0lTkV/iXKPOeTUFbDyiPcj2atk6w8PciAofmRrzNO2CYRmjWBD
         Pbbg==
X-Gm-Message-State: AJIora9cQd66727nKNiMxiTA5AGamnAjpcKdPyObGKvu4X0oUH351ygr
        W0w1JNtZu+ReNM9ja7QkOlo5gM7SarU7jrUSH2+8/A==
X-Google-Smtp-Source: AGRyM1uLe+Eot9/Gii9FHCNSp9e4B0AO9L5cu6BJRa/gKyT6RVxluqJtSDtIZcceEkz8EFXA7UMlariTheatj1THTrk=
X-Received: by 2002:ac2:4d43:0:b0:489:cb6e:b293 with SMTP id
 3-20020ac24d43000000b00489cb6eb293mr12061439lfp.376.1657632582048; Tue, 12
 Jul 2022 06:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb2d6c05e35a0d73@google.com> <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org> <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
 <Ys1r06szkVi3QEai@casper.infradead.org> <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
 <Ys1v1548IkSJ45F/@casper.infradead.org>
In-Reply-To: <Ys1v1548IkSJ45F/@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Jul 2022 15:29:29 +0200
Message-ID: <CACT4Y+a=N3Q6f4dDcmONZYBHMgkO3MpbqoYDupo_N1tKJ=14Rg@mail.gmail.com>
Subject: Re: [syzbot] memory leak in xas_create
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
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

On Tue, 12 Jul 2022 at 14:58, Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > > > > > > git tree:       upstream
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > > > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > > > > > >
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > > > > > >
> > > > > > > 2022/07/05 05:22:17 executed programs: 828
> > > > > > > 2022/07/05 05:22:23 executed programs: 846
> > > > > > > 2022/07/05 05:22:30 executed programs: 866
> > > > > > > 2022/07/05 05:22:37 executed programs: 875
> > > > > > > BUG: memory leak
> > > > > >
> > > > > > Thanks.  Presumably due to khugepaged changes.
> > > > >
> > > > > Huh, I was expecting it to be something I'd messed up.  I've been
> > > > > looking at it today, but no luck figuring it out so far.
> > > > >
> > > > > > Can we expect a bisection search?
> > > > >
> > > > > We only have a syz reproducer so far, and if I understand correctly,
> > > > > it's probably because this is a flaky test (because it's trying to
> > > > > find something that's a race condition).
> > > > >
> > > > > I expect a bisection search to go badly wrong if this is true.
> > > >
> > > > Is it possible that parts of xas are not freed on the error paths?
> > > > I don't immediately see where anything is freed on these error paths:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n681
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n721
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1675
> > >
> > > There's nothing to free; if a node is allocated, then it's stored in
> > > the tree where it can later be found and reused.
> >
> > What I was thinking of is:
> >
> > The leaked memory is allocated with:
> > xas_create_range(&xas);
> > here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1670
> >
> > So I assumed the nodes stored in the xas object, which is local to the
> > collapse_file() function.
>
> Yes, that's a reasonable thing to think, but it's actually not how
> it works.  When we allocate a node in xas_create(), we put it straight
> into the tree without storing it in xas->xa_alloc.  We may then end
> up not using it, but the node isn't leaked because it's in the tree.
>
> If the GFP_NOWAIT allocation fails (it didn't in these stack traces),
> we call xas_nomem(), which sees an -ENOMEM, allocates a node and stores
> it in xas->xa_alloc; then we go round the loop again where xas_create()
> will take the node from xas->xa_alloc.  But the backtraces here don't
> implicate xas_nomem().

I see. Thanks for the explanation.

Then I think it's still possible that this is a KMEMLEAK false
positive. IIRC it may have some false positives since it does not do
full stop-the-world before scanning memory/registers. syzkaller tries
to circumvent this by doing multiple scans with some delays, but it
does not give 100% guarantee.
And I am assuming this code does not try to hide pointers by storing
something in low/high bits, etc.


> > So if we do "goto out" here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1676
> >
> > There does not seem to be anything that frees anything stored in the xas:
> >
> > out:
> >     VM_BUG_ON(!list_empty(&pagelist));
> >     if (!IS_ERR_OR_NULL(*hpage))
> >         mem_cgroup_uncharge(page_folio(*hpage));
> >     /* TODO: tracepoints */
> > }
> >
