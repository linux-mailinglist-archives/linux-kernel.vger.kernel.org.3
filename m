Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEAC5AC1CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIDAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIDAE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:04:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66422A;
        Sat,  3 Sep 2022 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662249861; x=1693785861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RVEhZ6y4T1JLmd8UZJsB2e4A0dQiVCt7KFVfFW0jwQA=;
  b=cAtyjK00jWHVtA2WvzESCxsPrAKFS0tycokzzT+8Tt+S9CfaBxUeKnJc
   R3jSL9ttdEEmeQjCuRodx4Vb8PS5Ir3/1iWekFv3JmzDCYIoUkaxT2rKZ
   AjbQ6jPZtDwbhFAHygsg2uisHpGslDA1AScnhwRrZMaoLwAYunSrQLQRy
   2+fAJk9tCYavi+M1t8kU1c3HTF6pMIfoRJsFheoR6e+X9JXBIVNiDY6Fu
   3HGn7Zx+MD1817DUVUGoz0uAcveV4ZsdGfgmlUSKILxLP3X5zM1Pgb+Wc
   5D/a72JXPKwNeL9/2MVDREaIkfc2oxXGu2AMHeCUHmcQ0i5gx2lOLJK8R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="297494730"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="297494730"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 17:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="564348244"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 17:04:17 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUd7Y-0002Ll-1R;
        Sun, 04 Sep 2022 00:04:16 +0000
Date:   Sun, 4 Sep 2022 08:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v8 1/3] thunderbolt: Add vendor's specific operations of
 NVM
Message-ID: <202209040723.T3GBSVUx-lkp@intel.com>
References: <20220902094010.2170-2-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902094010.2170-2-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-add-vendor-s-NVM-formats/20220902-174246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 42e66b1cc3a070671001f8a1e933a80818a192bf
config: loongarch-randconfig-s051-20220901 (https://download.01.org/0day-ci/archive/20220904/202209040723.T3GBSVUx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/02a1339d2c5a67367909bfcb11e307d3cfa44f74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Szuying-Chen/thunderbolt-add-vendor-s-NVM-formats/20220902-174246
        git checkout 02a1339d2c5a67367909bfcb11e307d3cfa44f74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/thunderbolt/nvm.c: note: in included file:
>> drivers/thunderbolt/tb.h:743:20: sparse: sparse: marked inline, but without a definition
>> drivers/thunderbolt/tb.h:743:20: sparse: sparse: marked inline, but without a definition

vim +743 drivers/thunderbolt/tb.h

   742	
 > 743	inline int nvm_read(struct tb_switch *sw, unsigned int address,
   744				   void *buf, size_t size);
   745	struct tb_nvm *tb_nvm_alloc(struct device *dev);
   746	int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
   747	int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
   748			     size_t bytes);
   749	int tb_nvm_add_non_active(struct tb_nvm *nvm, size_t size,
   750				  nvmem_reg_write_t reg_write);
   751	void tb_nvm_free(struct tb_nvm *nvm);
   752	void tb_nvm_exit(void);
   753	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
