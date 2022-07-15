Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76A575A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGOEAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiGOEAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:00:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6311F753A6;
        Thu, 14 Jul 2022 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657857603; x=1689393603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKPPuQbWPT+H5/LhHy8Xc6+43fIOur+Tt3pMg1WW4Uw=;
  b=HNdrL3lct7bN36H440GDOBgiyPgv1xIP6kp2TcjUD1/9r47uUcCggZFx
   WdAHGtcOBPDyd5kfy6BmS96Q3zPBXP7ny+KFQMsg7or6bQxUaFMuh5+NU
   W7oBOpOnwsO5JOaw4iVTNHTrvKJpD0Q6jI8YUdHESUOGjb7oN58oCFOxA
   pRQbvGNGCrMZraRITBTrd1oqaKdiiPUJkUj19E/wNNGQZogCM7v0cfsjR
   F5lYraPK3KpvzXXgRzVEzoYOsyCsxZFV2EJrCOgVJStLp+FKkH9NM4uGT
   VhUPvvprxd2buJ1BT6b2rP79Z6+5x+ENTFn3tiWjJlCoMUgcLf44K+29O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283253559"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283253559"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 21:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623690669"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 21:00:00 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCCUi-0001VN-0k;
        Fri, 15 Jul 2022 04:00:00 +0000
Date:   Fri, 15 Jul 2022 11:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Bara <bbara93@gmail.com>, dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Message-ID: <202207151127.f15rTOxu-lkp@intel.com>
References: <20220713084247.3090353-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713084247.3090353-1-bbara93@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220715/202207151127.f15rTOxu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/13455f523263c4e90b5cc8c587ef2be97008ff5f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
        git checkout 13455f523263c4e90b5cc8c587ef2be97008ff5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/tsc2007_core.c:112:6: sparse: sparse: symbol 'tsc2007_is_pen_down_cansleep' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
