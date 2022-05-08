Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4E51F1DA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiEHVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiEHVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:46:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0A6445
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652046152; x=1683582152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R84R+8J9vaNzSiM/TZ6PeV+5YBL1xItA/lw6q6VRMxc=;
  b=JG9kJmAgE5qHQIJuEE7UO2D+4aV3noyRiIwe1iI165ClH42rzKb4WaW8
   epnEwS3jk9SqSK1eMWRptYT2yODHrROr9Bl7n0LDQITnS7LMhD0inm0Gj
   saL81O0A8K8e6GKUN6wP/PE2xwAkAX9z19jYSndqoyZUUK1moqLybIvOy
   Drsaq0Yy6V43kZzzhvNcTrhW6sWnxvPKhFMkVE89ejicak2uO7heaf/sf
   aRXtAGDSklO4vMFT3oFJbe2A4v2wfDdbMy/dGLs51DhfzN5dm46Wjg6uy
   MS6CfArCBJ039CdI5bvQ8q/w1DIjx64yL2Ye9XVE6tr+8xpHFON1gggYS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="267723610"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="267723610"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 14:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="569881003"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2022 14:42:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnofd-000FrQ-Mu;
        Sun, 08 May 2022 21:42:29 +0000
Date:   Mon, 9 May 2022 05:42:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Junwen Wu <wudaemon@163.com>
Subject: drivers/thermal/thermal_sysfs.c:814 find_show_state() warn:
 inconsistent indenting
Message-ID: <202205090542.dLZqKZr7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220508-232600/Zhang-Rui/thermal-thermal_stats-skip-broken-trans_table/20220419-165035
head:   a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7
commit: a9158ddd9f2a97e356583d0bdb81c4e6822e6ad7 thermal/core: change mm alloc method to avoid kernel warning
date:   6 hours ago
config: s390-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090542.dLZqKZr7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/thermal/thermal_sysfs.c:814 find_show_state() warn: inconsistent indenting

vim +814 drivers/thermal/thermal_sysfs.c

   785	
   786	static int find_show_state( int *nums, int numsSize, int k, unsigned int *max_value)
   787	{
   788	    int i, min = INT_MAX, max = 0;
   789	    for( i = 0; i < numsSize; ++i )
   790	    {
   791	        min = nums[i] < min ? nums[i] : min;
   792	        max = nums[i] > max ? nums[i] : max;
   793	    }
   794	    int l = min, r = max, mid, cnt = 0;
   795	    while( l < r )
   796	    {
   797	        mid = r - (r - l) / 2;
   798	        for( i = 0; i < numsSize; ++i )
   799	        {
   800	            if( nums[i] >= mid )
   801	                ++cnt;
   802	        }
   803	        if( cnt < k )
   804	        {
   805	            r = mid - 1;
   806	            cnt = 0;
   807	        }
   808	        else
   809	        {
   810	            l = mid;
   811	            cnt = 0;
   812	        }
   813	    }
 > 814	     *max_value = max;
   815	    return l;
   816	}
   817	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
