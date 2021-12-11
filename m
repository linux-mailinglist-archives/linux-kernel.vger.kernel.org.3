Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D90347133D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhLKKFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhLKKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:05:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 02:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F021CE2F50
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6EBC341C7;
        Sat, 11 Dec 2021 10:05:43 +0000 (UTC)
Date:   Sat, 11 Dec 2021 11:05:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+ce39644883793043ee77@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cxfcosmos@gmail.com,
        ebiederm@xmission.com, glider@google.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in make_kuid
Message-ID: <20211211100540.qe5jzvbxnbi2mzfx@wittgenstein>
References: <000000000000f1de5405d2ca4ae2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000f1de5405d2ca4ae2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 04:59:26AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b0f85c4ccdd4 kmsan: report: add dump_stack_print_info()
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1704eaf9b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce39644883793043ee77
> compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ce39644883793043ee77@syzkaller.appspotmail.com

I think this is triggered by the same 9p bug where it copies
uninitialized memory during setattr and then proceeds to send that
uninitialized memory over the wire. A patch for this was sent to 9p
devel but it seems to not have made it into mainline or -next just yet:
https://sourceforge.net/p/v9fs/mailman/message/37392685/
