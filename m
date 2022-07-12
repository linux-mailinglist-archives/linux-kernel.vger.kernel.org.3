Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B2572969
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiGLWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGLWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:40:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4EC9102
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657665649; x=1689201649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MnjWBudHiPOSJUc36RNp5Q22wgoR+eUiLQ4loZ0ELRw=;
  b=YjbrgI632dfM1fkn9hL1dZEmWIyPbSfQnRmjwIdcLFq2VLzt3YvTOjX4
   IzQk0Al6FQZ4bkoTMSSj6suJrgHQm40Pou9+a2NZ4A4OYIN1+BZE//xdS
   PZfdfQw5bIuVaCGMDm7B/ycvHAATTQ94szZy22d3A6KkSvxfllJ2lXT7G
   sVf8TcrH/3nIKy9RDv7fO6rN5fM6i4eisrkGpKMGVy0xbcQ2WXLa9PXFG
   zTI5BLrsXSDpMlkkZkAaVQqzYZ7zBVxiKYJfoUf2nM/OtVasG2AIv7ptr
   /GCtGxCDgv75Iye1D92Kv/6jI1AXTN+xsyLv5JiTN8niJtpoW3SWFQaND
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285085438"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285085438"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="595457315"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2022 15:40:35 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBOYV-0002l1-9t;
        Tue, 12 Jul 2022 22:40:35 +0000
Date:   Wed, 13 Jul 2022 06:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7114/7120] arch/x86/kernel/kvm.o:
 warning: objtool: __raw_callee_save___kvm_vcpu_is_preempted()+0x12: 'naked'
 return found in RETHUNK build
Message-ID: <202207130605.fX0cfbtW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   53b881e19526bcc3e51d9668cab955c80dcf584c
commit: 892f1f2b8631df5bdd0baba6e1ee3fa6eff396d0 [7114/7120] x86/retbleed: Add fine grained Kconfig knobs
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220713/202207130605.fX0cfbtW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=892f1f2b8631df5bdd0baba6e1ee3fa6eff396d0
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 892f1f2b8631df5bdd0baba6e1ee3fa6eff396d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/kvm.o: warning: objtool: __raw_callee_save___kvm_vcpu_is_preempted()+0x12: 'naked' return found in RETHUNK build

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
