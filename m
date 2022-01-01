Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BE4827AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 14:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiAANJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 08:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAANJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 08:09:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 05:09:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F0260A54
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 13:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F740C36AEA;
        Sat,  1 Jan 2022 13:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641042538;
        bh=PBglmaRoPeL1yVlqIAUYPkGns2BjpNgHavo6xtOcthw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0F0sl130qKS1TY90TDFLa+ocRSJ4OAqQ3gmWik5DLFbeESErBJZ58lRyEfe7Pscwk
         KxZn20pZQW8Ht0h4+VgiqWUcLic9boMCEaignQtvcaeF3jnb/LJb8cUt6R55t2lThd
         bHqFul3wRrj+Hq86v9+gg8Z64v7E3t7ct9ZTyoNQ=
Date:   Sat, 1 Jan 2022 14:08:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <lkp@intel.com>, devel@driverdev.osuosl.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [driver-core:debugfs_cleanup 4/5] fs/d_path.c:59 prepend() warn:
 unsigned 'p->len' is never less than zero.
Message-ID: <YdBSZsuW/JlUzp3p@kroah.com>
References: <202201010156.bJvO7Gaw-lkp@intel.com>
 <Yc9ba7ur1iVhaJd5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc9ba7ur1iVhaJd5@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 07:35:07PM +0000, Al Viro wrote:
> On Sat, Jan 01, 2022 at 01:08:41AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
> > head:   a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
> > commit: e95d5bed5d58c2f5352969369827e7135fa2261e [4/5] fs: make d_path-like functions all have unsigned size
> > config: i386-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20220101/202201010156.bJvO7Gaw-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > smatch warnings:
> > fs/d_path.c:59 prepend() warn: unsigned 'p->len' is never less than zero.
> 
> What do you mean, "unsigned p->len"?
> 
> ->len really *can* be negative - that's how running out of buffer is indicated.
> 
> Greg, I stand by the comment I made back in July - this kind of "hardening" is
> useless; there's no legitimate reason to pass a huge buffer length, especially
> since there's a limit on the length of pathname any syscall would accept.
> See https://www.spinics.net/lists/linux-fsdevel/msg200370.html for the
> variant I would prefer.

Sorry, yes, I agree with you, but never deleted this commit from this
"scratch" branch of mine.  I'll go rebase the branch and purge it from
the system so that 0-day doesn't hit it anymore, sorry for the noise.

greg k-h
