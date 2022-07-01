Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAA56348A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiGANpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGANpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:45:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2661423141;
        Fri,  1 Jul 2022 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656683121; x=1688219121;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=iYv9Qezv4/lhS1d/VQNMLKO5WRrxcyJmyqSpvuWM0rU=;
  b=DOBrGw82aTfsSXizdi/QiMTOv12oqv6j/2oomS60RFSJge5c3RfQ7JF5
   VVkkhzSXZCXHwUVAG08xRSx4Cg01dnR6vm+ftVC/TXrEvbMpEg4zm4qLk
   p5FSO5TgogjJe6efl0rJuZl+pyP6BQxi3kDlA1P/iR1s7c4+Gpy/odxU/
   37+sQ8aOKi1DjwoM2QE53yA8vAZlqDWtiAM+1u4nBYYkqhcmr2/bampDX
   kGBKJHA28ogqrUiTucjzMDi+q8rU7Jk/B3Z9tdbxSHWwPs+E4V2PkjB5r
   FGDs5mY3MLiJO/qkXNEOCVBEQ3fivNmoGUsZOKFcWvILJWvdmB6ZdVFkj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="263053329"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="263053329"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:45:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="648351854"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:45:19 -0700
Message-ID: <5463745a-4f62-095f-994c-982e8fcc85d9@intel.com>
Date:   Fri, 1 Jul 2022 16:45:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCHv4] mmc: block: Add single read for 4k sector cards
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/07/22 15:43, Christian Loehle wrote:
> Cards with 4k native sector size may only be read 4k-aligned,
> accommodate for this in the single read recovery and use it.
> 
> Fixes: 81196976ed946 (mmc: block: Add blk-mq support)
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f4a1281658db..912a398a9a76 100644
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
> @@ -1368,12 +1368,12 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>  			brq->data.blocks--;
>  
>  		/*
> -		 * After a read error, we redo the request one sector
> +		 * After a read error, we redo the request one (native) sector
>  		 * at a time in order to accurately determine which
>  		 * sectors can be read successfully.
>  		 */
> -		if (disable_multi)
> -			brq->data.blocks = 1;
> +		if (recovery_mode)
> +			brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
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
> +	size_t bytes_per_read = queue_physical_block_size(mq->queue);
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
> @@ -1879,10 +1880,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>  		return;
>  	}
>  
> -	/* FIXME: Missing single sector read for large sector size */
> -	if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
> -	    brq->data.blocks > 1) {
> -		/* Read one sector at a time */
> +	if (rq_data_dir(req) == READ && brq->data.blocks >
> +			queue_physical_block_size(mq->queue) >> 9) {
> +		/* Read one (native) sector at a time */
>  		mmc_blk_read_single(mq, req);
>  		return;
>  	}

