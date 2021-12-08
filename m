Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4527D46DE08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhLHWPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:15:44 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:33380 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLHWPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:15:42 -0500
Received: by mail-il1-f200.google.com with SMTP id w1-20020a056e021a6100b0029f42663adcso4908613ilv.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YDuFQ6emh5gUoA6TdFfIdjfCjIG5wOobAHlEcRoJOl8=;
        b=wi/TSmtSoIK73vd36bhxzAxc36UO0JhLJ7kO/ytrABm7AxJQF48Mbg83B3DdYBPvFq
         bU40hz6gP9fLDEMqXrrx1ow4cR2Fu4HCNdsETjuVBitwEMdVFS7Ct65FAkHMjO/4nWc1
         9CFlLmVwG+f/l5cRYYPar9QVmS+YpTLvZ0vdujXLSC/HiMuFZw3so/o61tZdEIajJ0sg
         qZKQdq42+q1Z6tFPVULKM1DXu6EeB8Y49vnaw2qDTty41rC4oy+RYNCspupzVbPevLHT
         n5OpKWYsnJ5/LXcTzNm3o7iFTjkKQO2xzi+5nLBvg4sHa+q5HbjFSYPHj4DLBs4YlIwv
         RRkA==
X-Gm-Message-State: AOAM531gWnASiu6e4EX76g5Z8vT0gvFYyezYJdlzyOQLsLkcQgFg5FXP
        oduHL8ozjPCr2BzvH3Daw+qGz6dlWWp8GnSul1KCa9cXbhol
X-Google-Smtp-Source: ABdhPJzDOMT8txQxYMhtFkPjs0jYJ8eGusGov8KXPtu3gDsFT0eObG9rdXmU3Y/TVBdj4zBJS2NgvnKjeItwx1YMxCue6BjKIzJ3
MIME-Version: 1.0
X-Received: by 2002:a02:9f15:: with SMTP id z21mr3393897jal.137.1639001529964;
 Wed, 08 Dec 2021 14:12:09 -0800 (PST)
Date:   Wed, 08 Dec 2021 14:12:09 -0800
In-Reply-To: <000000000000e016c205d1025f4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fadd4905d2a9c7e8@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic (2)
From:   syzbot <syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, clm@fb.com,
        dsterba@suse.com, fgheet255t@gmail.com, io-uring@vger.kernel.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 741ec653ab58f5f263f2b6df38157997661c7a50
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon Sep 27 07:22:01 2021 +0000

    btrfs: subpage: make end_compressed_bio_writeback() compatible

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103f2ae5b00000
start commit:   cd8c917a56f2 Makefile: Do not quote value for CONFIG_CC_IM..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123f2ae5b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=143f2ae5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5247c9e141823545
dashboard link: https://syzkaller.appspot.com/bug?extid=21e6887c0be14181206d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1218dce1b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f91d89b00000

Reported-by: syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com
Fixes: 741ec653ab58 ("btrfs: subpage: make end_compressed_bio_writeback() compatible")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
