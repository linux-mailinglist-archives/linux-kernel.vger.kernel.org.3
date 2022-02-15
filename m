Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29894B61ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiBOEED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:04:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiBOEDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:03:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755CF11B5;
        Mon, 14 Feb 2022 20:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644897813; x=1676433813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tC3Hs+x2mOyiBxsxRLHlmba7CRcpYMJnSTOSpndKGII=;
  b=WGq4iKzsQb/DBPm7SAzeAcQuJOvWqvURyi/OojiUIz6Nvq8UDTJ4cyAb
   DDlUUd8jPiHpBQ3/8nHD2mJ8dDaJRyuebVPh6OTSGJx1OdBJJr38kvTiw
   S6m4fQTpLwWOdCDj7c4BvzXvATGNRZD0WzmoHlPw3aEd5HDpTY63OrCPS
   VzysZKm80A68LVwWO5Jl5MdMwq0kqeL9hoCw6DSGtqQBemzzd1+I6Tfac
   Y4ztOqcvpco4sDMcEf5iOx2KELxC/1SDD1dZRDYzat7ELVy3X9O7BndBf
   Cx9qUD6VU+0ScnVeW9ixL6ucJ8bjZFyRVuryxB0b5Yft9RgaszqS4kpOD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237654649"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="237654649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="632516021"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2022 20:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJp3q-0009Fg-Qq; Tue, 15 Feb 2022 04:03:30 +0000
Date:   Tue, 15 Feb 2022 12:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] ata: add/use ata_taskfile::{error|status} fields
Message-ID: <202202151114.obEATTFy-lkp@intel.com>
References: <e99172ca-cf0e-5510-60fc-b19dc48658ac@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99172ca-cf0e-5510-60fc-b19dc48658ac@omp.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc4 next-20220214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sergey-Shtylyov/ata-add-use-ata_taskfile-error-status-fields/20220215-044836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d567f5db412ed52de0b3b3efca4a451263de6108
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220215/202202151114.obEATTFy-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5d89e7cd8ab42fd2cb6f59a7922784b0cce835bf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sergey-Shtylyov/ata-add-use-ata_taskfile-error-status-fields/20220215-044836
        git checkout 5d89e7cd8ab42fd2cb6f59a7922784b0cce835bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ata/sata_vsc.c: In function 'vsc_sata_tf_read':
>> drivers/ata/sata_vsc.c:203:35: error: 'feature' undeclared (first use in this function)
     203 |                 tf->hob_feature = feature >> 8;
         |                                   ^~~~~~~
   drivers/ata/sata_vsc.c:203:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/feature +203 drivers/ata/sata_vsc.c

^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  181  
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  182  
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  183  static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  184  {
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  185  	struct ata_ioports *ioaddr = &ap->ioaddr;
5d89e7cd8ab42fd drivers/ata/sata_vsc.c  Sergey Shtylyov 2022-02-14  186  	u16 nsect, lbal, lbam, lbah, error;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  187  
5d89e7cd8ab42fd drivers/ata/sata_vsc.c  Sergey Shtylyov 2022-02-14  188  	tf->status = ata_sff_check_status(ap);
0d5ff566779f894 drivers/ata/sata_vsc.c  Tejun Heo       2007-02-01  189  	tf->device = readw(ioaddr->device_addr);
5d89e7cd8ab42fd drivers/ata/sata_vsc.c  Sergey Shtylyov 2022-02-14  190  	error = readw(ioaddr->error_addr);
0d5ff566779f894 drivers/ata/sata_vsc.c  Tejun Heo       2007-02-01  191  	nsect = readw(ioaddr->nsect_addr);
0d5ff566779f894 drivers/ata/sata_vsc.c  Tejun Heo       2007-02-01  192  	lbal = readw(ioaddr->lbal_addr);
0d5ff566779f894 drivers/ata/sata_vsc.c  Tejun Heo       2007-02-01  193  	lbam = readw(ioaddr->lbam_addr);
0d5ff566779f894 drivers/ata/sata_vsc.c  Tejun Heo       2007-02-01  194  	lbah = readw(ioaddr->lbah_addr);
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29  195  
5d89e7cd8ab42fd drivers/ata/sata_vsc.c  Sergey Shtylyov 2022-02-14  196  	tf->error = error;
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29  197  	tf->nsect = nsect;
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29  198  	tf->lbal = lbal;
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29  199  	tf->lbam = lbam;
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29  200  	tf->lbah = lbah;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  201  
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  202  	if (tf->flags & ATA_TFLAG_LBA48) {
ac19bff25b6834d drivers/scsi/sata_vsc.c Jeff Garzik     2005-10-29 @203  		tf->hob_feature = feature >> 8;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  204  		tf->hob_nsect = nsect >> 8;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  205  		tf->hob_lbal = lbal >> 8;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  206  		tf->hob_lbam = lbam >> 8;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  207  		tf->hob_lbah = lbah >> 8;
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  208  	}
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  209  }
^1da177e4c3f415 drivers/scsi/sata_vsc.c Linus Torvalds  2005-04-16  210  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
