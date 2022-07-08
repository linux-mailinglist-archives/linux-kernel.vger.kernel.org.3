Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5C56B069
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiGHCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiGHCGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:06:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F6735B2;
        Thu,  7 Jul 2022 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657245981; x=1688781981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCg8kR4TS25FrYcEhQ1dqxKwo2QmLPDolQW0nQZ5zIQ=;
  b=b/j2cCm7ARBszkITvk5Qq9ZVrRJdtwZa1tfYWBGBsBv3iq/An7SG13Gk
   hNqvouPpmNXvc47T/Vo7LDQ9R6hQSWLhDUeTqMr8k9pHrt3Zvjy783Fh1
   LdDA4geeyP0sdw9tIO0t9KTe46cpL2jRkxpD5xN1gNr9ALr4Oey9fd9N9
   L/5FTPj39psTXPA4JbSUOcIBb3/b9XU/Pr4IGyhMqaH+lDnNpgejGXlpy
   WHSvYDzSrn+j7y69VChpqvBsRVdPSsQ2Tz2O8J4R7T+ypLqpC2FMEZf4R
   KqQY6vGTmMpK/7fHv2Tzqt4gXWJAxP1VPaS5F3a7mPbJJbKYmQOWeUBft
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="272964077"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="272964077"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="593951503"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2022 19:06:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9dNp-000Mkw-W3;
        Fri, 08 Jul 2022 02:06:17 +0000
Date:   Fri, 8 Jul 2022 10:05:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linus.walleij@linaro.org,
        kavyasree.kotagiri@microchip.com, alexandre.belloni@bootlin.com,
        colin.foster@in-advantage.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <202207080905.doKxbD08-lkp@intel.com>
References: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Horatiu-Vultur/pinctrl-ocelot-Add-fixes-for-ocelot-driver/20220708-025029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220708/202207080905.doKxbD08-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/162d70439a9da8a7142091d2fe2690f92756e34b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Horatiu-Vultur/pinctrl-ocelot-Add-fixes-for-ocelot-driver/20220708-025029
        git checkout 162d70439a9da8a7142091d2fe2690f92756e34b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pinctrl/pinctrl-ocelot.c:306:28: sparse: sparse: symbol 'regmap_pincfg' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
