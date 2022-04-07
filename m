Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70A4F767B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiDGGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiDGGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:44:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1B12A8C8;
        Wed,  6 Apr 2022 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649313755; x=1680849755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAVTFpy6LYooCFderoQr99inMqBK7rOaH4ENk+A9Eow=;
  b=YV1/ibCF/LR33lNwLpVKJXaKlBETQ2XBGjJxtlyQflhs3z2TZUW+UFAJ
   2PThuBGfIziFciMVFuLzf8Frc20QED1n8VaSlPqNCxhswUEKF8vLQj517
   7S9q/vh18iXScUF8l7OTHri2QMCdlA6oH+7tbc6Wj9eEnGlv9HgrauFGN
   HlYNFsX2eISoXq+8KwHJxhcO952oX0qxRrw/1WWlg5WvR6nJtYS5lITvZ
   7WJpXP6YlDzR6kcOHea80cNcWX3qIYY9zXC5XcFXGnCJd1kmdo42Rt48a
   36CQSeClEhPYNS/4aNB2kqeJkqEINdj6j/rZXvgMhSrAiTH2DDTkXyvT9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286222094"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="286222094"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="658948076"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Apr 2022 23:42:31 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncLqh-00059j-1S;
        Thu, 07 Apr 2022 06:42:31 +0000
Date:   Thu, 7 Apr 2022 14:41:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 4/4] device property: Constify fwnode APIs that uses
 fwnode_get_next_parent()
Message-ID: <202204071409.Vfki7cgi-lkp@intel.com>
References: <20220406130552.30930-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406130552.30930-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on rafael-pm/linux-next linus/master linux/master v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/device-property-Allow-error-pointer-to-be-passed-to-fwnode-APIs/20220407-002511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220407/202204071409.Vfki7cgi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d9d353ada8d8c3b1b7f3965ad7fe191bd7dea930
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/device-property-Allow-error-pointer-to-be-passed-to-fwnode-APIs/20220407-002511
        git checkout d9d353ada8d8c3b1b7f3965ad7fe191bd7dea930
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/base/property.c:647:42: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct fwnode_handle *fwnode @@     got struct fwnode_handle const *fwnode @@
   drivers/base/property.c:647:42: sparse:     expected struct fwnode_handle *fwnode
   drivers/base/property.c:647:42: sparse:     got struct fwnode_handle const *fwnode

vim +647 drivers/base/property.c

87e5e95db31a27 Sakari Ailus    2019-10-03  629  
87e5e95db31a27 Sakari Ailus    2019-10-03  630  /**
87e5e95db31a27 Sakari Ailus    2019-10-03  631   * fwnode_get_nth_parent - Return an nth parent of a node
87e5e95db31a27 Sakari Ailus    2019-10-03  632   * @fwnode: The node the parent of which is requested
87e5e95db31a27 Sakari Ailus    2019-10-03  633   * @depth: Distance of the parent from the node
87e5e95db31a27 Sakari Ailus    2019-10-03  634   *
87e5e95db31a27 Sakari Ailus    2019-10-03  635   * Returns the nth parent of a node. If there is no parent at the requested
87e5e95db31a27 Sakari Ailus    2019-10-03  636   * @depth, %NULL is returned. If @depth is 0, the functionality is equivalent to
87e5e95db31a27 Sakari Ailus    2019-10-03  637   * fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent() and so on.
87e5e95db31a27 Sakari Ailus    2019-10-03  638   *
87e5e95db31a27 Sakari Ailus    2019-10-03  639   * The caller is responsible for calling fwnode_handle_put() for the returned
87e5e95db31a27 Sakari Ailus    2019-10-03  640   * node.
87e5e95db31a27 Sakari Ailus    2019-10-03  641   */
d9d353ada8d8c3 Andy Shevchenko 2022-04-06  642  struct fwnode_handle *fwnode_get_nth_parent(const struct fwnode_handle *fwnode, unsigned int depth)
87e5e95db31a27 Sakari Ailus    2019-10-03  643  {
040f806ecab6cd Andy Shevchenko 2022-04-06  644  	struct fwnode_handle *parent;
87e5e95db31a27 Sakari Ailus    2019-10-03  645  
040f806ecab6cd Andy Shevchenko 2022-04-06  646  	if (depth == 0)
040f806ecab6cd Andy Shevchenko 2022-04-06 @647  		return fwnode_handle_get(fwnode);
87e5e95db31a27 Sakari Ailus    2019-10-03  648  
040f806ecab6cd Andy Shevchenko 2022-04-06  649  	fwnode_for_each_parent_node(fwnode, parent) {
040f806ecab6cd Andy Shevchenko 2022-04-06  650  		if (--depth == 0)
040f806ecab6cd Andy Shevchenko 2022-04-06  651  			return parent;
040f806ecab6cd Andy Shevchenko 2022-04-06  652  	}
040f806ecab6cd Andy Shevchenko 2022-04-06  653  	return NULL;
87e5e95db31a27 Sakari Ailus    2019-10-03  654  }
87e5e95db31a27 Sakari Ailus    2019-10-03  655  EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
87e5e95db31a27 Sakari Ailus    2019-10-03  656  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
