Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4913257F3A8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiGXHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiGXHVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:21:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E353C18B39;
        Sun, 24 Jul 2022 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658647311; x=1690183311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4GmNq+GGcx6lQyvDn2BjOxv6jRLWbFXCskzq4bO9cNs=;
  b=cNVF31mAHMab4aEs5w+sqKLmvUKDU6BJ86YGLuW2ZS/xJ/aa64l5My8y
   gA/S+WErvwoO3LcSid+seuna4gV6TeSVMrm7cpNLn+Xfil5NjCvq9sDFt
   s6ekZfmn6hzvfylRMX+NvruCPCyjl99DHTsaY4ofgBUD488NBbQzD9nZh
   E0UJa8qG8OUQFpfnvfAaFiJBS5PAnxbVLg/DRqVQdC4kUKeOzuNgL7XFr
   PDy5OzajLm0FvywNu9xia82gu0e1EoK1hoGrKg2gxVNwaHloIz15ouvRm
   4TV98wNI/7r2vvx1m1CilFmxjNY7t+6hnToLogpWEvQFQROxUTawzJvdP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286281634"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="286281634"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:21:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657737621"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:21:48 -0700
Message-ID: <69334100-1ba7-50e1-5d0e-83081c2241d7@intel.com>
Date:   Sun, 24 Jul 2022 10:21:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/1] mmc:sdhci:Fix the SD tuning CMD parameter issue
 that the SDHCI_TRANSFER_MODE is cleared from read direction to write
 direction incorrectly
Content-Language: en-US
To:     Charl Liu <charl.liu@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
References: <20220720123737.117-1-charl.liu@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220720123737.117-1-charl.liu@bayhubtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/22 15:37, Charl Liu wrote:
> When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
> should also be kept
> 
> Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
> ---
> Change in V1:
> Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_
> BLOCK
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 22152029e14c..6a0f6725dadb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1430,7 +1430,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
>  			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> -			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +			if ((cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> +			(cmd->opcode != MMC_SEND_TUNING_BLOCK))

mmc_op_tuning() could be used here

>  				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */

