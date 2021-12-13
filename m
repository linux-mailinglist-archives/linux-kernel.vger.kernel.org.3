Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8C471F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhLMCqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:46:11 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53030 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhLMCqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:46:09 -0500
Received: by mail-io1-f70.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so14340573iov.19
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 18:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2NuGDG85AfS9y7yRsPV78T4aS8gdf/qTEMMTGPv30Uo=;
        b=YZRyA2Qwo76RfOEdwR9FLiBHw7oUeOQtOv0+d01F33qS3/j/OgHsDj38IsTywTCE99
         Bm7Nu9Q4vNcDwmZ+2uEXWxdMbN+SmOBeKY97+Pi03ehJ0e4JOBrCgh466Qg8XywihqTB
         5KtJ1YevnhHiQv8iB9acKJ6HurMGWP9AB4hiplB0HzQqPKHKH4kAHjpKwFwae8X1aOWV
         rAjonkAuNajHAfvszRqn5pNlV5/1UpT2G9jPPn0XMqfzrocvYnDwIRZIyFgfVRYbuIcX
         pX5AdLyAqdGxZEiJBaH7W5Paw1cI12wdH15AMNtQ4N13He7KQbM6Cr9dSFU7A4WMMyAv
         R7ww==
X-Gm-Message-State: AOAM5306OsqmwxaXFvNhhhcRb2QY7SWJx0wBWWYJVWjPMc57+AHbXzZK
        1jnIu1lC6vWTSZtdPjaoQbrWiLlgm0rjPl7a05EAjE3fiUFW
X-Google-Smtp-Source: ABdhPJxmIIniwyRI+oGKfh384pqZnwOTrq/uMCOdu+0TQNm3dbrB4E/IT0pkWUrcZ6DzAviv5fB5LypbSmb2oXE+b+tp75tbjAS/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:: with SMTP id f10mr29103329ilu.281.1639363568731;
 Sun, 12 Dec 2021 18:46:08 -0800 (PST)
Date:   Sun, 12 Dec 2021 18:46:08 -0800
In-Reply-To: <00000000000033acbf05d1a969aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c0bbf05d2fe1382@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in bpf
From:   syzbot <syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jiri@nvidia.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 22849b5ea5952d853547cc5e0651f34a246b2a4f
Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Thu Oct 21 14:16:14 2021 +0000

    devlink: Remove not-executed trap policer notifications

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1465b449b00000
start commit:   ee60e626d536 netdevsim: don't overwrite read only ethtool ..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1665b449b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1265b449b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=cecf5b7071a0dfb76530
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a14b55b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13375f75b00000

Reported-by: syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com
Fixes: 22849b5ea595 ("devlink: Remove not-executed trap policer notifications")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
