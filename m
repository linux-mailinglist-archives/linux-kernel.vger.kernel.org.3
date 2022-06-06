Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC753F29B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiFFXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiFFXfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:35:14 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227214D622
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:35:12 -0700 (PDT)
Date:   Mon, 6 Jun 2022 16:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654558510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gt4DBYgcXVKDG81Upnb2aG0Q8F7JkfTTCfOh0AVQT9U=;
        b=Oh/h0HqfGHO/3nl2vC7PhrBmFqKhuAGU0yX+COkhggj2alXkzkm+Lo2CQE/18WE9Rt4XaT
        7elTH9cN9HLQ1lmmyi1wPVxpXhw/5FP07hvUZeQjbkRRS+4eQQ6ZaPzpSUYGK3IH8FXthp
        clLs7WO3Zt6ZdlyB0wIM7Rlt1MKdBaE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [syzbot] WARNING in register_shrinker_prepared
Message-ID: <Yp6PKQ5bPmwu9b2E@carbon>
References: <000000000000db448c05e0caa5ba@google.com>
 <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
 <Yp5y7NoNP9WF6vCS@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp5y7NoNP9WF6vCS@sol.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 02:34:36PM -0700, Eric Biggers wrote:
> On Mon, Jun 06, 2022 at 12:23:02PM -0700, Andrew Morton wrote:
> > (cc Roman)
> > 
> > On Mon, 06 Jun 2022 10:17:34 -0700 syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f7b6b3f00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=300d27c79fe6d4cbcc39
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103e5177f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13545057f00000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com
> > > 
> > > loop0: detected capacity change from 0 to 20
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 3694 at mm/vmscan.c:681 register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681
> > 
> > That's
> > 
> > 	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
> > 
> > I assume that debugfs_create_dir() failed.  Please see the NOTE: in
> > that function's kerneldoc.
> > 
> 
> The call to ida_alloc() can fail too.
> 
> register_shrinker_prepared() is not allowed to fail; anything that can fail must
> happen in prealloc_shrinker().  So either this new debugfs registration code
> needs to be moved to prealloc_shrinker(), or errors from it need to be ignored
> (which might be appropriate since it is just debugfs).

I don't think we want to panic or fail to mount filesystems because of it,
so I agree, ignoring is the best option.
