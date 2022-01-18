Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7B492C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiARRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:23:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:56626 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbiARRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642526619; x=1674062619;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EWRTFiZUItx3MWdwZQTZ060I//3YEQzPGnM9FwhmVhk=;
  b=HXl0OPd5cyKtsHxGJ+/fd1WU9sYJJ5g7vzqtX+sZt5r7Sc92+B814ADN
   aYMAFl0Gvdh5rH5fMU40fC74r7Zg8N2C2I9GNX/jVkZhfEo6vvcxmK1iv
   y275ChpfXJolIRedvJPTwA28c4B2kw1EqwUMp33KDCVNqcmmys5LZ61LM
   U0IqtLvbRNhgRzCQs5hQnj1cRHwul4/7S0hq8Ceifrpt04PzLRp/Whz22
   fbT4aj37ZY8Y/M54tXeDjD3bMZygryUpABnVuhbQy++ZY95V4sxZ4wfqN
   TVNo7PVk1m2I7HV+e4D6FdZ3mDqgFngWxpG4V/JA6zJ3QtISP6JOOyRKT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243692256"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243692256"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:21:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="622211580"
Received: from mdzurick-mobl.amr.corp.intel.com (HELO [10.209.145.208]) ([10.209.145.208])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:21:51 -0800
Subject: Re: [PATCH] ASoC: amd: fix unmet dependency on GPIOLIB for
 SND_SOC_DMIC
To:     Mark Brown <broonie@kernel.org>,
        Julian Braha <julianbraha@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Vijendar.Mukunda@amd.com, AjitKumar.Pandey@amd.com,
        kai.vehmanen@linux.intel.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        fazilyildiran@gmail.com
References: <20220117041528.59958-1-julianbraha@gmail.com>
 <Yeb0n9AVXeVzBHrT@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26ec72a7-effa-7553-fc0f-4e016b651c09@linux.intel.com>
Date:   Tue, 18 Jan 2022 11:21:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yeb0n9AVXeVzBHrT@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 11:10 AM, Mark Brown wrote:
> On Sun, Jan 16, 2022 at 11:15:28PM -0500, Julian Braha wrote:
>> When SND_SOC_AMD_YC_MACH is selected,
>> and GPIOLIB is not selected,
>> Kbuild gives the following warning:
>>
>> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>>   Selected by [y]:
>>   - SND_SOC_AMD_YC_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP6x [=y]
> 
> Why is this a good fix and not removing the dependency on gpiolib from
> DMIC?  While a DMIC *can* use a GPIO it's not something that's an
> intrinsic requirement and it's entirely optional in the code.

We also have similar 'depends on GPIOLIB' for Intel boards that are not
really useful. see e.g. 4262ddc2ad63 ('ASoC: Intel: boards: add explicit
dependency on GPIOLIB when DMIC is used'). IIRC we had this discussion
before about doing a larger cleanup.


