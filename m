Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65B512A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbiD1EJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiD1EJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:09:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB3996A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:06:12 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id v11-20020a056e0213cb00b002cbcd972206so1103048ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Dfql/PVbRo9vj4AXiDRfDxD3zQunv3jkZ/rUdTpjkoQ=;
        b=Y2QX9cgs7KneNOpCTTDDUugSxJ5NBhZPb7gCkyg5HtSgQMVtOFXOvhTHmQRziR4xg2
         EaxJgxX1ALGfqBcIx3R8nTry+dTperQOdEtqhkrLedNoE7133Op+5r5pp9NX7MdBZ9f7
         dkppbMY9CbAJdsneZr+BndK+B/WgM1pzbWszyzRY+FX0Gz5Mv8Oofv+EzAnxKdx4fplm
         1KQtIeaD1Q5vCPmoqsq9gMuQigUQIVGNQmjesx1PJiP88GGicWtkxmSZ900RwCElgyA0
         Z3U8SN1jeeoMqAq6GCiaLAEk+q6s/XIjMpy4cgesEkHzKoe6B3QDnAca5otffFUf+eaJ
         dtEQ==
X-Gm-Message-State: AOAM533ze3b0LA20Gf8xw6KAkF/XgNKuaEiFhOiYB8JtA5moDYH1bmHB
        nrQgbP34MP3T+T+acbr81sRj3AiNG3v0pw/WHvtCA8TslNRm
X-Google-Smtp-Source: ABdhPJwQ6i8qUC9Amlf/H5waQm4woInhqiLWWIk4lsYi9wwOGgI2/qt/bo8Lvuqb5afMDDqLrm7HNUKKBiJ85GEjX3x7xH2mD2e8
MIME-Version: 1.0
X-Received: by 2002:a92:6e0b:0:b0:2c9:a276:58cc with SMTP id
 j11-20020a926e0b000000b002c9a27658ccmr12743934ilc.199.1651118772189; Wed, 27
 Apr 2022 21:06:12 -0700 (PDT)
Date:   Wed, 27 Apr 2022 21:06:12 -0700
In-Reply-To: <000000000000a23c8505dda227eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6000105ddaf0b55@google.com>
Subject: Re: [syzbot] WARNING in vma_merge
From:   syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterx@redhat.com, quic_qiancai@quicinc.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
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

syzbot has bisected this issue to:

commit 80207910cd71b4e0e87140d165d82b5d3ff69e53
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Fri Mar 25 01:13:12 2022 +0000

    kasan: move and hide kasan_save_enable/restore_multi_shot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d9a4e4f00000
start commit:   f02ac5c95dfd Add linux-next specific files for 20220427
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d9a4e4f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d9a4e4f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
dashboard link: https://syzkaller.appspot.com/bug?extid=7728e4ab5371cebc9c00
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f76f82f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b42c3cf00000

Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com
Fixes: 80207910cd71 ("kasan: move and hide kasan_save_enable/restore_multi_shot")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
