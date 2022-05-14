Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD913526F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiENEV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 00:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiENEVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 00:21:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA72CAAA2;
        Fri, 13 May 2022 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652502081; x=1684038081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=foeZf0AUzYAEV4pRcRQiybWTbSdzFEZUJrOd+rIC80M=;
  b=RqX6AmMnpYv2UAl8y7YRaGp8TCz/3Q+klf3XwnRH8cExe5cxq8btYoLs
   j2ISuE/bMHCXclr/1+QYL0NyC1T7tBq7gGwQrW6IEcuUTeTHKJ45xffMN
   9/PgC+wQZfaQvzg1A5MvrLudyG4zJUkj7x1j39qrGw3vx6LbRZrfk2b2o
   MAWTzYsZ4Fq5nkecnyFb3Nmlg/8mb1tsGH/oxcrJzaDPzZ4LXsEzMCp/V
   uRseDTBA0cOSuRMblj+SFYJQ8p4OZIBIIFSDDi97fks94RwoCzfqMnz/j
   ix9hrvIzNjalr54YAtBZV3qZFL6NDIQWhgNXs3Vzjx/lJAn8D5isuyO1S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270595885"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="270595885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 21:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="896492815"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2022 21:21:18 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npjHJ-0000CL-Br;
        Sat, 14 May 2022 04:21:17 +0000
Date:   Sat, 14 May 2022 12:20:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2 1/2] can: skb:: move can_dropped_invalid_skb and
 can_skb_headroom_valid to skb.c
Message-ID: <202205141221.H0aZXRak-lkp@intel.com>
References: <20220513153606.302464-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513153606.302464-2-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I love your patch! Yet something to improve:

[auto build test ERROR on mkl-can-next/testing]
[also build test ERROR on v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-skb-move-can_dropped_invalid_skb-and-can_skb_headroom_valid-to-skb-c/20220514-003707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
config: arm-randconfig-r021-20220512 (https://download.01.org/0day-ci/archive/20220514/202205141221.H0aZXRak-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/8f56e6b1b9945ea47c9f410d1254451df9d6fe22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Mailhol/can-skb-move-can_dropped_invalid_skb-and-can_skb_headroom_valid-to-skb-c/20220514-003707
        git checkout 8f56e6b1b9945ea47c9f410d1254451df9d6fe22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>> ld.lld: error: undefined symbol: can_dropped_invalid_skb
   >>> referenced by vxcan.c:45 (drivers/net/can/vxcan.c:45)
   >>>               net/can/vxcan.o:(vxcan_xmit) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
