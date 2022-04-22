Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1453C50B97A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448325AbiDVOId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388281AbiDVOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9378546A8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650636334; x=1682172334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FcHVXfLJ0ETLbWVd9NyHdJ391U5rIrEfhWtnvhIpeA=;
  b=Q91Oisk1ojZ9FTxpCttzIo25zIb8NTqhc/fTmoEx5i93U/zwEPmcqScw
   yz5SGbiZpzfE1S3Y8oyXrwFpkK8tBvsAsX+Wr0jI6Jc+v+bC12CBvz50B
   WKItbPh6LoJUukB7vHt2r6VqPSWWpYUkNP7FLD96beNJ3PDW31Z+lCdks
   1hX/0Oc4rKEw74iSJpz9RbJ+j+NYoKyj18+nRb7vE+bz0GHaogHXah1NT
   BiYkK6aMUkxceUB/RnJ1a++aWKNFY1cyHhNSV9b5QYIYGv3tU5hSVnATX
   u6BsLzX+GdUrGN5g2uErBB+ksUFe/z3QlfpmL0AdPMMuQZXWyoNu6xqoz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246589585"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="246589585"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 07:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="627001572"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2022 07:05:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhtuP-000A9o-IK;
        Fri, 22 Apr 2022 14:05:17 +0000
Date:   Fri, 22 Apr 2022 22:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Cheng <michael.cheng@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, willy@infradead.org,
        michael.cheng@intel.com, casey.g.bowman@intel.com,
        lucas.demarchi@intel.com, wayne.boyer@intel.com,
        tvrtko.ursulin@linux.intel.com, matthew.d.roper@intel.com,
        geert@linux-m68k.org
Subject: Re: [PATCH v1] Add struct folio to cacheflush.h
Message-ID: <202204222144.rT2z4GlF-lkp@intel.com>
References: <20220225201248.984169-1-michael.cheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225201248.984169-1-michael.cheng@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[cannot apply to linus/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220422/202204222144.rT2z4GlF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f519440dbde207a6ade2472cd2e6c32028923342
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
        git checkout f519440dbde207a6ade2472cd2e6c32028923342
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: net/dccp/feat.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/input.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/minisocks.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/options.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/output.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/proto.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/timer.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/qpolicy.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/ccid2.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ackvec.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/ccid3.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/lib/tfrc.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/lib/tfrc_equation.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/lib/packet_history.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/ccids/lib/loss_interval.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
   ld: net/dccp/sysctl.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/dccp/ccid.o:include/linux/cacheflush.h:7: first defined here
--
>> ld: net/ipv6/ila/ila_common.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/ipv6/ila/ila_main.o:include/linux/cacheflush.h:7: first defined here
   ld: net/ipv6/ila/ila_lwt.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/ipv6/ila/ila_main.o:include/linux/cacheflush.h:7: first defined here
   ld: net/ipv6/ila/ila_xlat.o:include/linux/cacheflush.h:7: multiple definition of `folio'; net/ipv6/ila/ila_main.o:include/linux/cacheflush.h:7: first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
