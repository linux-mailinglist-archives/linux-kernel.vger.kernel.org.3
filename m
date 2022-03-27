Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226824E84E0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 03:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiC0BM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 21:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiC0BMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 21:12:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE84E9FFE;
        Sat, 26 Mar 2022 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648343445; x=1679879445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AE7+oETOuwbPdUhVZvvudlGhaJZZJhYbDc2eIov7KrM=;
  b=SQly/4B2UKqyEQB0U4PRUYJnv7h3RHEodrJ2hsTBkOC8uICOZq38GPC+
   H739M57p1ltzq5EjB4v15ZMu66Flw4xSjmnlfKNqEOntgaUhL7zGU95CX
   Ccvf/zR9BPEvonuHHIGIvoJnSJa+QDpSPifpg9+ZteGtTORIHia1747kD
   IIP2bulhf8DHbRtEzQ//vp++O5K741kqX8Viuq4wfRp96QKcg96Pf/iY5
   ZGolZX734q5R2yWiDIHeQ+vRKhqpScaOHfiot1aRPCRUasfwVFO4gEX/e
   KUg1hxy5Ufj84HnzI4X0sRnOEB+nsvcGUKudLamxypwIKE2LUsx/NQWMC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="283697058"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="283697058"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 18:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="602406271"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2022 18:10:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYHQY-0000b4-Da; Sun, 27 Mar 2022 01:10:42 +0000
Date:   Sun, 27 Mar 2022 09:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 2/4] hwmon: (bt1-pvt) use generic polynomial functions
Message-ID: <202203270925.NrqU6SE8-lkp@intel.com>
References: <20220326192347.2940747-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326192347.2940747-3-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on robh/for-next linus/master v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/hwmon-add-lan9668-driver/20220327-032606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: ia64-buildonly-randconfig-r002-20220327 (https://download.01.org/0day-ci/archive/20220327/202203270925.NrqU6SE8-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/51d4d93c8777a757e21386aa76ccc128a6bd85af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Walle/hwmon-add-lan9668-driver/20220327-032606
        git checkout 51d4d93c8777a757e21386aa76ccc128a6bd85af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/hwmon/bt1-pvt.o: in function `pvt_read_data':
>> bt1-pvt.c:(.text+0xeb2): undefined reference to `polynomial_calc'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
