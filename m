Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCA584A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiG2D0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiG2D0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:26:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401227AB16;
        Thu, 28 Jul 2022 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659065175; x=1690601175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khY2weZVBbRbbzoDJdWxVcjSsc1DekIgDb2bOJfl2YA=;
  b=YuAwaJW8BfGOCKSAKbafSkYxFFTMWIQ4Sklc+mfe1d9dw5U3mg6E3d+a
   N86Pw1g3EGhdPsYKPaiHjdgsn6Cxdtf8/fMhYqfhgvshqfA1f9E57Tp/6
   hb6TG49FphI/moWjKhobMrbNTbboTo8WmKpBWm6zY4z/HR8n//rayVHoK
   G6rH1QdRX7e9xrqADWF6TKW5ASuQRKhaZTsTeCDto+RHIZesSJmCd1GJx
   eA59KYq3DZ6EBwS69nZAE0r1rO7T8K5jbii7QkqSxxSjNdcZLMM5XWOMW
   fRnuJfQ6xPdgF/trDtxdn4Q2Xr++APEcUnq7s3OlyuvIsNuwMDW6nWrNT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289449548"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289449548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="633982421"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2022 20:26:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHGdg-000Azs-2K;
        Fri, 29 Jul 2022 03:26:12 +0000
Date:   Fri, 29 Jul 2022 11:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with
 use of get_unaligned_be24()
Message-ID: <202207291151.npmUhv4C-lkp@intel.com>
References: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ata-libata-scsi-Refactor-scsi_6_lba_len-with-use-of-get_unaligned_be24/20220726-234746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e0dccc3b76fb35bb257b4118367a883073d7390e
config: mips-randconfig-r011-20220724 (https://download.01.org/0day-ci/archive/20220729/202207291151.npmUhv4C-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 83882606dbd7ffb0bdd3460356202d97705809c8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ae9a00d0e0375aa2aea7a61dc2894d9d06005f8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ata-libata-scsi-Refactor-scsi_6_lba_len-with-use-of-get_unaligned_be24/20220726-234746
        git checkout ae9a00d0e0375aa2aea7a61dc2894d9d06005f8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ata/libata-scsi.c:1320:29: error: incompatible integer to pointer conversion passing 'const u8' (aka 'const unsigned char') to parameter of type 'const void *' [-Wint-conversion]
           *plba = get_unaligned_be24(cdb[1]) & 0x1fffff;
                                      ^~~~~~
   include/asm-generic/unaligned.h:90:50: note: passing argument to parameter 'p' here
   static inline u32 get_unaligned_be24(const void *p)
                                                    ^
   1 error generated.


vim +1320 drivers/ata/libata-scsi.c

  1307	
  1308	/**
  1309	 *	scsi_6_lba_len - Get LBA and transfer length
  1310	 *	@cdb: SCSI command to translate
  1311	 *
  1312	 *	Calculate LBA and transfer length for 6-byte commands.
  1313	 *
  1314	 *	RETURNS:
  1315	 *	@plba: the LBA
  1316	 *	@plen: the transfer length
  1317	 */
  1318	static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
  1319	{
> 1320		*plba = get_unaligned_be24(cdb[1]) & 0x1fffff;
  1321		*plen = cdb[4];
  1322	}
  1323	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
