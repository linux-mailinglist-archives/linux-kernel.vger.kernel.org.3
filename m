Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA55A7F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiHaNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiHaNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:50:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E131F2DB;
        Wed, 31 Aug 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661953804; x=1693489804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=StgOlXRVFmodsSKsgmXwtU3XrkGBQwDW/2gFO7/DX/M=;
  b=G88TbNbf1tjs6UeE+guoUyA1r2BHft7DhvHozHDpSlYUAu8uf7d3jtlf
   jcADjHYUynxdlwdeChlnV8aQMfLCnhL3C07alzT96Ik749IxAuUwwfW68
   hw0Ph3m6Ok8HnE+GYSHJOAMhORxc/xjYZo9T58i1UJZOI5S1UrZd8v8Lp
   1C0jYAVAeP0IjvlAyqR42xzWBpRKUgy0rkOmPnr72UTRILUDTYwuGFV1Q
   4+H0v0gj10pnEgVFxqEenKYtM6Yh6m8w/wwSYLawucGMVQEJCchJ0M1KJ
   tYWll6sRON8EOxAVjtP4FLL64WNf/HUJpNfWOmbp841UlYcd2bn90eXMR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275851947"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275851947"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:49:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="641877383"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.241])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:49:53 -0700
Message-ID: <7c02ec7c-fc6c-77a1-5ccd-bb35bddbe79d@intel.com>
Date:   Wed, 31 Aug 2022 16:49:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIFYxIDEvMV0gbW1jOnNkaGNpOkZpeCB0?=
 =?UTF-8?Q?he_SD_tuning_CMD_parameter_issue_that_the_SDHCI=5fTRANSFER=5fMODE?=
 =?UTF-8?Q?_is_cleared_from_read_direction_to_write_direction_incorrectly?=
Content-Language: en-US
To:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Charl Liu (WH)" <charl.liu@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Thomas Hu(WH)" <thomas.hu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
References: <20220720123737.117-1-charl.liu@bayhubtech.com>
 <69334100-1ba7-50e1-5d0e-83081c2241d7@intel.com>
 <PH0PR16MB4248A089CB5FF2BEC527742FEA789@PH0PR16MB4248.namprd16.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <PH0PR16MB4248A089CB5FF2BEC527742FEA789@PH0PR16MB4248.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/22 15:04, Chevron Li (WH) wrote:
> Hi, Adrian,
> 
> Sorry response you so late.
> 
> Does your comment "mmc_op_tuning() could be used here" means that we should use mmc_send_tuning() instead of sdhci_send_tuning?

I just meant, instead of:

-			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			if ((cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+			    (cmd->opcode != MMC_SEND_TUNING_BLOCK))

this is simpler:

-			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			if (!mmc_op_tuning(cmd->opcode))


> 
> If yes, I think we need add below patch commit by Charl Liu for those reasons:
> 1.Bayhub host tuning command does not have a data payload and our hardware does it automatically, so mmc_send_tuning() will return -EIO.
> 2.Bayhub host can be used for both SD and eMMC cards.
> 3.Both MMC_SEND_TUNING_BLOCK and MMC_SEND_TUNING_BLOCK_HS200 are tuning command opcode, maybe the same logical at here is better? 
> 
> BR,
> Chevron
> 
> -----邮件原件-----
> 发件人: Adrian Hunter <adrian.hunter@intel.com> 
> 发送时间: Sunday, July 24, 2022 15:22
> 收件人: Charl Liu (WH) <charl.liu@bayhubtech.com>; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> 抄送: Shaper Liu (WH) <shaper.liu@bayhubtech.com>; Chevron Li (WH) <chevron.li@bayhubtech.com>; Thomas Hu(WH) <thomas.hu@bayhubtech.com>; XiaoGuang Yu (WH) <xiaoguang.yu@bayhubtech.com>; Shirley Her(SC) <shirley.her@bayhubtech.com>
> 主题: Re: [PATCH V1 1/1] mmc:sdhci:Fix the SD tuning CMD parameter issue that the SDHCI_TRANSFER_MODE is cleared from read direction to write direction incorrectly
> 
> On 20/07/22 15:37, Charl Liu wrote:
>> When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE 
>> should also be kept
>>
>> Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
>> ---
>> Change in V1:
>> Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_ 
>> BLOCK
>> ---
>>  drivers/mmc/host/sdhci.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index 
>> 22152029e14c..6a0f6725dadb 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1430,7 +1430,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>  		if (host->quirks2 &
>>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>>  			/* must not clear SDHCI_TRANSFER_MODE when tuning */
>> -			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +			if ((cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
>> +			(cmd->opcode != MMC_SEND_TUNING_BLOCK))
> 
> mmc_op_tuning() could be used here
> 
>>  				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>>  		} else {
>>  		/* clear Auto CMD settings for no data CMDs */
> 

