Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18559B64B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiHUUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiHUUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:18:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987381A043;
        Sun, 21 Aug 2022 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661113085; x=1692649085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGwu4UYZpz4PTveoCzdOe9uswm9TgrvREj3LygEgkig=;
  b=m2yU0tvXY+g/Rph2K2AxfWM4suBNCxDSt8vHVUbsidpR050Gb8DMz+sD
   UydPtZ8jtPJcCJRDygUQdRYE07fdGu+l5pMDiW81+gUstAm9+hQ0UA5gx
   t5+7E6y/yMHE38OEK+c9Rz0SPWlMRCW2ilGgaFEctY9yZGJj+T50Yi6a3
   O2ijbXsNbBBSU9D5KKpJcmTr/moQEaI1BkyMIsJobVbU1wVHFF61VQIvM
   jC6nZ7Yd12EpynbRaJGRvcGCiA4YEWiNTW09+Vz8yD2Jy4fPhTuyoDj+3
   dkd6URrA/IHRm8pSFxf/p9L1P9aGmVX9P241q6jIIMKRWCX39+WnY4am8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357258062"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="357258062"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 13:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="676980543"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2022 13:18:02 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPrOT-0004Rz-2Q;
        Sun, 21 Aug 2022 20:18:01 +0000
Date:   Mon, 22 Aug 2022 04:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vimal Kumar <vimal.kumar32@gmail.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, chinmoyghosh2001@gmail.com,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Message-ID: <202208220446.ZLg90bEJ-lkp@intel.com>
References: <20220821134533.22901-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821134533.22901-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vimal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-runtime-Add-support-to-disable-wakeup-sources/20220821-214614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-c021 (https://download.01.org/0day-ci/archive/20220822/202208220446.ZLg90bEJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/base/power/wakeup_stats.c:221:11-18: WARNING opportunity for memdup_user

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
