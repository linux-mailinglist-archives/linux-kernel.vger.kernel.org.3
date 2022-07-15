Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E293B575FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiGOLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:24:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95A13DDA;
        Fri, 15 Jul 2022 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657884294; x=1689420294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JNPs4/IF9I3v2fBpT9/SGwbwqcvHXBKUeiu4ZOuzkhE=;
  b=d6vlxd9M05hidsXkn/J5dfmzryZu3d8h3yie6Wvh63HMxFenJU7sYk6x
   mrdZABYB4PpqPo1/w8um9UdBMZNiTZatNY/dH7uGGJm5SB70n3ylDr71+
   Qc/iXC9orWOEWgQyomsxY2mOyKQ2jd3XXIyRRahrzlqUx0iYR0vvgnVmF
   9zukeAuGK10F4JpOjnYW8DALxHVH0q6UaoDUce3BV31t9wcgVlUOcqfMu
   LpDc93ZVsFNRil3kxL+s9DmEgIpz0fsRlI2Xr3o+6OBlFSGt4pqRkHwya
   tks9Od3dxatRJ2WdbVotAMbSvtmS0Y8RrPi3vKQ/rQe3vd37GDlorqf/k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349732046"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="349732046"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 04:24:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="654298689"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.80])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 04:24:50 -0700
Message-ID: <13af7867-4a42-751c-e7b1-9af4e239c085@intel.com>
Date:   Fri, 15 Jul 2022 14:24:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: ufs: ufshcd: Read device property for ref clock
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/22 14:03, Daniil Lunev wrote:
> UFS storage devices require bRefClkFreq attribute to be set to operate
> correctly at high speed mode. The necessary value is determined by what the
> SoC / board supports. The standard doesn't specify a method to query the
> value, so the information needs to be fed in separately.
> 
> DT information feeds into setting up the clock framework, so platforms
> using DT can get the UFS reference clock frequency from the clock
> framework. A special node "ref_clk" from the clock array for the UFS
> controller node is used as the source for the information.
> 
> On the platforms that do not use DT (e.g. Intel), the alternative mechanism
> to feed the intended reference clock frequency is necessary. Specifying the
> necessary information in DSD of the UFS controller ACPI node is an
> alternative mechanism proposed in this patch. Those can be accessed via
> firmware property facility in the kernel and in many ways simillar to
> querying properties defined in DT.
> 
> This patch introduces a small helper function to query a predetermined ACPI
> supplied property of the UFS controller, and uses it to attempt retrieving
> reference clock value, unless that was already done by the clock
> infrastructure.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
>  Documentation/scsi/ufs.rst | 15 +++++++++++++++
>  drivers/ufs/core/ufshcd.c  | 16 ++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/scsi/ufs.rst b/Documentation/scsi/ufs.rst
> index fbac745b783ce..885b1a736e3f3 100644
> --- a/Documentation/scsi/ufs.rst
> +++ b/Documentation/scsi/ufs.rst
> @@ -17,6 +17,8 @@ Universal Flash Storage
>       3.2 UTP Transfer requests
>       3.3 UFS error handling
>       3.4 SCSI Error handling
> +   4. BSG Support
> +   5. UFS Reference Clock Frequency configuration
>  
>  
>  1. Overview
> @@ -193,3 +195,16 @@ UFS specifications can be found at:
>  
>  - UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
>  - UFSHCI - http://www.jedec.org/sites/default/files/docs/JESD223.pdf
> +
> +5. UFS Reference Clock Frequency configuration
> +==============================================
> +
> +Devicetree can define a clock named "ref_clk" under the UFS controller node
> +to specify the intended reference clock frequency for the UFS storage
> +parts. ACPI-based system can specify the frequency using ACPI
> +Device-Specific Data property named "ref-clk-freq". In both ways the value
> +is interpreted as frequency in Hz and must match one of the values given in
> +the UFS specification. UFS subsystem will attempt to read the value when
> +executing common controller initialization. If the value is available, UFS
> +subsytem will ensure the bRefClkFreq attribute of the UFS storage device is
> +set accordingly and will modify it if there is a mismatch.
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ce86d1b790c05..78242f189f636 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8536,6 +8536,19 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
>  	return ret;
>  }
>  
> +static enum ufs_ref_clk_freq ufshcd_parse_ref_clk_property(struct ufs_hba *hba)
> +{
> +	u32 freq;
> +	int ret = device_property_read_u32(hba->dev, "ref-clk-freq", &freq);
> +
> +	if (ret) {
> +		dev_dbg(hba->dev, "Cannnot query 'ref-clk-freq' property = %d", ret);
> +		return REF_CLK_FREQ_INVAL;
> +	}
> +
> +	return ufs_get_bref_clk_from_hz(freq);
> +}
> +
>  static int ufshcd_init_clocks(struct ufs_hba *hba)
>  {
>  	int ret = 0;
> @@ -8629,6 +8642,9 @@ static int ufshcd_hba_init(struct ufs_hba *hba)
>  	if (err)
>  		goto out_disable_hba_vreg;
>  
> +	if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +		hba->dev_ref_clk_freq = ufshcd_parse_ref_clk_property(hba);
> +
>  	err = ufshcd_setup_clocks(hba, true);
>  	if (err)
>  		goto out_disable_hba_vreg;

