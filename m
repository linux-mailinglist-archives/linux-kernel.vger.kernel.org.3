Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8A59110F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiHLMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHLMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:51:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E89DB45
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660308682; x=1691844682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pLT/JhLRJVT6Hx+fXKzxWkT0IVl2IJGUlJL/FYAB+og=;
  b=DEteU5CIXr66XytrHZRf8l5VT2odZwp1GNKgVDRRStfqgEVjqKhNSRfd
   8HJh4nEZgETN3113psSwitP4E7zXcaWrbX5kMsrJ0NyRo+6/MUgrxW0tI
   xNor30Zn1n/NvcrtEhsxE5XtND1zXhEwYSRsXuBrNIrm8N0IbPHSQCLDV
   4b6oXpUxPizlVkICU4IFyK12h7XHzv8ERiLnRFZYpq+Bd5/t2iXn+aZlw
   42qPSHKTBNfk+Fxi2ymZoQidZSOnYaWJHIPkNh6LYGV53l2x9MOOKxkzI
   v/FfO6gYXJZZ9kEj4z9h0DbzCqW+j1bStlCrPf+dSbIedV1lac0qqpUr3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292381164"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292381164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 05:51:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556506169"
Received: from pkruijer-mobl.ger.corp.intel.com (HELO [10.249.41.102]) ([10.249.41.102])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 05:51:16 -0700
Message-ID: <4fe4853d-a446-1f72-2f32-f63eb6733adc@linux.intel.com>
Date:   Fri, 12 Aug 2022 14:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Content-Language: en-US
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        perex@perex.cz, tiwai@suse.com
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, brent.lu@intel.com, yong.zhi@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  static const struct snd_soc_acpi_codecs mx98360a_spk = {
>  	.num_codecs = 1,
>  	.codecs = {"MX98360A"}
> @@ -78,6 +83,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  		.quirk_data = &mx98360a_spk,
>  		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
>  	},
> +	{
> +		.comp_ids = &rt5682_rt5682s_hp,
> +		.drv_name = "jsl_rt5682_rt1019",
> +		.sof_fw_filename = "sof-jsl.ri",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rt1019p_spk,
> +		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",

this patch adds support for the rt1019, the line above looks like a
copy-paste mistake.

We shouldn't use the same topology files for different platforms, it's
not good maintenance-wise and since we store default values for some
controls it's really not a good idea.

Please use a unique string such as sof-jsl-rt5682-rt1019.tplg, thanks.

> +	},
>  	{
>  		.id = "10134242",
>  		.drv_name = "jsl_cs4242_mx98360a",
