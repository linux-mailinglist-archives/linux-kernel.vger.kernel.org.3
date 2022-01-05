Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AEA485206
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiAELvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:51:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57850 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbiAELvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:51:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 901A5B81A96;
        Wed,  5 Jan 2022 11:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF1DC36AEB;
        Wed,  5 Jan 2022 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641383494;
        bh=L80exkg+JyVXmxcwgt/4UVXd9r21FU3v+spEJTkUfd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjU857r5FFX3YWfEMp7P+PdrzOo9zcy+z6MkYPpWwlzYbWQZdJNKrmw2DC92obG0R
         w/bKkVJsmAzct365bEkm0l4PJXwVgTfjW0IVE7bmNi4OQQvjW5kSL3kwmVSgeHiMVr
         18iSh7rTab8aLiDnNXVa6Oy9Kgm2kalV56xwCgRk=
Date:   Wed, 5 Jan 2022 12:51:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] debugfs: lockdown: Allow reading debugfs files that are
 not world readable
Message-ID: <YdWGQ+Kxeo9Q7Kli@kroah.com>
References: <20220104170505.10248-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104170505.10248-1-msuchanek@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 06:05:05PM +0100, Michal Suchanek wrote:
> 
> When the kernel is locked down the kernel allows reading only debugfs
> files with mode 444. Mode 400 is also valid but is not allowed.
> 
> Make the 444 into a mask.
> 
> Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  fs/debugfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why has it taken so long for anyone to notice this (2 years!)?

Is that because no one uses the lockdown mode and tries to read debugfs
files?


> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 7d162b0efbf0..950c63fa4d0b 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -147,7 +147,7 @@ static int debugfs_locked_down(struct inode *inode,
>  			       struct file *filp,
>  			       const struct file_operations *real_fops)
>  {
> -	if ((inode->i_mode & 07777) == 0444 &&
> +	if ((inode->i_mode & 07777 & ~0444) == 0 &&

You are now allowing more than just 0400, is that intentional?

I never understood why files that were 0666 were not able to be read
here as well, why not allow that as well?  What was magic about 0444
files?

thanks,

greg k-h
