Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8666497E27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiAXLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:41:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:54870 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233119AbiAXLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643024500; x=1674560500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GYM7PX8pNJ6ITgNfd6bX9u3gqavin9Q3V1eAtVwkEH0=;
  b=A7KZ2O8nGjz4pv2S/H4uCJt5ezOvb+RZVcNyeTroz6L6QATjZmRke+5q
   vkKCKDy+9od29S05+OP/EmU7J3TEjeklYnPpgQkep4FtBzWSFPPRMP6Qv
   JO1ZXbLVxOO97VP2c/om4DdlC7Q3mo4WVg5hzHEMBc2wVMoNnYMD4cbn5
   DGAk2ypQBqz4a6EbFKoiw+fSNjieHbnUclTF9Rf1NwXYbXxmmsRY9PGno
   FvwJJBrkNmzMTWf2xK2whYRkYpufaYjkUzvTvrao3N/pdqJkHcnwqkE4Q
   gNvpg4dsDT9omNgD821K1mp4iPXbjwI1YGtEzrzyIH0EkgupRGF0K0R6L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226006142"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226006142"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 03:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="494592318"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2022 03:41:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBxj7-000IFm-TR; Mon, 24 Jan 2022 11:41:37 +0000
Date:   Mon, 24 Jan 2022 19:40:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 68/135] arch/x86/kvm/vmx/main.c:35:
 undefined reference to `tdx_vm_init'
Message-ID: <202201241926.J8dgJCQB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   cf0e0f3ada8796602d986a2b3b5c91bb2d6126e3
commit: c24ea1a38f8e354cf113474401dcdc1d1a81aa45 [68/135] KVM: TDX: create/destroy VM structure
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220124/202201241926.J8dgJCQB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c24ea1a38f8e354cf113474401dcdc1d1a81aa45
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout c24ea1a38f8e354cf113474401dcdc1d1a81aa45
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kvm/vmx/main.o: in function `vt_vm_init':
>> arch/x86/kvm/vmx/main.c:35: undefined reference to `tdx_vm_init'


vim +35 arch/x86/kvm/vmx/main.c

    31	
    32	static int vt_vm_init(struct kvm *kvm)
    33	{
    34		if (kvm->arch.vm_type == KVM_X86_TDX_VM)
  > 35			return tdx_vm_init(kvm);
    36	
    37		return vmx_vm_init(kvm);
    38	}
    39	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
