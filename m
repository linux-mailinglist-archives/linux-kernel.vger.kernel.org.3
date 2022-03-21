Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADC4E20C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbiCUG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbiCUG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:57:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43713667B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:55:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so9903653otq.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wc7ThkaLJZR7210QtzX2oyJpNFvUx6zmHKI3fEwxV1k=;
        b=BvK9/xmg5mbwHV3uJTwp/m5Pz7h2c5hZQRgcSnDc6oglsPU9d/pd5sOMuJ939yX3Vh
         dZjJpDpxQHJuqZ+n0Sf+BtFPF+jMgtABw4DK/ziRf5dlaU5XLX7dMxMlNy/w9X30aN/h
         2jvbH32dNQ9vhadpL4YRGibyngHgH2U/jghKCwhWnGMYOZU2rx4sQuiLEnLFbtDPyUFv
         U2K+z8UCLc3cHxqucIIQQX6F0LRnNhZHvXvzv7xfMrk/lHW/u41duh/tcD9KoRZXx6Ib
         ERgXw5uZUzXBiu5wGPi5W0HG+q4qlt/QXquzGHa0ctILkRSzs5EcYk3aHtpk5E8TChtt
         tO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wc7ThkaLJZR7210QtzX2oyJpNFvUx6zmHKI3fEwxV1k=;
        b=vKvNjXC1y0evTs7BDU3xBEZsbQod3fJUh9EgbC+QZelB77d29SgWYzmm05LfydDsuA
         NR7n4mzaOLDPRWHRA5flsVp25Aj3eX8jI4dyoBuzLnQ8m2vhrJtl8H93ZCXLQtH9S7cU
         jKi4n8YqBp/TSCiyApHjyh170G/wOHsWJW7vdTjpGaYMSc+bsC1hrksBRZc6XpmZaEqf
         SteXpuztZjfqDU+403FOamP7qGbafxuyp4lS3g/wU6Mm63WmkSC26+RaxpHGuXBAXDu6
         9NkqY0BF2zVU0BkUMLfiwdIHjqOI+iTGEeJmNUVrqRHliVEbAMls22znhr1ok1tdIzuH
         XzZw==
X-Gm-Message-State: AOAM5328QB/1AGaCpamRcQ1vT7LDs+oHfIRyQoEzRPJdksuFihU5/SrH
        ROejqzyusgOq3R2F4m5fUg4IdOBrKd8CThkmcl1UhQ==
X-Google-Smtp-Source: ABdhPJxs66SQ7AlLchmppjScFi0PWxUVPW97mA7V9Pe6BdZ1UrrvgXFOuKMfA3wO/VHOJxyOXq7T8GsAw6vHTAzTKbQ=
X-Received: by 2002:a05:6830:23b6:b0:5b2:4ac0:9130 with SMTP id
 m22-20020a05683023b600b005b24ac09130mr7439221ots.196.1647845741145; Sun, 20
 Mar 2022 23:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com> <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com> <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
In-Reply-To: <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Mar 2022 07:55:29 +0100
Message-ID: <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Gao Xiang <xiang@kernel.org>
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

On Sun, 20 Mar 2022 at 05:19, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 6:33 AM syzbot
> > <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this issue to:
> > >
> > > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > > Author: Muchun Song <songmuchun@bytedance.com>
> > > Date:   Thu Mar 3 01:15:36 2022 +0000
> > >
> > >     mm: list_lru: allocate list_lru_one only when needed
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> > >
> > > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
> >
> > Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> > should be the commit 2768c206f2c3?  What am I missing here?
>
> Sometimes syzkaller bisection may make mistakes. Please ignore it.
>
> >
> > [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
>

Let's tell syzbot so that it reports new bugs in future:

#syz fix: fs: erofs: add sanity check for kobject in erofs_unregister_sysfs
