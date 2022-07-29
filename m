Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32DF584D19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiG2ICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiG2ICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:02:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E780F44;
        Fri, 29 Jul 2022 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659081743; x=1690617743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d0OEfYLhT9pPlxoUCYRjyRAQjyV8GZZUnsYK4JQajk4=;
  b=JTGvUBNRlGtuCnMCIftqV2/FD/z6R5hv73ntijIfPU+GMOGbsigNF4mZ
   mIce9KJ2Fb1x3R+b/B+kCspIXv30geOEczO+3vQu5EuQStk1HQ87fbX+I
   nHU85VTgDPHhcOFkfiybfh2Ukz115s/OLwXbIwaFl4fu7yZQroh+LhFRl
   in8+kACk4iv16y94Vr3D14wxElyQVPz3Lc6rReyWG6yj103iMAh4GMnGY
   1/kClxmhMd18dZRydo5QU4hKZqnOXMg7gO+dgsmU5euxqt+JnDKhcuqLH
   mv/+1lfAzN61vOx+sW+gVVeTdZEUKGCX/Kjp68BagTkGX5SX/mvOrqHJu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="352717824"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="352717824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 01:02:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="660140521"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 01:02:19 -0700
Message-ID: <4b889b61-5aa0-892f-0808-352545193e47@intel.com>
Date:   Fri, 29 Jul 2022 11:02:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] scsi: ufs: ufs-pci: Correct check for RESET DSM
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220728111748.v3.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220728111748.v3.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
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

On 28/07/22 04:18, Daniil Lunev wrote:
> dsm_fns is a bitmap, and it is 0-indexed according to the check in
> __intel_dsm function. But common initialization was checking it as if it
> was 1-indexed. This patch corrects the discrepancy. This change won't
> break any existing calls to the function, since before the change both
> bits 0 and 1 were checked and needed to be set.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v3:
> * Commit message typos
> * Args indentation
> 
> Changes in v2:
> * Make __INTEL_DSM_SUPPORTED a function
> * use `1u` instead of `1` in shift operator
> 
>  drivers/ufs/host/ufshcd-pci.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
> index 04166bda41daa..b9572fcc3bda5 100644
> --- a/drivers/ufs/host/ufshcd-pci.c
> +++ b/drivers/ufs/host/ufshcd-pci.c
> @@ -24,7 +24,7 @@ struct ufs_host {
>  	void (*late_init)(struct ufs_hba *hba);
>  };
>  
> -enum {
> +enum intel_ufs_dsm_func_id {
>  	INTEL_DSM_FNS		=  0,
>  	INTEL_DSM_RESET		=  1,
>  };
> @@ -42,6 +42,15 @@ static const guid_t intel_dsm_guid =
>  	GUID_INIT(0x1A4832A0, 0x7D03, 0x43CA,
>  		  0xB0, 0x20, 0xF6, 0xDC, 0xD1, 0x2A, 0x19, 0x50);
>  
> +static bool __intel_dsm_supported(struct intel_host *host,
> +				  enum intel_ufs_dsm_func_id fn)
> +{
> +	return fn < 32 && fn >= 0 && (host->dsm_fns & (1u << fn));
> +}
> +
> +#define INTEL_DSM_SUPPORTED(host, name) \
> +	__intel_dsm_supported(host, INTEL_DSM_##name)
> +
>  static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  		       unsigned int fn, u32 *result)
>  {
> @@ -71,7 +80,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  static int intel_dsm(struct intel_host *intel_host, struct device *dev,
>  		     unsigned int fn, u32 *result)
>  {
> -	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
> +	if (!__intel_dsm_supported(intel_host, fn))
>  		return -EOPNOTSUPP;
>  
>  	return __intel_dsm(intel_host, dev, fn, result);
> @@ -300,7 +309,7 @@ static int ufs_intel_device_reset(struct ufs_hba *hba)
>  {
>  	struct intel_host *host = ufshcd_get_variant(hba);
>  
> -	if (host->dsm_fns & INTEL_DSM_RESET) {
> +	if (INTEL_DSM_SUPPORTED(host, RESET)) {
>  		u32 result = 0;
>  		int err;
>  
> @@ -342,7 +351,7 @@ static int ufs_intel_common_init(struct ufs_hba *hba)
>  		return -ENOMEM;
>  	ufshcd_set_variant(hba, host);
>  	intel_dsm_init(host, hba->dev);
> -	if (host->dsm_fns & INTEL_DSM_RESET) {
> +	if (INTEL_DSM_SUPPORTED(host, RESET)) {
>  		if (hba->vops->device_reset)
>  			hba->caps |= UFSHCD_CAP_DEEPSLEEP;
>  	} else {

