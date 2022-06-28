Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DD55C4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiF1H4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiF1H4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:56:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B411581C;
        Tue, 28 Jun 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656402990; x=1687938990;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=S8NYqKZWJ95vXvA9MpHwV3qXnaZ8/CF+EBJ0kgg+LhM=;
  b=RLmw9SoNs1N2nqyiSQcyX8x4erdFIsdpNzqlfTE+VAS7rGEua4YfOS9O
   eMVV2RYO7w1RzCpXs48mIk/75x/wKsfgP+lpSIk30Wj6gVbnLPx824AE2
   0qbfMX4lWr426uDm4pT2zed2X+RWdxq2rFm8Ibea6bu3eIYXVZAgc+f3c
   QoyC8qF4waO93Zu8NmDj9ylwBKg/n5fPD7xhnHf0GZ5l6QnYzhKZAa81N
   fCcXjErP8L3q+F3YHmFoOzuC1sCMW4qc2uP2yQeAyQmYOJxWSfnmswSOU
   sIP5iUA1CHlMEY27jPJKhSEdqW31lDOXw4uIQzDOzKBAqjSemw/rrqoMQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261471815"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261471815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:56:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646804862"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.204])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:56:14 -0700
Message-ID: <bd0f9fb2-c641-5ad1-c70c-45a9a6e80642@intel.com>
Date:   Tue, 28 Jun 2022 10:56:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCHv2] mmc: block: Add single read for 4k sector cards
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6e379c703fe149e1923b31df1a33701e@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6e379c703fe149e1923b31df1a33701e@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/22 18:29, Christian Löhle wrote:
> Cards with 4k native sector size may only be read 4k-aligned,
> accommodate for this in the single read recovery and use it.

Thanks for the patch.

> 
> Fixes: 81196976ed946 (mmc: block: Add blk-mq support)
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

FYI checkpatch says:

WARNING: From:/Signed-off-by: email name mismatch: 'From: "Christian Löhle" <CLoehle@hyperstone.com>' != 'Signed-off-by: Christian Loehle <cloehle@hyperstone.com>'

> ---
>  drivers/mmc/core/block.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f4a1281658db..a75a208ce203 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -176,7 +176,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
>  				      unsigned int part_type);
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			       struct mmc_card *card,
> -			       int disable_multi,
> +			       int recovery_mode,
>  			       struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>  
> @@ -1302,7 +1302,7 @@ static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>  }
>  
>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> -			      int disable_multi, bool *do_rel_wr_p,
> +			      int recovery_mode, bool *do_rel_wr_p,
>  			      bool *do_data_tag_p)
>  {
>  	struct mmc_blk_data *md = mq->blkdata;
> @@ -1372,8 +1372,8 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>  		 * at a time in order to accurately determine which
>  		 * sectors can be read successfully.
>  		 */
> -		if (disable_multi)
> -			brq->data.blocks = 1;
> +		if (recovery_mode)
> +			brq->data.blocks = mmc_large_sector(card) ? 8 : 1;

I suggest changing to use queue_physical_block_size() here and further below

			brq->data.blocks = queue_physical_block_size(req->q) >> SECTOR_SHIFT;

>  
>  		/*
>  		 * Some controllers have HW issues while operating
> @@ -1590,7 +1590,7 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>  
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			       struct mmc_card *card,
> -			       int disable_multi,
> +			       int recovery_mode,
>  			       struct mmc_queue *mq)
>  {
>  	u32 readcmd, writecmd;
> @@ -1599,7 +1599,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  	struct mmc_blk_data *md = mq->blkdata;
>  	bool do_rel_wr, do_data_tag;
>  
> -	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
> +	mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
>  
>  	brq->mrq.cmd = &brq->cmd;
>  
> @@ -1690,7 +1690,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
>  
>  #define MMC_READ_SINGLE_RETRIES	2
>  
> -/* Single sector read during recovery */
> +/* Single (native) sector read during recovery */
>  static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>  {
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> @@ -1698,6 +1698,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>  	struct mmc_card *card = mq->card;
>  	struct mmc_host *host = card->host;
>  	blk_status_t error = BLK_STS_OK;
> +	size_t bytes_per_read = mmc_large_sector(card) ? 4096 : 512;

	size_t bytes_per_read = queue_physical_block_size(req->q);

>  
>  	do {
>  		u32 status;
> @@ -1732,13 +1733,13 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>  		else
>  			error = BLK_STS_OK;
>  
> -	} while (blk_update_request(req, error, 512));
> +	} while (blk_update_request(req, error, bytes_per_read));
>  
>  	return;
>  
>  error_exit:
>  	mrq->data->bytes_xfered = 0;
> -	blk_update_request(req, BLK_STS_IOERR, 512);
> +	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
>  	/* Let it try the remaining request again */
>  	if (mqrq->retries > MMC_MAX_RETRIES - 1)
>  		mqrq->retries = MMC_MAX_RETRIES - 1;
> @@ -1879,10 +1880,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>  		return;
>  	}
>  
> -	/* FIXME: Missing single sector read for large sector size */
> -	if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
> -	    brq->data.blocks > 1) {
> -		/* Read one sector at a time */
> +	if (rq_data_dir(req) == READ && brq->data.blocks > 1) {
> +		/* Read one (native) sector at a time */
>  		mmc_blk_read_single(mq, req);
>  		return;
>  	}

