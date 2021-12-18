Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25301479C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhLRT7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:59:21 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55197 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhLRT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:59:18 -0500
Received: by mail-io1-f71.google.com with SMTP id s8-20020a056602168800b005e96bba1363so3993594iow.21
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BYwp39HfkoKA0spS5iKDdSyw2i3LvTwEYaoIQ1fJH/I=;
        b=5t4bAQnc0iUKHpgxkMmBaFO5q4NUEStY2aOH3MLu7DqQVFuZVE+FIrJhO5zlfUOzLb
         YKB20yGVIq0RxLLo4nQ3IJRoC3uRhl2eVkytgtzzV+cHKyzEFHpqTSank7WmcRClPX/v
         HHXlyjypmIngYGUlTM7TkY2XWPSajY/wnUJp384ZS0rVDk4WOqRt9ViChmJ+aHRjults
         9Bhbk0rc8WnqVOxf2k6OhshlA/2CNCb+FTvSusfwAk1vhASlhkMjbGjMLyxLrm311TIv
         U0etd7VfNFLUvT4cLwaH50uKgGOfNn7mtFJtDpNLGI3dpYRaVDt/13DwWO62fAq8dwq6
         m3XQ==
X-Gm-Message-State: AOAM5326s8qK+/GvHc3lsZkYHSNx/TM/rsnv278GDbVo9gaJtGOZbbMo
        DoknHbieIosaxKvWS6cYr7Ys4x3/flaTby7JOGDBz1SLkWQO
X-Google-Smtp-Source: ABdhPJwtphcEpn94Y+GKY1ddbM7fL8AeKAWU5U3uy2A6xfXQnyUUGDnIRf4rsD452Bl9zZ3dM0mMHaUf7yhLWL7TBRJjz46LGT0b
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140d:: with SMTP id k13mr5342747jad.37.1639857558522;
 Sat, 18 Dec 2021 11:59:18 -0800 (PST)
Date:   Sat, 18 Dec 2021 11:59:18 -0800
In-Reply-To: <00000000000021bb9b05d14bf0c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000420dda05d37117f9@google.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
From:   syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, jiri@nvidia.com,
        kuba@kernel.org, leonro@nvidia.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 22849b5ea5952d853547cc5e0651f34a246b2a4f
Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Thu Oct 21 14:16:14 2021 +0000

    devlink: Remove not-executed trap policer notifications

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16464095b00000
start commit:   158b515f703e tun: avoid double free in tun_free_netdev
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15464095b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11464095b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ff127eb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bedb6db00000

Reported-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com
Fixes: 22849b5ea595 ("devlink: Remove not-executed trap policer notifications")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
