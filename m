Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC84DAA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiCPF75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiCPF7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:59:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FD5F24B;
        Tue, 15 Mar 2022 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647410319; x=1678946319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zfZnlOFK8Z/4hc0pM9Fr+RCd2hrVL1WnE5hcxyw+apA=;
  b=iLjQEmlEa6JpTG+bwripT+mpqswsg4S48Qq2xorN0czin1CdcBrgLvfk
   R5NqAG9elqNfqDGFd8l+Of7+ixUXb2N4+FV/kdZ9g3NFr+8yFiO8TiUar
   BtTlSSSpxR4NrGEXhusVMyQmpqm6NaYw934Cp8RKyYZPBR9U/5FXNNOB8
   cJSZhFPHP9FWZvATt1wLXXQm5EmpoWBlMvQuWdiG56mrXE5XzZsoHgpjE
   FrEFwAk7fIT3NTxw0Chc/rtY3RiO4oxJblZPX2MO4zzK0SakoJ17UMpcP
   gCwhORDWtfMYebtd571iTO010bwrDfnUo3ziMBkzfl/mYaHkLZu7VrQO+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342930172"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="342930172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516194047"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 22:58:04 -0700
Message-ID: <d30b5ded-c777-4de1-c48f-e7ac1ac37a3b@intel.com>
Date:   Wed, 16 Mar 2022 07:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Content-Language: en-US
To:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
 <01515ee6-b312-7f81-43f0-e72a0d290046@intel.com>
 <SJ0PR02MB8449518ACEA501523DB8E558CD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <SJ0PR02MB8449518ACEA501523DB8E558CD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 20:15, Sajida Bhanu (Temp) (QUIC) wrote:
> Hi,
> 
> Thanks for the review.
> 
> Please find the inline comments.
> 
> Thanks,
> Sajida
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Tuesday, March 8, 2022 3:36 PM
>> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>; Asutosh
>> Das (asd) <asutoshd@quicinc.com>; ulf.hansson@linaro.org;
>> agross@kernel.org; bjorn.andersson@linaro.org; linux-
>> mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: Veerabhadrarao Badiganti (QUIC) <quic_vbadigan@quicinc.com>; Ram
>> Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati
>> (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC)
>> <quic_sartgarg@quicinc.com>; Nitin Rawat (QUIC)
>> <quic_nitirawa@quicinc.com>; Sayali Lokhande (QUIC)
>> <quic_sayalil@quicinc.com>; Sayali Lokhande <sayalil@codeaurora.org>; Bao
>> D . Nguyen <nguyenb@codeaurora.org>
>> Subject: Re: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
>>
>> On 2.3.2022 15.03, Shaik Sajida Bhanu wrote:
>>> Set error state if any errors observed in eMMC and SD card driver level.
>>>
>>> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
>>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>>> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>>> 741fb06..4ba3797 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -224,6 +224,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>>>  		if (timedout) {
>>>  			pr_err("%s: Reset 0x%x never completed.\n",
>>>  				mmc_hostname(host->mmc), (int)mask);
>>> +			if (host->mmc && !host->mmc->err_state)
>>> +				mmc_debugfs_err_stats_enable(host-
>>> mmc);
>>
>> I really do not understand why this cannot be another err_stats entry such as
>> MMC_ERR_DRIVER and then as below?
>>
>> 			sdhci_err_stats_inc(host, DRIVER);
>>
>>
> Hi,
> 
> err_stats having all the error types.
> err_state is not the error type, if err_state set means some errors occurred in driver and we will go and check err_stats to know exact error.


In sdhci.c use only sdhci_err_stats_inc() adding err_stats entries as needed.
Seems like there are controller timeouts (say MMC_ERR_CTRL_TIMEOUT) and
unexpected interrupts (say MMC_ERR_UNEXPECTED_IRQ)

In drivers/mmc/core/debugfs.c calculate err_state as needed e.g.

static int mmc_err_state_get(void *data, u64 *val)
{
	struct mmc_host *host = data;

	*val = host->err_stats[MMC_ERR_REQ_TIMEOUT] ||
	       host->err_stats[MMC_ERR_CTRL_TIMEOUT] ||
	       host->err_stats[MMC_ERR_UNEXPECTED_IRQ] ||
	       <etc>

	return 0;
}
