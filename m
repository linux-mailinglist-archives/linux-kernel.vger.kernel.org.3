Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15D53880B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiE3UIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiE3UIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:08:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FB506EC;
        Mon, 30 May 2022 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653941314; x=1685477314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5DFuxeEQiZmsoL4z9TA7tFfoxem4NM9RkhVc6mpE1o=;
  b=l0JPJ7aoCAEn0zKaYZHO3kENfPGgp9ICbAr+HSEIZ0NWQmD7ICW4rvb0
   GwR78gJYSWH0CmbGuz/TiHbyUqGP/gfHkt+eqDmr2lYXN4MlA8zDuohd0
   K1/OSyxQB+xMrAKMgzm3KHNKHjBomSCHLzSUwHqRIHjEh/YpMnDSQELIm
   aZ9Rym3uaqtWvCj7jzpt8GF6kmeXG7zsiGEIgkdbexjFAZxZFN+mc5ljo
   ANVcwTMkk34Pce9Vy0uhnEjs0GSNCPurjOctxk9Gdq/uAq2xeK03kIOcV
   MCSAjhlGQePyoInhwpBBhHa50Q8qRzjU0InbDi7zju6ifYBULKkyrUEfH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="254945851"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="254945851"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 13:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="562032414"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2022 13:08:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvlgj-0001xe-SX;
        Mon, 30 May 2022 20:08:29 +0000
Date:   Tue, 31 May 2022 04:08:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Haowen Bai <baihaowen@meizu.com>, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hpsa: Fix pointer dereferenced before checking
Message-ID: <202205310427.9CgPG9aD-lkp@intel.com>
References: <1653899188-26544-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653899188-26544-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haowen-Bai/scsi-hpsa-Fix-pointer-dereferenced-before-checking/20220530-162826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: arm-randconfig-r002-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310427.9CgPG9aD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9a3105487f3b609149219bdb8adcb2b4f0108c74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haowen-Bai/scsi-hpsa-Fix-pointer-dereferenced-before-checking/20220530-162826
        git checkout 9a3105487f3b609149219bdb8adcb2b4f0108c74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/hpsa.c:5108:35: warning: variable 'map' is uninitialized when used here [-Wuninitialized]
           struct raid_map_disk_data *dd = &map->data[0];
                                            ^~~
   drivers/scsi/hpsa.c:5107:27: note: initialize the variable 'map' to silence this warning
           struct raid_map_data *map;
                                    ^
                                     = NULL
   drivers/scsi/hpsa.c:9485:16: warning: variable 'transMethod' set but not used [-Wunused-but-set-variable]
           unsigned long transMethod = CFGTBL_Trans_Performant |
                         ^
   2 warnings generated.


vim +/map +5108 drivers/scsi/hpsa.c

6b80b18fe51540 Scott Teel          2014-02-18  5098  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5099  /*
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5100   * Attempt to perform offload RAID mapping for a logical volume I/O.
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5101   */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5102  static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5103  	struct CommandList *c)
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5104  {
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5105  	struct scsi_cmnd *cmd = c->scsi_cmd;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5106  	struct hpsa_scsi_dev_t *dev = cmd->device->hostdata;
9a3105487f3b60 Haowen Bai          2022-05-30  5107  	struct raid_map_data *map;
283b4a9b98b192 Stephen M. Cameron  2014-02-18 @5108  	struct raid_map_disk_data *dd = &map->data[0];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5109  	int is_write = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5110  	u32 map_index;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5111  	u64 first_block, last_block;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5112  	u32 block_cnt;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5113  	u32 blocks_per_row;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5114  	u64 first_row, last_row;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5115  	u32 first_row_offset, last_row_offset;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5116  	u32 first_column, last_column;
6b80b18fe51540 Scott Teel          2014-02-18  5117  	u64 r0_first_row, r0_last_row;
6b80b18fe51540 Scott Teel          2014-02-18  5118  	u32 r5or6_blocks_per_row;
6b80b18fe51540 Scott Teel          2014-02-18  5119  	u64 r5or6_first_row, r5or6_last_row;
6b80b18fe51540 Scott Teel          2014-02-18  5120  	u32 r5or6_first_row_offset, r5or6_last_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5121  	u32 r5or6_first_column, r5or6_last_column;
6b80b18fe51540 Scott Teel          2014-02-18  5122  	u32 total_disks_per_row;
6b80b18fe51540 Scott Teel          2014-02-18  5123  	u32 stripesize;
6b80b18fe51540 Scott Teel          2014-02-18  5124  	u32 first_group, last_group, current_group;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5125  	u32 map_row;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5126  	u32 disk_handle;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5127  	u64 disk_block;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5128  	u32 disk_block_cnt;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5129  	u8 cdb[16];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5130  	u8 cdb_len;
2b08b3e9d9dad9 Don Brace           2015-01-23  5131  	u16 strip_size;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5132  #if BITS_PER_LONG == 32
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5133  	u64 tmpdiv;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5134  #endif
6b80b18fe51540 Scott Teel          2014-02-18  5135  	int offload_to_mirror;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5136  
45e596cd6ead1c Don Brace           2016-09-09  5137  	if (!dev)
45e596cd6ead1c Don Brace           2016-09-09  5138  		return -1;
45e596cd6ead1c Don Brace           2016-09-09  5139  
9a3105487f3b60 Haowen Bai          2022-05-30  5140  	map = &dev->raid_map;
9a3105487f3b60 Haowen Bai          2022-05-30  5141  
c5dfd106414f3e Don Brace           2019-05-07  5142  	if (dev->in_reset)
c5dfd106414f3e Don Brace           2019-05-07  5143  		return -1;
c5dfd106414f3e Don Brace           2019-05-07  5144  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5145  	/* check for valid opcode, get LBA and block count */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5146  	switch (cmd->cmnd[0]) {
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5147  	case WRITE_6:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5148  		is_write = 1;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  5149  		fallthrough;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5150  	case READ_6:
abbada7175999f Mahesh Rajashekhara 2016-09-16  5151  		first_block = (((cmd->cmnd[1] & 0x1F) << 16) |
abbada7175999f Mahesh Rajashekhara 2016-09-16  5152  				(cmd->cmnd[2] << 8) |
abbada7175999f Mahesh Rajashekhara 2016-09-16  5153  				cmd->cmnd[3]);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5154  		block_cnt = cmd->cmnd[4];
3fa89a04e064e5 Stephen M. Cameron  2014-07-03  5155  		if (block_cnt == 0)
3fa89a04e064e5 Stephen M. Cameron  2014-07-03  5156  			block_cnt = 256;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5157  		break;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5158  	case WRITE_10:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5159  		is_write = 1;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  5160  		fallthrough;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5161  	case READ_10:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5162  		first_block =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5163  			(((u64) cmd->cmnd[2]) << 24) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5164  			(((u64) cmd->cmnd[3]) << 16) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5165  			(((u64) cmd->cmnd[4]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5166  			cmd->cmnd[5];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5167  		block_cnt =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5168  			(((u32) cmd->cmnd[7]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5169  			cmd->cmnd[8];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5170  		break;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5171  	case WRITE_12:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5172  		is_write = 1;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  5173  		fallthrough;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5174  	case READ_12:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5175  		first_block =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5176  			(((u64) cmd->cmnd[2]) << 24) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5177  			(((u64) cmd->cmnd[3]) << 16) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5178  			(((u64) cmd->cmnd[4]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5179  			cmd->cmnd[5];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5180  		block_cnt =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5181  			(((u32) cmd->cmnd[6]) << 24) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5182  			(((u32) cmd->cmnd[7]) << 16) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5183  			(((u32) cmd->cmnd[8]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5184  		cmd->cmnd[9];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5185  		break;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5186  	case WRITE_16:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5187  		is_write = 1;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  5188  		fallthrough;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5189  	case READ_16:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5190  		first_block =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5191  			(((u64) cmd->cmnd[2]) << 56) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5192  			(((u64) cmd->cmnd[3]) << 48) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5193  			(((u64) cmd->cmnd[4]) << 40) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5194  			(((u64) cmd->cmnd[5]) << 32) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5195  			(((u64) cmd->cmnd[6]) << 24) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5196  			(((u64) cmd->cmnd[7]) << 16) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5197  			(((u64) cmd->cmnd[8]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5198  			cmd->cmnd[9];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5199  		block_cnt =
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5200  			(((u32) cmd->cmnd[10]) << 24) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5201  			(((u32) cmd->cmnd[11]) << 16) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5202  			(((u32) cmd->cmnd[12]) << 8) |
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5203  			cmd->cmnd[13];
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5204  		break;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5205  	default:
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5206  		return IO_ACCEL_INELIGIBLE; /* process via normal I/O path */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5207  	}
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5208  	last_block = first_block + block_cnt - 1;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5209  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5210  	/* check for write to non-RAID-0 */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5211  	if (is_write && dev->raid_level != 0)
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5212  		return IO_ACCEL_INELIGIBLE;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5213  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5214  	/* check for invalid block or wraparound */
2b08b3e9d9dad9 Don Brace           2015-01-23  5215  	if (last_block >= le64_to_cpu(map->volume_blk_cnt) ||
2b08b3e9d9dad9 Don Brace           2015-01-23  5216  		last_block < first_block)
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5217  		return IO_ACCEL_INELIGIBLE;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5218  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5219  	/* calculate stripe information for the request */
2b08b3e9d9dad9 Don Brace           2015-01-23  5220  	blocks_per_row = le16_to_cpu(map->data_disks_per_row) *
2b08b3e9d9dad9 Don Brace           2015-01-23  5221  				le16_to_cpu(map->strip_size);
2b08b3e9d9dad9 Don Brace           2015-01-23  5222  	strip_size = le16_to_cpu(map->strip_size);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5223  #if BITS_PER_LONG == 32
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5224  	tmpdiv = first_block;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5225  	(void) do_div(tmpdiv, blocks_per_row);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5226  	first_row = tmpdiv;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5227  	tmpdiv = last_block;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5228  	(void) do_div(tmpdiv, blocks_per_row);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5229  	last_row = tmpdiv;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5230  	first_row_offset = (u32) (first_block - (first_row * blocks_per_row));
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5231  	last_row_offset = (u32) (last_block - (last_row * blocks_per_row));
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5232  	tmpdiv = first_row_offset;
2b08b3e9d9dad9 Don Brace           2015-01-23  5233  	(void) do_div(tmpdiv, strip_size);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5234  	first_column = tmpdiv;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5235  	tmpdiv = last_row_offset;
2b08b3e9d9dad9 Don Brace           2015-01-23  5236  	(void) do_div(tmpdiv, strip_size);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5237  	last_column = tmpdiv;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5238  #else
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5239  	first_row = first_block / blocks_per_row;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5240  	last_row = last_block / blocks_per_row;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5241  	first_row_offset = (u32) (first_block - (first_row * blocks_per_row));
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5242  	last_row_offset = (u32) (last_block - (last_row * blocks_per_row));
2b08b3e9d9dad9 Don Brace           2015-01-23  5243  	first_column = first_row_offset / strip_size;
2b08b3e9d9dad9 Don Brace           2015-01-23  5244  	last_column = last_row_offset / strip_size;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5245  #endif
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5246  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5247  	/* if this isn't a single row/column then give to the controller */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5248  	if ((first_row != last_row) || (first_column != last_column))
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5249  		return IO_ACCEL_INELIGIBLE;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5250  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5251  	/* proceeding with driver mapping */
2b08b3e9d9dad9 Don Brace           2015-01-23  5252  	total_disks_per_row = le16_to_cpu(map->data_disks_per_row) +
2b08b3e9d9dad9 Don Brace           2015-01-23  5253  				le16_to_cpu(map->metadata_disks_per_row);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5254  	map_row = ((u32)(first_row >> map->parity_rotation_shift)) %
2b08b3e9d9dad9 Don Brace           2015-01-23  5255  				le16_to_cpu(map->row_cnt);
6b80b18fe51540 Scott Teel          2014-02-18  5256  	map_index = (map_row * total_disks_per_row) + first_column;
6b80b18fe51540 Scott Teel          2014-02-18  5257  
6b80b18fe51540 Scott Teel          2014-02-18  5258  	switch (dev->raid_level) {
6b80b18fe51540 Scott Teel          2014-02-18  5259  	case HPSA_RAID_0:
6b80b18fe51540 Scott Teel          2014-02-18  5260  		break; /* nothing special to do */
6b80b18fe51540 Scott Teel          2014-02-18  5261  	case HPSA_RAID_1:
6b80b18fe51540 Scott Teel          2014-02-18  5262  		/* Handles load balance across RAID 1 members.
6b80b18fe51540 Scott Teel          2014-02-18  5263  		 * (2-drive R1 and R10 with even # of drives.)
6b80b18fe51540 Scott Teel          2014-02-18  5264  		 * Appropriate for SSDs, not optimal for HDDs
3e16e83a62edac Don Brace           2020-03-20  5265  		 * Ensure we have the correct raid_map.
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5266  		 */
3e16e83a62edac Don Brace           2020-03-20  5267  		if (le16_to_cpu(map->layout_map_count) != 2) {
3e16e83a62edac Don Brace           2020-03-20  5268  			hpsa_turn_off_ioaccel_for_device(dev);
3e16e83a62edac Don Brace           2020-03-20  5269  			return IO_ACCEL_INELIGIBLE;
3e16e83a62edac Don Brace           2020-03-20  5270  		}
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5271  		if (dev->offload_to_mirror)
2b08b3e9d9dad9 Don Brace           2015-01-23  5272  			map_index += le16_to_cpu(map->data_disks_per_row);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5273  		dev->offload_to_mirror = !dev->offload_to_mirror;
6b80b18fe51540 Scott Teel          2014-02-18  5274  		break;
6b80b18fe51540 Scott Teel          2014-02-18  5275  	case HPSA_RAID_ADM:
6b80b18fe51540 Scott Teel          2014-02-18  5276  		/* Handles N-way mirrors  (R1-ADM)
6b80b18fe51540 Scott Teel          2014-02-18  5277  		 * and R10 with # of drives divisible by 3.)
3e16e83a62edac Don Brace           2020-03-20  5278  		 * Ensure we have the correct raid_map.
6b80b18fe51540 Scott Teel          2014-02-18  5279  		 */
3e16e83a62edac Don Brace           2020-03-20  5280  		if (le16_to_cpu(map->layout_map_count) != 3) {
3e16e83a62edac Don Brace           2020-03-20  5281  			hpsa_turn_off_ioaccel_for_device(dev);
3e16e83a62edac Don Brace           2020-03-20  5282  			return IO_ACCEL_INELIGIBLE;
3e16e83a62edac Don Brace           2020-03-20  5283  		}
6b80b18fe51540 Scott Teel          2014-02-18  5284  
6b80b18fe51540 Scott Teel          2014-02-18  5285  		offload_to_mirror = dev->offload_to_mirror;
6b80b18fe51540 Scott Teel          2014-02-18  5286  		raid_map_helper(map, offload_to_mirror,
6b80b18fe51540 Scott Teel          2014-02-18  5287  				&map_index, &current_group);
6b80b18fe51540 Scott Teel          2014-02-18  5288  		/* set mirror group to use next time */
6b80b18fe51540 Scott Teel          2014-02-18  5289  		offload_to_mirror =
2b08b3e9d9dad9 Don Brace           2015-01-23  5290  			(offload_to_mirror >=
2b08b3e9d9dad9 Don Brace           2015-01-23  5291  			le16_to_cpu(map->layout_map_count) - 1)
6b80b18fe51540 Scott Teel          2014-02-18  5292  			? 0 : offload_to_mirror + 1;
6b80b18fe51540 Scott Teel          2014-02-18  5293  		dev->offload_to_mirror = offload_to_mirror;
6b80b18fe51540 Scott Teel          2014-02-18  5294  		/* Avoid direct use of dev->offload_to_mirror within this
6b80b18fe51540 Scott Teel          2014-02-18  5295  		 * function since multiple threads might simultaneously
6b80b18fe51540 Scott Teel          2014-02-18  5296  		 * increment it beyond the range of dev->layout_map_count -1.
6b80b18fe51540 Scott Teel          2014-02-18  5297  		 */
6b80b18fe51540 Scott Teel          2014-02-18  5298  		break;
6b80b18fe51540 Scott Teel          2014-02-18  5299  	case HPSA_RAID_5:
6b80b18fe51540 Scott Teel          2014-02-18  5300  	case HPSA_RAID_6:
2b08b3e9d9dad9 Don Brace           2015-01-23  5301  		if (le16_to_cpu(map->layout_map_count) <= 1)
6b80b18fe51540 Scott Teel          2014-02-18  5302  			break;
6b80b18fe51540 Scott Teel          2014-02-18  5303  
6b80b18fe51540 Scott Teel          2014-02-18  5304  		/* Verify first and last block are in same RAID group */
6b80b18fe51540 Scott Teel          2014-02-18  5305  		r5or6_blocks_per_row =
2b08b3e9d9dad9 Don Brace           2015-01-23  5306  			le16_to_cpu(map->strip_size) *
2b08b3e9d9dad9 Don Brace           2015-01-23  5307  			le16_to_cpu(map->data_disks_per_row);
3e16e83a62edac Don Brace           2020-03-20  5308  		if (r5or6_blocks_per_row == 0) {
3e16e83a62edac Don Brace           2020-03-20  5309  			hpsa_turn_off_ioaccel_for_device(dev);
3e16e83a62edac Don Brace           2020-03-20  5310  			return IO_ACCEL_INELIGIBLE;
3e16e83a62edac Don Brace           2020-03-20  5311  		}
2b08b3e9d9dad9 Don Brace           2015-01-23  5312  		stripesize = r5or6_blocks_per_row *
2b08b3e9d9dad9 Don Brace           2015-01-23  5313  			le16_to_cpu(map->layout_map_count);
6b80b18fe51540 Scott Teel          2014-02-18  5314  #if BITS_PER_LONG == 32
6b80b18fe51540 Scott Teel          2014-02-18  5315  		tmpdiv = first_block;
6b80b18fe51540 Scott Teel          2014-02-18  5316  		first_group = do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5317  		tmpdiv = first_group;
6b80b18fe51540 Scott Teel          2014-02-18  5318  		(void) do_div(tmpdiv, r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5319  		first_group = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5320  		tmpdiv = last_block;
6b80b18fe51540 Scott Teel          2014-02-18  5321  		last_group = do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5322  		tmpdiv = last_group;
6b80b18fe51540 Scott Teel          2014-02-18  5323  		(void) do_div(tmpdiv, r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5324  		last_group = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5325  #else
6b80b18fe51540 Scott Teel          2014-02-18  5326  		first_group = (first_block % stripesize) / r5or6_blocks_per_row;
6b80b18fe51540 Scott Teel          2014-02-18  5327  		last_group = (last_block % stripesize) / r5or6_blocks_per_row;
6b80b18fe51540 Scott Teel          2014-02-18  5328  #endif
000ff7c25a1513 Stephen M. Cameron  2014-03-13  5329  		if (first_group != last_group)
6b80b18fe51540 Scott Teel          2014-02-18  5330  			return IO_ACCEL_INELIGIBLE;
6b80b18fe51540 Scott Teel          2014-02-18  5331  
6b80b18fe51540 Scott Teel          2014-02-18  5332  		/* Verify request is in a single row of RAID 5/6 */
6b80b18fe51540 Scott Teel          2014-02-18  5333  #if BITS_PER_LONG == 32
6b80b18fe51540 Scott Teel          2014-02-18  5334  		tmpdiv = first_block;
6b80b18fe51540 Scott Teel          2014-02-18  5335  		(void) do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5336  		first_row = r5or6_first_row = r0_first_row = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5337  		tmpdiv = last_block;
6b80b18fe51540 Scott Teel          2014-02-18  5338  		(void) do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5339  		r5or6_last_row = r0_last_row = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5340  #else
6b80b18fe51540 Scott Teel          2014-02-18  5341  		first_row = r5or6_first_row = r0_first_row =
6b80b18fe51540 Scott Teel          2014-02-18  5342  						first_block / stripesize;
6b80b18fe51540 Scott Teel          2014-02-18  5343  		r5or6_last_row = r0_last_row = last_block / stripesize;
6b80b18fe51540 Scott Teel          2014-02-18  5344  #endif
6b80b18fe51540 Scott Teel          2014-02-18  5345  		if (r5or6_first_row != r5or6_last_row)
6b80b18fe51540 Scott Teel          2014-02-18  5346  			return IO_ACCEL_INELIGIBLE;
6b80b18fe51540 Scott Teel          2014-02-18  5347  
6b80b18fe51540 Scott Teel          2014-02-18  5348  
6b80b18fe51540 Scott Teel          2014-02-18  5349  		/* Verify request is in a single column */
6b80b18fe51540 Scott Teel          2014-02-18  5350  #if BITS_PER_LONG == 32
6b80b18fe51540 Scott Teel          2014-02-18  5351  		tmpdiv = first_block;
6b80b18fe51540 Scott Teel          2014-02-18  5352  		first_row_offset = do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5353  		tmpdiv = first_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5354  		first_row_offset = (u32) do_div(tmpdiv, r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5355  		r5or6_first_row_offset = first_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5356  		tmpdiv = last_block;
6b80b18fe51540 Scott Teel          2014-02-18  5357  		r5or6_last_row_offset = do_div(tmpdiv, stripesize);
6b80b18fe51540 Scott Teel          2014-02-18  5358  		tmpdiv = r5or6_last_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5359  		r5or6_last_row_offset = do_div(tmpdiv, r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5360  		tmpdiv = r5or6_first_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5361  		(void) do_div(tmpdiv, map->strip_size);
6b80b18fe51540 Scott Teel          2014-02-18  5362  		first_column = r5or6_first_column = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5363  		tmpdiv = r5or6_last_row_offset;
6b80b18fe51540 Scott Teel          2014-02-18  5364  		(void) do_div(tmpdiv, map->strip_size);
6b80b18fe51540 Scott Teel          2014-02-18  5365  		r5or6_last_column = tmpdiv;
6b80b18fe51540 Scott Teel          2014-02-18  5366  #else
6b80b18fe51540 Scott Teel          2014-02-18  5367  		first_row_offset = r5or6_first_row_offset =
6b80b18fe51540 Scott Teel          2014-02-18  5368  			(u32)((first_block % stripesize) %
6b80b18fe51540 Scott Teel          2014-02-18  5369  						r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5370  
6b80b18fe51540 Scott Teel          2014-02-18  5371  		r5or6_last_row_offset =
6b80b18fe51540 Scott Teel          2014-02-18  5372  			(u32)((last_block % stripesize) %
6b80b18fe51540 Scott Teel          2014-02-18  5373  						r5or6_blocks_per_row);
6b80b18fe51540 Scott Teel          2014-02-18  5374  
6b80b18fe51540 Scott Teel          2014-02-18  5375  		first_column = r5or6_first_column =
2b08b3e9d9dad9 Don Brace           2015-01-23  5376  			r5or6_first_row_offset / le16_to_cpu(map->strip_size);
6b80b18fe51540 Scott Teel          2014-02-18  5377  		r5or6_last_column =
2b08b3e9d9dad9 Don Brace           2015-01-23  5378  			r5or6_last_row_offset / le16_to_cpu(map->strip_size);
6b80b18fe51540 Scott Teel          2014-02-18  5379  #endif
6b80b18fe51540 Scott Teel          2014-02-18  5380  		if (r5or6_first_column != r5or6_last_column)
6b80b18fe51540 Scott Teel          2014-02-18  5381  			return IO_ACCEL_INELIGIBLE;
6b80b18fe51540 Scott Teel          2014-02-18  5382  
6b80b18fe51540 Scott Teel          2014-02-18  5383  		/* Request is eligible */
6b80b18fe51540 Scott Teel          2014-02-18  5384  		map_row = ((u32)(first_row >> map->parity_rotation_shift)) %
2b08b3e9d9dad9 Don Brace           2015-01-23  5385  			le16_to_cpu(map->row_cnt);
6b80b18fe51540 Scott Teel          2014-02-18  5386  
6b80b18fe51540 Scott Teel          2014-02-18  5387  		map_index = (first_group *
2b08b3e9d9dad9 Don Brace           2015-01-23  5388  			(le16_to_cpu(map->row_cnt) * total_disks_per_row)) +
6b80b18fe51540 Scott Teel          2014-02-18  5389  			(map_row * total_disks_per_row) + first_column;
6b80b18fe51540 Scott Teel          2014-02-18  5390  		break;
6b80b18fe51540 Scott Teel          2014-02-18  5391  	default:
6b80b18fe51540 Scott Teel          2014-02-18  5392  		return IO_ACCEL_INELIGIBLE;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5393  	}
6b80b18fe51540 Scott Teel          2014-02-18  5394  
07543e0c05de17 Stephen Cameron     2015-01-23  5395  	if (unlikely(map_index >= RAID_MAP_MAX_ENTRIES))
07543e0c05de17 Stephen Cameron     2015-01-23  5396  		return IO_ACCEL_INELIGIBLE;
07543e0c05de17 Stephen Cameron     2015-01-23  5397  
03383736348bb7 Don Brace           2015-01-23  5398  	c->phys_disk = dev->phys_disk[map_index];
c3390df4751177 Don Brace           2016-02-23  5399  	if (!c->phys_disk)
c3390df4751177 Don Brace           2016-02-23  5400  		return IO_ACCEL_INELIGIBLE;
03383736348bb7 Don Brace           2015-01-23  5401  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5402  	disk_handle = dd[map_index].ioaccel_handle;
2b08b3e9d9dad9 Don Brace           2015-01-23  5403  	disk_block = le64_to_cpu(map->disk_starting_blk) +
2b08b3e9d9dad9 Don Brace           2015-01-23  5404  			first_row * le16_to_cpu(map->strip_size) +
2b08b3e9d9dad9 Don Brace           2015-01-23  5405  			(first_row_offset - first_column *
2b08b3e9d9dad9 Don Brace           2015-01-23  5406  			le16_to_cpu(map->strip_size));
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5407  	disk_block_cnt = block_cnt;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5408  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5409  	/* handle differing logical/physical block sizes */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5410  	if (map->phys_blk_shift) {
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5411  		disk_block <<= map->phys_blk_shift;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5412  		disk_block_cnt <<= map->phys_blk_shift;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5413  	}
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5414  	BUG_ON(disk_block_cnt > 0xffff);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5415  
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5416  	/* build the new CDB for the physical disk I/O */
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5417  	if (disk_block > 0xffffffff) {
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5418  		cdb[0] = is_write ? WRITE_16 : READ_16;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5419  		cdb[1] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5420  		cdb[2] = (u8) (disk_block >> 56);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5421  		cdb[3] = (u8) (disk_block >> 48);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5422  		cdb[4] = (u8) (disk_block >> 40);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5423  		cdb[5] = (u8) (disk_block >> 32);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5424  		cdb[6] = (u8) (disk_block >> 24);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5425  		cdb[7] = (u8) (disk_block >> 16);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5426  		cdb[8] = (u8) (disk_block >> 8);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5427  		cdb[9] = (u8) (disk_block);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5428  		cdb[10] = (u8) (disk_block_cnt >> 24);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5429  		cdb[11] = (u8) (disk_block_cnt >> 16);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5430  		cdb[12] = (u8) (disk_block_cnt >> 8);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5431  		cdb[13] = (u8) (disk_block_cnt);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5432  		cdb[14] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5433  		cdb[15] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5434  		cdb_len = 16;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5435  	} else {
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5436  		cdb[0] = is_write ? WRITE_10 : READ_10;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5437  		cdb[1] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5438  		cdb[2] = (u8) (disk_block >> 24);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5439  		cdb[3] = (u8) (disk_block >> 16);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5440  		cdb[4] = (u8) (disk_block >> 8);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5441  		cdb[5] = (u8) (disk_block);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5442  		cdb[6] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5443  		cdb[7] = (u8) (disk_block_cnt >> 8);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5444  		cdb[8] = (u8) (disk_block_cnt);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5445  		cdb[9] = 0;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5446  		cdb_len = 10;
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5447  	}
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5448  	return hpsa_scsi_ioaccel_queue_command(h, c, disk_handle, cdb, cdb_len,
03383736348bb7 Don Brace           2015-01-23  5449  						dev->scsi3addr,
03383736348bb7 Don Brace           2015-01-23  5450  						dev->phys_disk[map_index]);
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5451  }
283b4a9b98b192 Stephen M. Cameron  2014-02-18  5452  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
