Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE242562227
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiF3SfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiF3SfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:35:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152003CA54;
        Thu, 30 Jun 2022 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656614107; x=1688150107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfMvz34IQ1XlB/cxYb48cOD/Af4s6wGj7oK89k9bGoY=;
  b=IQCfJNOiwSujioUwO6dAZTa3HzwU3m2EQpa2Vgk1y/JZA0RPK6eCJtJX
   MhTPhj4crEj+5JkkLLCR9UqkS4iBQt6Uis2fqHLsb8mS8yvg9QVIWZ3s0
   ZPeCOZ0KoCUyq/utwD9kLEAYiWmVsF3HTOO5BBioDXv21ygvlVF/LnMXM
   9ZRKNSqI8lvuL7mb31UHyKK2LncO7ypDGVbrNRtK/Uk8S1pf+MxmUD1gb
   dTgGysIlsEVNc74Ad5kqLPsb6WCDGmFplTSPXqUwFEMB10/w7MHGXlD4N
   8r9/MXEbXkStXi7VAsmy2BTGXRm78pQM+SAYTLZP55lf130qNAeewe+ox
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262233449"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="262233449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 11:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="618071253"
Received: from jhilliar-mobl.amr.corp.intel.com (HELO [10.212.10.157]) ([10.212.10.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 11:35:05 -0700
Message-ID: <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
Date:   Thu, 30 Jun 2022 13:35:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com>
 <20220630150135.1799535-3-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220630150135.1799535-3-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 10:01, Stefan Binding wrote:
> When loading firmware, wm_adsp uses a number of parameters to
> determine the path of the firmware and tuning files to load.
> One of these parameters is system_name.
> Add support in cs35l41 to read this system name from the ACPI
> _SUB ID in order to uniquely identify the firmware and tuning
> mapped to a particular system.

It's my understanding that the _SUB method is optional, not required. It
may be wise to plan for a fallback, e.g to use DMI quirks or other
identifiers, no?

If it's used quite widely, then it may be a good thing to add to
'alsa-info'.
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs35l41.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index 8766e19d85f1..d70469686699 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -6,6 +6,7 @@
>  //
>  // Author: David Rhodes <david.rhodes@cirrus.com>
>  
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -1142,6 +1143,24 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
>  	return ret;
>  }
>  
> +static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
> +{
> +	acpi_handle handle = ACPI_HANDLE(cs35l41->dev);
> +	const char *sub;
> +
> +	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
> +	if (!handle)
> +		return 0;
> +
> +	sub = acpi_get_subsystem_id(handle);
> +	if (IS_ERR(sub))
> +		return PTR_ERR(sub);
> +
> +	cs35l41->dsp.system_name = sub;
> +	dev_dbg(cs35l41->dev, "Susystem ID: %s\n", cs35l41->dsp.system_name);

Typo: Subsystem

> +	return 0;
> +}
> +
>  int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
>  {
>  	u32 regid, reg_revid, i, mtl_revid, int_status, chipid_match;
> @@ -1270,6 +1289,10 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
>  		goto err;
>  	}
>  
> +	ret = cs35l41_acpi_get_name(cs35l41);
> +	if (ret < 0)
> +		goto err;
> +
>  	ret = cs35l41_dsp_init(cs35l41);
>  	if (ret < 0)
>  		goto err;
> @@ -1316,6 +1339,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
>  	pm_runtime_disable(cs35l41->dev);
>  
>  	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
> +	kfree(cs35l41->dsp.system_name);
>  	wm_adsp2_remove(&cs35l41->dsp);
>  	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
>  
