Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3455532B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377563AbiFVSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359064AbiFVSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:17:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A983D4AE;
        Wed, 22 Jun 2022 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921844; x=1687457844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lSht4PBByyP05ZkoNDMizevybcxsq9Fjn4pGO9nBcrI=;
  b=UkFSH5vnBamp+XTzUFGs920qg3LP2/mylMGJ/yDARlyrwH4rQ6fhIPSw
   f/NB4dz9YeUey/tkaDGfHNeXpAB+e/TJHyKHM0xEsYBUoGRunrDVWnTs7
   VPrioxWcb+xUtM+hQEnFujmO7KOHMA0dyh3wPAhmXQ5pLU3IwTSzsDYeO
   Vh8HGtTU8DenVW7NJT3PpTjR7poUrf/xO+It5ocEuoRdcp/OWFgmR6cqs
   QNIgylwuz5S67KOib3YI0ZCsfCTlm0po4K2U32WB7hUgrNhF5uLGIg2W9
   N38q4dsGBa/QPVXiR5YJgDfc4SsKhJ2Khx625CIUH8dytBB7SSxYqmmuf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279267740"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="279267740"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:56:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592302891"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.111.3]) ([10.212.111.3])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:56:11 -0700
Message-ID: <3fc73477-59e3-2935-489b-d3dbfd77eafc@linux.intel.com>
Date:   Wed, 22 Jun 2022 10:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] platform/x86: intel/pmc: Add Alder Lake N support to
 PMC core driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
References: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
 <caaca84e-1cc4-bf81-f705-fdabe2313d71@redhat.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <caaca84e-1cc4-bf81-f705-fdabe2313d71@redhat.com>
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

On 6/22/2022 3:23 AM, Hans de Goede wrote:

> Hi,
>
> On 6/15/22 02:27, Gayatri Kammela wrote:
>> Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
>> PMC core driver supports. RocketLake reuses all the TigerLake PCH IPs.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: David E. Box <david.e.box@linux.intel.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
Thank you Hans! I have sent v2 fixing the typo.
>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 40183bda7894..a1fe1e0dcf4a 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>   	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
>>   	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
>>   	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
>> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
>>   	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
>>   	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>>   	{}
>>
>> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
