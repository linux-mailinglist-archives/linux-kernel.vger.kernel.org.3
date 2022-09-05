Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9441E5ACF28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiIEJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiIEJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:47:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B652DDE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:47:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w19so8642347ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vGVJH5OA7KjJlmiPWzK9scUAv0CcOHtZiCcKY3maS0o=;
        b=AmsIsGuuDJ2PBKP65euT43bUkExLvC4oRSQj3LyixfKfTLB/MWq8YHdHoYouDwl5Q4
         j52ymo4jSKQQc0/E8fFgmISNqRiU0uPi1XwbDKHJ4G/YjOqICxOYwISDBefatmG24pgh
         kMBMneQhZi2DcfPncacOycMLzlcMsGw8cncOBdI/X3zqPypKNU7lSp3dHxQ7or7CF6xy
         SuOGX4OBVYDhJYUScTNI/dVf7DE2JPHmpM2ogBSsOQulP3JEZA/JqpVRm267O5CkfO6A
         mVHerWTCMhcvcyMdQLdHprK7wr795tWvuxOPyCN3WWipXYkx+09ApxuM0TjzERSfjKSS
         13gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vGVJH5OA7KjJlmiPWzK9scUAv0CcOHtZiCcKY3maS0o=;
        b=N+PGF8MQFQ5pU1szAxyRTGWoFe/eZ7Gzqby6HfuSl3eVYsvsleK9GLnyq2G1DVDKSr
         w0RcmUr7UhBsj2RoEJblbiSbU7Qo3HHCe947rxQSfnjKlvUpr9jplxrZIyPHBGTyWeAp
         FQYdobb6g+zYwgx+b4SU4nwO+XmQpf/vsIu4bN8+9yUblIN0MGQrPBxCb3Im1Ju75U4O
         VAC3qj+J3bDw8UqJC4ovsR1ttEm2zKEBixdJq2sdT5dkPLIlBcnMtDVk5bMBYKksz6Cs
         RgCf1iUWyXr5MAcgYhOBti4tQfIYrpsBHfbUlJLUiIVuP+F5rGBsF+27URZoQ5K3RM53
         XaKA==
X-Gm-Message-State: ACgBeo3p5xbpsFsQLQoVlPRfPOrZGys/J9ax0SLxZJDCxkGXUFoCKcMa
        N+3eFSboVZpJCYBETccbBUf1/Vc+FNSq+aohhYviJQ==
X-Google-Smtp-Source: AA6agR4nj5jK6NuN8qOKVzACCWuYWh86kCQEIz4FXviA89UV9pQ+Zq427qL6mDztcmVf/UGagiDLy1LV8j186VrfdWc=
X-Received: by 2002:a05:651c:332:b0:267:649d:1f29 with SMTP id
 b18-20020a05651c033200b00267649d1f29mr7586946ljp.465.1662371239208; Mon, 05
 Sep 2022 02:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000117c7505e7927cb4@google.com> <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
In-Reply-To: <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Sep 2022 11:47:07 +0200
Message-ID: <CACT4Y+YQmenC6KOZEQ0o3n+qQXTEwUcAnvm+nTUXz_nO_A91ng@mail.gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in truncate_inode_pages_range
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sept 2022 at 01:25, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 31 Aug 2022 17:13:36 -0700 syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    89b749d8552d Merge tag 'fbdev-for-6.0-rc3' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14b9661b080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5867885efe39089b339b@syzkaller.appspotmail.com
> >
> > ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> > ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> > ================================================================================
> > UBSAN: array-index-out-of-bounds in mm/truncate.c:366:18
> > index 254 is out of range for type 'long unsigned int [15]'
>
> That's
>
>                 index = indices[folio_batch_count(&fbatch) - 1] + 1;
>
> I looked.  I see no way in which fbatch.nr got a value of 255.
>
>
> I must say, the the code looks rather hacky.  Isn't there a more
> type-friendly way of doing this?

I don't see how this can happen either. Also can't reproduce.
It's happened only once so far, so maybe some silent memory corruption.
Let's wait for more crashes/reproducer, or otherwise syzbot will
auto-close it after some time.
