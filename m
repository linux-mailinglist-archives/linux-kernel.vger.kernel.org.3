Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D74F5750
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiDFHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbiDFG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:59:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB9133677;
        Tue,  5 Apr 2022 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649222753; x=1680758753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COGVcZeVG09PEnU/9FDhc6NmD42bc+QMIbu3CrpFM+8=;
  b=e6vQFcp5A+17axTBMCfKcA4ny7V3UIsWbZuAuLZspc91fEfV4C29Ta1G
   F8+mOWeO8fUNpss2x3DtgJxEx20S74zrBscHSxuOI7S8Pvacdwx7SKAu4
   d+pWZLU2yHJ+qMuIsjPWuqNXO0YyqMaX25VyDNLl9OX/ufn8FxqbuBABe
   T+Np2/p0SuE0j3LoYV9iSf18BewmjJ8lFg1u9FNnjo99dIjnmPvu1YYFy
   86n7Xi8437N19/ARo9b2xYVPgm4YuzIkfWUt8JuVZXxh07zn9ZFC9IiMg
   QAIkqKyyqMKc74hnDSJ1uiwsgdIxOjn359Xe3XtbBSQ5f4PNlZWi8k7qB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258540015"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="258540015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588230308"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 22:25:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbyAu-00046C-Ur;
        Wed, 06 Apr 2022 05:25:48 +0000
Date:   Wed, 6 Apr 2022 13:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kbuild-all@lists.01.org, kernel@axis.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mtd: phram: Allow probing via reserved-memory
Message-ID: <202204061349.puriUTMO-lkp@intel.com>
References: <20220405130350.1640985-4-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405130350.1640985-4-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test ERROR on mtd/mtd/fixes robh/for-next v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/mtd-phram-improvements/20220406-070357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220406/202204061349.puriUTMO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5f942c36259bf6194f9cc8ed7cbacdca28200e20
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Whitchurch/mtd-phram-improvements/20220406-070357
        git checkout 5f942c36259bf6194f9cc8ed7cbacdca28200e20
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mtd/devices/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/devices/phram.c:347:1: error: expected ',' or ';' before 'static'
     347 | static int phram_probe(struct platform_device *pdev)
         | ^~~~~~
>> drivers/mtd/devices/phram.c:372:27: error: 'phram_probe' undeclared here (not in a function); did you mean 'phram_write'?
     372 |         .probe          = phram_probe,
         |                           ^~~~~~~~~~~
         |                           phram_write


vim +347 drivers/mtd/devices/phram.c

   346	
 > 347	static int phram_probe(struct platform_device *pdev)
   348	{
   349		struct resource *res;
   350	
   351		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   352		if (!res)
   353			return -ENOMEM;
   354	
   355		/* mtd_set_of_node() reads name from "label" */
   356		return register_device(pdev, NULL, res->start, resource_size(res),
   357				       PAGE_SIZE);
   358	}
   359	
   360	static int phram_remove(struct platform_device *pdev)
   361	{
   362		struct phram_mtd_list *phram = platform_get_drvdata(pdev);
   363	
   364		mtd_device_unregister(&phram->mtd);
   365		iounmap(phram->mtd.priv);
   366		kfree(phram);
   367	
   368		return 0;
   369	}
   370	
   371	static struct platform_driver phram_driver = {
 > 372		.probe		= phram_probe,
   373		.remove		= phram_remove,
   374		.driver		= {
   375			.name		= "phram",
   376			.of_match_table	= of_match_ptr(phram_of_match),
   377		},
   378	};
   379	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
