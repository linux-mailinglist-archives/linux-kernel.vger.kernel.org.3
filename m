Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50335AC5CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiIDRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIDRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:52:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27852D1C9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662313930; x=1693849930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s+U1XhTJ0Wvvvqv6HICkGlCcCwN0Z3mAsCPx3osKbdM=;
  b=L/7uXNHMBqFlPSvKKpAmSdrhexQGRV4DlrjV4kGUiB5gbxinSNR+YJ/J
   L3doJPEyUllNH1xepTZM5E3N0uMcK8zFBPbErH/fau9I0XEj8THLVO+N9
   vpuecoMEa7V4gNozAtEgQwyqZQJSl+imYy9xrzdBaSRPxQtSjd2jNUWQy
   7Sus9LATgOKw8DGNuKPZQM9nY3O+NjQ+sdpD9/75VfzSi9/yNM82VzEl0
   0PnV8aCsxFwMmpgVKBZBNjfbh5ksD4BQXjmhA+rKE2KsVRru4VyZre70p
   Avj9WCXnjV1MGhSxhSfTnFBnxuGBbf57zbwvhD9EUx7p99XUXCituWJQl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297045564"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="297045564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 10:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="739365160"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2022 10:52:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUtmy-0003H5-2P;
        Sun, 04 Sep 2022 17:52:08 +0000
Date:   Mon, 5 Sep 2022 01:51:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 13/17] mapping.c:undefined reference
 to `dax_flush'
Message-ID: <202209050157.cidXIuy1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   28533c3555d9f4cc074eb01189343adbaa47b6f5
commit: 1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f [13/17] devdax: Move address_space helpers to the DAX core
config: parisc-buildonly-randconfig-r002-20220904 (https://download.01.org/0day-ci/archive/20220905/202209050157.cidXIuy1-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa64-linux-ld: hppa64-linux-ld: DWARF error: could not find abbrev number 2778688810
   drivers/dax/mapping.o: in function `.LC397':
>> mapping.c:(.data.rel.ro+0x4d0): undefined reference to `dax_flush'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
