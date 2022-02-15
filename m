Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8764B7175
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiBOPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:22:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiBOPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:22:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECE8A307;
        Tue, 15 Feb 2022 07:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20249B81A9A;
        Tue, 15 Feb 2022 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03089C340ED;
        Tue, 15 Feb 2022 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644938563;
        bh=QuSP9h1TZU+ulCdlSj9yBVKvN6wmhQlsP+xB+0dA3W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeKippxEJspepJjnd1bsYhzBkL8iHvQyelB20MvtPKI6dmZdTJo//IXdWbJ/cV0kk
         dfMtnRn0Z5u5Dtcf1TfFRlEVURp5rff03+Ne4jrKDe3vGq300ewL5H1RWqz/MLCEaQ
         os4KGhuSZ/l4ewKyF/T+QDdDKVVWI5A/bv79dF8Cj7dqPpBfRmwYJDZjbMIEz+sPvf
         PmNQd4OdCaiVj8L47yyzAAqq9g7NEu1pRzFtdFWcsYoaHXkl20VpB4RIC269ogeK01
         NT/ZxjIAir4Glmw0x/qDhwGtaavgjO5Q+JFEZ8AnuTA+ZNXbNeZuFp0+qYu7aEso9Q
         zzlQa2qQOiSpg==
Date:   Tue, 15 Feb 2022 07:22:40 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> After the surprise removal of a mounted NVMe disk the pciehp task
> reliably hangs forever with a trace similar to this one:
> 
>  INFO: task irq/43-pciehp:64 blocked for more than 120 seconds.
>  Call Trace:
>   <TASK>
>   __bio_queue_enter
>   blk_mq_submit_bio
>   submit_bio_noacct
>   submit_bio_wait
>   blkdev_issue_flush
>   ext4_sync_fs
>   sync_filesystem
>   fsync_bdev
>   delete_partition
>   blk_drop_partitions
>   del_gendisk
>   nvme_ns_remove
>   nvme_remove_namespaces
>   nvme_remove
>   pci_device_remove
>   __device_release_driver
>   device_release_driver
>   pci_stop_bus_device
>   pci_stop_and_remove_bus_device
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist
>   </TASK>
> 
> I observed this with 5.15.5 from debian bullseye-backports and confirmed
> with 5.17.0-rc3 but previous kernels may be affected as well.

Thanks for the patch.

Entering the queue used to fail if blk_queue_dying() was true. The
condition was changed in commit:

  8e141f9eb803e209714a80aa6ec073893f94c526
  block: drain file system I/O on del_gendisk

I can't actually tell if not checking the DYING flag check was
intentional or not, since the comments in blk_queue_start_drain() say
otherwise.

Christoph, do you know the intention here? Should __bio_queue_enter()
check the queue DYING flag, or do you prefer drivers explicity set the
disk state like this? It looks to me the queue flags should be checked
since that's already tied to the freeze wait_queue_head_t.

> @@ -4573,6 +4573,8 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>  		return;
>  
> +	set_bit(GD_DEAD, &ns->disk->state);
> +
>  	blk_set_queue_dying(ns->queue);
>  	nvme_start_ns_queue(ns);
