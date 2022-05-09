Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86052072E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiEIV6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiEIV43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:56:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E62C8194
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:50:10 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n8-20020a056e021ba800b002cf15f38e17so8357190ili.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s2rmpyNyFEujAf+EJYBoIEjX5MtLaffn8+X0o9N5fgE=;
        b=ABsG+W09Tqm2UIrN7X/IShObZRCf3p3Owbb6+bgYeUluusQPVoewOLiDNlRl54NAFY
         E/umYhZ6q3XpAXS195qHG+TR/Yu6wq04a86jwLrqQfFQcbPFT8Sf2wuSjDg0W5io0ewq
         AEwinTs5Tre1opIKRYDqeWEoFH8ATfKwPAd62gmsmlqIAOZOdlwtshDexC0QRq5tRLjt
         UiUeDIUpaOEaQ9HrSXzle+VAWOLxMx76/zUGujqLYt0hb++VXe+gd8+bpfGPngXf4LUM
         YiJ5TuzbUJ2PlV1+xO/00ThDCvIR3OdtZARg8F7KohsxSzNRqnd1O4zZNCA/HK7Mru/2
         q2Dg==
X-Gm-Message-State: AOAM533YXY/q5mffxYT/at4YqRlA/dFgkOMc9rCYVM5qXDqzdbncRN7B
        DXOJqapBHw8l0CVZ+YwnOEYAq5ynaGLHqzztWAf07A5lgsfZ
X-Google-Smtp-Source: ABdhPJwBVtl04Ej8XUy6iLjBCkDUNPExpqGoo3a5jGV8ypU3eIqqfYkoQPwIMtXgmETBrBFu7BHvBe/1eA2T9oXxg64g8WR0pnz3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:2cf:21fa:cce6 with SMTP id
 d11-20020a056e02214b00b002cf21facce6mr7280704ilv.160.1652133010262; Mon, 09
 May 2022 14:50:10 -0700 (PDT)
Date:   Mon, 09 May 2022 14:50:10 -0700
In-Reply-To: <00000000000029572505de968021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032d06e05de9b3136@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
From:   syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net, hch@lst.de,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
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

commit 0f38d76646157357fcfa02f50575ea044830c494
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Oct 12 10:40:45 2021 +0000

    blk-mq: cleanup blk_mq_submit_bio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12506f7ef00000
start commit:   c5eb0a61238d Linux 5.18-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11506f7ef00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16506f7ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=99938118dfd9e1b0741a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484cbc1f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7026cf00000

Reported-by: syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com
Fixes: 0f38d7664615 ("blk-mq: cleanup blk_mq_submit_bio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
