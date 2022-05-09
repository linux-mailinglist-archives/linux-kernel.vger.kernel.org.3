Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D835202BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiEIQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiEIQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:45:04 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7340E59
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:41:10 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id k6-20020a056e02156600b002cf4afa295bso7899743ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UQHR7i6vxvG7W9b1CjIdDI1PA7CC1Fpf3pZBpknVs7w=;
        b=t7hCJtnQ5DDxVc2OORd6HGsf/oYS8dloYhPgyyf90aUgtHmkKmUdPWNFoRLzXnC7EA
         DwuvJ6tUeyj8ePx6oQSoibqaN3QgHuEbZsHJzRFNOF56TA/4gGpIt5enW12GeV/lPn4p
         AmvLjd9bcd1lTPkNpdHKr+FxaQHfzyoDvkEBUhB05IkRo+30RJKhWv5SqLSTRo+3HRny
         xjsb5JBUe+UeL+oumeu5PX4AdMnT43hizXOzDPPS5Gh3RTSOvqDj929qRBt0uiQWHQQ4
         Hsr98ZRqbD2NoxOGWhPZcbssJN4zC05qpAvJ/fTQ8gPG3ijd8hV9cAKH8eWUuwHxE7Iv
         OHUw==
X-Gm-Message-State: AOAM533x9sn0JoG0vnsqGAxiEphKL26MPG0HqxCsOKq4FbMCgYmGOigq
        d2loLaUif2S9Vk8XiNInPvH0CULhuwAfif6bC2Ge/5CfDflK
X-Google-Smtp-Source: ABdhPJwR1r1shYChS7IbA+UkumG788L8TrCk2UoXDoS4lYNAKkbmJqSpjSmeEcYshtQqDLBeGt0kQ+Ug7FglJSsTUI49/CpRqUor
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:657:d130:daa with SMTP id
 b2-20020a05660214c200b00657d1300daamr6942690iow.83.1652114469771; Mon, 09 May
 2022 09:41:09 -0700 (PDT)
Date:   Mon, 09 May 2022 09:41:09 -0700
In-Reply-To: <000000000000183d9e05d7f0c0ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000195e9205de96e067@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
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

commit 2da376228a2427501feb9d15815a45dbdbdd753e
Author: Tadeusz Struk <tadeusz.struk@linaro.org>
Date:   Thu Mar 31 20:05:15 2022 +0000

    ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100ac712f00000
start commit:   09688c0166e7 Linux 5.17-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1205b189700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dda4fe700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
