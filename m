Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E44BC10C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiBRUNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBRUNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:13:19 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CE124B291
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:13:02 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e11so5514645ils.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVsHCHmwADKSqOo2GYanEhPkg98MAktxHGKwbeIcwQA=;
        b=I9BBM++2sTN5aGRqni53EP3taTChxanqlZJ+rnp+WqJODfYkMXtFECQAUiyTgRKCAK
         eU6xqPVAwBZbNPQXGVxAHM0Rzml12LqzqyZOnYJUARnvNegrbMc531+SYOWD+/jU03zI
         oS4gee3t77tcfziiVXaxqcvovI8kf9aFSRfN6gnoZFI1MMDx+0O4R1JCyepGKrU0+ItM
         c2Ke30RLO7gGl/simOSrkbfotOVMqRjfyut+66b3DOkrjvcmqoO/wHrPPkKr6+b/YDYu
         cHkkdcKzNmcE1RtrUyo1R+EN4M8vxTcbQcFINFHqe+o/tkORYo2lZjcbrTBvOViZCNjb
         G2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVsHCHmwADKSqOo2GYanEhPkg98MAktxHGKwbeIcwQA=;
        b=1VPf/x8HFVVmSa41pWBMgaL03iTBnjVBNf6qHgyaBCllS04SfZx2sqvP9rnMZyMuJd
         M98Xwq0VchjhK16LCyKXYjvK5S8BqcGgqJANlgclUG/wTWQ9406nIYBnqQm3iB8eCCZz
         dYmif2Oc0wKy4bMZYNHD3oLVi2ZaGKYVVL/sI1jamBMY1SD/KJK5Xi2Wv3Lv5K9wL3gY
         EXb9MYWxAD20DJCDlrb5WKd6ExQq7YwThq8c/MJ7R+QSohnPBDLyxDZXHxYQheYFeZ9N
         mbncIwF3EqazGjkzs1wBO1OAW+JaCBwiSqOSpvIiPXq19NpEcziPPAe5EV/sDj02IFvy
         kmPA==
X-Gm-Message-State: AOAM531GpUl1SJNAXYp/4Xgifscv+MRQD3x3l3BWptZJMfPmnZpi1hWA
        0wcT9pFQx7jiJzwep5LhGteVxOW2zC7xMlFOs4jPNA==
X-Google-Smtp-Source: ABdhPJz9xqKlKR2n+B2bJRtz8x9xLAQBSZHzS73OpfCRy+cu0hbrw8WHq8/TecendfrhWg59B+OJfszNK/hjMb+P1zg=
X-Received: by 2002:a05:6e02:1a0f:b0:2c1:a8db:a266 with SMTP id
 s15-20020a056e021a0f00b002c1a8dba266mr3315687ild.127.1645215181718; Fri, 18
 Feb 2022 12:13:01 -0800 (PST)
MIME-Version: 1.0
References: <00000000000073b3e805d7fed17e@google.com> <462fa505-25a8-fd3f-cc36-5860c6539664@iogearbox.net>
 <CAPhsuW6rPx3JqpPdQVdZN-YtZp1SbuW1j+SVNs48UVEYv68s1A@mail.gmail.com>
 <CAPhsuW5JhG07TYKKHRbNVtepOLjZ2ekibePyyqCwuzhH0YoP7Q@mail.gmail.com>
 <CANp29Y64wUeARFUn8Z0fjk7duxaZ3bJM2uGuVug_0ZmhGG_UTA@mail.gmail.com>
 <CAPhsuW6YOv_xjvknt_FPGwDhuCuG5s=7Xt1t-xL2+F6UKsJf-w@mail.gmail.com>
 <CANp29Y4YC_rSKAgkYTaPV1gcN4q4WeGMvs61P2wnMQEv=kiu8A@mail.gmail.com> <2AB2B7C8-5F07-4D41-8CC3-04BE7C74DCCC@fb.com>
In-Reply-To: <2AB2B7C8-5F07-4D41-8CC3-04BE7C74DCCC@fb.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 18 Feb 2022 21:12:50 +0100
Message-ID: <CANp29Y5cFKGRTFy9EGqTD=BU4GMsP8uvOXBb=O+Mh0i5ExPsag@mail.gmail.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_jit_free
To:     Song Liu <songliubraving@fb.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Song Liu <song@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        syzbot <syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
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

Hi Song,

On Thu, Feb 17, 2022 at 9:05 PM Song Liu <songliubraving@fb.com> wrote:
>
> Hi Aleksandr,
>
> > On Feb 17, 2022, at 10:32 AM, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Hi Song,
> >
> > On Wed, Feb 16, 2022 at 5:27 PM Song Liu <song@kernel.org> wrote:
> >>
> >> Hi Aleksandr,
> >>
> >> Thanks for your kind reply!
> >>
> >> On Wed, Feb 16, 2022 at 1:38 AM Aleksandr Nogikh <nogikh@google.com> wrote:
> >>>
> >>> Hi Song,
> >>>
> >>> Is syzkaller not doing something you expect it to do with this config?
> >>
> >> I fixed sshkey in the config, and added a suppression for hsr_node_get_first.
> >> However, I haven't got a repro overnight.
> >
> > Oh, that's unfortunately not a very reliable thing. The bug has so far
> > happened only once on syzbot, so it must be pretty rare. Maybe you'll
> > have more luck with your local setup :)
> >
> > You can try to run syz-repro on the log file that is available on the
> > syzbot dashboard:
> > https://github.com/google/syzkaller/blob/master/tools/syz-repro/repro.go
> > Syzbot has already done it and apparently failed to succeed, but this
> > is also somewhat probabilistic, especially when the bug is due to some
> > rare race condition. So trying it several times might help.
> >
> > Also you might want to hack your local syzkaller copy a bit:
> > https://github.com/google/syzkaller/blob/master/syz-manager/manager.go#L804
> > Here you can drop the limit on the maximum number of repro attempts
> > and make needLocalRepro only return true if crash.Title matches the
> > title of this particular bug. With this change your local syzkaller
> > instance won't waste time reproducing other bugs.
> >
> > There's also a way to focus syzkaller on some specific kernel
> > functions/source files:
> > https://github.com/google/syzkaller/blob/master/pkg/mgrconfig/config.go#L125
>
> Thanks for these tips!
>
> After fixing some other things. I was able to reproduce one of the three
> failures modes overnight and some related issues from fault injection.
> These errors gave me clue to fix the bug (or at least one of the bugs).
>
> I have a suggestions on the bug dashboard, like:
>
> https://syzkaller.appspot.com/bug?id=86fa0212fb895a0d41fd1f1eecbeaee67191a4c9
>
> It isn't obvious to me which image was used in the test. Maybe we can add
> a link to the image or instructions to build the image? In this case, I
> think the bug only triggers on some images, so testing with the exact image
> is important.

Hmm, that's interesting. If the exact image can really make a
difference, I think we could e.g. remember the images syzbot used for
the last 1-2 months and make them downloadable from the bug details
page. I'll check if there are any obstacles, at first sight this
should not be a problem.

Thanks for the suggestion!

--
Best Regards,
Aleksandr

>
> Thanks again,
> Song
