Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9BE54D281
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiFOU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiFOU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:26:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25FE50B37
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655324780; x=1686860780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VDVKIw6ylgbuESJkQQUemyUzYU5mbVRF4AqZiw+bcSk=;
  b=h0aC3UkXpocZ0SABs0c3BEloCYxv1D6/Uw0Ejl9ZNJ3OjFKUkR2sKv8y
   oNLlw4P7YDM8YY2arAdQhYSPf9S8vz/VnaUP8GA+SDFu1FOpn4dPa4NOh
   3Dfem6Sy+8NMyypUJ6i67vDS5SRNo/ddfkr1c5YjyD5W5uALCpvJ8ENwj
   iys/BVy4sNX6ta1WnM1Zdn10buOqLCB94oQM2eOzHH37t8e8Wr8V9RoiO
   ixMBYKt9cCmXOBYGigPOQJz0xuCiNLedPwc2L7zQiEQUuPk+R9NuXaEAF
   LFolm2OvEyat8S1aIq1jlWD5Hp848Wl+wxvgbKlEdy/vIsK2e2/Tx/HZ/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="343053606"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="343053606"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 13:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641196953"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2022 13:26:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1Zak-000NBJ-Ej;
        Wed, 15 Jun 2022 20:26:18 +0000
Date:   Thu, 16 Jun 2022 04:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 133/140]
 vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to
 __kasan_check_read() leaves .noinstr.text section
Message-ID: <202206160411.v3iL3YC0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
head:   0ba7324b44282870af740a5a121add62c7f5f730
commit: db21b02f8044e812f8a5e3811f602409290e3ede [133/140] context_tracking: Convert state to atomic_t
config: x86_64-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220616/202206160411.v3iL3YC0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/db21b02f8044e812f8a5e3811f602409290e3ede
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
        git checkout db21b02f8044e812f8a5e3811f602409290e3ede
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
