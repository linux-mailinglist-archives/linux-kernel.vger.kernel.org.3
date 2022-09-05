Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23785ACA54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiIEGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiIEGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:07:22 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80332AE2C;
        Sun,  4 Sep 2022 23:07:20 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aec85.dynamic.kabel-deutschland.de [95.90.236.133])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3F8AF61EA1929;
        Mon,  5 Sep 2022 08:07:18 +0200 (CEST)
Message-ID: <0be7f162-fe9d-1ecc-57bb-7b67cbfd50ee@molgen.mpg.de>
Date:   Mon, 5 Sep 2022 08:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/2] md/raid5: Remove unnecessary bio_put() in
 raid5_read_one_chunk()
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220902171609.23376-1-logang@deltatee.com>
 <20220902171609.23376-2-logang@deltatee.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220902171609.23376-2-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Logan, dear David,


Thank you for the patch.

Am 02.09.22 um 19:16 schrieb Logan Gunthorpe:
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

[…]

> The double free is caused by an unnecessary bio_put() in the
> if(is_badblock(...)) error path in raid5_read_one_chunk().
> 
> The error path was moved ahead of bio_alloc_clone() in c82aa1b76787c
> ("md/raid5: move checking badblock before clone bio in
> raid5_read_one_chunk"). The previous code checked and freed align_bio
> which required a bio_put. After he move that is no longer needed as

*t*he move

> raid_bio is returned to the control of the common io path which
> performs its own endio resulting in a double free on bad device blocks.
> 
> Fixes: c82aa1b76787c ("md/raid5: move checking badblock before clone bio in raid5_read_one_chunk")

This commit was added to Linux in v5.14-rc1, so it’s not a recent commit 
– or I misunderstood the cover letter.


Kind regards,

Paul


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
