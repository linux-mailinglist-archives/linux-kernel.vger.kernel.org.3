Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C259EFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiHWXnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHWXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:43:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B88895E9;
        Tue, 23 Aug 2022 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661298194; x=1692834194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nVmxykiA0uq+h7e/PcBCUGhl/NChr999fUIhLiACrHQ=;
  b=Bt9mP7LPKokL7Kb32eeVhBc95ZcPrv/h+ihpnJOy0kjLnhW6SahVnxh+
   spgIiB0VuMtw120pWVmXoAd7BeDDuvwUuUmGrn09B59vM5OVZdelX/blb
   2z3qBL45gZZBBjManrSlC3ZZnoICre8v+I8jkCVorU5VYeY2LzIVg0o+9
   Zd6noUVEK71JitAwXIIMkuAEu4T8b3RVkjxzxaoq2umoeD5Z5cVpzsVhB
   Rvel40j5N6J20UeXaqwZiPT2xad4bnlx12MJvBycxYkf077UvsmuwXufh
   BjEbsOMvIpjCJDbyRj3ODR4WhBY/El30hcjbKMeyAUSK6DHIyf/WzVHYn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="274208749"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="274208749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 16:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="698852680"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2022 16:43:11 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQdY6-0000id-1b;
        Tue, 23 Aug 2022 23:43:10 +0000
Date:   Wed, 24 Aug 2022 07:42:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Message-ID: <202208240749.UcN8Fuu0-lkp@intel.com>
References: <20220822183728.24434-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822183728.24434-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on axboe-block/for-next linus/master v6.0-rc2 next-20220823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: hexagon-randconfig-r041-20220821 (https://download.01.org/0day-ci/archive/20220824/202208240749.UcN8Fuu0-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fbc177b5ec3bf29261813907b13ab93865211e6e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
        git checkout fbc177b5ec3bf29261813907b13ab93865211e6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __clk_get_name
   >>> referenced by libahci_platform.c
   >>>               ata/libahci_platform.o:(ahci_platform_get_resources) in archive drivers/built-in.a
   >>> referenced by libahci_platform.c
   >>>               ata/libahci_platform.o:(ahci_platform_get_resources) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
