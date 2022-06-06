Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E733953EE88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiFFTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiFFTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2357666
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D06961464
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB23C385A9;
        Mon,  6 Jun 2022 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654543383;
        bh=nacxubDqFFdRgVSLGS1ry36IABpXpVQprcKZtbeliOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vxc6V+aPGyj7IZtXMPWd1wyKdJMKJdmLb7acJqI0wxdZlPloE6DcXfTYfaMS6KsuH
         Em6FW1FQD/p6GKuD6O8eB4GpbhxYIA5agMKnG0TNMJ03YXL1Qwspd4g9FqenQpMYmi
         dyPUFe8xBgubXXb/spABHk4+oElZS+nPa1xODKOE=
Date:   Mon, 6 Jun 2022 12:23:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [syzbot] WARNING in register_shrinker_prepared
Message-Id: <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
In-Reply-To: <000000000000db448c05e0caa5ba@google.com>
References: <000000000000db448c05e0caa5ba@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Roman)

On Mon, 06 Jun 2022 10:17:34 -0700 syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f7b6b3f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
> dashboard link: https://syzkaller.appspot.com/bug?extid=300d27c79fe6d4cbcc39
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103e5177f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13545057f00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3694 at mm/vmscan.c:681 register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681

That's

	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));

I assume that debugfs_create_dir() failed.  Please see the NOTE: in
that function's kerneldoc.


