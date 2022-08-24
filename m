Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6359F115
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiHXBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHXBgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:36:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F985F12C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:36:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso67755pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sPgJhzknX9KkK1+l1jl2WFywz4m8XSqoIA+b/BXLQkc=;
        b=hSEJa76VxY4ARwf5o/RROvxyNXxd4dBc+FOiC9xDnUycyCZMhf60/UKhxohf8dhqyF
         n09t/mpF6Nx+wDNqwYab1JPHxfw/6iqhHiLZuaysJg/wsRror4KSZQDEQALEFezK9Fhk
         0udhbuE2p+cYYJXD8MSwgfc13oa1XfWiGbRpfKF6e+Lze4J1l1m8a4fwgpABzfUGQ15D
         lgIT/4WDwL9C8stVTPFH4/yiIGdWrTJwCyGFXSnr3ISxHIri3GqP7vLOaR79CDYdDj3k
         16r4vEXDA4GGwYjm79Va3qhhzgmiBGBGtiHR4LqGZ340sx4BrTSHpJOvOjRGTOzpPguF
         +yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sPgJhzknX9KkK1+l1jl2WFywz4m8XSqoIA+b/BXLQkc=;
        b=WXdGa59L37HwuKozbvOaJmRv1RqdwdXntcRvABYHHFAheQN6b1aDWUbFYc1jg0OmUX
         r2c+IuawwszvpdG0ZB+yZ5uOoZaXTs7qBE4vVGszpBK1Tx7Zekd+Tr0iNUXtpJpKdLFW
         UxT2WMjxGQyIw7p0sIXreE0mpNaHpBgGUHzL9A/fyPg6RFZLjnwLHPzB1TO82tSCdXKK
         zYJga75/tXHCgZRTioWr4N5COSloDNGYywC5/45r/ngUF7QIb2R5ERCdEdfOW6yNwclF
         SREPZD2XFbTiTkdG9Ip9cpVFgpPhDbjzgIJTNWi0Ke1Iv5T/qCQRw0XHWet0RrWDGOI5
         QlFA==
X-Gm-Message-State: ACgBeo0T7ZR9yOaI64bXnftKlCFbbwDIoJkiiTibt54X3BY3o5hgsVac
        DeglymYCUJ5AHmrsosyBNCQ7lA9bGfHonI/O40KEhJkw5sg=
X-Google-Smtp-Source: AA6agR5KeTtro0vljw3ngt/Pn1ZvFqILmQCV7K0BdzzugiF6EpX2/XGSQahgO4BrjN1PBdN1BzMLZYpGO3lHdxLWg2k=
X-Received: by 2002:a17:90a:c381:b0:1fb:c32:6324 with SMTP id
 h1-20020a17090ac38100b001fb0c326324mr5707376pjt.21.1661304996807; Tue, 23 Aug
 2022 18:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a6f34a05e6efcd01@google.com>
In-Reply-To: <000000000000a6f34a05e6efcd01@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Aug 2022 18:36:24 -0700
Message-ID: <CAHbLzkrkaOcYB7yTSp4w91rkOZA2pmysWb5-RvVNdvi_r28XRQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in split_huge_page_to_list (2)
To:     syzbot <syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 3:08 PM syzbot
<syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ef7dc3080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=07a218429c8d19b1fb25
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17993aa5080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16521a3d080000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com
>
> raw: 05ffc00000010801 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
> page dumped because: VM_WARN_ON_ONCE_PAGE(is_hzp)
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3025 at mm/huge_memory.c:2555 split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
> Modules linked in:
> CPU: 1 PID: 3025 Comm: syz-executor201 Not tainted 5.19.0-rc8-syzkaller-01618-g680fb5b009e8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
> lr : split_huge_page_to_list+0x308/0xe2c mm/huge_memory.c:2555
> sp : ffff80001321bba0
> x29: ffff80001321bbf0 x28: 0000000000400000 x27: 0000000000000001
> x26: ffff80000ceda000 x25: 05ffc00000000000 x24: ffff80000d8c1000
> x23: fffffc0003300000 x22: ffff0001ff012d40 x21: fffffc0003304400
> x20: 0000000000000000 x19: fffffc0003300000 x18: 00000000000000c0
> x17: ffff80000dcfd698 x16: ffff80000db3b658 x15: ffff0000c6708000
> x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6708000
> x11: ff808000081bf324 x10: 0000000000000000 x9 : 461f0eca467c0e00
> x8 : 0000000000000001 x7 : ffff8000081937c0 x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000031
> Call trace:
>  split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
>  split_huge_page include/linux/huge_mm.h:206 [inline]
>  try_to_split_thp_page mm/memory-failure.c:1488 [inline]
>  memory_failure+0x510/0x14cc mm/memory-failure.c:1870
>  madvise_inject_error+0x260/0x334 mm/madvise.c:1115

MADV_HWPOISON is called on a huge zero page. The warning was raised
for this case intentionally (it was a BUG before), see commit
478d134e9506c7e9bfe2830ed03dd85e97966313 ("mm/huge_memory: do not
overkill when splitting huge_zero_page").

>  do_madvise+0x258/0x5ac mm/madvise.c:1398
>  __do_sys_madvise mm/madvise.c:1423 [inline]
>  __se_sys_madvise mm/madvise.c:1421 [inline]
>  __arm64_sys_madvise+0x2c/0x40 mm/madvise.c:1421
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> irq event stamp: 11566
> hardirqs last  enabled at (11565): [<ffff8000081bd590>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
> hardirqs last disabled at (11566): [<ffff80000bfa4314>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
> softirqs last  enabled at (11536): [<ffff8000080102e4>] _stext+0x2e4/0x37c
> softirqs last disabled at (11527): [<ffff800008101e20>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (11527): [<ffff800008101e20>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
> ---[ end trace 0000000000000000 ]---
> Memory Failure: 0x10c110: thp split failed
> Memory failure: 0x10c110: recovery action for unsplit thp: Ignored
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
