Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE948CAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356036AbiALSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:07:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:37714 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356020AbiALSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:07:07 -0500
Received: by mail-il1-f197.google.com with SMTP id l15-20020a056e021aaf00b002b7ed7d8cb4so1650567ilv.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4qfyyc8d8t6HSYNLIhDajcHWDIP5czgFUKxiWdgZZuo=;
        b=wb1JKaRbFb4/e8S8mbASxcKjqdtFkvyCbp5wpWzUUdz4tq17Ob2mMNrX8rgVMTPW2f
         W5guYK00luPeqUgdeVfB39w4Eu1xClqGJjLK5+2PnP3haWLpdIjKr3kLjmQNvRkjXINL
         AbMMueW/iXt0YZafvOYeJ78f+pnvgWr58hyHDMWwFlacSYm4QcJYxI0CKJRihblx3fMP
         pWz0gS7nsuddSjQg8FyzVGyXRgQVeInXc1mqrbJi69eVoNdfGOWo1A4RHPCcxe+b3F8m
         0Uf3yRWkdl8GqyWUAegHd16PGPYPOtnba6VCsqBJEn9+BWEZ4tJUXozWHLjMii/YBwxr
         akAQ==
X-Gm-Message-State: AOAM530lSx1ePuRRuM/HgK9uO1JYBTeMnYnLPHs7RWT4d9UnDoOl890q
        pDsAZyiTFcHrnkwe6TsxHgQKbkbtUGs/wO/g325gmEz6wo5T
X-Google-Smtp-Source: ABdhPJypiq3WNQhaEDkIOaecF5zA0hAxEGuLf4XczFian/Ud6RPY4l9/xIPbalhaOGaw8NUbxN6HUozucfb4pNbwD+xvQf1HCkcn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1490:: with SMTP id a16mr491280iow.30.1642010826998;
 Wed, 12 Jan 2022 10:07:06 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:07:06 -0800
In-Reply-To: <000000000000c1524005cdeacc5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f890905d56670f5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in veth_xdp_rcv
From:   syzbot <syzbot+67f89551088ea1a6850e@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, fgheet255t@gmail.com,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, toke@toke.dk,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2cbad989033bff0256675c38f96f5faab852af4b
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Nov 30 10:08:06 2021 +0000

    bpf: Do not WARN in bpf_warn_invalid_xdp_action()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e9e1ddb00000
start commit:   252c765bd764 riscv, bpf: Add BPF exception tables
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f60548b4c38ae4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=67f89551088ea1a6850e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1797fcf2b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e71f9f300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Do not WARN in bpf_warn_invalid_xdp_action()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
