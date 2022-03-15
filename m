Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8244D91F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbiCOBF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbiCOBFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:05:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D328999;
        Mon, 14 Mar 2022 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306270; x=1678842270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VI+nwOGBY1F4nf8CO+rm2Eo6mglQSNN3eSB1ZecEdas=;
  b=dKRcR0zbOAbHLnmvhsJo4NEc1JfXM8WzFgrqxF/7uA8Z0jgN3cLi8SF1
   SaJqjwSl4O7MoQ6WgYB89yVno5EtOgvH1tVrYC+WtBZDWer+A7NLuq+0/
   tG1gVqHoEW3aGReaCVMJTzYgxLOuiJkiUqDz0L6I5AcukOow6+G+n4QqA
   CsvljnzcjJ9+j7RT1wKSobktaIFTgvcvRqMj8p+yKaEkZLFr2h1GlMSCW
   us4ULDcefycSS7Z8lDnCBOwR9HI3C9zvH1h5r145wr+JF21mnEnKiaL4X
   RR7c99OPWQqp7eJ92jJxjdRxgOqxqifmFoQ026zg8PAKh6+3XC2dfiO6W
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243635571"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="243635571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="634415278"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Mar 2022 18:04:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTvbu-000AOb-DX; Tue, 15 Mar 2022 01:04:26 +0000
Date:   Tue, 15 Mar 2022 09:03:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Correct log level of several messages
Message-ID: <202203150825.QbKs1io1-lkp@intel.com>
References: <20220314195728.119160-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314195728.119160-1-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next v5.17-rc8 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Paul-Menzel/scsi-3w-sas-Correct-log-level-of-several-messages/20220315-035918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220315/202203150825.QbKs1io1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8d5baa500eb6500560660c4c5c355f9556cc4a51
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paul-Menzel/scsi-3w-sas-Correct-log-level-of-several-messages/20220315-035918
        git checkout 8d5baa500eb6500560660c4c5c355f9556cc4a51
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/scsi/3w-sas.c:876:11: error: use of undeclared identifier 'KERN_ERROR'; did you mean 'KERN_PROF'?
                           printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
                                  ^~~~~~~~~~
                                  KERN_PROF
   include/linux/printk.h:446:53: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ^
   include/linux/printk.h:418:11: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ^
   include/uapi/linux/sysctl.h:90:2: note: 'KERN_PROF' declared here
           KERN_PROF=6,            /* table: profiling information */
           ^
   drivers/scsi/3w-sas.c:883:11: error: use of undeclared identifier 'KERN_ERROR'; did you mean 'KERN_PROF'?
                           printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
                                  ^~~~~~~~~~
                                  KERN_PROF
   include/linux/printk.h:446:53: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ^
   include/linux/printk.h:418:11: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ^
   include/uapi/linux/sysctl.h:90:2: note: 'KERN_PROF' declared here
           KERN_PROF=6,            /* table: profiling information */
           ^
   drivers/scsi/3w-sas.c:1569:49: warning: shift count >= width of type [-Wshift-count-overflow]
           retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/scsi/3w-sas.c:1786:49: warning: shift count >= width of type [-Wshift-count-overflow]
           retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 2 errors generated.


vim +876 drivers/scsi/3w-sas.c

   857	
   858	/* This function passes sense data from firmware to scsi layer */
   859	static int twl_fill_sense(TW_Device_Extension *tw_dev, int i, int request_id, int copy_sense, int print_host)
   860	{
   861		TW_Command_Apache_Header *header;
   862		TW_Command_Full *full_command_packet;
   863		unsigned short error;
   864		char *error_str;
   865	
   866		header = tw_dev->sense_buffer_virt[i];
   867		full_command_packet = tw_dev->command_packet_virt[request_id];
   868	
   869		/* Get embedded firmware error string */
   870		error_str = &(header->err_specific_desc[strlen(header->err_specific_desc) + 1]);
   871	
   872		/* Don't print error for Logical unit not supported during rollcall */
   873		error = le16_to_cpu(header->status_block.error);
   874		if ((error != TW_ERROR_LOGICAL_UNIT_NOT_SUPPORTED) && (error != TW_ERROR_UNIT_OFFLINE) && (error != TW_ERROR_INVALID_FIELD_IN_CDB)) {
   875			if (print_host)
 > 876				printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
   877				       tw_dev->host->host_no,
   878				       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
   879				       header->status_block.error,
   880				       error_str,
   881				       header->err_specific_desc);
   882			else
   883				printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
   884				       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
   885				       header->status_block.error,
   886				       error_str,
   887				       header->err_specific_desc);
   888		}
   889	
   890		if (copy_sense) {
   891			memcpy(tw_dev->srb[request_id]->sense_buffer, header->sense_data, TW_SENSE_DATA_LENGTH);
   892			tw_dev->srb[request_id]->result = (full_command_packet->command.newcommand.status << 1);
   893			goto out;
   894		}
   895	out:
   896		return 1;
   897	} /* End twl_fill_sense() */
   898	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
