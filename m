Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E958E4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiHJBou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHJBoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:44:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6486FA2A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660095855; x=1691631855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2ii/FAzsKllxKwlw1SZ3nk8zJyVTVJglFHdwFnQBrE=;
  b=CYBDSDsrjl2i/HsUvfL4XVPeuVVaioRZskQumCrKyNkkrQcR3Yxo3sfF
   CQxRzmfcqxDeQfKG/KPdgM8H9idQdpyee/bf74Szo1OjoFk3IKxNmVRJ2
   Z4wdUQFLlXoo7r1ruUlAJ913PYTHz/OleNhtsYss9JPlrtX6m/zy4TTd8
   R9QI5Cc285rrCTAsJP/dVnsrLxdZXxJMyW8YSWgk8LqHg3W4XHp+xHLmJ
   7UtHfEfjLxcP+GO+07r7Q8GDi3Y8UL3DcmDzuWiW+mS+bvLMikFaLQVP/
   +1QGsWRCOSpCpNvKqsUL6evxDWB7GInHVBngchYC8UNyvZ3ImNB7D43he
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="354974381"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="354974381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="637927662"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2022 18:44:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLalQ-000NPV-1z;
        Wed, 10 Aug 2022 01:44:04 +0000
Date:   Wed, 10 Aug 2022 09:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     kbuild-all@lists.01.org, Kassey Li <quic_yingangl@quicinc.com>,
        minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5] mm/page_owner.c: add llseek for page_owner
Message-ID: <202208100941.jQ8Z3cEq-lkp@intel.com>
References: <20220809024725.31980-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809024725.31980-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kassey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.19]
[also build test ERROR on next-20220809]
[cannot apply to akpm-mm/mm-everything linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220809-104956
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: arm-buildonly-randconfig-r003-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100941.jQ8Z3cEq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2c71629233aa8742e2a6ce7341287c02bc1aa9fd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220809-104956
        git checkout 2c71629233aa8742e2a6ce7341287c02bc1aa9fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: mm/page_owner.o: in function `.LANCHOR4':
>> page_owner.c:(.rodata+0x4): undefined reference to `mem_lseek'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
