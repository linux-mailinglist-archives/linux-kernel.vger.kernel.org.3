Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B75362F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbiE0Mps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352147AbiE0Mo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:44:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4DD10CB;
        Fri, 27 May 2022 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653655452; x=1685191452;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6VnCHC0x9GRa5zg+b3CEdQK2vlmL+pME/qZ5s8NdHm4=;
  b=FUpxp37biKwhQtWQJ/UbkD/JIz3FZJuh71fNEUNfNNyfE6DkLodXEtS0
   STDWh+rh5qrvC3S0hvBOuVz4qCLxY514iUM8CLoAnbrQ0WM5S7O5432WZ
   Iqj8D1HTQzg8TVRnX+eVKcZEXh5H5yFWBkXqjb8cbGup2XVv2Ftink4Bj
   2csy5GfKS/kLbSIc8iE4Tw0AOoTUSyaVl9pGLBW5oXJ2lFvvB95UGDYW5
   No4D6ExEPnFC/THxrIhBXxw/bp70tUdLAKoHlxi1AOh/MLrfMlSbP97K2
   9FeyxNE24gyZV1ZZim0hyATEVN8FkuAYIk2NmRJe2o/DNmLxPV1mExLFn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="272042638"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="272042638"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 05:44:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="603864604"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 05:44:07 -0700
Message-ID: <618e533c-7155-3a8d-53f1-04c436a21364@intel.com>
Date:   Fri, 27 May 2022 15:44:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V1] mmc: core: Enable force hw reset
Content-Language: en-US
To:     "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>, quic_spathi <quic_spathi@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
 <7db46c19-a92a-a13a-eb63-38e5ed31580f@intel.com>
 <MWHPR0201MB3466CC9C676988E90D5D7D6FE3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
 <f21c11f86bf94e9b881761b9176cc45e@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f21c11f86bf94e9b881761b9176cc45e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/22 10:06, Sarthak Garg (QUIC) wrote:
> Hi Adrian,
> 
> Thanks for the review.
> Please find comments inline.
> 
> Thanks,
> Sarthak
> 
>> -----Original Message-----
>> From: Kamasali Satyanarayan (Consultant) (QUIC)
>> <quic_kamasali@quicinc.com>
>> Sent: Tuesday, May 24, 2022 5:33 PM
>> To: 'Adrian Hunter' <adrian.hunter@intel.com>; quic_spathi
>> <quic_spathi@quicinc.com>; ulf.hansson@linaro.org; riteshh@codeaurora.org;
>> asutoshd@codeaurora.org; axboe@kernel.dk; avri.altman@wdc.com;
>> kch@nvidia.com; CLoehle@hyperstone.com; swboyd@chromium.org;
>> digetx@gmail.com; bigeasy@linutronix.de; linux-mmc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Sarthak Garg (QUIC) <quic_sartgarg@quicinc.com>
>> Cc: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>> Subject: RE: [PATCH V1] mmc: core: Enable force hw reset
>>
>> Hi,
>> These patches will be further taken by Sarthak.
>>
>> Thanks,
>> Satya
>>
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Wednesday, April 27, 2022 6:04 PM
>> To: quic_spathi <quic_spathi@quicinc.com>; ulf.hansson@linaro.org;
>> riteshh@codeaurora.org; asutoshd@codeaurora.org; axboe@kernel.dk;
>> avri.altman@wdc.com; kch@nvidia.com; CLoehle@hyperstone.com;
>> swboyd@chromium.org; digetx@gmail.com; bigeasy@linutronix.de; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Shaik Sajida Bhanu <sbhanu@codeaurora.org>; Kamasali Satyanarayan
>> (Consultant) (QUIC) <quic_kamasali@quicinc.com>
>> Subject: Re: [PATCH V1] mmc: core: Enable force hw reset
>>
>> On 26/04/22 11:30, Srinivasarao Pathipati wrote:
>>> From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>>>
>>> During error recovery set need hw reset to handle ICE error where cqe
>>> reset is must.
>>
>> How do you get ICE errors?  Doesn't it mean either the hardware is broken or
>> the configuration is broken?
> 
> This patch is not intended for ice errors and will update the commit text in V2.
> Long back intermittent recovery failures were observed but after forcing hardware reset during error recovery we have no single instance of recovery failure. This have made recovery more robust for us.
> Any suggestions on how we can take it forward will be highly appreciated.

We can definitely go forward, but with hopefully a little more
explanation first.

It is preferable to be able to explain why changes are being made.

Do you have any logs or other information on the recovery failures?
Are you able to reproduce the problem?

I notice you always do mmc_blk_reset_success().  Does that mean you
sometimes need several resets in a row?

A potential issue that I notice, is that the recovery does not
explicitly deal with the case that the card's command queue has
been disabled e.g. due to RPMB access or IOCTL commands. Are you
using either of those?

>>
>>>
>>> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>>> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
>>> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
>>> ---
>>>  drivers/mmc/core/block.c      | 8 +++++---
>>>  drivers/mmc/host/cqhci-core.c | 7 +++++--
>>>  include/linux/mmc/host.h      | 1 +
>>>  3 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>>> b35e7a9..f63bf33 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -1482,10 +1482,12 @@ void mmc_blk_cqe_recovery(struct mmc_queue
>> *mq)
>>>  	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>>>
>>>  	err = mmc_cqe_recovery(host);
>>> -	if (err)
>>> +	if (err || host->need_hw_reset) {
>>>  		mmc_blk_reset(mq->blkdata, host,
>> MMC_BLK_CQE_RECOVERY);
>>> -	else
>>> -		mmc_blk_reset_success(mq->blkdata,
>> MMC_BLK_CQE_RECOVERY);
>>> +		if (host->need_hw_reset)
>>> +			host->need_hw_reset = false;
>>> +	}
>>> +	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>>>
>>>  	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));  } diff
>>> --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>> index b0d30c3..311b510 100644
>>> --- a/drivers/mmc/host/cqhci-core.c
>>> +++ b/drivers/mmc/host/cqhci-core.c
>>> @@ -812,18 +812,21 @@ static void cqhci_finish_mrq(struct mmc_host
>>> *mmc, unsigned int tag)  irqreturn_t cqhci_irq(struct mmc_host *mmc, u32
>> intmask, int cmd_error,
>>>  		      int data_error)
>>>  {
>>> -	u32 status;
>>> +	u32 status, ice_err;
>>>  	unsigned long tag = 0, comp_status;
>>>  	struct cqhci_host *cq_host = mmc->cqe_private;
>>>
>>>  	status = cqhci_readl(cq_host, CQHCI_IS);
>>>  	cqhci_writel(cq_host, status, CQHCI_IS);
>>> +	ice_err = status & (CQHCI_IS_GCE | CQHCI_IS_ICCE);
>>>
>>>  	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc),
>>> status);
>>>
>>>  	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
>>> -	    cmd_error || data_error)
>>> +	    cmd_error || data_error || ice_err){
>>> +		mmc->need_hw_reset = true;
>>>  		cqhci_error_irq(mmc, status, cmd_error, data_error);
>>> +	}
>>>
>>>  	if (status & CQHCI_IS_TCC) {
>>>  		/* read TCN and complete the request */ diff --git
>>> a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
>>> c193c50..3d00bcf 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -492,6 +492,7 @@ struct mmc_host {
>>>  	int			cqe_qdepth;
>>>  	bool			cqe_enabled;
>>>  	bool			cqe_on;
>>> +	bool                    need_hw_reset;
>>>
>>>  	/* Inline encryption support */
>>>  #ifdef CONFIG_MMC_CRYPTO
>>
> 

