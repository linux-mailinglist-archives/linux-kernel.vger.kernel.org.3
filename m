Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E8584A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiG2D01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiG2D0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:26:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891927AB2D;
        Thu, 28 Jul 2022 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659065175; x=1690601175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwrrBPZE8wW6mZimDW7VC1IIGLYtzzJIzUEph9W6Ow4=;
  b=Mxc4+DhCyVhC6tO02YCsts/tKKKFUNTC5FQuXzdCRZo6tGg0pDzM8u8l
   b074Ue4/BU8T/Z1IMaVr6HBei35u+CaBUgtCRANWEalWTYHUmBcXJjYh6
   wp1gUw2oium3NjP6qoi5QKIAWwPCo22qsVzINMy1sF/aBXOCtutZfAp0+
   RWdj67e4v4rAoRoAhbBf4gSQyMpQ4fs/jBD5BhozH+BPzZ+6EZve+UwEz
   qmlmASngUXKI6T7zblfhUTlaFD+huu1UfU9VBI18CZBngLmETMhwsyz+J
   +svxN59GmyNkxqwwllyZnF8WGAhsuZHdGqMgg/CdxrMoB55mpm37vutTO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="287434640"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="287434640"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="551594613"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 20:26:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHGdg-000Azq-2E;
        Fri, 29 Jul 2022 03:26:12 +0000
Date:   Fri, 29 Jul 2022 11:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with
 use of get_unaligned_be24()
Message-ID: <202207291116.SWCwVbB1-lkp@intel.com>
References: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ata-libata-scsi-Refactor-scsi_6_lba_len-with-use-of-get_unaligned_be24/20220726-234746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e0dccc3b76fb35bb257b4118367a883073d7390e
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220729/202207291116.SWCwVbB1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ae9a00d0e0375aa2aea7a61dc2894d9d06005f8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ata-libata-scsi-Refactor-scsi_6_lba_len-with-use-of-get_unaligned_be24/20220726-234746
        git checkout ae9a00d0e0375aa2aea7a61dc2894d9d06005f8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/libata-scsi.c: In function 'scsi_6_lba_len':
>> drivers/ata/libata-scsi.c:1320:39: warning: passing argument 1 of 'get_unaligned_be24' makes pointer from integer without a cast [-Wint-conversion]
    1320 |         *plba = get_unaligned_be24(cdb[1]) & 0x1fffff;
         |                                    ~~~^~~
         |                                       |
         |                                       u8 {aka unsigned char}
   In file included from ./arch/x86/include/generated/asm/unaligned.h:1,
                    from drivers/ata/libata-scsi.c:33:
   include/asm-generic/unaligned.h:90:50: note: expected 'const void *' but argument is of type 'u8' {aka 'unsigned char'}
      90 | static inline u32 get_unaligned_be24(const void *p)
         |                                      ~~~~~~~~~~~~^


vim +/get_unaligned_be24 +1320 drivers/ata/libata-scsi.c

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
