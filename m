Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800914F50B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444436AbiDFBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572968AbiDERgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:36:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892BDA7760
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649180047; x=1680716047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xNIgDv3tAxt+JijYYxs5mDw4LO9oYMf6VWgmKn7pa7M=;
  b=FP+myJFPpApTSNFWZe6zxtPXKXF9WE+WffJdeSc0+vpTwSazF/iWiiK4
   Oy3Zfl9Sn73Wc/IgwuCr90+H/eks3czOk0RhrONtUsxUL1unNnUs0jfKP
   72OkOicigfkNwPJ2DELBVNRWyDGG8q11YZWZJAiYZJg/KDzWiiKer+Mmi
   7P+Vtvw+iHLW/zK1N+feTmZXPjd8HzUFl8Mv0N0P4cU9MMDKN/jyDtfbk
   GwzPvYaw9zBxwm4lJiiQkTPzJKHr28YViaOD+MIe0Qhr7+HxIrqCA0SSp
   j4CiyB/fyAbKalqWDIz0LFRrRJoknRcxBwKNNxz0YD7tlPU+1xxr1nRMD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241403960"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="241403960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:33:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="651984104"
Received: from ctveazey-mobl2.amr.corp.intel.com (HELO [10.255.230.126]) ([10.255.230.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:33:41 -0700
Message-ID: <6eaa459d-b2a9-fc1e-e16d-01b28028462b@linux.intel.com>
Date:   Tue, 5 Apr 2022 12:33:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] ASoC: Intel: sof_es8336: support a separate gpio
 to control headphone
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
References: <cover.1649177516.git.mchehab@kernel.org>
 <535454c0c598a8454487fe29b164527370e2db81.1649177516.git.mchehab@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <535454c0c598a8454487fe29b164527370e2db81.1649177516.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -static const struct acpi_gpio_params speakers_enable_gpio0 = { 0, 0, true };
> +static const struct acpi_gpio_params enable_gpio0 = { 0, 0, true };
> +static const struct acpi_gpio_params enable_gpio1 = { 1, 0, true };
> +
>   static const struct acpi_gpio_mapping acpi_speakers_enable_gpio0[] = {
> -	{ "speakers-enable-gpios", &speakers_enable_gpio0, 1 },
> +	{ "speakers-enable-gpios", &enable_gpio0, 1 },
>   	{ }
>   };
>   
> -static const struct acpi_gpio_params speakers_enable_gpio1 = { 1, 0, true };
>   static const struct acpi_gpio_mapping acpi_speakers_enable_gpio1[] = {
> -	{ "speakers-enable-gpios", &speakers_enable_gpio1, 1 },
> +	{ "speakers-enable-gpios", &enable_gpio1, 1 },
> +};

nit-pick: these changes could be applied to the previous patch.

the rest of the code looks fine, thanks Mauro!
