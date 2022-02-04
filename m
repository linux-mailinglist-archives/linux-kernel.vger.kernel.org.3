Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF4A9BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359662AbiBDPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359644AbiBDPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB08B837C5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECFDC004E1;
        Fri,  4 Feb 2022 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643988051;
        bh=k8hRyDLb0dpZM8MNrFHnqUwFEG9HRSd7FBZSoHHVCVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwDhGTGZd5FIydWJC7m7ZxVo1Rk86ZZs7zUH5x4XFaingDs+4nwJNAs4neFfU12KL
         GM8hNJs3+T6xaXxSdbPhpv6qWUD8vrybGKbMmt6eLXAcRUY5TqSC1WqbUahO5giH/7
         vKADlI4ophh2iCVetsOUM02dqi23AaIjDrnVj0eI=
Date:   Fri, 4 Feb 2022 16:20:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Message-ID: <Yf1EUCgLIzb+rnIQ@kroah.com>
References: <20220202145027.723733-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145027.723733-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:50:25AM +1100, Imran Khan wrote:
> Reduce contention around global locks used in kernfs.
> 
> The current kernfs design makes use of 3 global locks to synchronize
> various operations. There are a few other global locks as well but
> they are used for specific cases and hence don't cause severe contention.
> 
> The above mentioned 3 main global locks used in kernfs are:
> 
> 1. A global mutex, kernfs_open_file_mutex, to protect the list of
> kernfs_open_file instances correspondng to a sysfs attribute.
> 
> 2. A global spinlock, kernfs_open_node_lock, to protect
> kernfs_node->attr.open which points to kernfs_open_node instance
> corresponding to a kernfs_node.
> 
> 3. A global per-fs rw semaphore, root->kernfs_rwsem, to synchronize most
> of the other operations like adding, removing, renaming etc. of a file
> or directory.
> 
> Since these locks are global, they can cause contention when multiple
> (for example few hundred) applications try to access sysfs (or other kernfs
> based file system) files in parallel, even if the applications are
> accessing different and unrelated files.
> 
> For example on a system with 384 cores, if I run 200 instances of an
> application which is mostly executing the following loop:
> 
>   for (int loop = 0; loop <100 ; loop++)
>   {
>     for (int port_num = 1; port_num < 2; port_num++)
>     {
>       for (int gid_index = 0; gid_index < 254; gid_index++ )
>       {
>         char ret_buf[64], ret_buf_lo[64];
>         char gid_file_path[1024];
> 
>         int      ret_len;
>         int      ret_fd;
>         ssize_t  ret_rd;
> 
>         ub4  i, saved_errno;
> 
>         memset(ret_buf, 0, sizeof(ret_buf));
>         memset(gid_file_path, 0, sizeof(gid_file_path));
> 
>         ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
>                            "/sys/class/infiniband/%s/ports/%d/gids/%d",
>                            dev_name,
>                            port_num,
>                            gid_index);
> 
>         ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
>         if (ret_fd < 0)
>         {
>           printf("Failed to open %s\n", gid_file_path);
>           continue;
>         }
> 
>         /* Read the GID */
>         ret_rd = read(ret_fd, ret_buf, 40);
> 
>         if (ret_rd == -1)
>         {
>           printf("Failed to read from file %s, errno: %u\n",
>                  gid_file_path, saved_errno);
> 
>           continue;
>         }
> 
>         close(ret_fd);
>       }
>     }
> 
> I can see contention around above mentioned locks as follows:
> 
> -   54.07%    53.60%  showgids         [kernel.kallsyms]       [k] osq_lock
>    - 53.60% __libc_start_main
>       - 32.29% __GI___libc_open
>            entry_SYSCALL_64_after_hwframe
>            do_syscall_64
>            sys_open
>            do_sys_open
>            do_filp_open
>            path_openat
>            vfs_open
>            do_dentry_open
>            kernfs_fop_open
>            mutex_lock
>          - __mutex_lock_slowpath
>             - 32.23% __mutex_lock.isra.5
>                  osq_lock
>       - 21.31% __GI___libc_close
>            entry_SYSCALL_64_after_hwframe
>            do_syscall_64
>            exit_to_usermode_loop
>            task_work_run
>            ____fput
>            __fput
>            kernfs_fop_release
>            kernfs_put_open_node.isra.8
>            mutex_lock
>          - __mutex_lock_slowpath
>             - 21.28% __mutex_lock.isra.5
>                  osq_lock
> 
> -   10.49%    10.39%  showgids         [kernel.kallsyms]      [k] down_read
>      10.39% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 9.72% link_path_walk
>             - 5.21% inode_permission
>                - __inode_permission
>                   - 5.21% kernfs_iop_permission
>                        down_read
>             - 4.08% walk_component
>                  lookup_fast
>                - d_revalidate.part.24
>                   - 4.08% kernfs_dop_revalidate
> 
> -    7.48%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
>      7.41% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 7.01% link_path_walk
>             - 4.12% inode_permission
>                - __inode_permission
>                   - 4.12% kernfs_iop_permission
>                        up_read
>             - 2.61% walk_component
>                  lookup_fast
>                - d_revalidate.part.24
>                   - 2.61% kernfs_dop_revalidate
> 
> Moreover this run of 200 application isntances takes 32-34 secs. to
> complete.                                                     
> 
> This patch set is reducing the above mentioned contention by replacing
> these global locks with hashed locks. 
> 
> For example with the patched kernel and on the same test setup, we no
> longer see contention around osq_lock (i.e kernfs_open_file_mutex) and also
> contention around per-fs kernfs_rwsem has reduced significantly as well.
> This can be seen in the following perf snippet:
> 
> -    1.66%     1.65%  showgids         [kernel.kallsyms]      [k] down_read
>      1.65% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 1.62% link_path_walk
>             - 0.98% inode_permission
>                - __inode_permission
>                   + 0.98% kernfs_iop_permission
>             - 0.52% walk_component
>                  lookup_fast
>                - d_revalidate.part.24
>                   - 0.52% kernfs_dop_revalidate
> 
> -    1.12%     1.11%  showgids         [kernel.kallsyms]      [k] up_read
>      1.11% __libc_start_main
>         __GI___libc_open
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         sys_open
>         do_sys_open
>         do_filp_open
>       - path_openat
>          - 1.11% link_path_walk
>             - 0.69% inode_permission
>                - __inode_permission
>                   - 0.69% kernfs_iop_permission
>                        up_read
> 
> Moreover the test execution time has reduced from 32-34 secs to 18-19 secs.
> 
> The patches of this patchset introduce following chanages:
> 
> PATCH-1: Make global kernfs_open_file_mutex and kernfs_open_node_lock
> 	 per-fs hashed locks, where address of a kernfs_node acts as hash key.
> 	 This results in kernfs_node objects, whose address give the
> 	 different hash value, using different kernfs_open_file_mutex
> 	 and kernfs_open_node_lock rather than all kernfs_node objects
> 	 using the same kernfs_open_file_mutex and kernfs_open_node_lock
> 	 as was the case earlier.
> 
> PATCH-2: Replace per-fs single rw semaphore with per-fs hashed semaphore,
> 	 where address of a kernfs_node acts as hash key to reduce contention
> 	 around single per-fs rw semaphore.
> 
> ------------------------------------------------------------------
> 
> Changes since v3:
>  - Make open_file_mutex and open_node_lock per-fs.
>  - Replace per-fs rwsem with per-fs hashed rwsem.
>    (Suggested by Tejun Heo <tj@kernel.org>)

Can you fix the issues found by the 0-day bot?

thanks,

greg k-h
