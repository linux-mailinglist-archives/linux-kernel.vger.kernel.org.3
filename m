Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1570C49CEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbiAZPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:49:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:54866 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235555AbiAZPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643212141; x=1674748141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+J63yfbsQbuQjnkNpkFhv6uxQDj/oTnzatWDWLCsMgU=;
  b=XmesMcw2YCailfty3FSyhP6YEBWuDAC0r6Cq9sV9HN4rKo9L0ouw/kiO
   cBRG0d6+p+q2m+S7LH52w32naaGPdOOa5hckGdwefz2vW00EbjyJeeO8J
   MX2hcWl6MHv+heqTI47FcbI9Mdy13hRTttJ3SO9rmIfH94YViMGIyrth1
   gXlTzeZyOu7rYJp00axWpWIr67BffSoHQct7kALp5mQJ1Oeu8XMMz8FMX
   QOVLoXOsJathTBDVoDgktcaQTqEO3hoa0S28ana1fx7P3NpGT59FyFk0a
   sVXYytvuFu7cTdZuG0SpLMu5KgWEdZKFtGngHldIVTVxaPNpTbexVuIvp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309891077"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="309891077"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 07:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="563442847"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 07:48:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCkXZ-000LLv-No; Wed, 26 Jan 2022 15:48:57 +0000
Date:   Wed, 26 Jan 2022 23:48:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH v4] drivers: thermal: clear all mitigation when thermal
 zone is disabled
Message-ID: <202201262251.KzdCvJYy-lkp@intel.com>
References: <1643128565-22838-1-git-send-email-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643128565-22838-1-git-send-email-quic_manafm@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manaf,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Manaf-Meethalavalappu-Pallikunhi/drivers-thermal-clear-all-mitigation-when-thermal-zone-is-disabled/20220126-004720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: nios2-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220126/202201262251.KzdCvJYy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/thermal/gov_step_wise.c:189 step_wise_unbind() warn: inconsistent indenting

vim +189 drivers/thermal/gov_step_wise.c

   169	
   170	/**
   171	 * step_wise_unbind() - unbind the step_wise governor to a thermal zone
   172	 * @tz:	thermal zone to unbind it to
   173	 *
   174	 * Clear all previous throttling and reset passive counter.
   175	 *
   176	 */
   177	static void step_wise_unbind(struct thermal_zone_device *tz)
   178	{
   179		struct thermal_instance *instance;
   180	
   181		dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
   182	
   183		mutex_lock(&tz->lock);
   184		tz->passive = 0;
   185		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
   186			instance->initialized = false;
   187			instance->target = THERMAL_NO_TARGET;
   188			mutex_lock(&instance->cdev->lock);
 > 189			 __thermal_cdev_update(instance->cdev);
   190			mutex_unlock(&instance->cdev->lock);
   191		}
   192		mutex_unlock(&tz->lock);
   193	}
   194	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
