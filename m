Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5819746CCCB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhLHFHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:07:44 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:37823 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhLHFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:07:43 -0500
Received: by mail-il1-f200.google.com with SMTP id d2-20020a056e02214200b0029e6bb73635so1442240ilv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tnvEcnHI7deEWxbqkKI/fN2Wn+QIAlfc8X3oFKTEmqY=;
        b=rCt1v9L4YHWZnhBswDYQZPMFyADNmTkpppnJj7ut/U8O5qLpBAtuYNQf71lT8vx40/
         loNlJ34DGhWwswzswrpF6t5Cm27RFJYwkCFdl4EzCWecVLpdZAD5/OolZ2n0f75ijLq5
         TppV40q02nC+xfo1LUOHbSVLsMUNe+BLlDdPmfoIeVgVDUqmg1/MhEtt+L5HFd4GZKGi
         +RF/EnzxfeujAMqXmBgc11Wx+dHnw0D6WwsNE81hlqYiUdFvQKVEOctkqa+7eUTHmlvZ
         DZRrjCY/2rvqAAppNJJ4YDYp58XHRMK0QlfEv/jwxwBqpjrXY8PSIH984Fd7Dm/h4XtO
         P20Q==
X-Gm-Message-State: AOAM5332jPUbDAXlNHrC701LMGEby47EckAL4PzHO/JYuIFU3mr9NSDq
        GKDhn1bag1tuLZoARXAT+VArrT6qWQyMox8K/4c6NTq7e6Tq
X-Google-Smtp-Source: ABdhPJwm0RWykDAPtEx8UlrJfAiQzKFk5qK0UkARc6aPbXgU5gciPJ8DsiwY9aXoIJsshTCDAJiywzLcKqgahKGSviNBMVtm5Mh8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr3885081ilk.89.1638939851818;
 Tue, 07 Dec 2021 21:04:11 -0800 (PST)
Date:   Tue, 07 Dec 2021 21:04:11 -0800
In-Reply-To: <0000000000007de81505cfea992f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0e4105d29b6b0f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in io_submit_one
From:   syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, bcrl@kvack.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 54a88eb838d37af930c9f19e1930a4fba6789cb5
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Oct 23 16:21:32 2021 +0000

    block: add single bio async direct IO helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1615e2b9b00000
start commit:   04fe99a8d936 Add linux-next specific files for 20211207
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1515e2b9b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1115e2b9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db884db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e9eabdb00000

Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com
Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
