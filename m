Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC981554980
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355209AbiFVIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354745AbiFVIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:40:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD29F7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887243; x=1687423243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tl2qUZB6PuyGPDvcow6eu6mLNljNYkxedfCib16DPLI=;
  b=GrizN5JKNr2T2C9BDMQxLiRqSpplbaOkVt89SV5fURr9o8Wmp1rqoI1S
   N4k/2GaYtz6ubxuH9dUTOu+E2knMKUF7iSY9y1XsogpwtJRCdSkKyEykW
   kez6Q/VLz32PuA21YublkK0YBvhPp1j3JYzGWdAQjJHMI/gsdEFaom0wr
   KgGv5T0Y5wNCQRZ3vIcZo+iJkfccShEDObKTGbMcUzhlRpFK4g7FlKAH0
   5WhkcSN065zhLX31T/F16Zj8V5lxzQIn8/R1uPLpd67qA7ZB7uy3QPANm
   9aK6Dr5xq0Iw/xgrsdUoZ0E0NEpCZeWqawOL4frnxALt42UJ3TOVg85/K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263391033"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="263391033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644080113"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.103]) ([10.99.249.103])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:40 -0700
Message-ID: <298dd904-586a-d09f-2e14-0e0fc45385fa@linux.intel.com>
Date:   Wed, 22 Jun 2022 10:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 07/14] ALSA: hda: cs35l41: Support multiple load paths
 for firmware
Content-Language: en-US
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
 <20220622074653.179078-8-vitalyr@opensource.cirrus.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220622074653.179078-8-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2022 9:46 AM, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> To be able to support different firmwares and tuning
> for different models, the driver needs to be able to
> load a different firmware and coefficient file based
> on its Subsystem ID.
> 
> The driver attempts to load the firmware in the
> following order:
> 
> /lib/firmware/cirrus/cs35l41-dsp1-<fw-type>-<ssid>-dev<#>.wmfw
> /lib/firmware/cirrus/cs35l41-dsp1-<fw-type>-<ssid>.wmfw
> /lib/firmware/cirrus/cs35l41-dsp1-<fw-type>.wmfw
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

...

	    CS35L41_FIRMWARE_ROOT, NULL, NULL, "wmfw");
> +	if (!ret) {
> +		/* fallback try cirrus/part-dspN-fwtype.bin */
>   		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
> -					      CS35L41_FIRMWARE_ROOT, "bin");
> +					      CS35L41_FIRMWARE_ROOT, NULL, NULL, "bin");
>   		return 0;
>   	}
>   
> @@ -143,7 +183,6 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
>   	return ret;
>   }
>   
> -

You add unnecessary line in patch 4 and remove in this one?

>   static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
>   {
>   	const struct firmware *coeff_firmware = NULL;

