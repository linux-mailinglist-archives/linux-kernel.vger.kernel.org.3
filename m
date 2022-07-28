Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC3583F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiG1M6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiG1M6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:58:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AED46DAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659013094; x=1690549094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mOBeZUird/F+xHLCKLGIqA+qu0Eq+kakO8OWHHGsyGA=;
  b=S5b9QbDRbUc+Uzw+OyFWlsOdMZty1arOPV4HN9UP6gzboIbKuTiI4H1L
   oV+A6xefgbz6Ylo3L98xEssgER8jPMh4A5Voc8IL/3dTJddMVOimXgdJe
   JcDijHwwXiEiLu1ylqPuyUWBu2wV6pRgmX2hDv6UYQQGttUPqMO1RJIQi
   BQOKPyS1FcsCMlShr1r7ri10credqHoLcEGeHeAdYOLx4oozMxHdIQUfk
   z5FAy9dg7teER/j2/0pmuPEZOG3JZRekS8iR1Hwz4kRTFNXOJM8KJIyoM
   1Bet4zxUouvE5nhWJeB/OMN+JrioYJH4gLCJHReQOIOJy/OLstLrJGCV7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="268884616"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="268884616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 05:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="668819284"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 05:58:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH35e-000A14-1m;
        Thu, 28 Jul 2022 12:58:10 +0000
Date:   Thu, 28 Jul 2022 20:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, minchan@kernel.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, quic_yingangl@quicinc.com
Subject: Re: [PATCH v2] mm/page_owner.c: add llseek for page_owner
Message-ID: <202207282029.T2NTavCf-lkp@intel.com>
References: <20220727125508.5154-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727125508.5154-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kassey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220727-205617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm64-randconfig-r025-20220727 (https://download.01.org/0day-ci/archive/20220728/202207282029.T2NTavCf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5533df4120ec1703df71542154e8c5b0b21ddb10
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220727-205617
        git checkout 5533df4120ec1703df71542154e8c5b0b21ddb10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_owner.c:573:8: warning: no previous prototype for function 'llseek_page_owner' [-Wmissing-prototypes]
   loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
          ^
   mm/page_owner.c:573:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
   ^
   static 
   1 warning generated.


vim +/llseek_page_owner +573 mm/page_owner.c

   572	
 > 573	loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
   574	{
   575		loff_t retval = 0;
   576		switch (whence) {
   577			case SEEK_CUR:
   578			case SEEK_SET:
   579				file->f_pos = offset;
   580				break;
   581			default:
   582				retval = -ENXIO;
   583		}
   584	
   585		return retval;
   586	}
   587	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
