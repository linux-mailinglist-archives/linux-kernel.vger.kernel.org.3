Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1A580352
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiGYRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiGYRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:08:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2917A8C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658768911; x=1690304911;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gaRQ8OrgasXoKsBE8DAQZEaK2QlXpbZjuu5pCy7Jz7A=;
  b=liuffyM1W+OXR1xZOoLDaUXD0/7j8jbhCKp7Y69chKlSQtbP6vWkqB4I
   5dQVqKmeJszgbYk4j6Q9wu4ubWPNKEnm7ICmdaWf7mtxPiwvw4YP2tzny
   /V0a6hR2WgEL3fXTclBDa4qRSpfl65rYmOUvElO0Dso27xdJD84RKXpPe
   rhWXhTt84yjbAgHWYTE2Wp9qXkXUCoWTV0qBBsN1QZ/E+6TBBB225D83Y
   3GlEJW5LRz6Y/WUbeNcEBmsTQ6doa6uCiteWqMBjlhuIQQKW4uQoYEabZ
   /HaMGk1P9qT5sRaFy4urjgpE85VQz7LdX6NgSKzKzTm4kseJyS45/iEfG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="287760213"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="287760213"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:08:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550062688"
Received: from jxzhao-mobl.amr.corp.intel.com (HELO [10.212.0.178]) ([10.212.0.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:08:30 -0700
Message-ID: <bdaec1b0-1385-b376-7640-61d363c9b009@linux.intel.com>
Date:   Mon, 25 Jul 2022 10:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: max98373: Removing 0x203E from the volatile reg
Content-Language: en-US
To:     Ryan Lee <ryan.lee.analog@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, steve@sk2.org,
        ryans.lee@analog.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220723015220.4169-1-ryans.lee@analog.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220723015220.4169-1-ryans.lee@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/22 20:52, Ryan Lee wrote:
> The 0x203E speaker gain register should be non-volatile.
> This register value was not able to be synced because it was marked as
> volatile.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
>  sound/soc/codecs/max98373-i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
> index 4fe065ece17c..3e04c7f0cce4 100644
> --- a/sound/soc/codecs/max98373-i2c.c
> +++ b/sound/soc/codecs/max98373-i2c.c
> @@ -442,7 +442,6 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
> -	case MAX98373_R203E_AMP_PATH_GAIN:

That register isn't declared as volatile for the SoundWire case so that
sounds like a good fix

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>  	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
>  	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
>  	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
