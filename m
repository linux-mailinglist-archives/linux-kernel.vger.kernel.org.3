Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D148283B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 19:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiAASks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 13:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiAASkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 13:40:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 10:40:47 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3jJ0-00GTbv-S5; Sat, 01 Jan 2022 18:40:39 +0000
Date:   Sat, 1 Jan 2022 18:40:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, devel@driverdev.osuosl.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [driver-core:debugfs_cleanup 4/5] fs/d_path.c:59 prepend() warn:
 unsigned 'p->len' is never less than zero.
Message-ID: <YdCgJtYNu985QMs7@zeniv-ca.linux.org.uk>
References: <202201010156.bJvO7Gaw-lkp@intel.com>
 <Yc9ba7ur1iVhaJd5@zeniv-ca.linux.org.uk>
 <YdBSZsuW/JlUzp3p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdBSZsuW/JlUzp3p@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 02:08:54PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 31, 2021 at 07:35:07PM +0000, Al Viro wrote:
> > On Sat, Jan 01, 2022 at 01:08:41AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
> > > head:   a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
> > > commit: e95d5bed5d58c2f5352969369827e7135fa2261e [4/5] fs: make d_path-like functions all have unsigned size
> > > config: i386-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20220101/202201010156.bJvO7Gaw-lkp@intel.com/config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > smatch warnings:
> > > fs/d_path.c:59 prepend() warn: unsigned 'p->len' is never less than zero.
> > 
> > What do you mean, "unsigned p->len"?
> > 
> > ->len really *can* be negative - that's how running out of buffer is indicated.
> > 
> > Greg, I stand by the comment I made back in July - this kind of "hardening" is
> > useless; there's no legitimate reason to pass a huge buffer length, especially
> > since there's a limit on the length of pathname any syscall would accept.
> > See https://www.spinics.net/lists/linux-fsdevel/msg200370.html for the
> > variant I would prefer.
> 
> Sorry, yes, I agree with you, but never deleted this commit from this
> "scratch" branch of mine.  I'll go rebase the branch and purge it from
> the system so that 0-day doesn't hit it anymore, sorry for the noise.

OK...  I'll probably throw something along the lines of "negative => EINVAL,
positive greater than 32Kb - adjust the buffer and length to the last 32Kb
of what had been passed" into the misc queue.
