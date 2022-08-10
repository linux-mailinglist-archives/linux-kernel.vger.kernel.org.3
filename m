Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78358E4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHJByS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiHJByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:54:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664E7B795
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660096448; x=1691632448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CyHQEakw+ZOvcBXAXXIIx7q7LG9CfGlIZtoo3MXTCXc=;
  b=frLyoe5sYfX5epHrlO6d2mkNAIXF45+QOfTDpAoju3fKOPmiail/W5tg
   iWU6wxlNe/4cmgBMTIcTlgDu/kQvZ0TCWzR24dPPPh1hzV1dz2vsgXA+5
   F8od9j+JQJb2VGtfOgPSrT3NETYsdvyW1GKmSmNeiD7Sj56YC6EBXVKx5
   owJjEDmoIFUJBRMU8F1XYRmkFQnmcqbGR7uMfImEi3Q0g7mim3Jb+KcBu
   ozjtvTPhmuihwfbNcW3D8YvKYpJOCbK/hRN1nuK/eAzSJScWFlkx74GSI
   MW7EUsBx9HBPXMv04MkbRSRLgzLu2XxPbGmgaVUCguQ6YH28c4UrZc8Ej
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289729477"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="289729477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="555556528"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2022 18:54:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLav6-000NPx-2t;
        Wed, 10 Aug 2022 01:54:04 +0000
Date:   Wed, 10 Aug 2022 09:53:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for
 'kasan_map_memory'
Message-ID: <202208100915.RsOr5Nax-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15205c2829ca2cbb5ece5ceaafe1171a8470e62b
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   3 weeks ago
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220810/202208100915.RsOr5Nax-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5b301409e8bc5d7fad2ee138be44c5c529dd0874
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5b301409e8bc5d7fad2ee138be44c5c529dd0874
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
      28 | void kasan_map_memory(void *start, size_t len)
         |      ^~~~~~~~~~~~~~~~
   arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
     212 | void __init check_tmpexec(void)
         |             ^~~~~~~~~~~~~


vim +/kasan_map_memory +28 arch/um/os-Linux/mem.c

    19	
    20	/*
    21	 * kasan_map_memory - maps memory from @start with a size of @len.
    22	 * The allocated memory is filled with zeroes upon success.
    23	 * @start: the start address of the memory to be mapped
    24	 * @len: the length of the memory to be mapped
    25	 *
    26	 * This function is used to map shadow memory for KASAN in uml
    27	 */
  > 28	void kasan_map_memory(void *start, size_t len)
    29	{
    30		if (mmap(start,
    31			 len,
    32			 PROT_READ|PROT_WRITE,
    33			 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
    34			 -1,
    35			 0) == MAP_FAILED) {
    36			os_info("Couldn't allocate shadow memory: %s\n.",
    37				strerror(errno));
    38			exit(1);
    39		}
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
