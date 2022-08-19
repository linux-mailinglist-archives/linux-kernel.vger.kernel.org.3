Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E894599A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiHSKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348240AbiHSKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C7EF00C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B70616F7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CA0C433D6;
        Fri, 19 Aug 2022 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660906540;
        bh=zobDY2SKPp75J2Cx/ISxA48hS5Fxa8rokLLNWz4cyYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTfXHZd7S2LizE6hYgSU+X2S8/ErO15fUOpPEfx+h79mpFGOK51IHa8l0l8iXT5eN
         gYMXf+3+2gEz/kM9WQ6rcfmvgesjcRE+K2EYJhcwsGLwM0fVjFrBRLZqOIWlQBJAW3
         wvrwuCzua1phRACBvKxBannfbAz0ZSxoQS/pcCHY=
Date:   Fri, 19 Aug 2022 12:55:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhishek Shah <abhishek.shah@columbia.edu>
Cc:     arnd@arndb.de, bryantan@vmware.com, linux-kernel@vger.kernel.org,
        rjalisatgi@vmware.com, vdasa@vmware.com,
        Gabriel Ryan <gabe@cs.columbia.edu>, pv-drivers@vmware.com
Subject: Re: data-race in vmci_ctx_dequeue_datagram /
 vmci_ctx_rcv_notifications_release
Message-ID: <Yv9sKUPrOJVCjHd/@kroah.com>
References: <CAEHB24_SgKPt9UBrFi3CWNhF9vhBSTVdEGqUFDN8YUeREipCMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHB24_SgKPt9UBrFi3CWNhF9vhBSTVdEGqUFDN8YUeREipCMA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 06:33:00AM -0400, Abhishek Shah wrote:
> Hi all,
> 
> We found the following race involving the *context->notify* variable. We
> were unable to find any security implications of the race, but we would
> still like to report it. Please let us know what you think.
> 
> Thanks!
> 
> 
> *-----------------Report--------------*
> 
> *write* to 0xffffffff8832e400 of 1 bytes by task 6542 on cpu 0:
>  ctx_clear_notify drivers/misc/vmw_vmci/vmci_context.c:51 [inline]
>  ctx_clear_notify_call drivers/misc/vmw_vmci/vmci_context.c:62 [inline]
>  vmci_ctx_rcv_notifications_release+0x26a/0x280
> drivers/misc/vmw_vmci/vmci_context.c:926
>  vmci_host_do_recv_notifications drivers/misc/vmw_vmci/vmci_host.c:900
> [inline]
>  vmci_host_unlocked_ioctl+0x17cf/0x1800
> drivers/misc/vmw_vmci/vmci_host.c:949
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xe1/0x150 fs/ioctl.c:856
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> *write* to 0xffffffff8832e400 of 1 bytes by task 6541 on cpu 1:
>  ctx_clear_notify drivers/misc/vmw_vmci/vmci_context.c:51 [inline]
>  ctx_clear_notify_call drivers/misc/vmw_vmci/vmci_context.c:62 [inline]
>  vmci_ctx_dequeue_datagram+0x1fc/0x2c0
> drivers/misc/vmw_vmci/vmci_context.c:519
>  vmci_host_do_receive_datagram drivers/misc/vmw_vmci/vmci_host.c:426
> [inline]
>  vmci_host_unlocked_ioctl+0x91a/0x1800 drivers/misc/vmw_vmci/vmci_host.c:925
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xe1/0x150 fs/ioctl.c:856
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 6541 Comm: syz-executor2-n Not tainted 5.18.0-rc5+ #107
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> 
> Input CPU 0:
> r0 = openat$vmci(0xffffff9c, &(0x7f0000001440)='/dev/vmci\x00', 0x2, 0x0)
> ioctl$IOCTL_VMCI_VERSION2(r0, 0x7a7, &(0x7f0000000000)=0xb0000)
> ioctl$IOCTL_VMCI_INIT_CONTEXT(r0, 0x7a0, &(0x7f0000000040)={@my=0x1})
> ioctl$IOCTL_VMCI_NOTIFICATIONS_RECEIVE(r0, 0x7a6, &(0x7f0000000080)={0x0,
> 0x0, 0x101, 0x5})
> 
> Input CPU 1:
> r0 = openat$vmci(0xffffff9c, &(0x7f0000001440)='/dev/vmci\x00', 0x2, 0x0)
> ioctl$IOCTL_VMCI_VERSION2(r0, 0x7a7, &(0x7f0000000000)=0xb0000)
> ioctl$IOCTL_VMCI_INIT_CONTEXT(r0, 0x7a0, &(0x7f0000000040)={@my=0x1})
> ioctl$IOCTL_VMCI_DATAGRAM_RECEIVE(r0, 0x7ac, &(0x7f00000004c0)={0x0})


If multiple userspace programs open this, then yes, there will be
oddities, but that shouldn't be an issue, right?

Do you have a proposed patch for this to show what you think should be
done?

thanks,

greg k-h
