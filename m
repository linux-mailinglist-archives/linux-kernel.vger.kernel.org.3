Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D857EC61
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiGWHA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGWHAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A1A18F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 00:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F64B82B92
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBB0C341C0;
        Sat, 23 Jul 2022 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658559616;
        bh=tm9xPYy/QSGHj/QDQyA2Dywv8TAfehEcXfMDxQl0Qlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/XYLhBJX+ol32mnT9TBbBbIOjloHmvUPEHP7Q7xkdJaUwSwzhUcL40QyU7di4edW
         Um4QAZ9sNCCHcoHgxMrEza+DZ/TnEeoODNbD5mU99bhzFs3JMjCBurd7EufO3JO737
         GJBZE9wP1Bi3YWavwYyr51CrVaYzheOCpLBujtiM=
Date:   Sat, 23 Jul 2022 09:00:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, consult.awy@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Subject: Re: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
Message-ID: <YtuceCr5OCJcDatJ@kroah.com>
References: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 09:37:52AM -0700, Dipanjan Das wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> description: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
> affected file: sound/core/pcm_native.c
> kernel version: 5.10.131
> kernel commit: de62055f423f5dcb548f74cebd68f03c8903f73a
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> BUG: KASAN: vmalloc-out-of-bounds in memset include/linux/string.h:384 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in snd_pcm_hw_params+0x19b0/0x1db0
> sound/core/pcm_native.c:799
> Write of size 2097152 at addr ffffc900113b2000 by task syz-executor.5/14437
> 
> CPU: 1 PID: 14437 Comm: syz-executor.5 Tainted: G           OE     5.10.131+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x4f7 mm/kasan/report.c:385
>  __kasan_report mm/kasan/report.c:545 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
>  check_memory_region_inline mm/kasan/generic.c:194 [inline]
>  check_memory_region+0x187/0x1e0 mm/kasan/generic.c:200
>  memset+0x20/0x40 mm/kasan/common.c:85
>  memset include/linux/string.h:384 [inline]
>  snd_pcm_hw_params+0x19b0/0x1db0 sound/core/pcm_native.c:799
>  snd_pcm_kernel_ioctl+0xd1/0x240 sound/core/pcm_native.c:3401
>  snd_pcm_oss_change_params_locked+0x17b6/0x3aa0 sound/core/oss/pcm_oss.c:965
>  snd_pcm_oss_change_params+0x76/0xd0 sound/core/oss/pcm_oss.c:1107
>  snd_pcm_oss_make_ready+0xb7/0x170 sound/core/oss/pcm_oss.c:1166
>  snd_pcm_oss_set_trigger.isra.0+0x34f/0x770 sound/core/oss/pcm_oss.c:2074
>  snd_pcm_oss_poll+0x679/0xb40 sound/core/oss/pcm_oss.c:2858
>  vfs_poll include/linux/poll.h:90 [inline]
>  do_pollfd fs/select.c:872 [inline]
>  do_poll fs/select.c:920 [inline]
>  do_sys_poll+0x63c/0xe40 fs/select.c:1014
>  __do_sys_poll fs/select.c:1079 [inline]
>  __se_sys_poll fs/select.c:1067 [inline]
>  __x64_sys_poll+0x18c/0x490 fs/select.c:1067
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f095de4f4ed
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f095bdffbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
> RAX: ffffffffffffffda RBX: 00007f095df6df60 RCX: 00007f095de4f4ed
> RDX: 0000000000000009 RSI: 0000000000000001 RDI: 00000000200000c0
> RBP: 00007f095bdffc40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
> R13: 00007ffff286ceff R14: 00007f095df6df60 R15: 00007f095bdffd80
> 
> 
> Memory state around the buggy address:
>  ffffc900115b1d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc900115b1d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc900115b1e00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                    ^
>  ffffc900115b1e80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc900115b1f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> ==================================================================

Wondeful, do you have a fix for this that solves the reported problem
that you have tested with the reproducer?

thanks,

greg k-h
