Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95FF5274BB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 02:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiEOAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiEOAJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 20:09:11 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB228DF6A
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:09:10 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r5-20020a924405000000b002cf9a5b9080so6363960ila.16
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4w7LpxRj5X+vIy/lVETOxSz5ptDf34rf9VfAF1/2p4Q=;
        b=ZLtc60OEdGQLCvBCEaayANYK67bHkIAgKFahX1OfLYxq5vYOtG9f8Bq3A3Tm3Jou8M
         oWuhrwlX36dVJcgzOirI6BMiTi7VG/u0hoGUdYo7Sg33znbPZzM2+W+mnTtgr4CzNzMw
         DTsOTlp11hjevpLG1hws8Np+xT4MCpl7RrPo/qFFm8WtkMILU5NyOO6dxcOS1Nksds+Y
         O6EHGboRox6DuGGherTxsfe1ThXxwNNux/JEtkqC4JXCjLyrXnhUQbEdWSs9Yexgys5v
         zNM48UAJ8+GusPd4nn1ws+WORhecb5w1ZOqoCvsV/SrtgZRl2Fhx07er9WTdRQmwh2Cb
         K/4Q==
X-Gm-Message-State: AOAM533jMe1YsLvU7pZQvzfhr7p+yibRytkiyp0rXaHCDXCNLwqAeAeA
        lCVqCnjYsYYCRidbkmSuTDftFcylY0aOpM7i8LUMmU7KyOqN
X-Google-Smtp-Source: ABdhPJz/8k9ckOb1pHQyHhQ0NYpFe1XoF44PaTpQPq0tV/ZauCYyGjXK/7Cyq7CPLx4IZfTwoJCGYAS39kAvmzBynHDPXZgzelSW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:2cf:4335:63b6 with SMTP id
 l15-20020a056e0212ef00b002cf433563b6mr5912298iln.284.1652573350109; Sat, 14
 May 2022 17:09:10 -0700 (PDT)
Date:   Sat, 14 May 2022 17:09:10 -0700
In-Reply-To: <0000000000007f31db05de0638f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fa7ff05df01b7c4@google.com>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
From:   syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
        ccross@google.com, david@redhat.com, ebiederm@xmission.com,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, michel@lespinasse.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        willy@infradead.org
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

commit b7d0f898f5ce328ad809417f2e728b58153d52d1
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri May 13 04:15:44 2022 +0000

    mm: remove the vma linked list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fefe69f00000
start commit:   1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11fefe69f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16fefe69f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=ee1fdd8dcc770a3a169a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142757f1f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cf0966f00000

Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com
Fixes: b7d0f898f5ce ("mm: remove the vma linked list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
