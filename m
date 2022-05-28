Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47972536CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiE1MIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiE1MIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:08:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C91A80A;
        Sat, 28 May 2022 05:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B04D1B816EA;
        Sat, 28 May 2022 12:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AE3C34100;
        Sat, 28 May 2022 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653739727;
        bh=l7QuoL+ncgWhP6611WfWzxqo9yTpWKNWP7/SwKFgPtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxJBxufpf777F2RMiYltTVATTJQHMLmO/pgDN/S1W8IvdREyaUM276fJA38bErvfG
         IWT7zMKdSvF05TUIIR+YjycB+cAuQvJ+Gn6kSIYv3oZSRAgal7JukXdpwSCR5by6Bj
         qBrAJZnNPJVr36jOS83zeMussxWqMQ1UD4o62k/o=
Date:   Sat, 28 May 2022 14:08:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in driver_unregister
Message-ID: <YpIQzJQzd93cWq4M@kroah.com>
References: <YpEi/sbT/R/0yKzo@rowland.harvard.edu>
 <000000000000f9e65705e003513a@google.com>
 <YpFEc5zeFK0AXa2q@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpFEc5zeFK0AXa2q@rowland.harvard.edu>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 05:36:51PM -0400, Alan Stern wrote:
> On Fri, May 27, 2022 at 12:29:08PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING in sysfs_create_file_ns
> > 
> > really_probe: driver_sysfs_add(gadget.0) failed
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> > Modules linked in:
> > CPU: 0 PID: 2361 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:sysfs_create_file_ns+0x131/0x1c0 fs/sysfs/file.c:351
> > Code: e9 03 80 3c 01 00 75 7f 8b 4c 24 38 4d 89 e9 48 89 ee 48 8b 7b 30 44 8b 44 24 48 e8 e9 fa ff ff 41 89 c5 eb 0d e8 cf 7c 9d ff <0f> 0b 41 bd ea ff ff ff e8 c2 7c 9d ff 48 b8 00 00 00 00 00 fc ff
> > RSP: 0018:ffffc900028ffca0 EFLAGS: 00010293
> 
> Here's some extra detail, taken from the console log:
> 
> [   98.336685][ T2361] really_probe: driver_sysfs_add(gadget.0) failed
> [   98.336836][ T2360] sysfs: cannot create duplicate filename '/bus/gadget/drivers/dummy_udc'
> [   98.343498][ T2361] ------------[ cut here ]------------
> [   98.352154][ T2360] CPU: 1 PID: 2360 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
> [   98.357802][ T2361] WARNING: CPU: 0 PID: 2361 at fs/sysfs/file.c:351 sysfs_create_file_ns+0x131/0x1c0
> 
> Simultaneous splats from two different threads trying to add drivers with 
> the same name suggests there might be a concurrency bug in the sysfs 
> filesystem.  This sort of thing should be an error but it shouldn't bring 
> the kernel to its knees.

It's not bringing anything down, it's just giving you a big fat warning
that the developer did something wrong and it should be fixed.  The
kernel should keep working just fine after this.

> Greg, do you know anyone who could take a look at this?  I don't know much 
> about sysfs.

It's not a sysfs thing, it's a "we should not register the same driver
name multiple times" thing, so that subsystem needs to be fixed to make
this always a unique name.

thanks,

greg k-h
