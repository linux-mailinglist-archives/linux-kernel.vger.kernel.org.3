Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAF48D636
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiAMK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:58:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44416 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiAMK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:58:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE740B82249
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E36C36AE3;
        Thu, 13 Jan 2022 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642071499;
        bh=W0tlPns/8hh5t5dUxhS9ruGELjPjP1Kr5hSt7g/w3vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+MD2cjzacJMicw8gLVRcdOSdtt+9XFMWOEz6ZjPS0Pn26hdTQbIDN6yiPdtoITLM
         bRZsg5TveoZfNXCDStZpnMiZ/iLyh9M2K8Hn0mWiaPolfyZm9yUrANwNUjzpl0ycEt
         mWTAaNPH/UIpMZSCSYGZwJ+fQzC5r/7NwJveg0Rc=
Date:   Thu, 13 Jan 2022 11:58:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs
 kernfs_rwsem.
Message-ID: <YeAFyOR61+c+FyMn@kroah.com>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104259.1584491-3-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:42:59PM +1100, Imran Khan wrote:
> Right now a global per file system based rwsem (kernfs_rwsem)
> synchronizes multiple kernfs operations. On a large system with
> few hundred CPUs and few hundred applications simultaenously trying
> to access sysfs, this results in multiple sys_open(s) contending on
> kernfs_rwsem via kernfs_iop_permission and kernfs_dop_revalidate.
> 
> -   21.42%    21.34%  showgids   [kernel.kallsyms]     [k] up_read
>      21.34% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 20.05% link_path_walk
>             - 9.76% walk_component
>                  lookup_fast
>                - d_revalidate.part.24
>                   - 9.75% kernfs_dop_revalidate
>                        up_read
>             - 9.46% inode_permission
>                - __inode_permission
>                   - 9.46% kernfs_iop_permission
>                        up_read
>             - 0.83% kernfs_iop_get_link
>                  up_read
>          - 0.80% lookup_fast
>               d_revalidate.part.24
>               kernfs_dop_revalidate
>               up_read
> 
> -   21.31%    21.21%  showgids   [kernel.kallsyms]    [k] down_read
>      21.21% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 19.78% link_path_walk
>             - 10.62% inode_permission
>                - __inode_permission
>                   - 10.62% kernfs_iop_permission
>                        down_read
>             - 8.45% walk_component
>                  lookup_fast
>                - d_revalidate.part.24
>                   - 8.45% kernfs_dop_revalidate
>                        down_read
>             - 0.71% kernfs_iop_get_link
>                  down_read
>          - 0.72% lookup_fast
>             - d_revalidate.part.24
>                - 0.72% kernfs_dop_revalidate
>                     down_read
>          - 0.71% may_open
>               inode_permission
>               __inode_permission
>               kernfs_iop_permission
>               down_read
> 
> Since permission is specific to a kernfs_node we can use a hashed
> lock to access/modify permission. Also use kernfs reference counting
> to ensure we are accessing/modifying permissions for an existing
> kernfs_node object.
> 
> Using this change brings down the above mentioned down_read/up_read
> numbers to ~8%, thus indicating that contention around kernfs_rwsem
> has reduced to about 1/3rd of earlier value.

Ah, nevermind, you do post the results here, I should have kept reading.

Nice work!

I'll look at these after 5.17-rc1 is out, thanks!

greg k-h
