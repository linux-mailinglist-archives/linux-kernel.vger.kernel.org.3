Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDCE57E3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiGVPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:38:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E1513E11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:38:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n20-20020a6b8b14000000b0067c00777874so1894557iod.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lMppGUEb50hZIYPAtBTOe3qW0mUd/jMUvfj5uTqx23M=;
        b=bg3sKs5n4wLXha7bVi+ULwRNdo0Bq5VlPYbAaS/z3gYMVyUxQwKvGYf2cJuumpxBxp
         PWCVJffon9j2A/1S2izVdxBnD5fLuAaxT2kdMN2U7GUC9v/+5tkcCRiGxSPxesCiLV42
         z6gAs6+BaMZwk/2vpCqGnR6TsQDY01gmm5lGum29GhI27nVbkHMPy1yD6EojUjKN10j6
         E01V57TR1i1MaUsF0aexqK130jKRf1uVOkwQHUzsot0T1L2HMQaSg0Sup0n9UGxd3+Rd
         vtnY+8KqTdHwu7IGxuPlxKcdkapoc/B3TDBbiOoGaUxLwsYb+UC41dXLpXXHeLNenGnH
         QYAw==
X-Gm-Message-State: AJIora9l6SG1HfWHpDdvLlCbjP/E2Y7stgV6/K/xEILVF0jUJwPtmdO+
        DnwgC6lfb+n7KOBycJA5aDuZ9np8AbTFexehiIRN/pZPQX3P
X-Google-Smtp-Source: AGRyM1vHa1s1m+S9zIZfCosD7S3la9xNWKcVIxZzZeJRwvqQNLp9hrFyXXohQ34KCeuI2dmBot+eu8V5xXEvGSxuclgUwKdryj6B
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d13:b0:33f:5203:5ab7 with SMTP id
 q19-20020a0566380d1300b0033f52035ab7mr318471jaj.72.1658504305278; Fri, 22 Jul
 2022 08:38:25 -0700 (PDT)
Date:   Fri, 22 Jul 2022 08:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9821705e4669f6b@google.com>
Subject: [syzbot] bpf-next build error (4)
From:   syzbot <syzbot+ea8ff4e064cd21861ec7@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac7ac432a67e Merge branch 'New nf_conntrack kfuncs for ins..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164443d6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=386b986585586629
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8ff4e064cd21861ec7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea8ff4e064cd21861ec7@syzkaller.appspotmail.com

net/bpf/test_run.c:703:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:704:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:703:1: error: unknown type name 'BTF_ID_FLAGS'
net/bpf/test_run.c:705:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:705:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
net/bpf/test_run.c:712:48: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:705:1: error: unknown type name 'BTF_ID_FLAGS'
net/bpf/test_run.c:713:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:714:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:715:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:716:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:717:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:718:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:719:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:720:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
