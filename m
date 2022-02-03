Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CB4A7DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiBCCXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:23:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35551 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbiBCCXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:23:07 -0500
Received: by mail-il1-f198.google.com with SMTP id h8-20020a056e021b8800b002ba614f7c5dso820419ili.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 18:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iWXNcqjV+9WEs5XX+yhW5rJvRY74SPW4WH9BDVS3ajc=;
        b=Y8XvKK3I/8whLZ18Qo1s0MxnLjogLZlvAOcG5mObWnNrBV331D2n1yT+oK2GRzIKsN
         2WQ5dKzgqGp85+VLcWb3waLhVHpU9nsRxOn8w1CzpkhpRwbPiVhrkwzvYwPmK3b7QTaW
         eHqzlajRqHP30VjTu28TOTDEJyld6MQCFu2gUlH6x1NCOwH6PhgNJyzuGIFNS//BK/BQ
         t0VVM8KSpGDyCMTZ+aTEUvnEqoaiSmfrnkFrAD0aeZtISF9pUyyk1pjqXmElkBatL2RU
         F+Px1mU4EvJoykxMH1qtJQjuWMOn4gLh2fDktdOn6ZSvsUGVmGHBOVEXhEvJoAb1Nheb
         tNjw==
X-Gm-Message-State: AOAM530njFbf6CQKj+esUbKTDzTI2Wo0aAQTqvVggTNxFKv3m+NKt5ky
        rh8qiGtendjQBFL9sWDm5Xyq0j6+5dANOK4OmVEn8IvVBVZh
X-Google-Smtp-Source: ABdhPJxmD986HllkBDWd17NvypWwYJvhmSpWp2Dm6GbGriKJ6SNo3PTO5JIteeKeiumH9TUjTtJ5uoY1D4vEC9YouQ6xLo+QnkvO
MIME-Version: 1.0
X-Received: by 2002:a02:6d11:: with SMTP id m17mr16852812jac.317.1643854987198;
 Wed, 02 Feb 2022 18:23:07 -0800 (PST)
Date:   Wed, 02 Feb 2022 18:23:07 -0800
In-Reply-To: <0000000000004cede805d58728c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009303f605d713d014@google.com>
Subject: Re: [syzbot] possible deadlock in f2fs_write_checkpoint
From:   syzbot <syzbot+0b9cadf5fc45a98a5083@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae
Author: Tim Murray <timmurray@google.com>
Date:   Fri Jan 7 20:48:44 2022 +0000

    f2fs: move f2fs to use reader-unfair rwsems

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108e6078700000
start commit:   6abab1b81b65 Add linux-next specific files for 20220202
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128e6078700000
console output: https://syzkaller.appspot.com/x/log.txt?x=148e6078700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8d8750556896349
dashboard link: https://syzkaller.appspot.com/bug?extid=0b9cadf5fc45a98a5083
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12de9cb8700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11953798700000

Reported-by: syzbot+0b9cadf5fc45a98a5083@syzkaller.appspotmail.com
Fixes: e4544b63a7ee ("f2fs: move f2fs to use reader-unfair rwsems")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
