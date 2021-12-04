Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5015B4683F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbhLDKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbhLDKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:23:01 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DDC061359
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:19:36 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so2853942oof.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUBxI6UjSH7mOTHyHCii08lOt35WlhuPwpHtCxGOpIM=;
        b=JcFz0uAn6z1BVaVAU+OkeYsIDQPsQqJqoJoFKp3g6uAVA/A84+FkF9SetrQkp4mJYM
         B1Hy54zZGMuCX6D6Z17g+EuUIzbeBsvdLOACzNtyEkIIXRGJYZ527kBWHdjBqZx5o4+g
         fMbe+xNpft4zrX6/5uMreZ0JiMg50omlcPQqDoLKusegh/7Z+inEo33l4LYT482FWdNb
         /j5ZA4xkYy1FPhVKRoBMrMN5gSclBnmtmtDkL5VMI9YmcOol/maEJN39ZonFYQ/EJD2x
         KawFs8/p6gzVTndoXsak5CfyU96l6d3RvaUqlFO4Cj2yDF+Yvqrs0hMWYCH6RWe52dJq
         Botw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUBxI6UjSH7mOTHyHCii08lOt35WlhuPwpHtCxGOpIM=;
        b=Q//97uoQuwnbeXWw4C2Zc1LVWPbBUudQrRf4i3W0GjOiMZbw50FvA/vBO3XGj99noN
         ejMjQW0mnXcqjeFhn7v1W7QiK+6qCvfLW4uQuIVxvLzuL3FL30broEh4MsK6DdG6V6TK
         SJcdVFg9wMj8uOg17TEAoVTOlEjhc4nizeeE/hjZxjQsDI6VxFhjJ9wEK5hA07P0MJEB
         2uIhHHEsjZKUkAsppTPvLbZ4I7qpdmIOV7ED1tUzwu5mvC2eE5jyyIRp+t/u/RPOjLS2
         Czu0feGmwDUehaK5eRK3xYcP9xssLKWH5BAQukOOIGYnn4014hnv0BLn2Fx92nl8Y/nG
         5T8w==
X-Gm-Message-State: AOAM5335juRbYZYPNvxzlMLFLtZdljTKwzW9ESiG6dEObWjd/+262ETS
        oLFgxD7cTDm2POvuN2VZX27qt7iiteJMxJQv3RBjrA==
X-Google-Smtp-Source: ABdhPJybkWfJfZCDkFBH5uXogkxvqt3rVv+MgfzBTH16slbKtn5ifaxol5h7rXJ+pKqtqLGkaKeFUZQJZW0KPHV7pSU=
X-Received: by 2002:a4a:d319:: with SMTP id g25mr16246239oos.21.1638613175445;
 Sat, 04 Dec 2021 02:19:35 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bd9ee505b01f60e2@google.com> <00000000000002e72b05cfdeee4d@google.com>
In-Reply-To: <00000000000002e72b05cfdeee4d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 4 Dec 2021 11:19:24 +0100
Message-ID: <CACT4Y+YbOGFpwtMXSifaiCUroB8ZGsyVJecRTB1OSjLH682+Ag@mail.gmail.com>
Subject: Re: [syzbot] WARNING in hrtimer_forward
To:     syzbot <syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, hchunhui@mail.ustc.edu.cn, hdanton@sina.com,
        ja@ssi.bg, jmorris@namei.org, johannes.berg@intel.com,
        johannes@sipsolutions.net, kaber@trash.net, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 at 10:21, syzbot
<syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 313bbd1990b6ddfdaa7da098d0c56b098a833572
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Sep 15 09:29:37 2021 +0000
>
>     mac80211-hwsim: fix late beacon hrtimer handling
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108b5712b00000
> start commit:   ba5f4cfeac77 bpf: Add comment to document BTF type PTR_TO_..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d44e1360b76d34dc
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca740b95a16399ceb9a5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1148fe4b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f5218d900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: mac80211-hwsim: fix late beacon hrtimer handling
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks legit:

#syz fix: mac80211-hwsim: fix late beacon hrtimer handling
