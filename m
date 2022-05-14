Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DE526EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiENF0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 01:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiENF00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:26:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D4BEC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652505984; x=1684041984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vOr1s4hyuADKclZdkCj1gSHUqC2uPya1MjINyW1/PRI=;
  b=khkW3DPmRKCKU1xQDW4eS9hNXf6vDv3nvlFX3D8Us3uVfATIQzFkPEu7
   BcvGTjwPK9dCmR5NavVRe/AOYiUighmefkXQkL1H3KT8a//p+53+k9L+O
   MRFD3yNGbi3NYYkpvqI2sNXYw5G2J7onVlN+42Ci4g18KEVj2FUgHPQim
   2tq/NiagMn6LRDSO5rTuKVPl8MJ5UUQ647SHbHK1vR/D2ItJY+rwhSPAg
   g3VYqAz1ubwG/YC8CvgCQYJ1shwCm3810MUkkJxay4Jygyf/rTqTB8gSP
   VnxpSn7Q5zRd0WL5ygs0ikI4fm4itB0ZNhg3PFYriPFyKrzl+d4W7UwVZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295733994"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="295733994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 22:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="573282365"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2022 22:26:20 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npkIF-0000Fa-NV;
        Sat, 14 May 2022 05:26:19 +0000
Date:   Sat, 14 May 2022 13:25:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dao Lu <daolu@rivosinc.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dao Lu <daolu@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] arch/riscv: Add Zihintpause extension support
Message-ID: <202205141316.E2mCmmhu-lkp@intel.com>
References: <20220512033045.1101909-1-daolu@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512033045.1101909-1-daolu@rivosinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dao-Lu/arch-riscv-Add-Zihintpause-extension-support/20220512-113348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
config: riscv-randconfig-r035-20220512 (https://download.01.org/0day-ci/archive/20220514/202205141316.E2mCmmhu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ebdb085998220eb16e6815608a3a6d8f87711d28
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dao-Lu/arch-riscv-Add-Zihintpause-extension-support/20220512-113348
        git checkout ebdb085998220eb16e6815608a3a6d8f87711d28
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: section .text file range overlaps with __jump_table
   >>> .text range is [0x800, 0x1277]
   >>> __jump_table range is [0x878, 0x8D7]
--
>> ld.lld: error: section .text virtual address range overlaps with __jump_table
   >>> .text range is [0x800, 0x1277]
   >>> __jump_table range is [0x878, 0x8D7]
--
>> ld.lld: error: section .text load address range overlaps with __jump_table
   >>> .text range is [0x800, 0x1277]
   >>> __jump_table range is [0x878, 0x8D7]
--
>> ld.lld: error: section .text load address range overlaps with __jump_table
   >>> .text range is [0x800, 0x1277]
   >>> __jump_table range is [0x878, 0x8D7]
--
>> ld.lld: error: section .text load address range overlaps with __jump_table
   >>> .text range is [0x800, 0x1277]
   >>> __jump_table range is [0x878, 0x8D7]
   llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
