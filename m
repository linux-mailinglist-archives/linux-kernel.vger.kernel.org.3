Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6646947BDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhLUJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:52:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55897 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLUJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:52:09 -0500
Received: by mail-io1-f70.google.com with SMTP id y74-20020a6bc84d000000b005e700290338so8755713iof.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gtMOeWgOjqpxf3UJsdLLfE47QPkTrgfO0H8YEz5DRG8=;
        b=SpCxQoR2eDV8rvLlp8qZHG+udgP3brxqz3JHiZNrz0h3B3u9OUONDaULvX7RVkjJP7
         /5SfouRu99t33DQOxNV7jmxBbuQ1pbuuZCcBgyJq4REob6mUxLZK6mA8jQLytrKLw2UY
         ppgZWEdiAHb8NBmRyEDB0/YEbRxNHX60NuIvtx7qS3nfufumobg8vjwWyN2XQv1cht2s
         X1ftejDDxkXws2ezdNfl1UHc8wpRzMPOWNph6JDRDsnfdQ8f7S/eA/5Ddwtx0dwt5Z0e
         V2zk+2Q1Zf/i0X+lyP27m95RtCi8QBGj5Hdy3FjSqfAjOfz+VYYsy2E9GU2KZ9a14pog
         88Bg==
X-Gm-Message-State: AOAM530qy5eQyxMw96J4ziLgUyCzroV8qrSFrUaUiyhIqZvA4VrVSi9P
        9EiTPdCuqe8w71qhezrAGMovgtXgd++74RpV2UYTYyL6FtVW
X-Google-Smtp-Source: ABdhPJx6QiXqNu7Hfc+O/DrzAKwtgSlzMWab3H3rNwlyXnrdxwZcfwS7rfCEn4d1tGHD0uzTYSEiyrI+miyx42y9AEkxASphiUL7
MIME-Version: 1.0
X-Received: by 2002:a6b:a10:: with SMTP id z16mr1105244ioi.204.1640080328753;
 Tue, 21 Dec 2021 01:52:08 -0800 (PST)
Date:   Tue, 21 Dec 2021 01:52:08 -0800
In-Reply-To: <000000000000c70eef05d39f42a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066073805d3a4f598@google.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
From:   syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, changbin.du@intel.com,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        kuba@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e4b8954074f6d0db01c8c97d338a67f9389c042f
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 7 01:30:37 2021 +0000

    netlink: add net device refcount tracker to struct ethnl_req_info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10620fcdb00000
start commit:   07f8c60fe60f Add linux-next specific files for 20211220
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12620fcdb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14620fcdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2060504830b9124a
dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12058fcbb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141adbb00000

Reported-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
