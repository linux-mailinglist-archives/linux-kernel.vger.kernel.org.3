Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C04D8A54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiCNREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiCNREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922726C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97FE60C4C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DED2C340E9;
        Mon, 14 Mar 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647277387;
        bh=pCwo8DVMuAXtLbgi4FppS9g1hfzWAu2PWvm7U+aZ9w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3VB5nwgpzixKzFTEIUR35ZeWEwR86iqfrlxG4rWe2gYlDs7o65YNwNvTTkPZC4cQ
         Lhe9nAbR+GmBkjVrE+14GS5GW9w/jnfEhstEnttGgoPn/D6mlzPctqnp/YmrABsya2
         mHHog/QafDJbYFpKZ6dMS1EhzWTYTpW99GSpGMoU=
Date:   Mon, 14 Mar 2022 18:03:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_get
Message-ID: <Yi91RwY/UDPJ4iky@kroah.com>
References: <0000000000006b04e005da2df2f3@google.com>
 <Yi9nzLtJRhtNXc8+@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi9nzLtJRhtNXc8+@slm.duckdns.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 06:05:32AM -1000, Tejun Heo wrote:
> On Mon, Mar 14, 2022 at 06:49:19AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    09688c0166e7 Linux 5.17-rc8
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b42729700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6da459dcfde3b8d0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=97a16334dbd58916f7fb
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com
> > 
> > usb 1-1: Direct firmware load for ueagle-atm/adi930.fw failed with error -2
> > usb 1-1: Falling back to sysfs fallback for: ueagle-atm/adi930.fw
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> > BUG: KASAN: use-after-free in kernfs_get+0x1c/0x90 fs/kernfs/dir.c:496
> > Read of size 4 at addr ffff88801ded39f8 by task kworker/1:2/2510
> 
> Looks like firmware loading and usb hub removal racing? I'm not sure there's
> whole lot we can do from the kernfs side. Greg?

Odd. Let me look at it.  If syzbot is starting to poke at ATM drivers,
wow, lots of issues are going to start falling out... 

thanks,

greg k-h
