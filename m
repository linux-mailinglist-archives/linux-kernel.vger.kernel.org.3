Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78D4A7A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbiBBVtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:49:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:54105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbiBBVtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643838572; x=1675374572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPkcJWxCJjFTfO/aC4FZRrAGxyrpHdV+HrMlVt033KM=;
  b=LqZ0fl0r+9dviMi8hxO6x2QDTv6WGRu4cxueSld2tlZx7U3oyt3xxWIO
   c7wQOwqXH20kg7lYZiBqII1q0JquIZTsaMBsnZsul/NECGd9BgPvYxlyd
   WwNf79ff6EIqJ412485asKdNJc4WMIkap3lflNo7P+Y2a1LXArf0K719A
   Nd8+hSqu3IAetOoNfaPdNQb70zS3yQmKOIhVOws2RQ8Gjf9O2ObqFFsp5
   KuZUVoPAfLOPrttQkqBNA4I4KRWNFCYqOFC8yqzU5rp/sdjNK5qF5I+b3
   hM/BqUQCQk2X2xRw1ABNGt48CoaSWLsOVJA7bw+uEJ6/WluPmW5WfxTy7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272515451"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="272515451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="480261715"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 13:49:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFNVH-000VAS-Qv; Wed, 02 Feb 2022 21:49:27 +0000
Date:   Thu, 3 Feb 2022 05:48:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 12/14] mtd: spi-nor: move all spansion specifics into
 spansion.c
Message-ID: <202202030556.9u7o7D18-lkp@intel.com>
References: <20220202145853.4187726-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-13-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220203/202202030556.9u7o7D18-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/01f9808a20c96553c43f929e10f3fb448cd8bd93
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
        git checkout 01f9808a20c96553c43f929e10f3fb448cd8bd93
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/spi-nor/spansion.c:332:5: sparse: sparse: symbol 'spi_nor_sr_ready_and_clear' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
