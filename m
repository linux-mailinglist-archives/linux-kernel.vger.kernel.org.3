Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6957554D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiGNSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiGNSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:45:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB652657A;
        Thu, 14 Jul 2022 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657824335; x=1689360335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pPi3eWsIlBGTVv6fqrE93d3yLDmKbn4WssjJSQISjSw=;
  b=Y7dSfBq3XlI1tsSfx8LY6mXh2WHAYuJaacJTNBNRzrD70uWFEjG4pynd
   BhbHCDi/44H5yS1j6IypjQ58VcF9b5jcPVA8TLyKNr73rWakPQ5tvacxT
   oHmzvetE+a9wYPmRzXXYa8MSY9jEYCRAOPLqyIFOIMSI/xyHBMsBehB4y
   iN2Whl8wPEXyGECSY2HgozyRwB6iayWx6ZFC29DaKi9iPGMeYOYvFLQKV
   fBk8aPqP6ScdigGIYYxgVd3ak0a/Y6A8O47BwuCKMrVtioCT6NIJmdcY7
   fo7eps3At7N8FQtWFkTxbflP35pz8lgBiEwXU6QXv6fQop21adFq2f+G/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265392860"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265392860"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="842248488"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2022 11:45:32 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC3q8-00010F-8A;
        Thu, 14 Jul 2022 18:45:32 +0000
Date:   Fri, 15 Jul 2022 02:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Chen <me@linux.beauty>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/sparse: skip no-map memblock check when
 fill_subsection_map
Message-ID: <202207150209.3Svjqq9D-lkp@intel.com>
References: <20220711122459.13773-3-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711122459.13773-3-me@linux.beauty>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core arm-perf/for-next/perf linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Chen/add-struct-page-and-Direct-I-O-support-to-reserved-memory/20220711-202957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-randconfig-k001 (https://download.01.org/0day-ci/archive/20220715/202207150209.3Svjqq9D-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d9809d17afee6693084b417325807c7123432fab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Chen/add-struct-page-and-Direct-I-O-support-to-reserved-memory/20220711-202957
        git checkout d9809d17afee6693084b417325807c7123432fab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x346d8f): Section mismatch in reference from the function fill_subsection_map() to the function .meminit.text:memblock_is_map_memory()
The function fill_subsection_map() references
the function __meminit memblock_is_map_memory().
This is often because fill_subsection_map lacks a __meminit
annotation or the annotation of memblock_is_map_memory is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
