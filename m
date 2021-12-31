Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE704825A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhLaTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhLaTfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:35:17 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:35:17 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3NgB-00GIXR-BH; Fri, 31 Dec 2021 19:35:07 +0000
Date:   Fri, 31 Dec 2021 19:35:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [driver-core:debugfs_cleanup 4/5] fs/d_path.c:59 prepend() warn:
 unsigned 'p->len' is never less than zero.
Message-ID: <Yc9ba7ur1iVhaJd5@zeniv-ca.linux.org.uk>
References: <202201010156.bJvO7Gaw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201010156.bJvO7Gaw-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 01:08:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
> head:   a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
> commit: e95d5bed5d58c2f5352969369827e7135fa2261e [4/5] fs: make d_path-like functions all have unsigned size
> config: i386-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20220101/202201010156.bJvO7Gaw-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> fs/d_path.c:59 prepend() warn: unsigned 'p->len' is never less than zero.

What do you mean, "unsigned p->len"?

->len really *can* be negative - that's how running out of buffer is indicated.

Greg, I stand by the comment I made back in July - this kind of "hardening" is
useless; there's no legitimate reason to pass a huge buffer length, especially
since there's a limit on the length of pathname any syscall would accept.
See https://www.spinics.net/lists/linux-fsdevel/msg200370.html for the
variant I would prefer.
