Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9558E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiHJIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiHJIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD76CD35
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B31A560FB1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B62C433D7;
        Wed, 10 Aug 2022 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660121403;
        bh=7DdOKNwMkF/itIl0UK3wH8fL2YQXQRsF8NfajD114MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3S3yEz0M0w7HP9XfGz0ge0moEg8QcvxJY4XEitq+WPpvaz4NWpROUX1+lftHOkjL
         rPoSWCkuDZ2Nqhf81ZqwgkzEis4eS2srSdN+pxEUdqUy4Y7tYHwu7mzieQ8coum6mP
         gnwg4Qo541x+kD8y8XbLd/P4f/OzpEoNGDBZ+3So=
Date:   Wed, 10 Aug 2022 07:18:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mazin Al Haddad <mazinalhaddad05@gmail.com>
Cc:     jirislaby@kernel.org, daniel.starke@siemens.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, paskripkin@gmail.com,
        syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_gsm: fix missing assignment of gsm->receive() in
 gsmld_attach_gsm()
Message-ID: <YvM/oKdt/NPfOiXS@kroah.com>
References: <20220810031251.91291-1-mazinalhaddad05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810031251.91291-1-mazinalhaddad05@gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:12:52AM +0300, Mazin Al Haddad wrote:
> Fixes a bug reported by syzbot.

I do not understand this sentence :(

> A null pointer dereference can
> happen when attempting to access the "gsm->receive()" function in
> gsmld_receive_buf(). Currently, the "gsm->receive()" function is only set
> after a call to the GSMIO_SETCONF ioctl. Since the gsmld_receive_buf()
> function can be accessed without the need to call the line discipline
> ioctl (GSMIO_SETCONF), the gsm->receive() function will not be set and a
> NULL pointer dereference will occur.
> 
> Fix this by setting the gsm->receive() function when the line discipline
> is being attached to the terminal device, inside gsmld_attach_gsm(). This
> will guarantee that the function is assigned and a call to TIOCSTI,
> which calls gsmld_receive_buf(), will not reference a null pointer.
> 
> Call Trace:
>  <TASK>
>  gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
>  tiocsti drivers/tty/tty_io.c:2293 [inline]
>  tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> 
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Reported-and-tested-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
> Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>

What commit does this fix?

thanks,

greg k-h
