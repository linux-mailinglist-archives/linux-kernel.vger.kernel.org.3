Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2757F294
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiGXBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:43:08 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E309DDF4A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:43:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i9-20020a056e021b0900b002dd12dfd5b6so5042735ilv.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QG1Vlguh+NyM3F4HgWqYABV/fXQ+R0FPUIrRkqohEF4=;
        b=TcM7JN/GXWcFocdVEglvSlhNWMhjgHM0kRcYgdklcEwQJH/KccAYhIjedsIrw8H2u8
         Cby0IfUMmvhSbK/WCYG5YNaU+YMVZ462/Pk4yCwJWOHI3KuBgM75O+nbQVrWiQhrm+B4
         Me/hTIJqSu1kvhkOuovZrc2t79Yz+RtKKdujgy/IFpFIQZnlt0fFQ3HTOWe3xtj0nKzH
         0RiZbHAG4BhtDJFyXO9lP8A/i5Z0EVahz7++3ZzA6YiVgC1YOp2rNfeHWrCOgozN6ytr
         LdLkbF55i3o/vjuOda1gLDdNSFKkMUtLSaY3bcSYez0SG1XwpWxF2OC4pXRwGKeTfcvk
         sA5w==
X-Gm-Message-State: AJIora/cyrVTXumyzaiQyhnBJ9J3wNRMZwcJLwzKxa3l/NymHdZNLn95
        LBG3VHPy+j4M/7cjkzZId81l1l7vvGsfWy/o54vyLsMrV2MV
X-Google-Smtp-Source: AGRyM1tp4Fvz9O2oOPrL74/ZW4gNp0xnmNAtVePYL6p3X8RrXpamx9vprT4+lJvwp8CMs4kzRkbvWTIrbxCkYJvpWmh+qLBvDVj+
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d1:b0:669:734a:4c8a with SMTP id
 g17-20020a05660226d100b00669734a4c8amr2242868ioo.209.1658626987315; Sat, 23
 Jul 2022 18:43:07 -0700 (PDT)
Date:   Sat, 23 Jul 2022 18:43:07 -0700
In-Reply-To: <0000000000007c525005e0ff1382@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064d78b05e483302a@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in kvm_xen_vcpu_set_attr
From:   syzbot <syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com>
To:     dwmw@amazon.co.uk, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 536395260582be7443b0b35b0bbb89ffe3947f62
Author: Joao Martins <joao.m.martins@oracle.com>
Date:   Thu Mar 3 15:41:22 2022 +0000

    KVM: x86/xen: handle PV timers oneshot mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1607b2c2080000
start commit:   70664fc10c0d Merge tag 'riscv-for-linus-5.19-rc8' of git:/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1507b2c2080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1107b2c2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c061eee05f8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=e54f930ed78eb0f85281
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e058ce080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151b2ec2080000

Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
