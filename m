Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D3510989
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354449AbiDZUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbiDZUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:10:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C61597A5;
        Tue, 26 Apr 2022 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651003651; x=1682539651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGuFDjNTHvUl3ZoFvwU6qHLIRIwg444s3wCh+hFkgzE=;
  b=gzLIdFPIeXruBaGbSidqEtthUZv9uyg8StccuBWDRGwd4vRYprOuCHsB
   N+gctOH264b8FNHFuhOi0Rh8I0c76kVo2UUMm/YmV9s6UYv/eeSekG3TA
   qRdYm+31d1ljy0q3r/ewlIA3AvB6Jq9+EhKB3huo1rO+KIUDzWrqP9cH2
   lgLQEzcyxhVHe6wiOmCycvBKznG4378E7Cn9ITQE2mMnRUiEfuJbGsLY7
   CXODeB8TRPCyJGpbN2P7QxxZaQjdstkC3OU7o7JQ2wdZAtP6jamhV/gGr
   c+4K+/MYiu1d4sPTcFvEgaDcJMUFaUE/wqu+opbn4SnHczlgOjlWsTZFQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247636161"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="247636161"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="874925758"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2022 13:07:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njRT4-0003vm-9d;
        Tue, 26 Apr 2022 20:07:26 +0000
Date:   Wed, 27 Apr 2022 04:07:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>,
        ulf.hansson@linaro.org, avri.altman@wdc.com,
        linus.walleij@linaro.org, shawn.lin@rock-chips.com,
        merez@codeaurora.org, s.shtylyov@omp.ru, huijin.park@samsung.com,
        briannorris@chromium.org, digetx@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
Message-ID: <202204270458.l6hjhnD4-lkp@intel.com>
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasarao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v5.18-rc4 next-20220426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasarao-Pathipati/mmc-core-Add-partial-initialization-support/20220426-175124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d615b5416f8a1afeb82d13b238f8152c572d59c0
config: nios2-randconfig-m031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270458.l6hjhnD4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/mmc/core/mmc.c:2168 _mmc_suspend() warn: inconsistent indenting

vim +2168 drivers/mmc/core/mmc.c

  2146	
  2147	static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
  2148	{
  2149		int err = 0;
  2150		unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
  2151						EXT_CSD_POWER_OFF_LONG;
  2152	
  2153		mmc_claim_host(host);
  2154	
  2155		if (mmc_card_suspended(host->card))
  2156			goto out;
  2157	
  2158		err = _mmc_flush_cache(host);
  2159		if (err)
  2160			goto out;
  2161	
  2162		if (mmc_can_poweroff_notify(host->card) &&
  2163		    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
  2164		     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
  2165			err = mmc_poweroff_notify(host->card, notify_type);
  2166		if (mmc_can_sleepawake(host)) {
  2167			memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
> 2168			 mmc_cache_card_ext_csd(host);
  2169		}
  2170		if (mmc_can_sleep(host->card))
  2171			err = mmc_sleepawake(host, true);
  2172		else if (!mmc_host_is_spi(host))
  2173			err = mmc_deselect_cards(host);
  2174	
  2175		if (!err) {
  2176			mmc_power_off(host);
  2177			mmc_card_set_suspended(host->card);
  2178		}
  2179	out:
  2180		mmc_release_host(host);
  2181		return err;
  2182	}
  2183	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
