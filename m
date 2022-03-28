Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E124EA3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiC1XpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiC1XpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:45:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D5126FBA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648511014; x=1680047014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4avTRIrnHAvVCB23P7MPIKTwh4gepgKr4ohUVOGRVw=;
  b=OjI2zoKLpkAjbL5V/FZAwxV4GUPJK5J72iL3Wkp/UpXBCLmQPlRS+0fB
   vcKkPmTStl3GGjLqDAqbIgsBbIPoh8qmGENUUtqRzFBJowpcP3+5xpTWs
   71cgAQ/ueT8TEkZLKIp1UdlyRkYAx/ifR4Rtm0T5LwY7sJFCK3Ef2v7Fj
   xkZ/ZffpkEW1gAB9p3hWM0f2H02gjEZaD2FXHy70cNOMh+DjUEaVuHTS0
   Hh+XhEeg/CYywnbTyBRVV2GTcPMOIaRU8+t+xAqBqpXNnvJhusT+3zcRw
   jCLL/vEtaWBMGHgkvILSrydPOBg267aVzBvSld7dUSHUc6uLKd6IEGG5o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="246613521"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="246613521"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 16:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="652455642"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2022 16:43:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYz1G-0002Q8-6C; Mon, 28 Mar 2022 23:43:30 +0000
Date:   Tue, 29 Mar 2022 07:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kirill Tkhai <kirill.tkhai@openvz.org>, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, song@kernel.org,
        linux-kernel@vger.kernel.org, khorenko@virtuozzo.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 3/4] dm-qcow2: Introduce driver to create block devices
 over QCOW2 files
Message-ID: <202203290708.kbbyhG39-lkp@intel.com>
References: <164846631540.251310.2398727490395218229.stgit@pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164846631540.251310.2398727490395218229.stgit@pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on song-md/md-next linus/master v5.17 next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-Tkhai/dm-Introduce-dm-qcow2-driver-to-attach-QCOW2-files-as-block-device/20220328-192031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203290708.kbbyhG39-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c41a15c11909af3588885a88f6622c36dcc9ca35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kirill-Tkhai/dm-Introduce-dm-qcow2-driver-to-attach-QCOW2-files-as-block-device/20220328-192031
        git checkout c41a15c11909af3588885a88f6622c36dcc9ca35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/md/dm-qcow2-target.o: in function `calc_cached_parameters':
   dm-qcow2-target.c:(.text+0x10ee): undefined reference to `__divdi3'
   m68k-linux-ld: drivers/md/dm-qcow2-map.o: in function `qio_subclu_indexes':
   dm-qcow2-map.c:(.text+0x15e): undefined reference to `__udivdi3'
   m68k-linux-ld: drivers/md/dm-qcow2-map.o: in function `calc_refcounters_map':
   dm-qcow2-map.c:(.text+0x2be): undefined reference to `__divdi3'
>> m68k-linux-ld: dm-qcow2-map.c:(.text+0x2e8): undefined reference to `__moddi3'
   m68k-linux-ld: drivers/md/dm-qcow2-map.o: in function `process_embedded_qios':
   dm-qcow2-map.c:(.text+0x38fa): undefined reference to `__divdi3'
   m68k-linux-ld: drivers/md/dm-qcow2-map.o: in function `parse_metadata':
   dm-qcow2-map.c:(.text+0x4d7a): undefined reference to `__divdi3'
>> m68k-linux-ld: dm-qcow2-map.c:(.text+0x4d98): undefined reference to `__divdi3'
   m68k-linux-ld: dm-qcow2-map.c:(.text+0x4e00): undefined reference to `__moddi3'
   m68k-linux-ld: dm-qcow2-map.c:(.text+0x4e26): undefined reference to `__divdi3'
   m68k-linux-ld: drivers/md/dm-qcow2-map.o: in function `relocate_refcount_table':
   dm-qcow2-map.c:(.text+0x52ce): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
