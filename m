Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF13576A64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiGOXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGOXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:06:12 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2F8B48F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:06:11 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n16-20020a056e02141000b002dabb875f0aso3489296ilo.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7VxCdsY3RYz1KoElXYwvbRCxsMp3bsrtHeLkwilP1iQ=;
        b=J5TowqiSHJSA7ZcmZpGU9FmT3L+5H10qyzOe2oHvybMiB1Stwsy+v42LP94OYOAQQ9
         UtV0DyC3HKXmw3rjc6JSns0ES8YoVhDvk78dMGc73ckJTT0U4QCZYHRZH2JGlk/zG9cz
         TztaN5VOCoHez5PJCzHx2kLQzy2rXL2iZVE7MYbSmWBH4CU2m5/Ny6mRK3mn4g4cN0+F
         RRKJOAx7dvrW/oahJcOFQsj34jhIozC22lQmABXyrWeF7v2VIGieR1KSGIFokzHF80xc
         4VULadsr8iBCWrySbDUyKQm4CVMXCQhhgwOus6+cvUBZfrh3u04NRr/SgUWKMpeSGkwA
         NBdg==
X-Gm-Message-State: AJIora87fjk/oJAVvlrXwPG2t2mTsjQ+seB3ksgxl7QTQtJm/gyWaxCn
        dTB6ElIcMIuZyyvuLvMIfBcZgo3t8cwE1L6PmCuIegCqp5R9
X-Google-Smtp-Source: AGRyM1sLyoMIrDFtN03wEjcFQ6/TfatVEyim8uM5OpRo0EK1yiA+K+5W6Qse0BCFEY41/V9z4O+6px02EeTgK6D9PezMnaNg56tB
MIME-Version: 1.0
X-Received: by 2002:a5d:8459:0:b0:669:4fab:2f86 with SMTP id
 w25-20020a5d8459000000b006694fab2f86mr7858389ior.84.1657926370854; Fri, 15
 Jul 2022 16:06:10 -0700 (PDT)
Date:   Fri, 15 Jul 2022 16:06:10 -0700
In-Reply-To: <20220715225546.1354-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000660b1305e3e010c4@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
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
SYZFATAL: executor failed NUM times: failed to create temp dir: mkdir ./syzkaller-testdir2ADDR: read-only file system

2022/07/15 23:05:48 SYZFATAL: executor failed 11 times: failed to create temp dir: mkdir ./syzkaller-testdir2570391515: read-only file system
[   81.505213][   T47


Tested on:

commit:         9b59ec8d Merge tag 'riscv-for-linus-5.19-rc7' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17a34994080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cc990589d31f8d6
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1577b5b2080000

