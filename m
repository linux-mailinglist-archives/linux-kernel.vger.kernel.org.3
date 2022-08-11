Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F6590574
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiHKRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiHKRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:12:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 630749DF80
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:52:07 -0700 (PDT)
Received: (qmail 9907 invoked by uid 1000); 11 Aug 2022 12:52:07 -0400
Date:   Thu, 11 Aug 2022 12:52:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, andriy.shevchenko@linux.intel.com,
        jakobkoschel@gmail.com, quic_wcheng@quicinc.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: kernel v5.19 warn in usb_ep_queue
Message-ID: <YvUzt6yeKU4aOu34@rowland.harvard.edu>
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:12:04AM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver 5.19.0-rc4-00208-g69cb6c6556ad,
> the following crash was triggered.
> 
> HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)

Why does this say v5.18 if the kernel you were testing was 5.19?

> git tree: upstream
> 
> kernel config: https://pastebin.com/KecL2gaG
> C reproducer: https://pastebin.com/wLDJ9cnP
> console output: https://pastebin.com/t0r8EwTw

This link is bad.  The pastebin.com page contains a second copy of the C 
reproducer, not the console output.

Alan Stern

> 
> Basically, in the c reproducer, we use the gadget module to emulate
> the process of attaching a usb device (vendor id: 0xbaf, product id:
> 0x121, with function: midi and ms_null).
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, make install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
> trick.
> 
> It seems that an error state in struct usb_ep trigger such kernel warning.
> 
> The crash report is as follow:
> 
> ```
> ------------[ cut here ]------------
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 3442 at drivers/usb/gadget/udc/core.c:283
> usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> Modules linked in:
> CPU: 3 PID: 3442 Comm: file-storage Not tainted
> 5.19.0-rc4-00208-g69cb6c6556ad #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> Code: 46 05 0f 92 c3 31 ff 89 de e8 f1 e9 49 fd 84 db 0f 85 16 01 00
> 00 e8 c4 e8 49 fd 44 89 e0 5b 5d 41 5c 41 5d c3 e8 b5 e8 49 fd <0f> 0b
> 41 bc 94 ff ff ff e9 73 ff ff ff e8 a3 e8 49 fd 65 8b 1d cc
> RSP: 0018:ffffc9000490fd00 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888110e0d580
> RDX: 0000000000000000 RSI: ffff888110e0d580 RDI: 0000000000000002
> RBP: ffff88810ae84158 R08: ffffffff83fb31eb R09: 0000000000000000
> R10: 0000000000000001 R11: ffffed10221c1ab0 R12: 0000000000000cc0
> R13: ffff888111843f10 R14: ffff888111843f10 R15: ffff88811084e000
> FS: 0000000000000000(0000) GS:ffff88811a980000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f841985e020 CR3: 000000010d19a000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> start_transfer.isra.0+0x26/0x100
> drivers/usb/gadget/function/f_mass_storage.c:527
> start_out_transfer.isra.0+0xf0/0x1b0
> drivers/usb/gadget/function/f_mass_storage.c:560
> get_next_command drivers/usb/gadget/function/f_mass_storage.c:2249 [inline]
> fsg_main_thread+0x377/0x6fc0 drivers/usb/gadget/function/f_mass_storage.c:2572
> kthread+0x2ef/0x3a0 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> </TASK>
> 
> 
> ```
