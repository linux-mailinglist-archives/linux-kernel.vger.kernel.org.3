Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21321509FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355454AbiDUMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384659AbiDUMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:32:00 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC663152D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:29:11 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso3163678iom.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2LH/TUAXgyjFg87lmutVH/Zh/Ig4GTObkpnNk61xg+4=;
        b=1DMFWBrlgm3JrNKVM65/sbUxj0O+4q09V/BxYhWz7lhDfcYVCMy8SOxT/S2wojSsDJ
         bqz61S3Xq1hB7Ddz2xdVIs2jWhw/IypyJxyi8fU9aaDZSfvilQnuKEQpMYvAV1o8V+w5
         hJG8/MW3OL6RVyKzU5dKIN5KtNkk9QMrqMGmgZc7gETokC6ioGLASonNHAAvl0qMDxdY
         a2fFYhpmPpyO0opkzr7+k2ZHea2GFVnhmiv4Rxc7f/GLzlEvrhtbT80GHqlKGHC/fl3N
         /94LudNIsUBqOj6fJrrYPBVqRsepIwASc/Bahfw5uCdTMVcxY3FWM0wbAAikYVNvqxMR
         d8vA==
X-Gm-Message-State: AOAM5303+91wapLq6ntpvo4LHybk6aKpHjqK3pdeHOKngDwXoboyrK4I
        pWGHAjH985n6HsRL4ZD+sUk1G8jNW1r6BJDOwIGIPlnvKFQR
X-Google-Smtp-Source: ABdhPJw9cDZEQPn7qRg5XxIXfP++kvVm4Mw1mTgznR6D5YpBs5CrAp8bCEiEqG9rWSv0a5q9ra/l7nk55Ugc5U+QM+RiN92OCC+2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cab:b0:2ca:b397:a2e0 with SMTP id
 x11-20020a056e021cab00b002cab397a2e0mr10720692ill.104.1650544150570; Thu, 21
 Apr 2022 05:29:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 05:29:10 -0700
In-Reply-To: <000000000000f8b5ef05dd25b963@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7ede805dd2941b2@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in ntfs_fill_super
From:   syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, chao@kernel.org,
        davem@davemloft.net, jaegeuk@kernel.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        luiz.dentz@gmail.com, marcel@holtmann.org, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit adf9ea89c719c1d23794e363f631e376b3ff8cbc
Author: Chao Yu <chao@kernel.org>
Date:   Thu Aug 26 02:03:15 2021 +0000

    f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101dd0fcf00000
start commit:   b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121dd0fcf00000
console output: https://syzkaller.appspot.com/x/log.txt?x=141dd0fcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff9f8140cbb3af7
dashboard link: https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e13cfcf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e3008f00000

Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com
Fixes: adf9ea89c719 ("f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
