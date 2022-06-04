Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552E53D62E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiFDJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFDJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643A2CCB8;
        Sat,  4 Jun 2022 02:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C95B80123;
        Sat,  4 Jun 2022 09:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40071C34115;
        Sat,  4 Jun 2022 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654333434;
        bh=217ze+lr6QqzxW0zfUNP8dEz4eFku6hxMpaH4iUZ9Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9/aU3+Ihkq6BKPt54tPmidePYdBEAe5KqSbdYG1gnO3uH/S9Dvlc5EnZzOCcicYS
         gpK3daMFqzKanhb5RrN53vH8FCzP2Vgw0X7FKrbUEBNM2PBvFp8sh9pmg6XwY/RWZY
         tvrD5gVupRmSGFp97H5OTtocNm49T4rVssrfRzKo=
Date:   Sat, 4 Jun 2022 11:04:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Non-working serial console
Message-ID: <YpsgHpRfz0JQcm9D@kroah.com>
References: <d8e9f4fe-e8dc-67aa-e240-f2f5f1dfca2f@molgen.mpg.de>
 <1880b7a7-2353-c381-5afb-1d4224eb223b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1880b7a7-2353-c381-5afb-1d4224eb223b@molgen.mpg.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:09:15PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 02.06.22 um 18:50 schrieb Paul Menzel:
> 
> > Since a while I noticed, output to the serial console with
> > `console=ttyS0,115200n8` does not work with the attached configuration
> > `defconfig-non-working-serial.txt` created by `make savedefconfig`.
> > Only, when with `earlyprintk=ttyS0,115200,keep` the serial console
> > starts working. I am able to reproduce it in QEMU. It’s reproducible
> > with Linus’ latest master branch.
> > 
> >      $ git log --oneline --no-decorate -1
> >      8ab2afa23bd19 Merge tag 'for-5.19/fbdev-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> >      $ qemu-system-x86_64 --version
> >      QEMU emulator version 5.1.0
> >      Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
> >      $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
> > 
> > With `earlyprintk=` it works:
> > 
> >      $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "earlyprintk=serial console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
> > 
> > Strangely, I found a different configuration, where it works, but I
> > didn’t see what configuration option makes the difference.
> > 
> > Can you reproduce the problem with `defconfig-no-working-serial.txt`?
> 
> It turns out, the non-working configuration build the serial 8250 driver as
> a module (`CONFIG_SERIAL_8250=m`) instead of building it into the Linux
> kernel. Building it into the Linux kernel and using
> `CONFIG_SERIAL_8250_CONSOLE=y` fixes my issue.

That makes sense, you need the console to be able to properly send data
out to it :)

Was this a Kconfig change somewhere recently that we messed up the
defaults for?  Any chance you can use 'git bisect' to track down the
offending change?

thanks,

greg k-h
