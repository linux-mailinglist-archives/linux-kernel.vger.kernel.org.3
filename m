Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98158FAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiHKKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiHKKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:43:09 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624E75FDE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:43:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so9453711iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lEX60Cbcazn6R6L/6XwKBw23ViseQXIZ1Z7ZlktS5UU=;
        b=fP3pJgS1EI+6IfeJvGSmHmWpFP5JP+whRDu5aTr4HVSld1TBuGfqhVKnSACkqB8QQ3
         HJ/b5/sHZ7dGK+UtAuo+rrNkH0SCSQX58egjbpfX3+Xv3MK/i1+WTISmdu5v1YwA3sVS
         XSbRQwBcGtMGucgXZkZu9fqSErk/HJs1F4tZjf5fR4me6HD5iwYvyEg5ORH7JjUUrVB9
         TJlW1kkV0H05bglmjvb3Y8MixegwAg4oQ+vAZHpjxiMkSAxTswCrDNMpqqnGcwdA1q8f
         pL806mACR4fLzHzD5yQDI5ywx4qomyaCUnYguU9UEI7x9o3uqP1ckns3dUfxotknhE7v
         cxcQ==
X-Gm-Message-State: ACgBeo27qz8vZJXu4z0UWPDXCvBrgyaq4aKAZSLkcaF3pEpc+zaO2kPc
        z1254sNcOx+EZjGJnn+52W2QCg41tMpMBkPtBhWodlMzK6Cw
X-Google-Smtp-Source: AA6agR7Hi8B5W6WKGtAFwNNK4FUnHOGc4ICUBkEfs2/hpQ+PtJ8uOlWMicG2kCUmtKciLXR1skIHdYUjGApnwnJNYP1JTBqG2pa1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2490:b0:343:31f3:b09f with SMTP id
 x16-20020a056638249000b0034331f3b09fmr5093263jat.247.1660214587687; Thu, 11
 Aug 2022 03:43:07 -0700 (PDT)
Date:   Thu, 11 Aug 2022 03:43:07 -0700
In-Reply-To: <000000000000a256df05e39a74e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0089905e5f4d452@google.com>
Subject: Re: [syzbot] inconsistent lock state in find_vmap_area
From:   syzbot <syzbot+8d19062486784d15dda9@syzkaller.appspotmail.com>
To:     alan.maguire@oracle.com, andrii@kernel.org, ast@kernel.org,
        bp@alien8.de, bpf@vger.kernel.org, daniel@iogearbox.net,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hpa@zytor.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, netdev@vger.kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 43174f0d4597325cb91f1f1f55263eb6e6101036
Author: Alan Maguire <alan.maguire@oracle.com>
Date:   Mon Nov 29 10:00:40 2021 +0000

    libbpf: Silence uninitialized warning/error in btf_dump_dump_type_data

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1350eb05080000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d0eb05080000
console output: https://syzkaller.appspot.com/x/log.txt?x=1750eb05080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=8d19062486784d15dda9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1252c5a7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1160a8e3080000

Reported-by: syzbot+8d19062486784d15dda9@syzkaller.appspotmail.com
Fixes: 43174f0d4597 ("libbpf: Silence uninitialized warning/error in btf_dump_dump_type_data")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
