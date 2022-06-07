Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083E542557
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389144AbiFHAqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450073AbiFGXKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:10:49 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA6184931
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:48:18 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k4-20020a6b4004000000b006697f6074e6so1374371ioa.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=F4ALpda75nlB6V1TanWvj/lUfY62eLCUke6YTesSXU0=;
        b=qlELnEwXomhX0ynfOc+3DGuIYzwRNmfjqbifFG0bXK2TFbkuPrJ7A0kwV3Lz/BF4Af
         UJ61Hg2NbdBueSKtt+cYqPwXud5dzAHWTGX7kFOHV4/vALnOaRxh7N5JdCR1a56jLRgp
         zfvrQiBVeFBp5CBJJnp9f9s7HqChqO73SxyX4pSHeBZpg3AsjbCMYauJeqMMnSHTkxC0
         S2qc32j1VDPf5tQy5ZPgB1h2DTEKyYUTEE6FrwJiAepoRVyJtaHhYM3TsQnk3WY6GbuH
         Xwtxo6z7S55kkL4kRIM8DiR9YVVkIXlDGiJ8Voh7hMkLeQJR1orNt64BXaMVtgm8zSi5
         PELg==
X-Gm-Message-State: AOAM531P3TIjwjaEidmUq15JODZWNWAOWJgX58sv5kCSglse331TbMTv
        55q8H+HBHBMI4tnb6EdLRBGCU6n25ZbdX3wYdyCucak8Bl+y
X-Google-Smtp-Source: ABdhPJywpIJI/Qsn0/0LRzPy3Pf1VaqXJDD6UFpb2QRZsRbu49CjVlxdTBPAJ6dZb0YOM4HDd8FvUd/5fgQzJJYwO+C47z4AW1dG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:2d3:cfe9:4d89 with SMTP id
 h10-20020a056e021d8a00b002d3cfe94d89mr18176040ila.322.1654634897458; Tue, 07
 Jun 2022 13:48:17 -0700 (PDT)
Date:   Tue, 07 Jun 2022 13:48:17 -0700
In-Reply-To: <0000000000003fc46005e0db5390@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bcf6905e0e1b527@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Write in check_move_unevictable_pages
From:   syzbot <syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com,
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

commit 15603c238d1318c66c49df232fb2e2631a0062a0
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Jun 4 21:39:09 2022 +0000

    vmscan: Add check_move_unevictable_folios()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ad0107f00000
start commit:   73d0e32571a0 Add linux-next specific files for 20220607
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ad0107f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad0107f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448ee2b64e828049
dashboard link: https://syzkaller.appspot.com/bug?extid=8847ae8c7bc46bc9c10e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14359627f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177d5f3ff00000

Reported-by: syzbot+8847ae8c7bc46bc9c10e@syzkaller.appspotmail.com
Fixes: 15603c238d13 ("vmscan: Add check_move_unevictable_folios()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
