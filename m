Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6890149F430
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiA1HPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:15:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51372 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA1HPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:15:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A473B824C0;
        Fri, 28 Jan 2022 07:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93284C340E0;
        Fri, 28 Jan 2022 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643354119;
        bh=6lxx68iSS1U1W2TnImkmbLqFUWEEnGk/yh4Ob3PdewY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhCDYUS/cuAk9G0bkahY/OAx9alklsgRby0SAzau62NpncjXwP4qcxbXNUTaFPiv0
         0VFsyTNN716Q2sRhiyZhN5sCtOj1M5cuv5RKWI1XDo/sKEhHY3bOwGLWnWn3YuA04U
         pQmFargnUc2pHLByqiDYCs+yTQfYk4Z5XtEjj9J8=
Date:   Fri, 28 Jan 2022 08:15:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
Message-ID: <YfOYBLz7/ktBcMNT@kroah.com>
References: <YfMpk7DM9zA7NfmI@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfMpk7DM9zA7NfmI@debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:24:03PM +0000, Sudip Mukherjee wrote:
> Hi Wander,
> 
> Not sure if this has been reported before but since last few weeks I am
> seeing a problem with the rpi4 serial port on my test setup. The initial
> boot message will be completely garbled as you can see at:
> https://lava.qa.codethink.co.uk/scheduler/job/543#L380.
> The last good boot was https://lava.qa.codethink.co.uk/scheduler/job/540#L390.
> 
> The bisect log:
> 
> # bad: [455e73a07f6e288b0061dfcf4fcf54fa9fe06458] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> # good: [7e7b69654724c72bd3219b71f58937845dca0b2b] Merge tag 'dma-mapping-5.17' of git://git.infradead.org/users/hch/dma-mapping
> git bisect start '455e73a07f6e288b0061dfcf4fcf54fa9fe06458' '7e7b69654724c72bd3219b71f58937845dca0b2b'
> # bad: [342465f5337f7bd5b8bd3b6f939ac12b620cbb43] Merge tag 'tty-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
> # good: [6dc69d3d0d18d587ab9d809fe060ba4417cf0279] Merge tag 'driver-core-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 6dc69d3d0d18d587ab9d809fe060ba4417cf0279
> # good: [e269f7acdc53623769da31135f60afeb3a65eaff] staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
> git bisect good e269f7acdc53623769da31135f60afeb3a65eaff
> # bad: [ad234e2bac274a43c9fa540bde8cd9f0c627b71f] tty: serial: meson: Drop the legacy compatible strings and clock code
> git bisect bad ad234e2bac274a43c9fa540bde8cd9f0c627b71f
> # good: [c66453ce8af8bac78a72ba4e21fd9a86720127d7] tty: fix kernel-doc in n_tty.c
> git bisect good c66453ce8af8bac78a72ba4e21fd9a86720127d7
> # good: [0882b473b084df31288003b3bee974aabac9dcf9] tty: serial: samsung: Enable console as module
> git bisect good 0882b473b084df31288003b3bee974aabac9dcf9
> # bad: [b4a29b94804c4774f22555651296b838df6ec0e4] serial: 8250: Move Alpha-specific quirk out of the core
> git bisect bad b4a29b94804c4774f22555651296b838df6ec0e4
> # good: [e822b4973f49015e1c6f63b91c8641ed9bfaf229] tty/ldsem: Fix syntax errors in comments
> git bisect good e822b4973f49015e1c6f63b91c8641ed9bfaf229
> # good: [fb09d0ac07725b442b32dbf53f0ab0bea54804e9] tty: Fix the keyboard led light display problem
> git bisect good fb09d0ac07725b442b32dbf53f0ab0bea54804e9
> # bad: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
> git bisect bad 5021d709b31b8a14317998a33cbc78be0de9ab30
> # good: [adbfddc757aec1ed54ccb35c4a7ca9170df827e0] docs/driver-api: Replace a comma in the n_gsm.rst with a double colon
> git bisect good adbfddc757aec1ed54ccb35c4a7ca9170df827e0
> # first bad commit: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
> 
> And, indeed reverting 5021d709b31b ("tty: serial: Use fifo in 8250 console
> driver") on top of 23a46422c561 ("Merge tag 'net-5.17-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") fixes the problem
> for me.

Thanks, but this is already reverted in my tree and will go to Linus
later today.

greg k-h
