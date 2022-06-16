Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4754DC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359623AbiFPIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359243AbiFPIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:10:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42135D663
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:10:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FFC1474;
        Thu, 16 Jun 2022 01:10:26 -0700 (PDT)
Received: from [10.57.84.206] (unknown [10.57.84.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16833F7F5;
        Thu, 16 Jun 2022 01:10:24 -0700 (PDT)
Message-ID: <26872911-d9d2-3764-a579-ad60f8c8bfa5@arm.com>
Date:   Thu, 16 Jun 2022 09:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] init: Initialize noop_backing_dev_info early
To:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Guenter Roeck <linux@roeck-us.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>
References: <20220615214815.6901-1-jack@suse.cz>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220615214815.6901-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 22:48, Jan Kara wrote:
> noop_backing_dev_info is used by superblocks of various
> pseudofilesystems such as kdevtmpfs. After commit 10e14073107d
> ("writeback: Fix inode->i_io_list not be protected by inode->i_lock
> error") this broke because __mark_inode_dirty() started to access more
> fields from noop_backing_dev_info and this led to crashes inside
> locked_inode_to_wb_and_lock_list() called from __mark_inode_dirty().
> Fix the problem by initializing noop_backing_dev_info before the
> filesystems get mounted.
> 
> Fixes: 10e14073107d ("writeback: Fix inode->i_io_list not be protected by inode->i_lock error")
> Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reported-and-tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Jan Kara <jack@suse.cz>

Works for me too. Thanks for the proper fix


Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   drivers/base/init.c         |  2 ++
>   include/linux/backing-dev.h |  2 ++
>   mm/backing-dev.c            | 11 ++---------
>   3 files changed, 6 insertions(+), 9 deletions(-)
> 
> Since this bug prevents some machines from booting, I plan to push this patch
> to Linus unless someone objects soon... Review is welcome :).
> 
> diff --git a/drivers/base/init.c b/drivers/base/init.c
> index d8d0fe687111..397eb9880cec 100644
> --- a/drivers/base/init.c
> +++ b/drivers/base/init.c
> @@ -8,6 +8,7 @@
>   #include <linux/init.h>
>   #include <linux/memory.h>
>   #include <linux/of.h>
> +#include <linux/backing-dev.h>
>   
>   #include "base.h"
>   
> @@ -20,6 +21,7 @@
>   void __init driver_init(void)
>   {
>   	/* These are the core pieces */
> +	bdi_init(&noop_backing_dev_info);
>   	devtmpfs_init();
>   	devices_init();
>   	buses_init();
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 2bd073fa6bb5..f0baef68f90f 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -119,6 +119,8 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>   
>   extern struct backing_dev_info noop_backing_dev_info;
>   
> +extern int bdi_init(struct backing_dev_info *bdi);
> +
>   /**
>    * writeback_in_progress - determine whether there is writeback in progress
>    * @wb: bdi_writeback of interest
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index ff60bd7d74e0..95550b8fa7fe 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -231,20 +231,13 @@ static __init int bdi_class_init(void)
>   }
>   postcore_initcall(bdi_class_init);
>   
> -static int bdi_init(struct backing_dev_info *bdi);
> -
>   static int __init default_bdi_init(void)
>   {
> -	int err;
> -
>   	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_UNBOUND |
>   				 WQ_SYSFS, 0);
>   	if (!bdi_wq)
>   		return -ENOMEM;
> -
> -	err = bdi_init(&noop_backing_dev_info);
> -
> -	return err;
> +	return 0;
>   }
>   subsys_initcall(default_bdi_init);
>   
> @@ -781,7 +774,7 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
>   
>   #endif	/* CONFIG_CGROUP_WRITEBACK */
>   
> -static int bdi_init(struct backing_dev_info *bdi)
> +int bdi_init(struct backing_dev_info *bdi)
>   {
>   	int ret;
>   

