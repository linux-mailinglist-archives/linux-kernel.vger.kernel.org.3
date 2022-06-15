Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6C54D16E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357582AbiFOTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346482AbiFOTOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:14:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFC2717E;
        Wed, 15 Jun 2022 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655320469; x=1686856469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhJp3BBzKkSAhPSokH+1OsWLVBR4UOySK6LdL2s0mZE=;
  b=cMXinJrEJN27++lHyA1YqpSCVBK+Vhrj9chtAWfkqP70FRy5MoVLwUEN
   H4kklczd3R95qRBISQFdafBX0VCgiMbvbZeRr8Ax38OUvJ4xdGdFWMpm6
   jmGmMRpa2VzIxFhJWWCI/dN8Cl1FRC7TTT+ttgkDy+j/mgVUoC7Pjd/fg
   +Buo+EgG36+wOmZg8ttZxJmb8Gt2yb35MpuKmbo859wQEDKBRfIgKozoH
   Au5zA6JGnFwHSaeMR2/TY3pVXVdxxXFKsPkFjqEe3NYu3yZopDLJteuA6
   lL37OCKd3uEqCx19VQsObn0qj7WI7TheCw2VsWrhRfi7pfHTfKVTrOMfb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280116118"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280116118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612884393"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2022 12:14:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1YTC-000N7j-Nm;
        Wed, 15 Jun 2022 19:14:26 +0000
Date:   Thu, 16 Jun 2022 03:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <202206160239.6lkHbYaU-lkp@intel.com>
References: <20220613111759.1550578-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613111759.1550578-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

I love your patch! Yet something to improve:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Conor-Dooley/pwm-add-microchip-soft-ip-corePWM-driver/20220613-211851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206160239.6lkHbYaU-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4451a8420f9fd16ee9a0801fcf02f1ec04bb8ab0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Conor-Dooley/pwm-add-microchip-soft-ip-corePWM-driver/20220613-211851
        git checkout 4451a8420f9fd16ee9a0801fcf02f1ec04bb8ab0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/pwm/pwm-microchip-core.o: in function `mchp_core_pwm_apply':
>> pwm-microchip-core.c:(.text.mchp_core_pwm_apply+0x290): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
