Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521484AEAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiBIGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiBIGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:54:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64457C05CB85;
        Tue,  8 Feb 2022 22:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644389673; x=1675925673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qo/ffmlCcS58q+JxMXvgEK1N8bRkvNy+6yQLFamMA5w=;
  b=CrHvT1ojVzpW6VeWWD1POrMlDgvn5Ua+lY6EoJ4UZgtYKL/HzVu3cvit
   snjChFD72OK+19oPHEUpymYWFhnP5oKUbFTnmKq8xTn54ctJ9Hl11TVzD
   pYx0E5EbyJ1NUkqCdoU8nvaiNRB6DyMyBbqbhTQ4WkG7jN9ecr1YT8MB6
   ckzbvwH9GPOxYB+e1uhfqG6EBRTjAXCgwpQaHi5nCY9swqmw1fICtwJaO
   QAITgjs6t5dQF63g7+UdplN1e6dZM77u5ndv+tS5JfDQG4yaS6pnkcOtc
   PlF09vw6a2YS59I5R+bl1gMAXLtfUaKK28Zcsk2VVFXdJznq8GdTZCMNK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="247971746"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="247971746"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="568138924"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2022 22:54:30 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHgs1-0001Mp-Vh; Wed, 09 Feb 2022 06:54:29 +0000
Date:   Wed, 9 Feb 2022 14:53:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v2 1/2] usb: typec: tcpm: add interface for passing
 supported_pd_rev from tcpc_dev
Message-ID: <202202091453.L5BVOjcx-lkp@intel.com>
References: <20220208112226.9108-2-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208112226.9108-2-potin.lai@quantatw.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Potin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.17-rc3 next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Potin-Lai/usb-typec-tcpm-add-interface-for-passing-supported_pd_rev-from-tcpc_dev/20220208-202246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm64-randconfig-s031-20220208 (https://download.01.org/0day-ci/archive/20220209/202202091453.L5BVOjcx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/322696594704fa918e63d1c80fa6d346a02e9a28
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Potin-Lai/usb-typec-tcpm-add-interface-for-passing-supported_pd_rev-from-tcpc_dev/20220208-202246
        git checkout 322696594704fa918e63d1c80fa6d346a02e9a28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/usb/typec/tcpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/typec/tcpm/tcpm.c:581:16: sparse: sparse: incompatible types in comparison expression (different signedness):
>> drivers/usb/typec/tcpm/tcpm.c:581:16: sparse:    unsigned int *
>> drivers/usb/typec/tcpm/tcpm.c:581:16: sparse:    int *

vim +581 drivers/usb/typec/tcpm/tcpm.c

   573	
   574	static u32 tcpm_pd_supported_rev(struct tcpm_port *port)
   575	{
   576		u32 rev = PD_MAX_REV;
   577	
   578		if (port->tcpc->supported_pd_rev)
   579			rev = port->tcpc->supported_pd_rev(port->tcpc);
   580	
 > 581		return min(rev, PD_MAX_REV);
   582	}
   583	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
