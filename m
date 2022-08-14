Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF9591FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHNMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:52:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7DA26E6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660481519; x=1692017519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kFk1jUbR8Kh+cFUMjzYkduWCTXacUecoe/Y9VWupVTQ=;
  b=F8csmVgQxifJBsAX65oN7ZTrmkRGa5bfg6S2F0/t9T3+Ud+tc0dyMWgD
   yQnSRCgsBhaD2l6MLaRewQnlEHy23GdnalnalxLvAjVH2M8EQqUxHXQxX
   sYvT+qat77D0v8JKLKsOQVQo4thb/9V1gBC8O5WKVc2+YfFaxUyT6xCXQ
   fDjkjBeOVG8sfcMjtGWDGBD8bGJ/JEwg018f9Fkha/UAxBJPnmrcONeOF
   d9m6i17eflpUzOZShCMZz7+40HSRpSPieegLlnBUTorjxmFZ8uTh/yUxM
   kGWjid5h8IAij7MslZ1td9cW701coW61ml18VDw4upy4B1LE7PDFH4Ayw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="293092905"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="293092905"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 05:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="557006389"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 05:51:57 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oND5x-00005z-06;
        Sun, 14 Aug 2022 12:51:57 +0000
Date:   Sun, 14 Aug 2022 20:51:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable:linux-5.15.y 5373/9027] arch/x86/kvm/hyperv.c:2185:5:
 warning: stack frame size (1036) exceeds limit (1024) in 'kvm_hv_hypercall'
Message-ID: <202208142025.NHKErAjq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   7217df81279835a7aee62a07aabb7b8fb8c766f2
commit: cb188e07105f2216f5efbefac95df4b6ce266906 [5373/9027] KVM: x86: hyper-v: HVCALL_SEND_IPI_EX is an XMM fast hypercall
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220814/202208142025.NHKErAjq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=cb188e07105f2216f5efbefac95df4b6ce266906
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout cb188e07105f2216f5efbefac95df4b6ce266906
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/hyperv.c:2185:5: warning: stack frame size (1036) exceeds limit (1024) in 'kvm_hv_hypercall' [-Wframe-larger-than]
   int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
       ^
   1 warning generated.


vim +/kvm_hv_hypercall +2185 arch/x86/kvm/hyperv.c

4ad81a91119df7 Vitaly Kuznetsov         2021-05-21  2184  
e83d58874ba1de Andrey Smetanin          2015-07-03 @2185  int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
e83d58874ba1de Andrey Smetanin          2015-07-03  2186  {
4e62aa96d6e55c Vitaly Kuznetsov         2021-07-30  2187  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
bd38b32053eb1c Siddharth Chandrasekaran 2021-05-26  2188  	struct kvm_hv_hcall hc;
bd38b32053eb1c Siddharth Chandrasekaran 2021-05-26  2189  	u64 ret = HV_STATUS_SUCCESS;
e83d58874ba1de Andrey Smetanin          2015-07-03  2190  
e83d58874ba1de Andrey Smetanin          2015-07-03  2191  	/*
e83d58874ba1de Andrey Smetanin          2015-07-03  2192  	 * hypercall generates UD from non zero cpl and real mode
e83d58874ba1de Andrey Smetanin          2015-07-03  2193  	 * per HYPER-V spec
e83d58874ba1de Andrey Smetanin          2015-07-03  2194  	 */
b3646477d458fb Jason Baron              2021-01-14  2195  	if (static_call(kvm_x86_get_cpl)(vcpu) != 0 || !is_protmode(vcpu)) {
e83d58874ba1de Andrey Smetanin          2015-07-03  2196  		kvm_queue_exception(vcpu, UD_VECTOR);
0d9c055eaaf41b Andrey Smetanin          2016-02-11  2197  		return 1;
e83d58874ba1de Andrey Smetanin          2015-07-03  2198  	}
e83d58874ba1de Andrey Smetanin          2015-07-03  2199  

:::::: The code at line 2185 was first introduced by commit
:::::: e83d58874ba1de74c13d3c6b05f95a023c860d25 kvm/x86: move Hyper-V MSR's/hypercall code into hyperv.c file

:::::: TO: Andrey Smetanin <asmetanin@virtuozzo.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
