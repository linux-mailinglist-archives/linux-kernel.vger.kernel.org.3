Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BD585E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiGaKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGaKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:09:19 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CDBC03
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:09:16 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j5-20020a056e02218500b002de1cf2347bso3393838ila.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=fB4ZFQbGOh22CQyNCxnbUuNY0WDSjtBE2vSyeSW5G+c=;
        b=sE2uPhELtv2Vtn45rgeS2jLlqJkVef3d5XiUqw3yhmDyAlvOOIMCqJtKnKsy/SsB+V
         3H4xuCGva/SqhVhsNHLeFkXGjeZmejLIk1/Z/8ZV8LTU7hrG6R0xYgmD0Hd+9wZQX3jC
         lH04JAMMGLXHLgkzBCyDbeDHRBUaYPgW7cjpJUkWlUKRgTJ05tLPqbQlSXtJjVbO2FJo
         stVwE/LQPy68RKL0OGkhiRnSYDXYGsAtCTBpUoNb/g1Ula5L0FsXW81nmmBQcWENujzC
         UdIAU+ESzMW6CdkUEEmI9P2P5I/lmKMr6TDME/WyG5CWiRqNylwkc9MW6Cz77Abqr1Kl
         +IJA==
X-Gm-Message-State: ACgBeo2jXYtaTyd7nIlGbocuXQJgd2CjgV14+gxsVopz5h/j/4+BcPyw
        z2vZnDd58mBuE5AA8oCexd7vB//f0uLtNV3Y/b658CTZCm6n
X-Google-Smtp-Source: AA6agR4YNsdIXwW4E3ZVaopPhSjeQnRfxTz3O+lMbX2712oNCcbItZdONhSQyTHdUx3uQMh8IJ+Ty6Fch6q0b1TKD2saTWINeznW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcc:b0:2de:67ee:c89f with SMTP id
 x12-20020a056e021bcc00b002de67eec89fmr1664162ilv.169.1659262156350; Sun, 31
 Jul 2022 03:09:16 -0700 (PDT)
Date:   Sun, 31 Jul 2022 03:09:16 -0700
In-Reply-To: <20220731094805.847-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b309205e51713c7@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=cad/1/0x4000000000000000 softirq=7023/7025 fqs=2 
	(detected by 1, t=10502 jiffies, g=7257, q=133)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4073 Comm: syz-executor.0 Not tainted 5.17.0-rc6-next-20220303-syzkaller-dirty #0
Harclient_loop: send disconnect: Broken pipe


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=166fe82e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c240c1080000

