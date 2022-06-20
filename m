Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAC5516E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiFTLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbiFTLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:10:16 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3C15822
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:10:10 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id l3-20020a056e021aa300b002d9094fb397so2275250ilv.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L0CA2MlhQtK4QPyPo58hRkJeBmVI86UDYe2VvyBU06Q=;
        b=e8BDxA5LsYAv+x1PC2N9cOyK6sEPWCCDugTOhmzyk5FifnkPv/jKnH0W+GGN2tJ0I1
         /H/dOm4hnNTkTeuAmC1J6w2W+1+VUqOniq7NIqhdW+FbHqq9MF7QjtcsIMMl75yFESCF
         FC6w06Jl8qaeBpN3mBW5vutRps9sIdK1GOvC7KDkiVl9hkqShixXN6y9RZVfKKPWjXNS
         NekpJ2v+sTj8ICAFplYMxyCJ0sEJ/V2yP3vbCMOupQxbqPjXheZd2XugNZ8U18F7zP2S
         vCAeDi3RCq+oUPa9EpLDUzRQLHUbDbiPfVPOySt3cRZpwGhAa1do6T7RnzcSGiTGSpL4
         hnjg==
X-Gm-Message-State: AJIora9dySQYTsNEBUJR/AhfGYhaedhMygiXn5XlYsqiUyI2I9QSGpGp
        KYHdQiKJpr1CfAPUI7oqBIHnHdzCR7C0T7SHRRzB3OScLU7t
X-Google-Smtp-Source: AGRyM1t3Qv1qIqXMTM3FbSGIAXCdjUmf3YlJqyUoTT9et2ae0H6zlkw2h8JP7uEmoci29o7QjzdAQ0dHnL5UJYoU0JUkQlBS59am
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:2d3:ff91:12a3 with SMTP id
 u4-20020a056e021a4400b002d3ff9112a3mr13480154ilv.82.1655723409647; Mon, 20
 Jun 2022 04:10:09 -0700 (PDT)
Date:   Mon, 20 Jun 2022 04:10:09 -0700
In-Reply-To: <20220620104728.501-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adb35405e1df2545@google.com>
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
From:   syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
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
UBSAN: object-size-mismatch in wg_xmit

IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
================================================================================
UBSAN: object-size-mismatch in ./include/linux/skbuff.h:2085:28
member access within address ffffc9000278f420 with insufficient space
for an object of type 'struct sk_buff'
CPU: 1 PID: 3626 Comm: kworker/1:6 Not tainted 5.16.0-rc4-syzkaller-00161-gc741e49150db-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 handle_object_size_mismatch lib/ubsan.c:232 [inline]
 ubsan_type_mismatch_common+0x1e6/0x390 lib/ubsan.c:245
 __ubsan_handle_type_mismatch_v1+0x4a/0x60 lib/ubsan.c:274
 __skb_queue_before include/linux/skbuff.h:2085 [inline]
 __skb_queue_tail include/linux/skbuff.h:2118 [inline]
 wg_xmit+0x565/0xda0 drivers/net/wireguard/device.c:185
 __netdev_start_xmit include/linux/netdevice.h:4994 [inline]
 netdev_start_xmit+0x7b/0x140 include/linux/netdevice.h:5008
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x182/0x2e0 net/core/dev.c:3606
 __dev_queue_xmit+0x158e/0x2540 net/core/dev.c:4229
 neigh_output include/net/neighbour.h:527 [inline]
 ip6_finish_output2+0xf45/0x1300 net/ipv6/ip6_output.c:126
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ndisc_send_skb+0x8c3/0xdd0 net/ipv6/ndisc.c:508
 addrconf_dad_completed+0x543/0xa70 net/ipv6/addrconf.c:4216
 addrconf_dad_work+0xbd8/0x1450
 process_one_work+0x4ea/0x920 kernel/workqueue.c:2298
 worker_thread+0x686/0x9e0 kernel/workqueue.c:2445
 kthread+0x35c/0x430 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
================================================================================


Tested on:

commit:         c741e491 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11102217f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308b87e56290f642
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1117be40080000

