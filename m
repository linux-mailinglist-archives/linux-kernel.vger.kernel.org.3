Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292D05ADF5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiIFGEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiIFGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:04:32 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913241152;
        Mon,  5 Sep 2022 23:04:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid5: Remove unnecessary bio_put() in
 raid5_read_one_chunk()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662444266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1Hx9zKkSqShfHLYD/BCxj56hkaYTpL8T/E2x/FgJgY=;
        b=F8Fltwi/pjMJWAG4PZnfTeKNO3hT23D87QK5FxBPhyUpLHCcgmS1H4L9n1IxfP7BAn0BTU
        MzO+HHZisbNkKgsVfniuvyC3HIGgI0SrCu7YQFejxkgegbkcAp72qN/BeG9MdoHV5KJvTu
        vAgqrHtwhOlTV0B+XfEzSisV4C2E7N0=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220902171609.23376-1-logang@deltatee.com>
 <20220902171609.23376-2-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <f244023c-a794-fe24-bf98-b1149ee7846d@linux.dev>
Date:   Tue, 6 Sep 2022 14:04:11 +0800
MIME-Version: 1.0
In-Reply-To: <20220902171609.23376-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/22 1:16 AM, Logan Gunthorpe wrote:
> From: David Sloan <david.sloan@eideticom.com>
>
> When running chunk-sized reads on disks with badblocks duplicate bio
> free/puts are observed:
>
>     =============================================================================
>     BUG bio-200 (Not tainted): Object already free
>     -----------------------------------------------------------------------------
>     Allocated in mempool_alloc_slab+0x17/0x20 age=3 cpu=2 pid=7504
>      __slab_alloc.constprop.0+0x5a/0xb0
>      kmem_cache_alloc+0x31e/0x330
>      mempool_alloc_slab+0x17/0x20
>      mempool_alloc+0x100/0x2b0
>      bio_alloc_bioset+0x181/0x460
>      do_mpage_readpage+0x776/0xd00
>      mpage_readahead+0x166/0x320
>      blkdev_readahead+0x15/0x20
>      read_pages+0x13f/0x5f0
>      page_cache_ra_unbounded+0x18d/0x220
>      force_page_cache_ra+0x181/0x1c0
>      page_cache_sync_ra+0x65/0xb0
>      filemap_get_pages+0x1df/0xaf0
>      filemap_read+0x1e1/0x700
>      blkdev_read_iter+0x1e5/0x330
>      vfs_read+0x42a/0x570
>     Freed in mempool_free_slab+0x17/0x20 age=3 cpu=2 pid=7504
>      kmem_cache_free+0x46d/0x490
>      mempool_free_slab+0x17/0x20
>      mempool_free+0x66/0x190
>      bio_free+0x78/0x90
>      bio_put+0x100/0x1a0
>      raid5_make_request+0x2259/0x2450
>      md_handle_request+0x402/0x600
>      md_submit_bio+0xd9/0x120
>      __submit_bio+0x11f/0x1b0
>      submit_bio_noacct_nocheck+0x204/0x480
>      submit_bio_noacct+0x32e/0xc70
>      submit_bio+0x98/0x1a0
>      mpage_readahead+0x250/0x320
>      blkdev_readahead+0x15/0x20
>      read_pages+0x13f/0x5f0
>      page_cache_ra_unbounded+0x18d/0x220
>     Slab 0xffffea000481b600 objects=21 used=0 fp=0xffff8881206d8940 flags=0x17ffffc0010201(locked|slab|head|node=0|zone=2|lastcpupid=0x1fffff)
>     CPU: 0 PID: 34525 Comm: kworker/u24:2 Not tainted 6.0.0-rc2-localyes-265166-gf11c5343fa3f #143
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>     Workqueue: raid5wq raid5_do_work
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x5a/0x78
>      dump_stack+0x10/0x16
>      print_trailer+0x158/0x165
>      object_err+0x35/0x50
>      free_debug_processing.cold+0xb7/0xbe
>      __slab_free+0x1ae/0x330
>      kmem_cache_free+0x46d/0x490
>      mempool_free_slab+0x17/0x20
>      mempool_free+0x66/0x190
>      bio_free+0x78/0x90
>      bio_put+0x100/0x1a0
>      mpage_end_io+0x36/0x150
>      bio_endio+0x2fd/0x360
>      md_end_io_acct+0x7e/0x90
>      bio_endio+0x2fd/0x360
>      handle_failed_stripe+0x960/0xb80
>      handle_stripe+0x1348/0x3760
>      handle_active_stripes.constprop.0+0x72a/0xaf0
>      raid5_do_work+0x177/0x330
>      process_one_work+0x616/0xb20
>      worker_thread+0x2bd/0x6f0
>      kthread+0x179/0x1b0
>      ret_from_fork+0x22/0x30
>      </TASK>
>
> The double free is caused by an unnecessary bio_put() in the
> if(is_badblock(...)) error path in raid5_read_one_chunk().
>
> The error path was moved ahead of bio_alloc_clone() in c82aa1b76787c
> ("md/raid5: move checking badblock before clone bio in
> raid5_read_one_chunk"). The previous code checked and freed align_bio
> which required a bio_put. After he move that is no longer needed as
> raid_bio is returned to the control of the common io path which
> performs its own endio resulting in a double free on bad device blocks.
>
> Fixes: c82aa1b76787c ("md/raid5: move checking badblock before clone bio in raid5_read_one_chunk")
> Signed-off-by: David Sloan <david.sloan@eideticom.com>
> [logang@deltatee.com: minor rewording of commit message]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4e6d865a6456..734f92e75f85 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5538,7 +5538,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
>   
>   	if (is_badblock(rdev, sector, bio_sectors(raid_bio), &first_bad,
>   			&bad_sectors)) {
> -		bio_put(raid_bio);
>   		rdev_dec_pending(rdev, mddev);
>   		return 0;
>   	}

Acked-by: Guoqing Jiang <Guoqing.jiang@linux.dev>

Thanks,
Guoqing
