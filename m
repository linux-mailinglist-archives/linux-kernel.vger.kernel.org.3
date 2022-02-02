Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A84A7B44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiBBWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:48:15 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41912 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiBBWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:48:13 -0500
Received: by mail-il1-f199.google.com with SMTP id o8-20020a056e0214c800b002bc2f9cffffso505736ilk.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 14:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wPRVy6cCZjxIGaY7GW0QhGPoF6HyxL4xHm0Y75S1HfY=;
        b=70bC9MKAQzqd2TvBKKJDF8QZvcm9A4LD3YcOcZntx8rEcvEWM0KgRHEGSwQ+ASO77k
         IMeYQg9mVpM7JekTaaof9AvO4hFg6u/gatei+hqKovPJ/e5MCNwMaeJyXlgtRRXttQ5r
         49c6GGzuyxYdJX6UPlYHApmcuIC9q79MT2pFH6DR6DU+W8HQyFTBpfMaqhjrgzETabNN
         ZOfubwD3LnKCn7UXU1kiyzLvYXJU0Qni5MyceUaDWlEZD9t672+RZoT913LDDkjNfCzw
         hbfHCYGywFjCanb1hqLo19riFi2ccovRADYrTYJ/+c/u/MERz1hBJEkpdSgDtpBsvYuk
         yhbg==
X-Gm-Message-State: AOAM5331mbFCBgaFKdgIdWSynrwhB44SS5e3xVPgVzRqf9YMHezS+54p
        vh0Mj0hrWpsDZQUbBTNJ3RPA8NavN0h1vPo64NNMJPZIdiTy
X-Google-Smtp-Source: ABdhPJxazeG/KSFW4yUcasmzMOdmC/DL0bFZExqauOUeXy/hnReM+RRSSGklrexPTcyyuAPHnKRqalDWqVAqFarV3Dxl2/1VlXzE
MIME-Version: 1.0
X-Received: by 2002:a92:d68a:: with SMTP id p10mr3673258iln.85.1643842093461;
 Wed, 02 Feb 2022 14:48:13 -0800 (PST)
Date:   Wed, 02 Feb 2022 14:48:13 -0800
In-Reply-To: <000000000000df66a505d68df8d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c37d105d710d0e1@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in bpf_prog_test_run_xdp
From:   syzbot <syzbot+6d70ca7438345077c549@syzkaller.appspotmail.com>
To:     alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.bianconi@redhat.com, lorenzo@kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1c194998252469cad00a08bd9ef0b99fd255c260
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri Jan 21 10:09:58 2022 +0000

    bpf: introduce frags support to bpf_prog_test_run_xdp()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a1e914700000
start commit:   000fe940e51f sfc: The size of the RX recycle ring should b..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a1e914700000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a1e914700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e029d3b2ccd4c91a
dashboard link: https://syzkaller.appspot.com/bug?extid=6d70ca7438345077c549
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c08cc8700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1258f610700000

Reported-by: syzbot+6d70ca7438345077c549@syzkaller.appspotmail.com
Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
