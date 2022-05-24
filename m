Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986B53245F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiEXHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:49:13 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C995DCE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:49:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id m9-20020a927109000000b002d1af1ed294so3221948ilc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q6iJvMWzMT/0z+8OLRas7nJa9KSBpjczyiBezB/+WCE=;
        b=PqKmdYQGJHb+jE5OYVrwQl6PZt+9rkxDNqrMr0hpRVrcdK7rK0GKVmUTkt34CTauzb
         scs81gmv9fNbkMBsBJ5WpbSthk3WpPecZsDvgt1U4/HFTIj7a1IXhkkxKV9NLvTpkTuG
         ha0yjwgubupgO+jWz9jV3w0/p4F0PtTkKJDS5B12ZGcRHK0ryvQ5BF1n2VhoK+X1icpc
         b9cklp6KpH3WCUp4EhCI0w2umv+XF0K0vpvdFBOPxVcZVkevkqDK/UNQY5CAKvJAeZar
         vgR/70MglxiSvIndJ6Jno9ffKG7LS4WRHkCpdjb34o3ZHitMJbXFuwvYwRyivK5CXMG0
         dj/Q==
X-Gm-Message-State: AOAM531AveF3n95463MQ2M1WCZL3WfKm0P8ZoJAiWOthyNZ9B8k5Xmci
        yNIF2S3lzjx/4Z/M/ZxCovfscykzBC0ax5/TS7gUO4WTF4QJ
X-Google-Smtp-Source: ABdhPJxs57ETHrJJ0qvG9RgzsdVuV0GFTudow3aStKlh5s1EsREK6XkWbVNrxmoaZwxTesyQs1LWPT7E9ywzpiX+yzHyueFhpsD+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a5:b0:32b:b8db:e2e3 with SMTP id
 v37-20020a05663835a500b0032bb8dbe2e3mr12800449jal.63.1653378551818; Tue, 24
 May 2022 00:49:11 -0700 (PDT)
Date:   Tue, 24 May 2022 00:49:11 -0700
In-Reply-To: <20220524073044.3421-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042b21705dfbd3128@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in udf_close_lvid
From:   syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
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
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4150 } 4 jiffies s: 2565 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):
IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
Bluetooth: hci1: command 0x0409 tx timeout


Tested on:

commit:         143a6252 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147795e5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc73592fcf812ebf
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147d0ad6f00000

