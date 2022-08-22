Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2928F59BD48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiHVKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiHVKBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:01:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030431EF8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661162461; x=1692698461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tl7MK2y9cCPTFv4sAiZf04Kt8yi60Qz75s5nN3qWKyg=;
  b=MRNOrzeXy5Ros3XklWny1erYbC8Rdhnv5WJ0YruJu9OPHlBxJv0mWbKP
   wIzmU+LXH6wwgbSDiL4OHrzPlrHVVF1wSoAX7CWY/sJDFlMWCGqBiecUe
   nMsBDZihtQQyBIO3/09PCy1GL37YBWlkiFIb46O/7d547dsehNPX/MyjP
   JJGuB3sS7FvNdJc+mKchAiOSx7izzdiIgdkTL9+Fhx9LCSiLjop6J/sJp
   +KyoH1FSMK+OZUL1/j9El9Slm+l92Q3HGDELkgI3allm7IktwzP5fy3oi
   q+CZiWhZTBZdWOzeAtN65ZsH+pDQQIkyDcItKPpr50AWugd+KhjjK+a60
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="273760158"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="273760158"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 03:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="751225875"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 03:00:44 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ4Ed-0005Bj-2T;
        Mon, 22 Aug 2022 10:00:43 +0000
Date:   Mon, 22 Aug 2022 18:00:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/block/aoe/aoenet.c:42:9: warning: 'strncpy' specified bound
 1024 equals destination size
Message-ID: <202208221724.e2TzAhaW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   8 months ago
config: arm64-randconfig-r034-20220821 (https://download.01.org/0day-ci/archive/20220822/202208221724.e2TzAhaW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/block/aoe/ drivers/bus/fsl-mc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/block/aoe/aoenet.c: In function 'aoe_iflist_setup':
>> drivers/block/aoe/aoenet.c:42:9: warning: 'strncpy' specified bound 1024 equals destination size [-Wstringop-truncation]
      42 |         strncpy(aoe_iflist, str, IFLISTSZ);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj':
>> drivers/bus/fsl-mc/dprc.c:453:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     453 |         strncpy(obj_desc->type, rsp_params->type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c:455:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     455 |         strncpy(obj_desc->label, rsp_params->label, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_set_obj_irq':
>> drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     494 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj_region':
   drivers/bus/fsl-mc/dprc.c:567:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     567 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +42 drivers/block/aoe/aoenet.c

eb086ec59667df Ed L. Cashin 2012-10-04  38  
03c41c434775c5 Ed L. Cashin 2005-04-29  39  #ifndef MODULE
03c41c434775c5 Ed L. Cashin 2005-04-29  40  static int __init aoe_iflist_setup(char *str)
03c41c434775c5 Ed L. Cashin 2005-04-29  41  {
03c41c434775c5 Ed L. Cashin 2005-04-29 @42  	strncpy(aoe_iflist, str, IFLISTSZ);
03c41c434775c5 Ed L. Cashin 2005-04-29  43  	aoe_iflist[IFLISTSZ - 1] = '\0';
03c41c434775c5 Ed L. Cashin 2005-04-29  44  	return 1;
03c41c434775c5 Ed L. Cashin 2005-04-29  45  }
03c41c434775c5 Ed L. Cashin 2005-04-29  46  

:::::: The code at line 42 was first introduced by commit
:::::: 03c41c434775c52092d17a5031ad8ebaaf555bc4 [PATCH] aoe: improve allowed interfaces configuration

:::::: TO: Ed L Cashin <ecashin@coraid.com>
:::::: CC: Greg KH <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
