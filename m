Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578A53F28A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiFFX3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFFX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:29:29 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FF2101DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:29:26 -0700 (PDT)
Date:   Mon, 6 Jun 2022 16:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654558164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPd50RzBLQnNTDWq5I+8g4Pd+wy9MD7JQRJ8I1ChLEo=;
        b=hnk3yVbnmAnqrLvGXZCNRVup8nEcZBoUUZ75WLie78mhcJdNheAzU8yCgx3vrtmcmrGwoQ
        GLi1/Iz/xZtbzmYHhnBct0XsEIIHIL4EUHdg5n7juir0+B9QXHDRxUt0ql/sz7d2MuwqK8
        QKJ+jwMeCUeCIU1YLwSllf6AA6fudLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in register_shrinker_prepared
Message-ID: <Yp6Nz08Ae9ENfsSv@carbon>
References: <000000000000db448c05e0caa5ba@google.com>
 <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 12:23:02PM -0700, Andrew Morton wrote:
> (cc Roman)
> 
> On Mon, 06 Jun 2022 10:17:34 -0700 syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f7b6b3f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=300d27c79fe6d4cbcc39
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103e5177f00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13545057f00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3694 at mm/vmscan.c:681 register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681
> 
> That's
> 
> 	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
> 
> I assume that debugfs_create_dir() failed.  Please see the NOTE: in
> that function's kerneldoc.


I agree and we really need to just ignore it.

If it happens because shrinker_debugfs is not initialized yet, there will be
a second chance. Otherwise we can't do much anyway.

Thank you!

--

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fd8a472b6501..ab885561d3e5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -682,7 +682,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
        down_write(&shrinker_rwsem);
        list_add_tail(&shrinker->list, &shrinker_list);
        shrinker->flags |= SHRINKER_REGISTERED;
-       WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
+       shrinker_debugfs_add(shrinker);
        up_write(&shrinker_rwsem);
 }
 
