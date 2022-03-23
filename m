Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D363D4E54DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiCWPIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiCWPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:08:46 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8875E41
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:07:16 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so991672ilc.17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OCNxa9n6u0UYsSpngdxE2RzTqlLKDflz8tjBWq7Q28s=;
        b=42MO3rEPRHH4Yknt1tNXiRpWUJ4Sqmw5O4U9iBjUWJCxP+srn12ONCvmO81+3PACrg
         ysgP/Pask0Ugqp62xi9IZpplpZ7jF+xQX7wFyu7RDtOagFdL+3nWmlh+L2CkOPvdyk+m
         P7PRqYp3xzLAhp06DkRjFPZEvqs+5RN3ZEiDp7OolIi8B19YmBika2YC0qnuzjakPZWQ
         xDLPZMkb0Nf5D4guMm8yUfcarZEjVXM/Cfanv4mVa5hrK50yvi66DDY84VZHqfOarclE
         zFx75LQRqUizcOvOqshN7IVnXfDfYpX/mxgMSGptNQGmtGSEyJbi+qtZ7pQcC8a6w4mF
         sutQ==
X-Gm-Message-State: AOAM533xldyjKWd7riJj8ma2R8oocJX8Yo1c7OcXK/XDcniG+JbylfWI
        kcOngvG37e3Ena8ZBP/GOCjaGsuzLHf6rMY/JEfyLsJIizg8
X-Google-Smtp-Source: ABdhPJws14Yfc6W/f6AeMeaXwEcAaKf4KKbckIBCk2WA1PXSi3Ym6qbtgZlUT0YzULj9ZhdyGN8lcTD2cRxHyl+/k4g7AJstdvLR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:2c7:f556:da52 with SMTP id
 z9-20020a056e0217c900b002c7f556da52mr262922ilu.96.1648048035383; Wed, 23 Mar
 2022 08:07:15 -0700 (PDT)
Date:   Wed, 23 Mar 2022 08:07:15 -0700
In-Reply-To: <00000000000079c56a05ba1c18c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8cdba05dae41558@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ext4_xattr_set_entry (4)
From:   syzbot <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjc@chobot.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, wanjiabing@vivo.com
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

commit 6e47a3cc68fc525428297a00524833361ebbb0e9
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Wed Oct 27 14:18:52 2021 +0000

    ext4: get rid of super block and sbi from handle_mount_ops()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100bc10b700000
start commit:   f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=96b123631a6700e9
dashboard link: https://syzkaller.appspot.com/bug?extid=4cb1e27475bf90a9b926
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11131f94d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3761b500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: get rid of super block and sbi from handle_mount_ops()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
