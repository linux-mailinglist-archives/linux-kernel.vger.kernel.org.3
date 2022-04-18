Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E1504F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiDRL7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiDRL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:59:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114619283;
        Mon, 18 Apr 2022 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650282990; x=1681818990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HxZz6S5PJGAsiWfCIX8Ebb5KnPrpBo25d6b8Hx0WyA=;
  b=W4MM89jgBF8/vffe8TFZJr5JyVsGHMjXe0a8HF2amvj541uRZbXdRfHS
   jD70a9fUUFfj04uzp7VZLH19VIC8DEe1aVKM7t0gvRZOpKxv6tTeXmq/P
   TV1fWVlhRRR3/01do+h88X/TSBY7dC0W36u8w5E7Cl+1/xcmPVzf//Xsc
   t9HQKkLKeujmsLWCupQXN/jUqN+hWYjAZdJdX8nFhQjqG/F7fJ4UyWewj
   uxT5cG7DtHFNWyLAFzXrmWpwpdMX+qyIlB1xb1uv+0G4Q4MfszXNxTlsX
   V53UPaDPyVoHaG8pmXyIzYbzR3e/rV4FUwyFCk8dnoXDQshQTvOCpvHyh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262361511"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262361511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="665155557"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 04:56:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngPzU-0004bH-1G;
        Mon, 18 Apr 2022 11:56:24 +0000
Date:   Mon, 18 Apr 2022 19:55:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     kbuild-all@lists.01.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: mmc: sdhci_am654: Add the quirk to set
 TESTCD bit
Message-ID: <202204181920.iopT8zQA-lkp@intel.com>
References: <20220418102040.4993-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418102040.4993-3-a-govindraju@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master ulf-hansson-mmc-mirror/next v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aswath-Govindraju/MMC-Add-quirk-to-set-the-TESTCD-bit/20220418-182325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220418/202204181920.iopT8zQA-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a7d917691f55e240b1ab0abf36b0b39d1194a323
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aswath-Govindraju/MMC-Add-quirk-to-set-the-TESTCD-bit/20220418-182325
        git checkout a7d917691f55e240b1ab0abf36b0b39d1194a323
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci_am654.c:375:6: warning: no previous prototype for 'sdhci_am654_reset' [-Wmissing-prototypes]
     375 | void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
         |      ^~~~~~~~~~~~~~~~~


vim +/sdhci_am654_reset +375 drivers/mmc/host/sdhci_am654.c

   374	
 > 375	void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
   376	{
   377		u8 ctrl;
   378		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
   379		struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
   380	
   381		sdhci_reset(host, mask);
   382	
   383		if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
   384			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
   385			ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
   386			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
   387		}
   388	}
   389	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
