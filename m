Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018E04C7DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiB1WyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiB1WyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:54:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F38226;
        Mon, 28 Feb 2022 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646088814; x=1677624814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yIm7V15EpTQEteU1KS+l9s/+KA1nJQQU0c8OZGB6jE=;
  b=E/xTgLexv9H32ir7n2YEtCZhVkPPkwIJeLh0yC7p/A97MVuF4CM/bQMq
   u/p20IkJRnViF9arsC7dvXd7HLVUcmLeat+m9L6axpo3unY3hDhIapRkD
   sqUYVf8IcgpiwsJHD5MW4qKyRJwkDLCVO+73/KMMPuAcJvIzpUCyZ+FCR
   uKsUecWwNDRFHyKtuzIOdgnhnJrG0/WbWmrG/os2EMmaa0479TTxxHYNY
   ljGI1RENCMWae7Bm/NtDxZy7h7oWExR/l1WKZWItKEgwbPiat+ihnnZKQ
   qLXsC4xJjlXpUQ307QPmlCSOP7V2eVRDORjxRqiZ0sQjfQNvEO6xhYTUl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250587968"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="250587968"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="803506507"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2022 14:53:31 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOotW-0007rm-RC; Mon, 28 Feb 2022 22:53:30 +0000
Date:   Tue, 1 Mar 2022 06:52:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Won Chung <wonchung@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Won Chung <wonchung@google.com>
Subject: Re: [PATCH] usb:typec: Add sysfs support for Type C connector's
 physical location
Message-ID: <202203010628.Aac5rBDB-lkp@intel.com>
References: <20220228190649.362070-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228190649.362070-1-wonchung@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on chrome-platform/for-next linus/master v5.17-rc6 next-20220228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Won-Chung/usb-typec-Add-sysfs-support-for-Type-C-connector-s-physical-location/20220301-030738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: hexagon-randconfig-r041-20220227 (https://download.01.org/0day-ci/archive/20220301/202203010628.Aac5rBDB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/93d7a0fa1ed009ae6cc98fe5039cec8c9c77609f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Won-Chung/usb-typec-Add-sysfs-support-for-Type-C-connector-s-physical-location/20220301-030738
        git checkout 93d7a0fa1ed009ae6cc98fe5039cec8c9c77609f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/typec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/class.c:1649:7: warning: no previous prototype for function 'get_pld' [-Wmissing-prototypes]
   void *get_pld(struct device *dev)
         ^
   drivers/usb/typec/class.c:1649:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *get_pld(struct device *dev)
   ^
   static 
   1 warning generated.


vim +/get_pld +1649 drivers/usb/typec/class.c

  1648	
> 1649	void *get_pld(struct device *dev)
  1650	{
  1651	#ifdef CONFIG_ACPI
  1652		struct acpi_pld_info *pld;
  1653		acpi_status status;
  1654	
  1655		if (!has_acpi_companion(dev))
  1656			return NULL;
  1657	
  1658		status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
  1659		if (ACPI_FAILURE(status))
  1660			return NULL;
  1661		return pld;
  1662	#else
  1663		return NULL;
  1664	#endif
  1665	}
  1666	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
