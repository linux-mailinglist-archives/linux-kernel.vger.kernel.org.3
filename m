Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108B554B7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiFNRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiFNRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7682F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C04C361731
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C0C3411B;
        Tue, 14 Jun 2022 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655227865;
        bh=r3uCYxUZc+WIQja9EkQY4poMaqsttIMSV746cHkhO2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBGWCaTbdSQpqBNjp/uMekz9tzoJpIZ6jZcNnCWUayoC7UZH7VWIx9PRqxpfZ0XN1
         wbcjfV0jvBNVlaGcI5tItICT8+0bfmkoGr9ZFyPEpdHAXWbNuRbxs5ZxxO7evR6iyY
         ry5zfgHrPzW+bGOOOC46aTpL4UJ6sgqDuPs7XCSQ=
Date:   Tue, 14 Jun 2022 19:28:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@android.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer dereference
Message-ID: <YqjFPxuPO6SZuvg2@kroah.com>
References: <20220614172401.3010509-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614172401.3010509-1-willmcvicker@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:24:01PM +0000, Will McVicker wrote:
> When the kobj->ktype is null,

How can that happen?  What in-tree code does that?

> sysfs_file_ops() returns a NULL pointer
> for the sysfs_ops. When this happens, we hit a kernel panic in
> sysfs_kf_seq_show() by dereferencing ops to check if ->show is NULL.
> Based on commit 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show"), it
> sounds like we won't hit this often, but I have randomly hit this on my
> Pixel 6 with 5.19-rc1. Refer to the crash stack below:
> 
>    Unable to handle kernel paging request at virtual address ...
>    Internal error: Oops: 96000004 [#1] PREEMPT SMP
>    Hardware name: Oriole EVT 1.0 (DT)
>    pc : sysfs_kf_seq_show+0x3c/0x160
>    lr : kernfs_seq_show+0x54/0xa0
>    Call trace:
>     sysfs_kf_seq_show+0x3c/0x160
>     kernfs_seq_show+0x54/0xa0
>     seq_read_iter+0x17c/0x638
>     kernfs_fop_read_iter+0x70/0x1f4
>     vfs_read+0x240/0x36c
>     ksys_read+0x7c/0xf0
>     __arm64_sys_read+0x20/0x30
>     invoke_syscall+0x60/0x150
>     el0_svc_common+0xb8/0x100
>     do_el0_svc+0x30/0xd4
>     el0_svc+0x30/0xc0
>     el0t_64_sync_handler+0x88/0xf8
>     el0t_64_sync+0x1a0/0x1a4
> 
> Fixes: 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show")
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  fs/sysfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index a12ac0356c69..f09f86f10410 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -45,7 +45,7 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
>  	ssize_t count;
>  	char *buf;
>  
> -	if (WARN_ON_ONCE(!ops->show))
> +	if (WARN_ON_ONCE(!ops || !ops->show))
>  		return -EINVAL;

Seems reasonable, but I want to track down how ops can be NULL here
under normal operation.

thanks,

greg k-h
