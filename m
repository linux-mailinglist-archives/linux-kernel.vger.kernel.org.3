Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFA4ECF98
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiC3WZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbiC3WZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:25:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378D483BC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648679026; x=1680215026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6pU881YWAtrpzuqnzwzRx2JwUavPzlXZa030gwZJrE=;
  b=K09XyWDnbh2kpH0p79OkxvafwqoSxEzcV3Eh4/wx9lQxvWuJo4NTdP62
   iUWEEibUUOf9+JqB1bGPpb4pskkP37WNqBCFgnN7oQI+B5B9xTmQLdDKp
   4cYlvh8DOKVfOUy/h6occGSuj0BKsDvnJTqrgFYkPtUQD379LGTIkDllR
   XV2F2np84VBMEVZa1FO31bVZBvnJOC4HXnMJVLxgOj3l77RGG+kg2uDVS
   jw80gxVlHAmKCw0tmAuQzS0Oo1GY31+0yvU23Y8Twrh7cTfCsnn21Hl1h
   /yQ0RRE1Fhwt53TA/B5tQk5M7vttXBjZGkIdqqS8kiieuTyNFQ238FOtG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259633786"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259633786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="503483636"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 15:23:44 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZgj9-0000Zm-L8;
        Wed, 30 Mar 2022 22:23:43 +0000
Date:   Thu, 31 Mar 2022 06:23:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kbuild-all@lists.01.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jean-Marc Eurin <jmeurin@google.com>
Subject: Re: [PATCH v2 2/2] mtd: mtdoops: Create a header structure for the
 saved mtdoops.
Message-ID: <202203310648.it4f2xXD-lkp@intel.com>
References: <20220330182816.1177341-4-jmeurin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330182816.1177341-4-jmeurin@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes linux/master linus/master v5.17 next-20220330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Marc-Eurin/mtd-mtdoops-Structure-the-header-of-the-dumped-oops/20220331-023808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220331/202203310648.it4f2xXD-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0d39801219fd826554caf69402424346799810d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Marc-Eurin/mtd-mtdoops-Structure-the-header-of-the-dumped-oops/20220331-023808
        git checkout 0d39801219fd826554caf69402424346799810d5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/mtd/mtdoops.c:10:
   drivers/mtd/mtdoops.c: In function 'find_next_position':
>> include/linux/kern_levels.h:5:18: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   drivers/mtd/mtdoops.c:243:4: note: in expansion of macro 'printk'
     243 |    printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
         |    ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   drivers/mtd/mtdoops.c:243:11: note: in expansion of macro 'KERN_ERR'
     243 |    printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
         |           ^~~~~~~~
   drivers/mtd/mtdoops.c:243:59: note: format string is defined here
     243 |    printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
         |                                                          ~^
         |                                                           |
         |                                                           int
         |                                                          %ld


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
