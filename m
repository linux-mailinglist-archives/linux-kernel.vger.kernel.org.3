Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E45AD571
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiIEOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiIEOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:47:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85601E5A;
        Mon,  5 Sep 2022 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662389252; x=1693925252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZwtkoVzthvQh0BwuPCbrIeiKZoNKlYVrBGd6h2F+gk=;
  b=c+zBo/8qLBSnkjm5PKTQsufuOtI3+6ry0I0Jv6DDsgvXXI0t4KOD5kjQ
   YCCTSRwh2BSAzeWfOIpRvtJ9kssuwv99SH+Sjru6W4rih8JBXqG6tbs12
   IvoTMC87meupNcQewjoHa4IlRH5aDAY63IuuXcqZMSwu5gkwhRAwaKClk
   oSWqyuprwA+ytW+3H/xrehJPHyb2dW2MS2d+8qN4KJ90DT149+ujnhXw1
   3Fx1CHsOqT2iUWJFMgsXabLrMJpO3iu7QC/eJ1H10V0cLhYXn0v87qqMK
   KZlzuTUHKs62c5ZN8sCvkKZ9bTERWe2EMGOETmwR1tB9C7+Of2Itf6co8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283396830"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="283396830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 07:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="942131368"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 07:47:29 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVDNo-0004FZ-2H;
        Mon, 05 Sep 2022 14:47:28 +0000
Date:   Mon, 5 Sep 2022 22:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     kbuild-all@lists.01.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, mwilck@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH] module: Merge same-name module load requests
Message-ID: <202209052214.GvWvd88T-lkp@intel.com>
References: <20220905084131.14567-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905084131.14567-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc4]
[also build test WARNING on linus/master next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Pavlu/module-Merge-same-name-module-load-requests/20220905-164434
base:    7e18e42e4b280c85b76967a9106a13ca61c16179
config: i386-randconfig-s033-20220905 (https://download.01.org/0day-ci/archive/20220905/202209052214.GvWvd88T-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/581eb179f101ce9990a4435e198280b542fa68ed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Petr-Pavlu/module-Merge-same-name-module-load-requests/20220905-164434
        git checkout 581eb179f101ce9990a4435e198280b542fa68ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/module/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/module/main.c:81:1: sparse: sparse: symbol 'running_loads' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
