Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7552A550827
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiFSDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiFSDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:47:10 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57DFD2B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:47:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s6-20020a056e021a0600b002d8fcba296aso1440556ild.20
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WXySugZ8bUiz8VWb5l+slcpwKki8VnN88v/Exthe2M8=;
        b=ClB9cRDqHfKTvylzNj3sdrQlhHJU3LIwgzQv+DBDYOScc0LX6p6oMwVIIasfrL+Oqt
         MKvNL9rlK+UEO+5tlYCrKQqEgJzEV3L1W+uKf27XNO2FZrKdpGALHbsk+sMp7pYXZc8O
         +FRBqVw8G3KAMk1ExVUu0AIwcYVX/UOB2E3t27Rrfr6KCPPPsHDkR+zEAvtDeQFZSize
         3ld5t5GaRXZQcojWsrqcZSgFKgWUInIXuJLdss5qnlUfUVx4r1DT1kldrguy9ogky1Ll
         fRgvRHC5i7ACRJzRoXUa4pKPPEz3Un/ckFje+xf1MTdjFDeXOYFwzZ1Tn1aMJmwBKiI6
         CVbA==
X-Gm-Message-State: AJIora+ZBK6gbmzTWNIZKrm77DwV8TZSG0VzG/AZO8DfSZ5FscQ0O1a+
        XPcETIWShKP2aICVyQNADfan/tc7Hv3DiE7pUT9WIKR3GRbi
X-Google-Smtp-Source: AGRyM1t+Vl2HiKNCL/Jahe4Vlo8/OPk3csvuXoOU/rlUZehfYW5eNneB/So0j7A31bDK+uZvv0nYPoG1WLJbsfgPgSJLHUtGPS5i
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198c:b0:2d8:e8bd:d8ff with SMTP id
 g12-20020a056e02198c00b002d8e8bdd8ffmr5413244ilf.66.1655610427936; Sat, 18
 Jun 2022 20:47:07 -0700 (PDT)
Date:   Sat, 18 Jun 2022 20:47:07 -0700
In-Reply-To: <0000000000007ba8cd05d0c1c3b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071951f05e1c4d7c8@google.com>
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
From:   syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit faebd693c59387b7b765fab64b543855e15a91b4
Author: John Ogness <john.ogness@linutronix.de>
Date:   Thu Apr 21 21:22:36 2022 +0000

    printk: rename cpulock functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d0607bf00000
start commit:   bc403203d65a Merge tag 'powerpc-5.18-5' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c08966f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108132e9f00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: printk: rename cpulock functions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
