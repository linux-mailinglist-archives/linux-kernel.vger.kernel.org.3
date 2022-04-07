Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF464F879B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbiDGTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiDGTDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:03:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B422C8EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358090; x=1680894090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Do0YfsDHRH1l+qnksliBRchsPuZipjLmbC6F1eP0s4=;
  b=kICbjmGxnmS6MwGDmXJjmP2hCPu8UvQfdj4x/Gx/aelyKB+QinUCaj2x
   yqUywpjONQUChjXcWpHjClavkdFNCPtKNvZKHdYx7PZT6WXxeThVOu2UL
   qVI9NObcIUrHLiK1kDQpJZo59b9MXLjpZdBm1qftOJ+zXnGh5SRdyLt0u
   411MHlszln8jsXDKu9WZHLExPslSBdfxFX5OyukKn+HSnbv63JTE6/6tD
   XdivzMmXylfLGl0BK032gRK+zbpILHr2XW/IStkurX7Mu606Up81bcMEm
   k/3FVRRdmjVGIjErnZUQxQ5dh5whG+4MLBFqi56NTjYecK6ovBu1k0WYE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347857044"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347857044"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:01:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="524499719"
Received: from achordiy-mobl.amr.corp.intel.com (HELO [10.209.88.227]) ([10.209.88.227])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:01:27 -0700
Message-ID: <591f1596-a2be-309c-4f61-0d58ab0effc0@linux.intel.com>
Date:   Thu, 7 Apr 2022 14:01:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/4] Make headphone work on Huawei Matebook D15
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        alsa-devel@alsa-project.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
References: <cover.1649357263.git.mchehab@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cover.1649357263.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 13:49, Mauro Carvalho Chehab wrote:
> Huawei Matebook D15 uses two different GPIOs are used to control the output:
> 
> 	- gpio0 controls the speaker output;
> 	- gpio1 controls the headphone output.
> 
> Changing both at the same time cause spurious events that are mis-interpreted
> as input events, causing troubles on apps. So, a delay is needed before turning
> on such gpios.
> 
> Also, the headset microphone is connected to MIC1, instead of MIC2 port.
> 
> With this patch, plugging a headphone causes a jack event to trigger the speaker
> supply, powering down the speaker and powering up the headphone output.
> Removing the headphone also triggers the power supply, powering up the speaker
> and powering down the headphone.
> 
> The headset microphone also works. 

For the series:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Mauro for your work, much appreciated.

> 
> ---
> 
> v5:
>   - dropped an uneeded differential mux from the boards driver.
> 
> v4:
>   - add support for headset microphone on MIC1 port.
> 
> v3:
>   - add a patch changing GPIO quirk speaker naming. Patch 2 got rebased on the top of it.
> 
> Mauro Carvalho Chehab (3):
>   ASoC: Intel: sof_es8336: support a separate gpio to control headphone
>   ASoC: Intel: sof_es8336: add a quirk for headset at mic1 port
>   ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15
> 
> Pierre-Louis Bossart (1):
>   ASoC: Intel: sof_es8336: simplify speaker gpio naming
> 
>  sound/soc/intel/boards/sof_es8336.c | 117 +++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 28 deletions(-)
> 
