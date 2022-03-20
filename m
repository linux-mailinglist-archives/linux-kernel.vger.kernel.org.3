Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F884E199D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiCTEVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiCTEVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:21:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A535213503
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:19:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so24012244ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThmAHSwk/7ko3WSXWM03wBAJ2ziyTZM2hGOwlAVmV3E=;
        b=CUhqyE9RpibP0n/dCIwaRSyBSGxH9Lqdejw1SUhMkc1SpTCwph02RbPrQ+I/2cevwS
         9FFFQFqonBAlGnCFuvj2d4DTtfkzTmn3viGjrimp2EZxxg5hybnRZlw0I3rxs5XkLg4b
         JJ6f6Hu5gEeVRMZcvfZbl5cLzkQYtb8UtlsbgdAslYKufXCmaVmIM3jr6PaOip3n9KZX
         NctGeAfFZPNCfSIvPqfbiIBf9CIJntnWG0ZjTbRCa/RZxVuYS7Pe8d+KCg1iQt19N3vk
         KajWfWfdPIYGM4FWjZNGoB/b+NNmJJvCSnwtCYjsC+4rYTyZynPmpXhV7S/Ogbh7/6Do
         VO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThmAHSwk/7ko3WSXWM03wBAJ2ziyTZM2hGOwlAVmV3E=;
        b=GNyZTZlgda9MXQyQ+hDBj62h77wtsTFKOzS+SslfNL51d56QToYNUNXYSba/aZMNdI
         +s6VZalq/c0L17f9VNSBjIWMXUg41DWwv5dc8HcmKEW6Gxg5aIwrzol0KYVvHcavPdd1
         IUFkoQAAs64PcH1wMux/5bXpFouJ1ZJdneKf9JUc7xm8nviCx6FGpgzxlqprgY0+dJIP
         PHo0M9ES8v1CD6Pe5o+oMslRtCke55DMIgZftwfiLJCg7ieFixUtRIBxlHUr2OOWEM/Z
         KrQ3+OqZtJW4DgQA4u3saf2itESQIn5obGN/9UT2y/74+2uYpcYnrS/rx85vsEslAa5o
         xHDg==
X-Gm-Message-State: AOAM531AGF7wNYncAr3rXPRlew9iPI8B+5gba5nCTUhEP3uYZihcmg3D
        hZVPatO/xZDGFTSag1MmnrtKddYk8FsR9ruGWjy1riok
X-Google-Smtp-Source: ABdhPJziOumFLAwYEoKfif2LckyWSl5LuX77kfLGW4pbcJ62NovQKgrhjk+uXemaFXZ4hWB75vvKgdoXJnsEAO+cpdY=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr15910082eje.753.1647749981806; Sat, 19
 Mar 2022 21:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com> <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
In-Reply-To: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sun, 20 Mar 2022 12:19:15 +0800
Message-ID: <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Mar 19, 2022 at 6:33 AM syzbot
> <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > Author: Muchun Song <songmuchun@bytedance.com>
> > Date:   Thu Mar 3 01:15:36 2022 +0000
> >
> >     mm: list_lru: allocate list_lru_one only when needed
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> >
> > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
>
> Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> should be the commit 2768c206f2c3?  What am I missing here?

Sometimes syzkaller bisection may make mistakes. Please ignore it.

>
> [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
>
> Thanks.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAMZfGtWL-2%2Ben7%3DFKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ%40mail.gmail.com.
