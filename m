Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066E4A6E82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiBBKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:17:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:53228 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiBBKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:17:08 -0500
Received: by mail-il1-f199.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso13729898ilu.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=T4JU1DoNJxSChrqfuHiopIuSM4M9SJ+2CDXtqoAN2Pk=;
        b=UULYZbUz3jn81EE9wjb5B7noow63dV81Hhl8gtfhD1oXpvOB7aj3FpfQthEku+L6c+
         bq4ZFDkuJpFZdcmk28/kqqjXr1q4+HWgK5w4tkAlX/Md3m12Rkz56+unXfMoF+9NzHtD
         bY/2KHVjdBT4JNTASt5m7JqFGnubJeh+8QvcONwDmWkVmNdI+oUQ8UPxvUDn7h2dFyFB
         ofWI0OyjdAMxz0Ek1P9znUjrGj3xhUEKllHqeJrJwVEa7YUTOr4+OZCFR2nwEhCkC0Eo
         Z+26fWe6iaH2+6lOPMjC7zanq++56txhFuirOCm6LSZtZZuxvBblzam2YJcaEaGkgONP
         n4XQ==
X-Gm-Message-State: AOAM531aqiwHTFkbT4YeERRkKaJ5oOxBV7rSox9e6fcmNc6NXCh0pP80
        SFsgqScAPFU+fs9bRbvgTobO1FWdUNAJhb8O4Ar1W+4IF/ZP
X-Google-Smtp-Source: ABdhPJw4KeUmCBVwdZfxRK0hXg1ocwqu6RnrmCRYKKNjNwZR7QIHqD5U3iE9JlZq3uGjGDOB4y0gjrFGMpmgO6wluB+daBCTCT/6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:: with SMTP id k1mr18620390ilu.146.1643797028546;
 Wed, 02 Feb 2022 02:17:08 -0800 (PST)
Date:   Wed, 02 Feb 2022 02:17:08 -0800
In-Reply-To: <0000000000000560cc05d4bce058@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f82ecc05d706513d@google.com>
Subject: Re: [syzbot] general protection fault in hidraw_release
From:   syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, changbin.du@intel.com,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        jikos@kernel.org, kuba@kernel.org, linux-input@vger.kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15179fa8700000
start commit:   9f7fb8de5d9b Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17179fa8700000
console output: https://syzkaller.appspot.com/x/log.txt?x=13179fa8700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c9b92aaaee24
dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fff530700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106469f0700000

Reported-by: syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
