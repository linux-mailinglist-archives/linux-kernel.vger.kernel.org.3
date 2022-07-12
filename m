Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B865728AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiGLVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGLVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:39:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF058CDA22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657661976; x=1689197976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4fKL0I4CEkU/vp1cpmuqjpSokdof3TOx4kCluaF4yTA=;
  b=DfHnWSQNVr7y8HAbRx7I9bTqVynb+AspRNK3m5nt0prBEzvN8JakG06J
   dCVbH65HCaNxrS5gfZ/VJZ2/LMZ5g7Tm0ct/RTPndYZYmugpKWTersI1J
   bH6a8xQZeNGenmbnVTzzUOyNxL1V0prsFcjglbkzguW8acaoA2LYIk0AY
   XjTQeRAC+rLWPU7THLQoKTuLUthDmLB1cnJasBCNYQZj27AKiLtF1ttVs
   Q4SfkGIZfFIGBYUJvw4isDLZHtRy58mV1btUYJItCZ9IzvEYau4Hw3OlI
   YDkkJhMVAQpiDGToHJroF8KMDv0n1LM4tOTC+sUryZczgkd5matL4yjJt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268085421"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="268085421"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="663105088"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2022 14:39:34 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBNbR-0002iB-Ou;
        Tue, 12 Jul 2022 21:39:33 +0000
Date:   Wed, 13 Jul 2022 05:38:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7082/7120] arch/x86/kernel/head_64.o:
 warning: objtool: xen_hypercall_mmu_update(): can't find starting
 instruction
Message-ID: <202207130531.SkRjrrn8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   53b881e19526bcc3e51d9668cab955c80dcf584c
commit: 7575d3f3bbd1c68d6833b45d1b98ed182832bd44 [7082/7120] x86: Use return-thunk in asm code
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220713/202207130531.SkRjrrn8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=7575d3f3bbd1c68d6833b45d1b98ed182832bd44
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 7575d3f3bbd1c68d6833b45d1b98ed182832bd44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
