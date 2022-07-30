Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5E5858AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 07:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiG3FGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 01:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiG3FGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:06:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B774DDF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659157601; x=1690693601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M+ILQ7FP/pB1bK3rMa5I7SaCioP/MKssXQTzB0JGgrM=;
  b=BQN85GA+9LBSLJtnNCY3KLuSQmnAvabp2DlYnDaRp2lQpp/TIWHrGJHq
   2/8wdvLwDx8X2fCz+uDDcImZW9BGtdOhiEqvz7Buqm+hW/ztHVinzzX2+
   8QwaTOm6eKmoNRPafDcz0nm2QYxXOhCtTdCDYxVZSiqgJ0xMgkxuAtRBn
   Ajl/0srcdmza8bTC4BpQfZO58KPvPAjGWc3l17EHTpXdWtJ18F3BO+4XI
   sm5tZEuRDSXz3UQGpKqpLVKQlAte8sAKkY7PrN8svUC2vUt3LMIEEb7IT
   sPSoul6KrK2g2g7yezJNKhC9nBj6Vv0O1ku+WDfwANrWB41zKumHsbF/I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289661137"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="289661137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="928970057"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 22:06:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHegR-000CQX-11;
        Sat, 30 Jul 2022 05:06:39 +0000
Date:   Sat, 30 Jul 2022 13:06:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: ERROR: modpost: "__iget" [fs/fuse/fuse.ko] undefined!
Message-ID: <202207301359.irfw6S8Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220730-014236/Tycho-Andersen/sched-__fatal_signal_pending-should-also-check-shared/20220712-042911
head:   ac9225bf0cc3ae54d88be11ebf712c819bd0812b
commit: ac9225bf0cc3ae54d88be11ebf712c819bd0812b fuse: In fuse_flush only wait if someone wants the return code
date:   11 hours ago
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220730/202207301359.irfw6S8Q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ac9225bf0cc3ae54d88be11ebf712c819bd0812b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220730-014236/Tycho-Andersen/sched-__fatal_signal_pending-should-also-check-shared/20220712-042911
        git checkout ac9225bf0cc3ae54d88be11ebf712c819bd0812b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__iget" [fs/fuse/fuse.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
