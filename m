Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3804D0F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiCHF5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiCHF5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:57:32 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67A32991;
        Mon,  7 Mar 2022 21:56:36 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nRSpm-0003fn-Ba; Tue, 08 Mar 2022 06:56:34 +0100
Message-ID: <4af605b4-d4c9-0060-9a26-f9846d44a328@leemhuis.info>
Date:   Tue, 8 Mar 2022 06:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Bug 215647 - aoe: removing aoe devices with flush (implicit in rmmod
 aoe) leads to page fault
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646718996;ff796f56;
X-HE-SMSGID: 1nRSpm-0003fn-Ba
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! As part of my regression tracking work I noticed this bug report
that was filed about a week ago:

https://bugzilla.kernel.org/show_bug.cgi?id=215647

To quote the first para:

> there is a bug in the aoe driver module between v4.20-rc1 and
> v5.14-rc1 inroduced in 3582dd2 (aoe: convert aoeblk to blk-mq) and
> fixed in 6560ec9 (aoe: use blk_mq_alloc_disk and blk_cleanup_disk). 
> Every forcible removal of an aoe device (eg. "rmmod aoe" with aoe
> devices available or "aoe-flush ex.x") leads to a page fault. This
> bug was successfully reproduced with kernel 5.10.92 from the debian
> repository, there were no changes to the affected code between
> v4.20-rc1 and v5.14-rc1. Version 4.19.208 (from debian buster) and
> 5.17-rc4 (from debian experimental) are confirmed not to be
> affected.

I checked the logs to see why mainline might not be affected anymore and
noticed a recent commit in the same area:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/aoe/aoedev.c?id=6560ec961a080944f8d5e1fef17b771bfaf189cb

> From 6560ec961a080944f8d5e1fef17b771bfaf189cb Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 2 Jun 2021 09:53:31 +0300
> Subject: aoe: use blk_mq_alloc_disk and blk_cleanup_disk
> 
> Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
> request_queue allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Link: https://lore.kernel.org/r/20210602065345.355274-17-hch@lst.de
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/aoe/aoedev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> (limited to 'drivers/block/aoe/aoedev.c')
> 
> diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> index e2ea2356da061..c5753c6bfe804 100644
> --- a/drivers/block/aoe/aoedev.c
> +++ b/drivers/block/aoe/aoedev.c
> @@ -277,9 +277,8 @@ freedev(struct aoedev *d)
>  	if (d->gd) {
>  		aoedisk_rm_debugfs(d);
>  		del_gendisk(d->gd);
> -		put_disk(d->gd);
> +		blk_cleanup_disk(d->gd);
>  		blk_mq_free_tag_set(&d->tag_set);
> -		blk_cleanup_queue(d->blkq);
>  	}
>  	t = d->targets;
>  	e = t + d->ntargets;

Does that need backporting? Or is the patch the reporter provided in
bugzilla the easier and safer way to fix that regression in older releases?

Ciao, Thorsten
