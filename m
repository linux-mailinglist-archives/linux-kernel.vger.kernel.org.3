Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B05275DD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiEOFYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiEOFYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 01:24:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A381F620
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 22:24:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d7-20020a0566022d4700b0065aa0c91f27so8058982iow.14
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 22:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=80ZXYlQ6dS5CtsXTKCFFO9+wbjw6aSUhy8TuWocJ2ME=;
        b=LnnTkdEAbPT+fikPlBrpRdY17RIjWHG2rt4P1JFMvckpTCoqggzGOaB40WYAL0umHi
         NqPbobnTWCZFxBjXHKIxOAjvM13YrqIuNImQeOBs417xfTbL1/FR/fwLD4ZmOp5V85bd
         IjjSsT44lODQzJ0EO0iXjtjY4slHdCwEMsl2NDu6PBWBUHI27zlxq3/JwZK6Amov8J/q
         VIPJKqc6sO80BDid9nI9wKIntdYJ+N9/8+TN2rLus/lntS1jJDog5xkqkCOeDucozg5a
         xJqSBL6ASOAW4KVqr7Lnqaxorr7/3One9kfHx8i2DeZl7R2pPXy1cyP5IReDAwXR4VtB
         vc1A==
X-Gm-Message-State: AOAM530WlnTTwb8ib2q+N4snI2Mcc8C6jL8yH+XhLXX/Ee8+QSZ0WEuw
        1gPTyQyalBvNTQKFgzGj6kBvyfXVC7PAHq687byk9L3PVw8Z
X-Google-Smtp-Source: ABdhPJzwbHwZn26BdK/dmPXeyfn4Uvqg2YXdHFF02wrnO1vSd6zUWch0Kk8PMSXcLwgMmqq0fdCJNCP/pbh2OmQlS/HH3N8hMTRA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2042:b0:32b:c513:21b2 with SMTP id
 t2-20020a056638204200b0032bc51321b2mr6136562jaj.90.1652592250055; Sat, 14 May
 2022 22:24:10 -0700 (PDT)
Date:   Sat, 14 May 2022 22:24:10 -0700
In-Reply-To: <20220515045838.1591-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f0b905df061e1e@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in l2cap_chan_hold
From:   syzbot <syzbot+fd86a41b17a416a37a75@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in l2cap_chan_hold

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 3 PID: 3688 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Modules linked in:
CPU: 3 PID: 3688 Comm: kworker/u19:2 Not tainted 5.18.0-rc6-syzkaller-00007-g9be9ed2612b5-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 09 31 ff 89 de e8 97 44 81 fd 84 db 0f 85 36 ff ff ff e8 aa 40 81 fd 48 c7 c7 80 61 26 8a c6 05 0f 00 ad 09 01 e8 e7 f5 30 05 <0f> 0b e9 17 ff ff ff e8 8b 40 81 fd 0f b6 1d f4 ff ac 09 31 ff 89
RSP: 0018:ffffc90002ef7960 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888021eb8080 RSI: ffffffff815f4a18 RDI: fffff520005def1e
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ef3ee R11: 0000000000000000 R12: ffff888022671000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555842708 CR3: 0000000019825000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 kref_get include/linux/kref.h:45 [inline]
 l2cap_chan_hold+0xff/0x120 net/bluetooth/l2cap_core.c:497
 l2cap_global_chan_by_psm+0x3b1/0x4a0 net/bluetooth/l2cap_core.c:1986
 l2cap_conless_channel net/bluetooth/l2cap_core.c:7611 [inline]
 l2cap_recv_frame+0x68d/0x8e60 net/bluetooth/l2cap_core.c:7681
 l2cap_recv_acldata+0xa96/0xc10 net/bluetooth/l2cap_core.c:8394
 hci_acldata_packet net/bluetooth/hci_core.c:3633 [inline]
 hci_rx_work+0x4d5/0xd60 net/bluetooth/hci_core.c:3824
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


Tested on:

commit:         9be9ed26 Merge tag 'platform-drivers-x86-v5.18-4' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1449db8ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe599903e2c6b6
dashboard link: https://syzkaller.appspot.com/bug?extid=fd86a41b17a416a37a75
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159a21f1f00000

