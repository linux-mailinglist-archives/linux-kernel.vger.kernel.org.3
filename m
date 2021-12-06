Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B939C468F16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhLFC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:26:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:24064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhLFC0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:26:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224485488"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="224485488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:22:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="656846997"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 18:22:50 -0800
Message-ID: <e3dbe26c-9c6f-8fb7-64dd-60cad76e5493@intel.com>
Date:   Mon, 6 Dec 2021 10:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: drivers/ata/pata_falcon.c:58:41: sparse: sparse:
 cast removes address space '__iomem' of expression
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202111240519.TR4XadIt-lkp@intel.com>
 <93c33f2-dd5d-fdfd-c5b8-fe18ce153a91@linux-m68k.org>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <93c33f2-dd5d-fdfd-c5b8-fe18ce153a91@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/21 12:14, Finn Thain wrote:
> On Wed, 24 Nov 2021, kernel test robot wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   136057256686de39cc3a07c2e39ef6bc43003ff6
>> commit: 44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee m68k/q40: Replace q40ide driver with pata_falcon and falconide
> That's the wrong commit. The missing annotations actually date back to
> commit 7e11aabd48eb ("ata: add Atari Falcon PATA controller driver").
> It was not my commit but I'll send a patch anyway.

Hi Finn,

Thanks for the fix, the bot can't always find the first introduced 
commit with the bisection method,

Best Regards,
Rong Chen

>
>> date:   6 months ago
>> config: m68k-randconfig-s031-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240519.TR4XadIt-lkp@intel.com/config.gz)
>> compiler: m68k-linux-gcc (GCC) 11.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 44b1fbc0f5f30e66a56d29575349f0b1ebe2b0ee
>>          # save the config file to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/ata/pata_falcon.c:58:41: sparse: sparse: cast removes address space '__iomem' of expression
>>>> drivers/ata/pata_falcon.c:58:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:58:41: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:58:41: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:60:35: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:60:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:60:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:60:35: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:63:42: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:63:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:63:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:63:42: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:65:36: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:65:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:65:36: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:65:36: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:77:49: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:77:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:77:49: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:77:49: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:79:43: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:79:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:79:43: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:79:43: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:84:50: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:84:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:84:50: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:84:50: sparse:     got unsigned short [usertype] *
>>     drivers/ata/pata_falcon.c:86:44: sparse: sparse: cast removes address space '__iomem' of expression
>>     drivers/ata/pata_falcon.c:86:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
>>     drivers/ata/pata_falcon.c:86:44: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
>>     drivers/ata/pata_falcon.c:86:44: sparse:     got unsigned short [usertype] *
>>
>> vim +/__iomem +58 drivers/ata/pata_falcon.c
>>
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  39
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  40  static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  41  					  unsigned char *buf,
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  42  					  unsigned int buflen, int rw)
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  43  {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  44  	struct ata_device *dev = qc->dev;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  45  	struct ata_port *ap = dev->link->ap;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  46  	void __iomem *data_addr = ap->ioaddr.data_addr;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  47  	unsigned int words = buflen >> 1;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  48  	struct scsi_cmnd *cmd = qc->scsicmd;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  49  	bool swap = 1;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  50
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  51  	if (dev->class == ATA_DEV_ATA && cmd && cmd->request &&
>> 79f4d1d5c0d7d1 Linus Torvalds            2017-02-21  52  	    !blk_rq_is_passthrough(cmd->request))
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  53  		swap = 0;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  54
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  55  	/* Transfer multiple of 2 bytes */
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  56  	if (rw == READ) {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  57  		if (swap)
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30 @58  			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  59  		else
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  60  			raw_insw((u16 *)data_addr, (u16 *)buf, words);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  61  	} else {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  62  		if (swap)
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  63  			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  64  		else
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  65  			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  66  	}
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  67
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  68  	/* Transfer trailing byte, if any. */
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  69  	if (unlikely(buflen & 0x01)) {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  70  		unsigned char pad[2] = { };
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  71
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  72  		/* Point buf to the tail of buffer */
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  73  		buf += buflen - 1;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  74
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  75  		if (rw == READ) {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  76  			if (swap)
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  77  				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  78  			else
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  79  				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  80  			*buf = pad[0];
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  81  		} else {
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  82  			pad[0] = *buf;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  83  			if (swap)
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  84  				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  85  			else
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  86  				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  87  		}
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  88  		words++;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  89  	}
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  90
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  91  	return words << 1;
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  92  }
>> 7e11aabd48eb00 Bartlomiej Zolnierkiewicz 2016-12-30  93
>>
>> :::::: The code at line 58 was first introduced by commit
>> :::::: 7e11aabd48eb00240b280bf927cba9198664dcf6 ata: add Atari Falcon PATA controller driver
>>
>> :::::: TO: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> :::::: CC: Tejun Heo <tj@kernel.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

