Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B5C52F9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiEUHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiEUHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 03:32:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C517064A;
        Sat, 21 May 2022 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653118358; x=1684654358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoOOM5CAOzlhTkn74IGlT9QSDPamrwRXxRrc9NAlZrY=;
  b=Fl93PkkOglGtRPBOVFD08/Y9W3BlZxLs74nQRzPi6oXDqQYeBzzNt64Z
   kROOr3tLFyvl6BB0Ts0a6esuIHu0OhwxO44A/9K9P3mktUFX5/3/Hmi+T
   KB/fk+B9VCIrkvYLGIcVAdzC15Uri4p2kXU+9pANKxvSqMq/LB5EJmTGa
   d0MvmZQb+uv3AR2qob19h+jLCh41x1M2lLRdHVTXJNjJzxYcqteyUsnXb
   y0RQzbhMrZgZPsy2IY1sVOihM8ufehPCr3bFp0VJxj/dWJM7UB6nYn7qa
   DZ6c/ymKjoRr5Mg6LGiAFqQe28lEJm6pY8MFu0PtGZTUY/LHBimmEAyQU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="359225709"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="359225709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 00:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="702123548"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2022 00:32:33 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsJbE-00064p-N4;
        Sat, 21 May 2022 07:32:32 +0000
Date:   Sat, 21 May 2022 15:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, mturquette@baylibre.com, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v16 08/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
Message-ID: <202205211551.WXBmoQuh-lkp@intel.com>
References: <5b8f48113ddea6a1e8cdd6b1b6e5c9999dbe7332.1653027644.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8f48113ddea6a1e8cdd6b1b6e5c9999dbe7332.1653027644.git.qinjian@cqplus1.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on robh/for-next clk/clk-next tip/irq/core linus/master v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220520-150501
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: (https://download.01.org/0day-ci/archive/20220521/202205211551.WXBmoQuh-lkp@intel.com/config)
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/a18534d0375224dcbfbd6d313ec16c9042212661
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220520-150501
        git checkout a18534d0375224dcbfbd6d313ec16c9042212661
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SERIAL_SUNPLUS_CONSOLE --selectors CONFIG_SOC_SP7021 -a=arm
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE when selected by SOC_SP7021
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=n])
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
