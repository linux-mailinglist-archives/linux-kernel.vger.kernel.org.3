Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B84A571A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiGLMvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiGLMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:51:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C549AE61
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:51:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bf9so13724899lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dar9xPCP0T8sKNILKIgEn4rxc26k/YVLrGayncNYO94=;
        b=Ph/bTfm3Cmf9TYNEjTgKgZSFxWd4afIMXyQYaFjDG/kjR09YmvxRd9J/ilL6IFUeV8
         0LQZ04PGCw/PtZOPeMA1tgqtAv6fJx+pZFkTrdBJ+rpBweZDx7ulW/LIJxVJy3Tb+y2u
         WqALeL65b6b3TjgGkfpW4zpB4L33umf031d4hOyNEN1Nx/A+Oj/5Gb/Xlwqj2dNtePan
         DnHsDKuLyCNv+HVE2sF1vVSBEOQ7CCM2jz8Wxw9PtkzEOjLm9pjy9LMhwQ5GinC4+H7k
         kcbeHvXJOG3z7D0Pm5oBfhHOHrdpvJe4eI1YeBbpiVRbS3VZAK5kXzthvgHwQSn5meFu
         fEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dar9xPCP0T8sKNILKIgEn4rxc26k/YVLrGayncNYO94=;
        b=jOFRoNX5vEpTxpEesFc2+bvUuPPBjpZb+m3wZ2npRA/nLgmjKcXcKzjAWVQYLtdaZa
         gT3fhZHmO9kjwYdUH3UtIFTKI5wzQSdFrdFdrnFsJ/bi+U3V+rtZTaayYs3Q40iJ2B04
         b0irzrWv9/WtQaNVx/xELdLMe5u/nVi8H6ocS9yOvzVXh5Q+yy8qaUOETNuwrmjpHmGD
         kn6V9eWKwOnOZNj/oU27HaO/TJqvS9/bcEQYFO3efA6v6JoIguv+RE2U04mgDpPZVqiU
         dJwW7O0zN5WmrFM01Xb3DfB5YDp69aHQpU7fiG/ueMNb49sElLJE16Vsz46p7PRWQdjW
         wSYg==
X-Gm-Message-State: AJIora8CGb2WRSI8F+X5OSTjyEQNHDGFjA/1TH+B092+hfFuAw2ekGKB
        HpgV3Eb8ZnIz4P29vz3fyZwvJNCb4T+hTNRRjdfp1g==
X-Google-Smtp-Source: AGRyM1vU+TK0XWzHEN4FlxEp1aK/EkHICV4PZe4YQ79JeHGfIso1GuEHiWsRJy6lGMbVk179ksnn1WaPet3TYvaXI/g=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr14547822lfg.417.1657630262386; Tue, 12
 Jul 2022 05:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb2d6c05e35a0d73@google.com> <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org> <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
 <Ys1r06szkVi3QEai@casper.infradead.org>
In-Reply-To: <Ys1r06szkVi3QEai@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Jul 2022 14:50:50 +0200
Message-ID: <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
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

On Tue, 12 Jul 2022 at 14:40, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 12, 2022 at 08:54:28AM +0200, Dmitry Vyukov wrote:
> > On Mon, 11 Jul 2022 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Jul 11, 2022 at 01:38:08PM -0700, Andrew Morton wrote:
> > > > On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > > > >
> > > > > 2022/07/05 05:22:17 executed programs: 828
> > > > > 2022/07/05 05:22:23 executed programs: 846
> > > > > 2022/07/05 05:22:30 executed programs: 866
> > > > > 2022/07/05 05:22:37 executed programs: 875
> > > > > BUG: memory leak
> > > >
> > > > Thanks.  Presumably due to khugepaged changes.
> > >
> > > Huh, I was expecting it to be something I'd messed up.  I've been
> > > looking at it today, but no luck figuring it out so far.
> > >
> > > > Can we expect a bisection search?
> > >
> > > We only have a syz reproducer so far, and if I understand correctly,
> > > it's probably because this is a flaky test (because it's trying to
> > > find something that's a race condition).
> > >
> > > I expect a bisection search to go badly wrong if this is true.
> >
> > Is it possible that parts of xas are not freed on the error paths?
> > I don't immediately see where anything is freed on these error paths:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n681
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n721
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1675
>
> There's nothing to free; if a node is allocated, then it's stored in
> the tree where it can later be found and reused.

What I was thinking of is:

The leaked memory is allocated with:
xas_create_range(&xas);
here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1670

So I assumed the nodes stored in the xas object, which is local to the
collapse_file() function.

So if we do "goto out" here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1676

There does not seem to be anything that frees anything stored in the xas:

out:
    VM_BUG_ON(!list_empty(&pagelist));
    if (!IS_ERR_OR_NULL(*hpage))
        mem_cgroup_uncharge(page_folio(*hpage));
    /* TODO: tracepoints */
}
