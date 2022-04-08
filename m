Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F404F9FC4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiDHWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiDHWyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:54:32 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338672BD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:52:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso6621702ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 15:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bzt9Z5p0uad85LLIp+TaBnz8TD3Frv18qcrHApPV7Ek=;
        b=JEYHBQ/fL+fR5PwHBaTGUj9v6f3KdLWwocVRVQJIMQoGVOJd8dGwcbm8vpPYmlwxU2
         szi3Mm8BJuHMlsAyy804aZqXJDJxN8KNyRopj/PFjNjRAEFmavl4G45ddmle8NMGPA/N
         07ymBq55g8GR8wPyQ7O4kKfvUs3Q+rVAjr1ZG1gDpKrNPwcBsRm4xNxEl5tsf4w3cZeY
         YblFznCyPcG9pMYN/AAJ28CuVDJ1Yx/QY5uekM2bqY+xu4B6Wh0fp1PZYGddlN1A41/h
         2t/qiZhCq+isO+c/MFJ5dXFisoZBPyIEDy0z1bnkc0hpMiAQAUCBYTZxoX3VEZK32sw4
         fLJw==
X-Gm-Message-State: AOAM531VJ6wbLf1d6gMGLnxdh4jkLsl3J/fMU2Lkex2WJ5QNx26IEIH8
        ma80ivaSPMgVOQRzqY51E4pZqRRQ6yE4fNyzTTWv2jJiy2PA
X-Google-Smtp-Source: ABdhPJy4wCGmhkenOavrH0karBsmOC5UrHcs85nWF//FYeeFAPIGJSQFFKSwt3F/YK7HQNXWvRLqe9aqAFBtbvwAr49hVIi1NSUt
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c7:b0:646:3bfb:7555 with SMTP id
 b7-20020a05660214c700b006463bfb7555mr9239062iow.83.1649458346558; Fri, 08 Apr
 2022 15:52:26 -0700 (PDT)
Date:   Fri, 08 Apr 2022 15:52:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d188ef05dc2c7279@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Write in snd_pcm_format_set_silence
From:   syzbot <syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    312310928417 Linux 5.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f30a90f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595bcd2109a73f9c
dashboard link: https://syzkaller.appspot.com/bug?extid=205eb15961852c2c5974
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798df4f700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12981dbf700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in snd_pcm_format_set_silence sound/core/pcm_misc.c:441 [inline]
BUG: KASAN: null-ptr-deref in snd_pcm_format_set_silence+0x215/0x350 sound/core/pcm_misc.c:424
Write of size 16383 at addr 0000000000000001 by task syz-executor156/3605

CPU: 0 PID: 3605 Comm: syz-executor156 Not tainted 5.18.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_report mm/kasan/report.c:432 [inline]
 kasan_report.cold+0x61/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memset+0x20/0x40 mm/kasan/shadow.c:44
 snd_pcm_format_set_silence sound/core/pcm_misc.c:441 [inline]
 snd_pcm_format_set_silence+0x215/0x350 sound/core/pcm_misc.c:424
 snd_pcm_oss_sync+0x60e/0x800 sound/core/oss/pcm_oss.c:1690
 snd_pcm_oss_ioctl+0x208c/0x3430 sound/core/oss/pcm_oss.c:2634
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0846a59e69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0846c74318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0846af0028 RCX: 00007f0846a59e69
RDX: 0000000000000000 RSI: 0000000000005001 RDI: 0000000000000003
RBP: 00007f0846af0020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6475612f7665642f
R13: 00007f0846bffd8f R14: 00007f0846c74400 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
