Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5961A57C489
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGUGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGUGew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:34:52 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC485245F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:34:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK-QiEr_1658385285;
Received: from 30.178.82.178(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VK-QiEr_1658385285)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 14:34:46 +0800
Message-ID: <06b571a5-4d0f-2112-c73b-35618b652a3b@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 14:34:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
To:     Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20220721035735.2720-1-nbowler@draconx.ca>
From:   Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20220721035735.2720-1-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM,

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

在 2022/7/21 11:57, Nick Bowler 写道:
> Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
> the initialization of compat_ioctl from the nvme block_device_operations
> structures.
>
> Presumably the expectation was that 32-bit ioctls would be directed
> through the regular handler but this is not the case: failing to assign
> .compat_ioctl actually means that the compat case is disabled entirely,
> and any attempt to submit nvme ioctls from 32-bit userspace fails
> outright with -ENOTTY.
>
> For example:
>
>    % smartctl -x /dev/nvme0n1
>    [...]
>    Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Inappropriate ioctl for device
>
> The blkdev_compat_ptr_ioctl helper can be used to direct compat calls
> through the main ioctl handler and makes things work again.
>
> Fixes: 89b3d6e60550 ("nvme: simplify the compat ioctl handling")
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> ---
>
> v2: use blkdev_compat_ptr_ioctl as suggested by Christoph Hellwig
>
>   drivers/nvme/host/core.c      | 1 +
>   drivers/nvme/host/multipath.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a12a906a11e..9c75d7378d31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2123,6 +2123,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>   static const struct block_device_operations nvme_bdev_ops = {
>   	.owner		= THIS_MODULE,
>   	.ioctl		= nvme_ioctl,
> +	.compat_ioctl	= blkdev_compat_ptr_ioctl,
>   	.open		= nvme_open,
>   	.release	= nvme_release,
>   	.getgeo		= nvme_getgeo,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d3e2440d8abb..432ea9793a84 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -408,6 +408,7 @@ const struct block_device_operations nvme_ns_head_ops = {
>   	.open		= nvme_ns_head_open,
>   	.release	= nvme_ns_head_release,
>   	.ioctl		= nvme_ns_head_ioctl,
> +	.compat_ioctl	= blkdev_compat_ptr_ioctl,
>   	.getgeo		= nvme_getgeo,
>   	.report_zones	= nvme_ns_head_report_zones,
>   	.pr_ops		= &nvme_pr_ops,
