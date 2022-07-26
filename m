Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF45811D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiGZLWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGZLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:22:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C989659B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658834526; x=1690370526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rBPO9xa/oJv3nN9DO6TWnF5eY6pHJ7aM4T3fp0MZmsA=;
  b=JwAI7Juq7QycedEb+r0/y76PhOj+2G6ivpiirDx6P/WrIjQDQule9GEW
   MK/yQZIQBE17e0yiQHv4nc2LeQl4asczrccFohejhizv02arkvnBbSm12
   ZsMLY9FKEVUcwT1stUAt24KDy7g9sxoXONNKqbAItO7LP7R+5IecefSS0
   yjJY5V+XjJZaws11KGik6kbdIOgpeYDBIJH2va0qiQViYJSfTTD5zA45O
   YbgbFxJq897GypaV2xisd6tF4aeKamBJycEpdsh1BeSzGcy+oZhdfH9Oh
   InCD89eBZWspNZuTqY136+TZ+jAihoQio53pQfjSfdLb5SoPsO2C/Pj8I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267695888"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267695888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575457652"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 04:22:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGIdX-0006jS-2b;
        Tue, 26 Jul 2022 11:22:03 +0000
Date:   Tue, 26 Jul 2022 19:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faycal Benmlih <faycal.benmlih@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/socwatch/sw_mem.c:141:18: sparse: sparse: cast
 to restricted gfp_t
Message-ID: <202207261920.HbinaE6P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faycal,

First bad commit (maybe != root cause):

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: e65547c5a9bb37e907edecece4da7cb12dadea96 platform/x86: Use $(srctree) instead of $(src) to adapt to kbuild regression
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220726/202207261920.HbinaE6P-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/e65547c5a9bb37e907edecece4da7cb12dadea96
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout e65547c5a9bb37e907edecece4da7cb12dadea96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socwatch/sw_mem.c:141:18: sparse: sparse: cast to restricted gfp_t
   drivers/platform/x86/socwatch/sw_mem.c:305:38: sparse: sparse: cast to restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *dest @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse:     got void *dest
>> drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse:     got void *
>> drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __user *buffer @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse:     expected void *dest
   drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse:     got void [noderef] __user *buffer
--
>> drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[assigned] out_arg @@
   drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse:     got char *[assigned] out_arg
>> drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buffer @@     got char *remote_buffer @@
   drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse:     expected void [noderef] __user *buffer
   drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse:     got char *remote_buffer
>> drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *remote_cfg @@
   drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse:     got char *remote_cfg
--
>> drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_collector.c:85:33: sparse: sparse: symbol 'sw_copy_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:116:5: sparse: sparse: symbol 'sw_init_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:138:5: sparse: sparse: symbol 'sw_init_ops_i' was not declared. Should it be static?
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_collector.c:211:24: sparse: sparse: symbol 'sw_alloc_ops_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:323:6: sparse: sparse: symbol 'sw_free_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:329:6: sparse: sparse: symbol 'sw_free_ops_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:335:5: sparse: sparse: symbol 'sw_reset_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:453:6: sparse: sparse: symbol 'sw_free_collector_msg_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:459:6: sparse: sparse: symbol 'sw_handle_per_cpu_msg_i' was not declared. Should it be static?
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse:     got restricted gfp_t

vim +141 drivers/platform/x86/socwatch/sw_mem.c

d605aabab41663 Jon Moeller    2018-11-13  132  
d605aabab41663 Jon Moeller    2018-11-13  133  /*
d605aabab41663 Jon Moeller    2018-11-13  134   * Allocate free pages.
d605aabab41663 Jon Moeller    2018-11-13  135   * TODO: add memory tracker?
d605aabab41663 Jon Moeller    2018-11-13  136   */
688e338c753b33 Faycal Benmlih 2019-04-23  137  unsigned long sw_allocate_pages(
688e338c753b33 Faycal Benmlih 2019-04-23  138  	unsigned int flags, unsigned int alloc_size_in_bytes)
d605aabab41663 Jon Moeller    2018-11-13  139  {
688e338c753b33 Faycal Benmlih 2019-04-23  140  	return __get_free_pages(
688e338c753b33 Faycal Benmlih 2019-04-23 @141  		(gfp_t)flags, get_order(alloc_size_in_bytes));
d605aabab41663 Jon Moeller    2018-11-13  142  }
d605aabab41663 Jon Moeller    2018-11-13  143  /*
d605aabab41663 Jon Moeller    2018-11-13  144   * Free up previously allocated pages.
d605aabab41663 Jon Moeller    2018-11-13  145   * TODO: add memory tracker?
d605aabab41663 Jon Moeller    2018-11-13  146   */
688e338c753b33 Faycal Benmlih 2019-04-23  147  void sw_release_pages(
688e338c753b33 Faycal Benmlih 2019-04-23  148  	unsigned long addr, unsigned int alloc_size_in_bytes)
d605aabab41663 Jon Moeller    2018-11-13  149  {
d605aabab41663 Jon Moeller    2018-11-13  150  	free_pages(addr, get_order(alloc_size_in_bytes));
d605aabab41663 Jon Moeller    2018-11-13  151  }
d605aabab41663 Jon Moeller    2018-11-13  152  

:::::: The code at line 141 was first introduced by commit
:::::: 688e338c753b33c023de3b774f7347effbf537a4 Platform/x86: Update SoCWatch driver code to 2.10

:::::: TO: Faycal Benmlih <faycal.benmlih@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
