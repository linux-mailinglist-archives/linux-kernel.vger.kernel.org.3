Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01CE4B3887
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiBLXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:14:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiBLXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:14:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E85F8CE;
        Sat, 12 Feb 2022 15:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644707673; x=1676243673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gd+aFqfmOKSD6/n5omvf69+8KOB5SRxFpZkpzwn8bwU=;
  b=MQ1JBM+sOkaQJCH7+Xc1Wf9YFDSpIrmQgSE68Ys2sZ26A6wca7ijXGv8
   9DtDFACCwoTGXo4/0IVZyGeg6hGumZmtkQMOOBD3JjcJBqU3kVSSGejZC
   GQznzPfGryg4swlOlQs11IIo9pOJBLqIZgmJjCRSepXh5WRYDXEM1UcBa
   EDHKdHELJw1kaw+JcGtBlsIEOFkZgcNgyLompFjd9s+Ndwl+6JT80AohY
   E2KTb/pZw4YE/aZkTe+zLLPkvmOk+KqX3ZalVBdkLzxezzlARFowWxpjk
   A+Qsmv59F6GSPmflwKOakQxq/h/4zIzZzVo9dAAHPbkKzEEBS9K8PmL/q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="274471837"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="274471837"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 15:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="774573109"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2022 15:14:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ1b5-0006jp-Gx; Sat, 12 Feb 2022 23:14:31 +0000
Date:   Sun, 13 Feb 2022 07:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] pmbus: Add support for pli1209bc
Message-ID: <202202130705.3YDPfyow-lkp@intel.com>
References: <e4d83b95cfb0cc0c6acb65bd1263cf0131b6ce51.1644597670.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d83b95cfb0cc0c6acb65bd1263cf0131b6ce51.1644597670.git.sylv@sylv.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on robh/for-next v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Marcello-Sylvester-Bauer/Support-pli1209bc-Digital-Supervisor/20220212-011956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: hexagon-randconfig-r024-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130705.3YDPfyow-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c7eb84634519e6497be42f5fe323f9a04ed67127)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0b0d15e123c13b2eb898502661b18d81ed87e325
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Marcello-Sylvester-Bauer/Support-pli1209bc-Digital-Supervisor/20220212-011956
        git checkout 0b0d15e123c13b2eb898502661b18d81ed87e325
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module pli1209bc uses symbol pmbus_read_word_data from namespace PMBUS, but does not import it.
>> ERROR: modpost: module pli1209bc uses symbol pmbus_do_probe from namespace PMBUS, but does not import it.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
