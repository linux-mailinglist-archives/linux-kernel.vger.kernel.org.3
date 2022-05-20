Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B652EF30
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbiETP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiETP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:28:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0686B0A5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653060533; x=1684596533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2leG2LmaeymdY17ZfAaPpngzgqFnDp+gD2t1Nl2U6Yo=;
  b=kPaoqNhWtZNol28aIuNoeAARTbnLmQOssIOaJ26GU507cx5K6Cfr9LWP
   l6Q1VPc7ULItdIzxAM36n98J955KairBcIuhGuTAaVdziWm0iaeStSED0
   jbZdkWA2pT5WNh+uUrgRym3Zx0XeIAuG/GXqPaGb/1qw1JC8DkIpJPdA2
   Oj0qVG5JYzE5MR1BIOW/Su2cph3v8Ni2LJiWEZgiCG4IflNrzPOFLmb/P
   lP4PwEQFlEPolvmwNvLLMptrEqXNRClb5+OwoVaZGbPFsRn7mHlzAkpb1
   DmNH8hVB61QCdtbo1MHNdoTufR8dc82sgX9LQYnPeDvMLj7DNRMzvkdgZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272612188"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="272612188"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="899369665"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2022 08:28:50 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns4Yb-0004rl-NI;
        Fri, 20 May 2022 15:28:49 +0000
Date:   Fri, 20 May 2022 23:28:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, mst@redhat.com, david@redhat.com
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, pbonzini@redhat.com,
        peterx@redhat.com, qemu-devel@nongnu.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <202205202330.u0vQWiWG-lkp@intel.com>
References: <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220519]
[cannot apply to linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm-randconfig-r026-20220519 (https://download.01.org/0day-ci/archive/20220520/202205202330.u0vQWiWG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a42127073dd4adb6354649c8235c5cde033d01f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
        git checkout a42127073dd4adb6354649c8235c5cde033d01f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `unpoison_memory_func':
>> virtio_balloon.c:(.text+0x89a): undefined reference to `unpoison_memory'
   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_probe':
>> virtio_balloon.c:(.text+0x111a): undefined reference to `register_memory_failure_notifier'
   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_remove':
>> virtio_balloon.c:(.text+0x12a2): undefined reference to `unregister_memory_failure_notifier'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
