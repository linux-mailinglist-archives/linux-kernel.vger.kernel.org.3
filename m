Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5130487777
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiAGMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:11:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45178 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiAGMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:11:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CBEBB825E5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2540C36AE5;
        Fri,  7 Jan 2022 12:11:36 +0000 (UTC)
Date:   Fri, 7 Jan 2022 13:11:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+13e44cec8bcb2396a0a3@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cxfcosmos@gmail.com,
        ebiederm@xmission.com, glider@google.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in from_kgid
Message-ID: <20220107121134.onasmfrz7xwveiue@wittgenstein>
References: <000000000000ac7b2e05d4fc7a88@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000ac7b2e05d4fc7a88@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:42:18AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=10071b99b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=13e44cec8bcb2396a0a3
> compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+13e44cec8bcb2396a0a3@syzkaller.appspotmail.com

Same 9p issue as others steeming from 9p copying from struct iattr
without checking what fields are valid leading to ultimately invalid
values being sent over the wire which is why KMSAN reports it.

Fixed in 9p and sitting in -next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a403e2bd0026a690478719e46bef478777e7dd41
should show up during merge window.
