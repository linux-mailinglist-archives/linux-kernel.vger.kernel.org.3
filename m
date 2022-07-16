Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12D576D59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGPK4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 06:56:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5FACE2A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657968969; x=1689504969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=grnTWgXhzfLD9ND8ntiGCpjQ1qbsNzpWO6Ixj5ZvrMg=;
  b=aaWa7WRxkWnXM8AB40vRtWRYjG47E/9UZJcCjVbK8MjZwALvvMnKBKVs
   xAapx0WCeAXwXmqVHkE/cnxawWhakDzYNy5noOxsw32uadKUeXoudRmhj
   qm8TUCs2Rcb9Vi32UHNq1gDHJxWgX4mA5NwqHWM2ru18eG4fsRCigQj6Q
   0EQv17t7dLdhw9JcBW28pss1YwCVCz6q0JNn1jF6MfA4DiKfys3vxtchB
   cDzB6Hol0vOeyXS4Iuylfi04Ui9mrCvDnsJqPukczma5p+67DjCeuDOAi
   9wcs/yJwdQbuF/f95nRu+noBr+FTtXo432GT31UKS/ueers/vRSvqEuDv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="285991556"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="285991556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 03:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="624165384"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2022 03:56:07 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCfSw-0001OC-ED;
        Sat, 16 Jul 2022 10:56:06 +0000
Date:   Sat, 16 Jul 2022 18:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [linux-stable-rc:linux-5.15.y 5373/8464]
 arch/x86/kvm/hyperv.c:2185:5: warning: stack frame size (1036) exceeds limit
 (1024) in 'kvm_hv_hypercall'
Message-ID: <202207161843.WnHPjB0l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   baefa2315cb1371486f6661a628e96fa3336f573
commit: cb188e07105f2216f5efbefac95df4b6ce266906 [5373/8464] KVM: x86: hyper-v: HVCALL_SEND_IPI_EX is an XMM fast hypercall
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220716/202207161843.WnHPjB0l-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=cb188e07105f2216f5efbefac95df4b6ce266906
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
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
