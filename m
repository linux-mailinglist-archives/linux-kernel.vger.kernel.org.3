Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C1549FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiFMUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbiFMUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:41:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E253EAA2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 820FAB81260
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DBFC34114;
        Mon, 13 Jun 2022 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655149105;
        bh=IlyREGSSiPBcDabHaDrw79yO/FNKivARjh643g+g8bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKxskh0FzKAYavUnvpmvVGz58e6f02/DD31IMhs0e3QIy8kF25+Q4kZED2OAA/JyF
         kFWE3kXI/WQ672dssR7JZHVNhWnRLQ4eHQJhTZ6siEiLoiAcet93ZVbgAddfCH8Mak
         Yw4qwxLr/B/BBkNU8uqSjigM70N4wk5/BUbMdfL8=
Date:   Mon, 13 Jun 2022 21:38:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: RFC: repeated insmod/rmmod and DEBUG_KOBJECT_RELEASE - do we
 care?
Message-ID: <YqeSLvnLo2CX+oTp@kroah.com>
References: <20220613110239.GA69975@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613110239.GA69975@windriver.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:02:39AM -0400, Paul Gortmaker wrote:
> If a person has CONFIG_DEBUG_KOBJECT_RELEASE enabled, and runs a rather
> questionable test suite doing a repeated modprobe followed by modprobe -r
> it will eventually trigger a duplicate sysfs name warning:
> 
> [ 1427.032646] kobject: 'usbserial_generic' (00000000c91a1c2c): kobject_release, parent 00000000890627c7 (delayed 4000)
> [...]
> [ 1430.110659] kobject: 'usbserial_generic' (00000000a633d9a5): kobject_add_internal: parent: 'drivers', set: 'drivers'
> [ 1430.110667] sysfs: cannot create duplicate filename '/bus/usb/drivers/usbserial_generic'
> [ 1430.110671] CPU: 2 PID: 1102 Comm: modprobe Not tainted 5.15.38 #7
> [ 1430.110678] Call Trace:
> [ 1430.110685]  dump_stack_lvl+0x33/0x42
> [ 1430.110693]  sysfs_warn_dup+0x51/0x60         <----------
> [ 1430.110699]  sysfs_create_dir_ns+0xb8/0xd0
> 
> For context to lkml readers, CONFIG_DEBUG_KOBJECT_RELEASE inserts a
> random delay of between 2 and 5 seconds before freeing a kobject.
> 
> In the above case, the free was delayed 4s by the DEBUG option, but we tried
> to reconstruct the same sysfs entry in just 3s elapsed and hence it triggered
> the namespace collision warning. 
> 
> I'm not convinced this warrants fixing, given the contrived nature of the
> root only test, but I did at least want to get it on record, so maybe it
> saves someone else some research time, given a similar report.

It's come up many many times in the past years, sorry you hit it again
without realizing it.

> We could I guess, within the CONFIG_DEBUG_KOBJECT_RELEASE ifdef'd code use
> kobject_rename() to add a "-zombie" suffix or something like that, but then
> it might mask name space collisions people *do* want to see?

That wouldn't work as you would have rename collisions as well.

And that warning is just that, a warning that you did something foolish
so the kernel is trying to say "don't do that".  And doing a
modprobe/rmmod constantly is a huge "don't do that" hint.

> As per above it was seen with usb-serial, but I suspect any driver with a
> sysfs kobject could reproduce the issue.  I also didn't reproduce on the
> latest kernel but I can't imagine anything has changed in this area.

Yes, the module handling code has changed a bit, so it might have solved
some of these things.  But the root cause is still there, you are doing
something odd/broken and the kernel warned you about it :)

thanks,

greg k-h
