Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCC84FC6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbiDKVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350211AbiDKVuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:50:25 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E871A814
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:48:10 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i2-20020a056e021d0200b002cac9b3b46cso640606ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nrfu+QqSF6/ab+WasZFQXdtEXQrUlu6Oj2jlqNXgE2Y=;
        b=sV4l3P6w0DcLUjVphBesMedrzyTwpFnX6dwpscNYocCYzkonWKuTH0w3xCr84KSN1G
         2F/bv+owoL+L3QCBiZXwpsw5AJqWoYosi1Cm7jVpGbXWT1GObsQfUNnh7e9LNY+/fpN/
         qkW8D2ZiVz7CiVjTfobjI3MYacymQP/vITeX6MPvsQfOJUompJGjQhKl7ThdnWZynMkt
         vJiDvth6tDmqQ/LGjZnN8r2cP7tsrf6wFBJClJhrO/iUeYAZNMiFnEsx5E2DOxtRFZH7
         Bkh6FMi8XixPu2eKTOBBr0PvbuxY48zR8G/JtpIYqHLQKAttMgOo9jLL7veIVi5iLpcJ
         q2MQ==
X-Gm-Message-State: AOAM533eOe7ITQduoRHu/NyEZTi3drfxNGxa1aI/43XMMgt4BBVVmD3L
        fmJG56fXrJ7p2fE+7yDxFr0MHOPaUw47OpfHzZnL5vTQpNg/
X-Google-Smtp-Source: ABdhPJwJO9uxDUuoSJ6AW+FyvTZ0JArsOxFYZApz2erqpsQNVtXt62RJ98yJQG2Mai75WQ1cVZbXr1dav+A3EkX+HtssNTxCCL1X
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0e:b0:2c6:18c3:9691 with SMTP id
 g14-20020a056e021e0e00b002c618c39691mr14673558ila.287.1649713689588; Mon, 11
 Apr 2022 14:48:09 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:48:09 -0700
In-Reply-To: <00000000000098289005dc17b71b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072fb2705dc67e6c0@google.com>
Subject: Re: [syzbot] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        josephsih@chromium.org, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        yinghsu@chromium.org
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

syzbot has bisected this issue to:

commit 92b8aa6d18f7a9ae36a0f71d31742aeef201207a
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Sat Mar 26 07:09:28 2022 +0000

    Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fada04f00000
start commit:   d12d7e1cfe38 Add linux-next specific files for 20220411
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fada04f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fada04f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58fcaf7d8df169a6
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2ff0f700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd2df700000

Reported-by: syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com
Fixes: 92b8aa6d18f7 ("Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
