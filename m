Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6652AE58
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiEQW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiEQW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:58:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDED50469
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eZVpkMBT6AVV+r5iQZY6MKKGqLcD6ydnJ5+gSb3sYAw=; b=cOr6Pg/RKJlh8mSWMKZc9tAoz7
        hHFZ/IuwwWRLd+9PY6PGRMdS1AEPpImgS0+x0g/9OEotctdx24FAe1ba5yy/PUWTlbO7Em9nF0Tno
        458Cym284fha7Z4n3sQndM5SAZW2LaFFo8Y2aEqY5OaIKcSYQ4h5eupq/5mz63aVVmL6LThqp/Gmf
        P1PiYng/pN+HdF/9192fWosVrxPGtDOLvgfvevbTtpxuex56z2Hnj8kPJEyG/bELpGxhATjBd8uV7
        hCKyFRi815nnK1J95B86KKbKkN5/hHGif2LkqOgiaMsvQg8YjfTWtrqvapp92DS3tPeGeIaPIbLIw
        mb+iblcw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr68t-00FrK9-U5; Tue, 17 May 2022 22:58:16 +0000
Date:   Tue, 17 May 2022 22:58:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000be329205df3cf252@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in mntput_no_expire

Obvious question: which filesystem it is?

>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f3b7a03bd2b
> Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
> RSP: 002b:00007ffe9eb268b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f3b7a03bd2b
> RDX: 0000001b2ff20000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f3b7a19d960 R08: 0000000000000000 R09: 00007ffe9ebbf080
> R10: 00007ffe9ebbf090 R11: 0000000000000293 R12: 00000000000181f5
> R13: 00007ffe9eb269b0 R14: 00007ffe9eb269d0 R15: 0000000000000032
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ee4759f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1108ae3af00000
> 
