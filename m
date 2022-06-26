Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB655B025
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiFZIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiFZIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:04:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A9E08D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 01:04:11 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f1-20020a056602070100b00674f8035487so4174805iox.17
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 01:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2XMyrDkWjNE8S0FV9z6vPu9PCor3SLEC4GN+KAoxEzI=;
        b=XrfhCqIQVmO+KtmqHavYSG5WeBk9254hZnXSqbPZC5VONyzNwFU16oapiMi3COE/Yj
         WsVPgkdlgTfTkvph9BLJhg7/42Qj25WZJ5dJNKSXNkaHNE8GHUdzy1MP4inct9888iP2
         T33AuTmjhdma4M8PWEtqiGV8lrC1T4/XvnLC9iAc1NDH/P5Hmnri32Wx16IxRuLJZdRE
         S4dFn6Y5MfCkJI/VHypKLo9A+41KDgZSpKgMSWg4PN7nrmMCY+uKDwfZQxb7fKhNyW63
         eWUbeIscc16RnmUzlFpZwz6tgfMuv44ZImbEkyIqhJRxyzP7NzxErtDuioSCyqrL89Qn
         V0jQ==
X-Gm-Message-State: AJIora+p6vPmTxR3AmhPCLnJYD9edtu2njAdvuSvBaEosfEkZ/y9WxBr
        3FMpFuyQir8vIi6FAKBTiQ9A8LOhF3CUL3ERObp3WuYGrPd4
X-Google-Smtp-Source: AGRyM1vxgFQzPbVhbOpEQnsCt0EbHSvi7ghK2Om/Ja3q4a2NRghbxwiFaNiWetvsX1FwZ96XEb6LjAP7JrOqZucHhv9arpGUIH87
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5af:b0:2d8:ff5b:e0c with SMTP id
 k15-20020a056e0205af00b002d8ff5b0e0cmr3879295ils.192.1656230650436; Sun, 26
 Jun 2022 01:04:10 -0700 (PDT)
Date:   Sun, 26 Jun 2022 01:04:10 -0700
In-Reply-To: <000000000000dab76c05d0bc284c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095e3d105e2553f0a@google.com>
Subject: Re: [syzbot] possible deadlock in console_unlock (2)
From:   syzbot <syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, elver@google.com, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit faebd693c59387b7b765fab64b543855e15a91b4
Author: John Ogness <john.ogness@linutronix.de>
Date:   Thu Apr 21 21:22:36 2022 +0000

    printk: rename cpulock functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed359bf00000
start commit:   aa051d36ce4a Merge tag 'for-linus-2022052401' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c31e1555a4c59f3
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7c8bfd17c00d016fb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a5aad6f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d697c3f00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: printk: rename cpulock functions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
