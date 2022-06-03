Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600F53C451
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiFCFeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiFCFeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:34:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8B38DB6;
        Thu,  2 Jun 2022 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654234442; x=1685770442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dsMVJcKJEcaeF8QAGuahkwXPqxSC4I8wQTrHBh2W82k=;
  b=aQk/nJQlSVQA9F0hHPsyA3DL/4VHyww1PUyrEavj/zfAfUgfu24SeCg2
   OmHv/NXu+QS1bq/TaJS65LVG5XW2Aqz9b9O0caK+UX/Uw+1WiVBOA8JI5
   3WGl8/drixLYjUU+2tuQ7bRTr3uJzghZTHjIT+7dI6UoBeUpb3KEYv2ga
   T+nWANYUv9mIwfjKmJQjxOXK6PhYsIckUDiggwybYrAkybORk1lUjIZ1k
   RlPCCNrMWO0lPMVPEuvCgmXEN3T35LwL4KrgUXKmeYs5tE5AjbD+E+6ZK
   I/OK4M8ESNuFbnGJpoNQlfBqjRwxw03xZWSJyO2isYL2a/d7f/cxbixHe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263815475"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="263815475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 22:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="607227864"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.54.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 22:33:50 -0700
Message-ID: <bbcd824b-457a-1009-835d-3e51ed04c1c2@intel.com>
Date:   Fri, 3 Jun 2022 08:33:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V1 1/2] mmc: core: Introduce new flag to force hardware
 reset
Content-Language: en-US
To:     Sarthak Garg <quic_sartgarg@quicinc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Jens Axboe <axboe@kernel.dk>,
        Avri Altman <Avri.Altman@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Bean Huo <beanhuo@micron.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
References: <20220603051534.22672-1-quic_sartgarg@quicinc.com>
 <20220603051534.22672-2-quic_sartgarg@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220603051534.22672-2-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/06/22 08:15, Sarthak Garg wrote:
> Introduce new flag cqe_recovery_reset_always to allow vendors to force
> hardware reset during cqe recovery.
> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>

You should re-base on top of "mmc: block: Fix CQE recovery reset success"

Also you may want to consider fixes / stable tags.

Otherwise, for both patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c | 2 +-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1259ca22d625..496cdd8a2999 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1497,7 +1497,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>  	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>  
>  	err = mmc_cqe_recovery(host);
> -	if (err)
> +	if (err || host->cqe_recovery_reset_always)
>  		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
>  	else
>  		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c193c50ccd78..3e2fe950b4ec 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -492,6 +492,7 @@ struct mmc_host {
>  	int			cqe_qdepth;
>  	bool			cqe_enabled;
>  	bool			cqe_on;
> +	bool			cqe_recovery_reset_always;
>  
>  	/* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO

