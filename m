Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2847014C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhLJNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:12:56 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:53057 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbhLJNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:12:56 -0500
Received: by mail-io1-f72.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so10124719iov.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q9dao8PkNdrzaMik8Bp0sVf8aqOYgnuPkHzFSkHqjeo=;
        b=1mXzCUXTGi9d7nIFOeXNqj/8KfPwGEYVhU2QYvjqjlRn83M6/sEaAmDtD5+LSNokwA
         Zfz3S3SIlTMIJjVwWGSohY/rBAvxIJD3Is4wzzD/IDCJtK41pOmd/X33u3ILmYydrNBT
         ux4DD7lsNlpQ/zkHFRZlXONfCsk6ho6f1CEL9NN89ZOAnOfRJIBgp8qwSTw1mUVQOvVl
         q/Nf8iwXlV4Iiw4xHF/tkizzxYXa3l4ZoQE4cSWfCqTTUtT7EF0T6zCwWh5sU2XuYy2v
         +p+S13Z9B03VXuu9lC1CV7oTurG59DNAv2nLlQyQ2GjtAh6a5om1YcTdGaZEKPkvTILh
         SAIQ==
X-Gm-Message-State: AOAM533UcL09x5Za+9D5boK4IcqIOG6vV8hltPboNMKRz6epTfeLZ7/5
        gKWddzQpKK2RGzGFRruLYVFK+c41KROU6Y7NWc7+7eAjLas5
X-Google-Smtp-Source: ABdhPJx44lNFRF0CBDtsQ1nIykpINcfQGzbONln81/iDbRan8DAmUslhvHSx2Jl7+1dw9URlen5rD0yN0+oluhbJP5FDjcHtNa5L
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4091:: with SMTP id m17mr17155971jam.41.1639141760935;
 Fri, 10 Dec 2021 05:09:20 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:09:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065abfe05d2ca6ea0@google.com>
Subject: [syzbot] KMSAN: uninit-value in _ieee802_11_parse_elems_crc
From:   syzbot <syzbot+59bdff68edce82e393b6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    093998ececa3 [PATCH net] tcp: fix another uninit-value (sk..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=110b5395b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=59bdff68edce82e393b6
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59bdff68edce82e393b6@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_parse_extension_element net/mac80211/util.c:948 [inline]
BUG: KMSAN: uninit-value in _ieee802_11_parse_elems_crc+0x3448/0x4310 net/mac80211/util.c:1348
 ieee80211_parse_extension_element net/mac80211/util.c:948 [inline]
 _ieee802_11_parse_elems_crc+0x3448/0x4310 net/mac80211/util.c:1348
 ieee802_11_parse_elems_crc+0x17e3/0x1e30 net/mac80211/util.c:1490
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2208 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1605 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x7e5/0x4350 net/mac80211/ibss.c:1639
 ieee80211_iface_process_skb net/mac80211/iface.c:1468 [inline]
 ieee80211_iface_work+0xeda/0x1990 net/mac80211/iface.c:1522
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 __kmalloc_node_track_caller+0xe0c/0x1510 mm/slub.c:4974
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0x545/0xf90 net/core/skbuff.c:426
 skb_copy+0x191/0xb90 net/core/skbuff.c:1586
 mac80211_hwsim_tx_frame_no_nl+0x1fcf/0x2c00 drivers/net/wireless/mac80211_hwsim.c:1565
 mac80211_hwsim_tx+0x10d3/0x1760 drivers/net/wireless/mac80211_hwsim.c:1669
 drv_tx net/mac80211/driver-ops.h:35 [inline]
 ieee80211_tx_frags+0x7bf/0x1250 net/mac80211/tx.c:1714
 __ieee80211_tx+0x5a8/0x7d0 net/mac80211/tx.c:1768
 ieee80211_tx+0x776/0x790 net/mac80211/tx.c:1948
 ieee80211_xmit+0x849/0x890 net/mac80211/tx.c:2040
 __ieee80211_tx_skb_tid_band+0x297/0x3a0 net/mac80211/tx.c:5701
 ieee80211_tx_skb_tid net/mac80211/ieee80211_i.h:2186 [inline]
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2195 [inline]
 ieee80211_mgmt_tx+0x1721/0x1d00 net/mac80211/offchannel.c:927
 rdev_mgmt_tx+0x117/0x4e0 net/wireless/rdev-ops.h:742
 cfg80211_mlme_mgmt_tx+0x910/0x1330 net/wireless/mlme.c:759
 nl80211_tx_mgmt+0x112a/0x1870 net/wireless/nl80211.c:11708
 genl_family_rcv_msg_doit net/netlink/genetlink.c:731 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x157f/0x1660 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x447/0x800 net/netlink/af_netlink.c:2491
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x1095/0x1360 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x16f3/0x1870 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg net/socket.c:724 [inline]
 ____sys_sendmsg+0xe11/0x12c0 net/socket.c:2409
 ___sys_sendmsg net/socket.c:2463 [inline]
 __sys_sendmsg+0x4a5/0x640 net/socket.c:2492
 __do_sys_sendmsg net/socket.c:2501 [inline]
 __se_sys_sendmsg net/socket.c:2499 [inline]
 __x64_sys_sendmsg+0xe2/0x120 net/socket.c:2499
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
