Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9C51F957
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiEIKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiEIKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:11:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38BE2689F2;
        Mon,  9 May 2022 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652090855; x=1683626855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B+eSCA25WCW9DWhJnn18Ar5AxTMjxoUjv6JHGGKprXM=;
  b=OVl5/33G74++3TexbNrjOjaTL3aj1mK61N9ZCXi8EtuEuyLd0m7YmQG2
   T6NDvafCdgc6QQEKLxQ+vdwSyLyJDtNkYgOGyuXfS64kppfiAccPqfgxj
   8Vp7w9gfwJZdk4zp61RpoSt21BaW7toG7uYoFIGPyLuAozTyVPrG6n6zM
   ohIAM2ubTssrgXrwwMDJooOD9opiC28RuSDND7xOUTHjbA/GJuega3kMg
   MN12M6nrBh2yrXzqByyLcw4lm/YdIVR2tovOv1haT7vFn7fWKjFE6VyOe
   gdeQeqGgb7gP2Y8gfnuvGi9pUpGyY6MC0epHv3AgWqVbxVwMXDzrHSh4X
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="256537497"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="256537497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 03:03:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="591659549"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 03:03:24 -0700
Message-ID: <9261a62d-e496-ba2b-74f4-627e0a5e6abe@intel.com>
Date:   Mon, 9 May 2022 13:03:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V5 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
Content-Language: en-US
To:     "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, linus.walleij@linaro.org,
        digetx@gmail.com, briannorris@chromium.org,
        quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1650902443-26357-5-git-send-email-quic_c_sbhanu@quicinc.com>
 <ce5582e3-0d8d-f1cf-0d23-8fbf17226775@intel.com>
 <5c2a9eae-3ab2-1fa4-c7df-ba7384e07b24@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5c2a9eae-3ab2-1fa4-c7df-ba7384e07b24@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/05/22 12:42, Sajida Bhanu (Temp) wrote:
> Hi,
> 
> Thank you for the review.
> 
> Please find the inline comments.
> 
> Thanks,
> 
> Sajida
> 
> On 4/26/2022 1:24 PM, Adrian Hunter wrote:
> 
>> On 25/04/22 19:00, Shaik Sajida Bhanu wrote:
>>> Add debug fs entry error state to query eMMC and SD card errors statistics.
>>> If any errors occurred in eMMC and SD card driver level then
>>> err_state value will be set to 1.
>>>
>>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> ---
>>>  drivers/mmc/core/debugfs.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>>> index 6aa5a60..2f5b63f 100644
>>> --- a/drivers/mmc/core/debugfs.c
>>> +++ b/drivers/mmc/core/debugfs.c
>>> @@ -222,6 +222,29 @@ static int mmc_clock_opt_set(void *data, u64 val)
>>>  
>>>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>>>  	"%llu\n");
>> A blank line would be nice here
> Sure
>>> +static int mmc_err_state_get(void *data, u64 *val)
>>> +{
>>> +	struct mmc_host *host = data;
>>> +
>>> +	if (!host)
>>> +		return -EINVAL;
>>> +
>> I am not sure why you have left out some err_stats[].
>> Why not all of them?  At least, it needs a comment to explain.
> 
> MMC_ERR_ICE_CFG --> we don't have ICE config.

So err_stats[MMC_ERR_ICE_CFG]  would be zero and make
no difference.

If you are going to check all then you could loop
through them

	*val = 0;
	for (i = 0; i < MMC_ERR_MAX; i++) {
		if (host->err_stats[i]) {
			*val = 1;
			break;
		}
	}

> 
> Remaining we need to update, Thank you for pointing.
> 
>>> +	*val = host->err_stats[MMC_ERR_REQ_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_ADMA] ||
>>> +	       host->err_stats[MMC_ERR_CTRL_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_UNEXPECTED_IRQ] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_RED] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_GCE] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_ICCE] ||
>>> +	       host->err_stats[MMC_ERR_DAT_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_DAT_CRC] ||
>>> +	       host->err_stats[MMC_ERR_CMD_CRC] ||
>>> +	       host->err_stats[MMC_ERR_CMD_TIMEOUT];
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>>>  
>>>  static int mmc_err_stats_show(struct seq_file *file, void *data)
>>>  {
>>> @@ -289,6 +312,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>>>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>>>  				   &mmc_clock_fops);
>>>  
>>> +	debugfs_create_file("err_state", 0600, root, host,
>>> +			    &mmc_err_state);
>>>  	debugfs_create_file("err_stats", 0600, root, host,
>>>  			    &mmc_err_stats_fops);
>>>  

