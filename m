Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0771F4EC5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbiC3NcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343844AbiC3Nby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:31:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF912126E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648647009; x=1680183009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9XSMKO8oo14JJdj7xhUYlZZTp0yFo4MzZJwC0dmP+k=;
  b=mJgWNqhRBodrqntWo1oao8g5Hitiv+d0EajA3XXUZSTZAVWJKNsvLX11
   d2OchbkQ+fn2Emp4liRPfqU+ot+K/kboAJ+yWX1bIOQN6be8Pa5DGX7FM
   J1HcVt7dJRlzr9kIFIBdTovEXNtbggelFrgfFNQQQGhLAlv8mTsKwpQ6c
   /ZVr3GVJRQ3GPQy1XyXqAcnQYLrsxwdPPQ674iY1Teb0fgBTJtb+B1hWy
   dKd7Ijv0lIUSHqVnkOAaCUNZ4+9yBxvVRe1fJZytuONjA+Ov8aupT1+o3
   +FEHCclDz0mpvI3kLPpuweaOi1PmWC60NfgR3O78SbdWFsCLST1iZqq/X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="240138024"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="240138024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519677516"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 06:30:04 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZYOh-00001U-Gq;
        Wed, 30 Mar 2022 13:30:03 +0000
Date:   Wed, 30 Mar 2022 21:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>, liaochang1@huawei.com
Cc:     kbuild-all@lists.01.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
        bjorn.topel@gmail.com, changbin.du@intel.com,
        ebiederm@xmission.com, guoren@linux.alibaba.com,
        jszhang@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, palmer@dabbelt.com, paul.walmsley@sifive.com,
        penberg@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2 -next 5/6] RISC-V: Add purgatory
Message-ID: <202203302109.2IHqpKOe-lkp@intel.com>
References: <20220330081701.177026-6-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330081701.177026-6-lizhengyu3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220329]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhengyu/riscv-kexec-add-kexec_file_load-support/20220330-162008
base:    c2528a0cdebd8ba7ef30e0655f8ea89f34c3a633
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203302109.2IHqpKOe-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f59da20dab679116176a82c5b23517ce69584123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhengyu/riscv-kexec-add-kexec_file_load-support/20220330-162008
        git checkout f59da20dab679116176a82c5b23517ce69584123
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/purgatory/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/purgatory/purgatory.c:20:5: warning: no previous prototype for 'verify_sha256_digest' [-Wmissing-prototypes]
      20 | int verify_sha256_digest(void)
         |     ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/purgatory/purgatory.c:36:6: warning: no previous prototype for 'purgatory' [-Wmissing-prototypes]
      36 | void purgatory(void)
         |      ^~~~~~~~~


vim +/verify_sha256_digest +20 arch/riscv/purgatory/purgatory.c

    19	
  > 20	int verify_sha256_digest(void)
    21	{
    22		struct kexec_sha_region *ptr, *end;
    23		struct sha256_state ss;
    24		u8 digest[SHA256_DIGEST_SIZE];
    25	
    26		sha256_init(&ss);
    27		end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
    28		for (ptr = purgatory_sha_regions; ptr < end; ptr++)
    29			sha256_update(&ss, (uint8_t *)(ptr->start), ptr->len);
    30		sha256_final(&ss, digest);
    31		if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)) != 0)
    32			return 1;
    33		return 0;
    34	}
    35	
  > 36	void purgatory(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
