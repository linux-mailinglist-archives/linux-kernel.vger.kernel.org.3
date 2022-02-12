Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94824B32DA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 04:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiBLDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 22:24:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLDYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 22:24:18 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0862CC97
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 19:24:15 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y124-20020a6bc882000000b0060fbfe14d03so7750345iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 19:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HIaZdliGeUGHxPX/pnldMtfHMd66z97/0dotF/EKdqA=;
        b=a4gCzg3JnZPOEBllanKVspWGhnLrMX2XsZ8gh5tNAqLQAevh4f7feBGvxJm0gNoVKw
         gd3BrlCq21JqfcpLap4AvYxTCbiNBpXpifJEC5NEf+L5nXpYBuVRz2xhYxAVs4n3/zVu
         Gxvhp03t/p1K5jfWeNwzU/dDA/vDOjRYYU3Iri+J/2YNxp8gmwrTd53WQSXY94VDf6/F
         7/4c/vTZ9c+l293as8mC51Gt/zr6YmPsho8ZGeKTYQwD8+r1ja/CZF4e6moi+iEFaPeG
         ZqL7O3cPx2RVOdBPyURkaviPW0I1wadlIihrnrMyQlkoY/eSnIGd5Tqj4XhmJnCH/xzB
         Vafg==
X-Gm-Message-State: AOAM531Q657cdWHcQvFhuVNg+xvK3FkMl6pb2t8pKD15ZyXds64bXvHg
        H9hOCN+MJ/2qUiCJq9ipJMShsJFJLdtJSdn6h/9/t/h3z7x+
X-Google-Smtp-Source: ABdhPJxCfK7Iy7cDY5K320ofBfU6awjoOFIusgr1bupoMTBw316F8wBt29XqX3iJC5RJtJdQr8Xai18AjbafKuofTwhgsZBaceQV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:: with SMTP id t10mr2564156ilu.65.1644636255275;
 Fri, 11 Feb 2022 19:24:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 19:24:15 -0800
In-Reply-To: <000000000000c560bd05ad3c5187@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7d07705d7c9b7a4@google.com>
Subject: Re: [syzbot] WARNING in rtnl_dellink
From:   syzbot <syzbot+b3b5c64f4880403edd36@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, hawk@kernel.org,
        jiri@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev, yhs@fb.com
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

commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Mon Nov 29 17:53:27 2021 +0000

    net: netlink: af_netlink: Prevent empty skb by adding a check on len.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107b5472700000
start commit:   cd02217a5d81 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b5c64f4880403edd36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f8172900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145d1b1900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
