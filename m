Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFB472167
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhLMHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLMHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:13:52 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F8C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:13:52 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q25so22138830oiw.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZDrFI40TasCaA3T259Y8DtL1KA2JHEBHErIBYdLfgc=;
        b=ivezv/lbEVj0cCxUVdsFQzPqUsVRx2/UDOsDWk9pXilcFeoFjyZAjXQfskAHbxaLY0
         bueOjD1Pm3btHZEEwGO/kXiPUpVd4X7Gn7v+9FJTyTD3jmCzvfBGlp+p5FsVL7ujUVcb
         mplTEU2PHcqGOlbwepCBmXIA5GXO3NAHpMi+6/C13cVETMlC/GdNb8e8qfq9xDjiA5/k
         rrbtJlnRrjBAzNuMxW1Tyin7p54oTs+GEGeDNMljh4cXVGgFxc9BUhzPZx29whwPV60q
         LgQ03j6zleXY9PfwqA3LT9umhPbw2TjHeqdK7Sm+EitgvKMQ7ul1JVF14b0o6sNBlCZy
         E3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZDrFI40TasCaA3T259Y8DtL1KA2JHEBHErIBYdLfgc=;
        b=7Vza6L87whc0VEzkvTitxzKXTXYEK5MQuHfdSUbLv61WBeqlOxDt7P/5+fmvL7UfaA
         3ucLlPLdPxiKwE8HBYVkPo+9jBzmnk9pVJ+gPK+wUOvFtI5WNVIYUxvjK6TtoV7z2n5N
         9xC+WWrQSmpMREfRXwvcFaDQNUQMO2IP2YDIH+6UDymRUPTniNxGrbwoSbbqC6/ey8gQ
         bhjeVPBLDcdqwmFIyOhHFKXH53VDW52j2YnT3v2u9EFOr74xzKSAB8kgEHVuwubDt56x
         gKSjt6m3YQuYImF117r9oRJRk1+5LtRsC3pVL+x1Lv5e9NBfPLScZyMSTc6Fac6G8rj8
         Scig==
X-Gm-Message-State: AOAM533wUcvtbBsV7xg8NS8tCTzqfXn1/9RFE5qqXo0kEWKqte/aW3nw
        jl5mHwlWmOu8BSLRiW4uiI8VmfJPM7ejoI/Gf+TxMg==
X-Google-Smtp-Source: ABdhPJy+Hs5ALSSk6qQuXMMMbTYpMozvcw2ALxfo+Jw5wrLrANfoyIS5pk1E//OfTGqGvAafwvqe7pbA5uEpOncRr/I=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr25973725oiv.160.1639379631162;
 Sun, 12 Dec 2021 23:13:51 -0800 (PST)
MIME-Version: 1.0
References: <00000000000047627e05b17a6ec9@google.com> <000000000000b17d0105d2e80b47@google.com>
In-Reply-To: <000000000000b17d0105d2e80b47@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 Dec 2021 08:13:40 +0100
Message-ID: <CACT4Y+aPDpuxY7Hqg7a=bawDqR5EgdnxMV3q9Lk2qiDR7YSeqw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in scsi_queue_rq
To:     syzbot <syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com>
Cc:     anmol.karan123@gmail.com, capitolscan@capitolsecuritypr.com,
        hare@suse.de, hch@lst.de, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 at 01:29, syzbot
<syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 20aaef52eb08f1d987d46ad26edb8f142f74d83a
> Author: Tadeusz Struk <tadeusz.struk@linaro.org>
> Date:   Wed Nov 3 17:06:58 2021 +0000
>
>     scsi: scsi_ioctl: Validate command size
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11db6f3ab00000
> start commit:   ec681c53f8d2 Merge tag 'net-5.15-rc6' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=0796b72dc61f223d8cc5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1279df24b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a855f4b00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: scsi: scsi_ioctl: Validate command size
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks legit:

#syz fix: scsi: scsi_ioctl: Validate command size
