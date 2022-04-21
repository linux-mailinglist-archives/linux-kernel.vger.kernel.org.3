Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263A6509BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387491AbiDUJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387485AbiDUJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:20:46 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB5255A4;
        Thu, 21 Apr 2022 02:17:55 -0700 (PDT)
Received: from [172.18.70.146] (unknown [46.183.103.17])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 103EB61EA1929;
        Thu, 21 Apr 2022 11:17:51 +0200 (CEST)
Message-ID: <b0bd9204-1f76-aba3-b754-464e28763f59@molgen.mpg.de>
Date:   Thu, 21 Apr 2022 11:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220420195425.34911-2-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Logan,


Thank you for these patches.


Am 20.04.22 um 21:54 schrieb Logan Gunthorpe:
> There are a few uses of an ugly ternary operator in raid5_make_request()
> to check if a sector is a head of a reshape sector.
> 
> Factor this out into a simple helper called ahead_of_reshape().
> 
> This appears to fix the first bio_wouldblock_error() check which appears
> to have comparison operators that didn't match the check below which
> causes a schedule. Besides this, no functional changes intended.

If there is an error, could that be fixed in a separate commit, which 
could be applied to the stable series?

> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7f7d1546b9ba..97b23c18402b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5787,6 +5787,15 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
>   	bio_endio(bi);
>   }
>   
> +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
> +			     sector_t reshape_sector)
> +{
> +	if (mddev->reshape_backwards)
> +		return sector < reshape_sector;
> +	else
> +		return sector >= reshape_sector;

I like the ternary operator. ;-)

     return mddev->reshape_backwards ? (return sector < reshape_sector) 
: (sector >= reshape_sector)

Sorry, does not matter.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>



Kind regards,

Paul


> +}
> +
>   static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   {
>   	struct r5conf *conf = mddev->private;
> @@ -5843,9 +5852,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
>   	if ((bi->bi_opf & REQ_NOWAIT) &&
>   	    (conf->reshape_progress != MaxSector) &&
> -	    (mddev->reshape_backwards
> -	    ? (logical_sector > conf->reshape_progress && logical_sector <= conf->reshape_safe)
> -	    : (logical_sector >= conf->reshape_safe && logical_sector < conf->reshape_progress))) {
> +	    !ahead_of_reshape(mddev, logical_sector, conf->reshape_progress) &&
> +	    ahead_of_reshape(mddev, logical_sector, conf->reshape_safe)) {
>   		bio_wouldblock_error(bi);
>   		if (rw == WRITE)
>   			md_write_end(mddev);
> @@ -5874,14 +5882,12 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   			 * to check again.
>   			 */
>   			spin_lock_irq(&conf->device_lock);
> -			if (mddev->reshape_backwards
> -			    ? logical_sector < conf->reshape_progress
> -			    : logical_sector >= conf->reshape_progress) {
> +			if (ahead_of_reshape(mddev, logical_sector,
> +					     conf->reshape_progress)) {
>   				previous = 1;
>   			} else {
> -				if (mddev->reshape_backwards
> -				    ? logical_sector < conf->reshape_safe
> -				    : logical_sector >= conf->reshape_safe) {
> +				if (ahead_of_reshape(mddev, logical_sector,
> +						     conf->reshape_safe)) {
>   					spin_unlock_irq(&conf->device_lock);
>   					schedule();
>   					do_prepare = true;
> @@ -5912,9 +5918,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>   				 */
>   				int must_retry = 0;
>   				spin_lock_irq(&conf->device_lock);
> -				if (mddev->reshape_backwards
> -				    ? logical_sector >= conf->reshape_progress
> -				    : logical_sector < conf->reshape_progress)
> +				if (!ahead_of_reshape(mddev, logical_sector,
> +						      conf->reshape_progress))
>   					/* mismatch, need to try again */
>   					must_retry = 1;
>   				spin_unlock_irq(&conf->device_lock);
