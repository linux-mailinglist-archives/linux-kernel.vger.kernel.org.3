Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1A547CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiFLWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFLWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:08:09 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1D4706C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:08:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i18-20020a926d12000000b002d1b13b896cso3453749ilc.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qsYh4wsra1/+8GV1O0hVa5h4gAvGFc0J5bHW5EhnYG4=;
        b=JBkXX4i/731gA0KiYdJFgmasWNUm+9CKdkYunJAbnCqm5Z02SyAO+1ZhjRXEGgyNcK
         dqP9iD7/UoVIlShHgEhFrBqUXzVVoLmVtP7vBMcbgl35Sthy0hTscSgna9Uc/n2sLKUt
         lnq6UL0n7vh7xVy+fVaVMTBHxdEpsOn+jN3ugHiO1ysbHgCWIqNjpU2nCdq+x1KUQGgV
         J+FTI20pX7ufh7GAVifHn4AWGVzRM2BLtiEo5gWiPv5l2PX11TNSSO2XCfx7hbnTgy6N
         DNiWeohS/0JXx5wT0K+Ba0sPvN6sujo8Y3mhP1uQyS70qSf6kbJUFHB5eWtCWiD89XRF
         Kp/w==
X-Gm-Message-State: AOAM532h3Wz1Y+0OcJSaFJ2kuDsVcOmEn7+vDV3BZt1RNqcMCzvUoA/E
        EtvpOkragD21EsSecV5iWCg9mCUm4sRlvlR2iCyfr/hDzSxA
X-Google-Smtp-Source: ABdhPJyDeEO5zaGjQm5TP28UECdnszqBMOD3jtdvy4S10o2j0i7IoiRcZuvwddcJUp9oaLdNaDvm9g5oTitC8nx3O0SB4yttEGr0
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:2d3:e79f:2fc1 with SMTP id
 k10-20020a92c24a000000b002d3e79f2fc1mr30135664ilo.250.1655071688169; Sun, 12
 Jun 2022 15:08:08 -0700 (PDT)
Date:   Sun, 12 Jun 2022 15:08:08 -0700
In-Reply-To: <000000000000c0517405e13dc59e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d20dc05e14768b5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __vma_adjust
From:   syzbot <syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
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

commit d3ccd17e7c9647b956d415acdf3e3fde7ae9e20c
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Thu Jun 9 20:57:09 2022 +0000

    mm: start tracking VMAs with maple tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11463853f00000
start commit:   6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13463853f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15463853f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=68771c0e74f7bb7804e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e632bbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103df80ff00000

Reported-by: syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com
Fixes: d3ccd17e7c96 ("mm: start tracking VMAs with maple tree")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
