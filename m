Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA04FA20B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiDIDmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240649AbiDIDmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:42:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDD304E04;
        Fri,  8 Apr 2022 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649475598; x=1681011598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qze9RYK4ui0ByNmAqFkQyf4VBZx1hpmkKmu8YdbL7gM=;
  b=oA2EHTT325u3nHFqgJCRdaaxLFUM2eBjIcUrrZnGa8DSB+NUPJaODQnn
   uOn2v7dhnLrMl9FaWTZkavixHuClu2n1p66dCEOfFe5gP5mvbPT3GKiJ5
   1mXs6hkhc2swC2anJbs4lmh8iMp3fh289P03izCXVXJQaEz8M0/aN7e0G
   SdU7gah+2C+gcOpW/BoS3PduA9mfuIZoDiscsOQO5Biy9Vy6oQiqr2EFG
   W52+pRppVBsWKg3uw51tSNoBlMuwIyfj+J2sgMZb+7gSVHUfGbJrf1cC/
   QnoqDVXlOj/kGBVKA6WjkTORh04TXv1P6GoPRFnJGwBIIm8LNY3yT0yrd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241688562"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="241688562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 20:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="653558544"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 20:39:55 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd1x4-0000qb-Bv;
        Sat, 09 Apr 2022 03:39:54 +0000
Date:   Sat, 9 Apr 2022 11:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <202204091133.KMBmLNSx-lkp@intel.com>
References: <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on rafael-pm/linux-next robh/for-next linus/master v5.18-rc1 next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/device-property-Allow-error-pointer-to-be-passed-to-fwnode-APIs/20220409-025056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220409/202204091133.KMBmLNSx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/477683439b5ee0954b08970d8c356b4cdaca8bc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/device-property-Allow-error-pointer-to-be-passed-to-fwnode-APIs/20220409-025056
        git checkout 477683439b5ee0954b08970d8c356b4cdaca8bc0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/base/property.c: In function 'fwnode_handle_get':
>> drivers/base/property.c:782:24: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     782 |                 return fwnode;
         |                        ^~~~~~


vim +/const +782 drivers/base/property.c

613e97218ccbd7f Adam Thomson    2016-06-21  772  
e7887c284969a23 Sakari Ailus    2017-03-28  773  /**
e7887c284969a23 Sakari Ailus    2017-03-28  774   * fwnode_handle_get - Obtain a reference to a device node
e7887c284969a23 Sakari Ailus    2017-03-28  775   * @fwnode: Pointer to the device node to obtain the reference to.
cf89a31ca55272e Sakari Ailus    2017-09-19  776   *
cf89a31ca55272e Sakari Ailus    2017-09-19  777   * Returns the fwnode handle.
e7887c284969a23 Sakari Ailus    2017-03-28  778   */
477683439b5ee09 Andy Shevchenko 2022-04-08  779  struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
e7887c284969a23 Sakari Ailus    2017-03-28  780  {
cf89a31ca55272e Sakari Ailus    2017-09-19  781  	if (!fwnode_has_op(fwnode, get))
cf89a31ca55272e Sakari Ailus    2017-09-19 @782  		return fwnode;
cf89a31ca55272e Sakari Ailus    2017-09-19  783  
cf89a31ca55272e Sakari Ailus    2017-09-19  784  	return fwnode_call_ptr_op(fwnode, get);
e7887c284969a23 Sakari Ailus    2017-03-28  785  }
e7887c284969a23 Sakari Ailus    2017-03-28  786  EXPORT_SYMBOL_GPL(fwnode_handle_get);
e7887c284969a23 Sakari Ailus    2017-03-28  787  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
