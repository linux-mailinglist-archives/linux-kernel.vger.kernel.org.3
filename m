Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E54683BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384535AbhLDJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbhLDJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:51:41 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93FC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:48:15 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bk14so10910365oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOAkXZDiyTsKYfGEC23YRLp6n8iiidS662e1ynxgsxA=;
        b=WNErxpaJ0vt9GBbdqCxCm7NrYJDMBAl8LPN1SiLwt3loHe/k206b12pHYF3Yx/xmEg
         pLJcdL9Xch8oLQXlTwN35R2wEE0Ko/K28/LeEyS3cMg4VdHEsYEEn5PCot9EdNmYdc55
         C4cSFD9Qqdj6zuZXFkxqQsivgdk+Z2YRI650E53U5DqSv5aCklUh6UCyR0WA7TsD8GJi
         eQ5M9p4tMrbWcVZXmYdROE7HOTUWc+v6YtF2HwXKraubXnyR2Mt3D+fxwXwWy3hNe1T1
         vinQjMCt9bkRCl3OpwbZctWQZG1cVCj20qb4CMg37elx1ZlQ3uWo+cQXAyDkFZSG1+3D
         Fhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOAkXZDiyTsKYfGEC23YRLp6n8iiidS662e1ynxgsxA=;
        b=aHvv5GxRtBZmHHHfrUIeygVxRhevEv9tCUmcm+DBSI5efFVdV8Aq+9R0lr0m8gh2BP
         Z5bqgrztMBTJMxJWmaq3gFJDHnKunEBZq+fIjid6vqJ5hsy0ucZAQKW/8YpWR/tOVy/N
         jgbobWzUeRao8+ojUqOr9OmGft+xlH0B/LFkTQ6DV27rjpchd/1KuWq7z2VgB6/hFlq1
         rT2MDUHDS6oHkR5tnhmoqtLRouSvH71bbkJdqYK3B6NbtR2rMnFvqgTNYyGuQ7wRmAwS
         0/xSONtLFHKD2QdJyzruGNdFCmdTAYTKMG/CLzzrSS36XShVcb6yKy1eptxZcSfJ2GhE
         aGLw==
X-Gm-Message-State: AOAM5332sbCGqtocqXggi2G9LPcUzGK2/tgpMoJTOlH9jjKZ6f6D00lC
        v1U0xlwxhiissS53Smo5lIznI2bK8My1WH5Hu4YH6g==
X-Google-Smtp-Source: ABdhPJxKiMFgxJ5zcd3V9wHDP+cMEBZxSFcKc2VU3eqKSIdvXpYm+andMC88m4jlKzdjIBB7Rx1ycGPNnDJpKj4FBu8=
X-Received: by 2002:aca:b843:: with SMTP id i64mr14560842oif.109.1638611294801;
 Sat, 04 Dec 2021 01:48:14 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000a389a05ac5a9864@google.com> <00000000000091c45705d1b3d7ea@google.com>
In-Reply-To: <00000000000091c45705d1b3d7ea@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 4 Dec 2021 10:48:03 +0100
Message-ID: <CACT4Y+YQC1eFH9BsrPnRaGW_H+_jzpELWuiBa9n+paB7-3k4HA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in l2cap_chan_put
To:     syzbot <syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com>
Cc:     anant.thazhemadam@gmail.com, bobo.shaobowang@huawei.com,
        cobranza@ingcoecuador.com, davem@davemloft.net, ducheng2@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 at 17:47, syzbot
<syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
> Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Date:   Wed Sep 1 00:35:37 2021 +0000
>
>     Bluetooth: fix use-after-free error in lock_sock_nested()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141cfa45b00000
> start commit:   c70672d8d316 Merge tag 's390-5.9-5' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
> dashboard link: https://syzkaller.appspot.com/bug?extid=452e9465a3b2817fa4c2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f31f9900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()
