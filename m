Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42674E84CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiC0AvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 20:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiC0AvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 20:51:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470AFD29;
        Sat, 26 Mar 2022 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648342185; x=1679878185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dxvmqHpgoKoSM3oeOZwtiuPqLp1SG2yKyDRHdmBQRhY=;
  b=Iqt2TuDSkkylBukBgbO192w9RKlwzfswKC3nD1Xxtmr9N9MpX9c5MvmL
   qASsBhcTmqmSL9GTaX7QoANfxJMZ3PXMB7rj+gax8IziQ/Q09gJw7KliO
   4QRrT2CGQs89+NhEjBggk6fxMooytIFlYobrLtzIr8NRefRdQrKT6/Olc
   /A6FePzN5EYchQUvYGVizTdRplRPNEkCpDB+oXJx1K8ZnjkUZwRG9lzfl
   ewRBuf7YNvCZEctqSNHnjsLIGmQEb5KW7LNtnGElRLF1SwcBFfr7nwLCI
   dw9SHKBXXk27MXF5aDfyeobXfWkH+PBaV0mOJlOWKOvw+rZwuB5TekKJA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="238748202"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="238748202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 17:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="602403742"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2022 17:49:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYH6D-0000ZH-Ok; Sun, 27 Mar 2022 00:49:41 +0000
Date:   Sun, 27 Mar 2022 08:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 2/4] hwmon: (bt1-pvt) use generic polynomial functions
Message-ID: <202203270834.xEWniPdY-lkp@intel.com>
References: <20220326192347.2940747-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326192347.2940747-3-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220327/202203270834.xEWniPdY-lkp@intel.com/config)
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
   bt1-pvt.c:(.text+0xa32): undefined reference to `polynomial_calc'
   ia64-linux-ld: drivers/hwmon/bt1-pvt.o: in function `pvt_write_limit':
   bt1-pvt.c:(.text+0xae2): undefined reference to `polynomial_calc'
>> ia64-linux-ld: bt1-pvt.c:(.text+0xb22): undefined reference to `polynomial_calc'
   ia64-linux-ld: drivers/hwmon/bt1-pvt.o: in function `pvt_hwmon_read':
   bt1-pvt.c:(.text+0x2532): undefined reference to `polynomial_calc'
   ia64-linux-ld: bt1-pvt.c:(.text+0x2732): undefined reference to `polynomial_calc'
   ia64-linux-ld: drivers/hwmon/bt1-pvt.o:bt1-pvt.c:(.text+0x27e2): more undefined references to `polynomial_calc' follow
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
