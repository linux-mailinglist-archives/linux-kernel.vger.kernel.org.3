Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738404FF014
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiDMGsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiDMGse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:48:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CB24BEA;
        Tue, 12 Apr 2022 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649832371; x=1681368371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tO2uBxF8zoVz0KV8YQe93LbJlCRoFpE5jeJmkP5ZZGM=;
  b=Xcs2qv6C0jEQeK6YALDroxnI0pykrmduLl6g2qgAhldX7nTkIHVDq1AI
   WWyd3kaLcuQtQ24DpZ/bHE9EwbsDwHAcVLNjw/aZOyHxNUWm3wCgZT63o
   YLSEgeO/nayftNZwgq4kp5IwbRkEyRkg4GN1ICfW/nSUEijDvSydo/5M5
   fZyY3kwM4yNQuKD2NbHTvyIHkSLLSUx9LvrjTFeaePCEY8n5uh4/3WZrg
   ElegoQqmcB+/NBX2oZTGCfsUF0QBy0qXLf0XBhTKRT7mhcBIAp3bKxzAc
   z+YYORtBAcR58HQcz/Plth4y5asAU52KmZLfrmx1VmAeTG8B5S4pi/0fl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349026713"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="349026713"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="645053052"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 23:46:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neWlT-00006G-Rc;
        Wed, 13 Apr 2022 06:46:07 +0000
Date:   Wed, 13 Apr 2022 14:45:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kbuild-all@lists.01.org, kernel@axis.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mtd: phram: Allow cached mappings
Message-ID: <202204131446.omJ5mC54-lkp@intel.com>
References: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
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

Hi Vincent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/mtd/next]
[also build test ERROR on mtd/mtd/fixes robh/for-next v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/mtd-phram-improvements/20220412-215547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220413/202204131446.omJ5mC54-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/188069fe016214c257926df29c84b97859850720
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Whitchurch/mtd-phram-improvements/20220412-215547
        git checkout 188069fe016214c257926df29c84b97859850720
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/mtd/devices/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:13,
                    from drivers/mtd/devices/phram.c:21:
   drivers/mtd/devices/phram.c: In function 'register_device':
>> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
     274 | #define iounmap(addr)           do { } while (0)
         |                                 ^~
   drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
     150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
         |                                            ^~~~~~~
   drivers/mtd/devices/phram.c: In function 'phram_remove':
>> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
     274 | #define iounmap(addr)           do { } while (0)
         |                                 ^~
   drivers/mtd/devices/phram.c:372:53: note: in expansion of macro 'iounmap'
     372 |         phram->cached ? memunmap(phram->mtd.priv) : iounmap(phram->mtd.priv);
         |                                                     ^~~~~~~


vim +/do +274 arch/sh/include/asm/io.h

d57d64080ddc0f Paul Mundt        2010-01-19  272  
13f1fc870dd747 Christoph Hellwig 2020-07-14  273  #else /* CONFIG_MMU */
13f1fc870dd747 Christoph Hellwig 2020-07-14 @274  #define iounmap(addr)		do { } while (0)
13f1fc870dd747 Christoph Hellwig 2020-07-14  275  #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
13f1fc870dd747 Christoph Hellwig 2020-07-14  276  #endif /* CONFIG_MMU */
d627a2ebd1a303 Paul Mundt        2010-01-28  277  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
