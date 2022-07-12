Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCA571294
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiGLGyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiGLGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:54:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169F936B7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:54:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w17so7235999ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn3i9yImta8oxCfkEnFJ7Ot67eZ6TujXXgzt8R7sT4Y=;
        b=ihrcO8cVPHAyPrALJVwtzrj2gUBS2E6i3309qBnD3hax2Iy/zRjNk6czP/DsgUC49o
         e3jCP7oUhlSvTSUrbJjwE6BaT8hqG6cKXG+p9YmuAqIulSEqvl36GbeWPRINrXtLb502
         x0TPy8OQv+4rxx54AK2+SN4b+jlcj+qSfXQf6lq1PluyCeAUcnAgYweGYPYj8sYhc5oj
         jBt1QtXPHpuqmW9yZQelgMATbcV5lHWrQStHw3t3vjvLpn/EZn255PmXW1P2A+XcP2jZ
         KeXO9KTekIq9fH3BBJiEdb2KNd2cjIhE0Xvod+zYkFIVQtMWGwxErE+8awCF6xZzy0Ca
         h/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn3i9yImta8oxCfkEnFJ7Ot67eZ6TujXXgzt8R7sT4Y=;
        b=SHwfjdC5Q4v4VUEZMsA8xhDGvk2AVKopEon5N1LHGR/j8s5KaOtwZWsqvhmhCKniMj
         CLwiuHiJJVFVEbLgOSfk+r+0AqIeIFN93JKlVXJKSnYFLon8xoIVVxQXcCCQF2CpMGRk
         PW0OcvTJXqi3RZYvKhS1G1Di4vYeys1bMLO2SRKdhqQw4WnVOvqn759TtQCSYq5xWa6O
         fAVH8DWwkDMXUX6yHHbc9eQRyQE7CE09ksHjt/JZgmK3GCpfLM06Us8YPyuqOu3o9v07
         +mYA27k9QjLyFjqzTzzwcmrFQDoWmyh0Oc7l52jl3hDlldDjGdcRKsww6k6XV1Te+t2N
         QTdA==
X-Gm-Message-State: AJIora9PUbfV+TlI/i4TVplYFpZYNMfsk9c75O205DpsMF0Zou+hxjyC
        GzXJzup+3iitO6zQiEf4AzEdIoxkCpeqocwPg57yEg==
X-Google-Smtp-Source: AGRyM1uG/ok2m2oUO2WYxnvG3wzXsku8i0A3iXbzzRKcl8h9DzshoJc/DWAfa9TBBucfiIGwwuvECMdkk5ceWWjWGjA=
X-Received: by 2002:a2e:be8d:0:b0:25d:6035:ebd0 with SMTP id
 a13-20020a2ebe8d000000b0025d6035ebd0mr8580717ljr.92.1657608880218; Mon, 11
 Jul 2022 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb2d6c05e35a0d73@google.com> <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org>
In-Reply-To: <YsyMQ2jzOICVbCda@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Jul 2022 08:54:28 +0200
Message-ID: <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
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

On Mon, 11 Jul 2022 at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jul 11, 2022 at 01:38:08PM -0700, Andrew Morton wrote:
> > On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> > >
> > > 2022/07/05 05:22:17 executed programs: 828
> > > 2022/07/05 05:22:23 executed programs: 846
> > > 2022/07/05 05:22:30 executed programs: 866
> > > 2022/07/05 05:22:37 executed programs: 875
> > > BUG: memory leak
> >
> > Thanks.  Presumably due to khugepaged changes.
>
> Huh, I was expecting it to be something I'd messed up.  I've been
> looking at it today, but no luck figuring it out so far.
>
> > Can we expect a bisection search?
>
> We only have a syz reproducer so far, and if I understand correctly,
> it's probably because this is a flaky test (because it's trying to
> find something that's a race condition).
>
> I expect a bisection search to go badly wrong if this is true.

Is it possible that parts of xas are not freed on the error paths?
I don't immediately see where anything is freed on these error paths:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n681
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xarray.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n721
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/khugepaged.c?id=c1084b6c5620a743f86947caca66d90f24060f56#n1675
