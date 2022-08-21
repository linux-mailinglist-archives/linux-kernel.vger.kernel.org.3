Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563859B111
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiHUAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHUAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:42:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEC2B611
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661042544; x=1692578544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bHJMBp6/LJ3mdt5msj9P1XP2sKNjsx2SoWBe/+Fs23A=;
  b=lwMYp9uevT28Mg8JaCIG/zw4cnrt1NG3teWAHR70aBD0Xy8vACHv2suu
   yzWUqfDmg8FoJ8MDmcbBTywEMfWGXXkDQvPVXsejxgX3R1aoh+Bb2V7IU
   7iNwfnQSef7oEY0m2bMTI8sCvELlOSigrZ0kR1PKmFyWxFg6Q13K7RH0h
   SEWvdvDetUk/YsYSt9AMtcVuh3N1spNsYP7J51t/t2PujPtIPgnHPj0tz
   AuM1Fg6IOh7Blgfx4Txcnapw5wCpmtKPHfkI3aFsOsZ2T8+2ahpWRBz/D
   g/48h7SxWKuWORt9uSwlxZLDWO6ST3G/Yo9/d3egbJTznoCU/OL6k9XYa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="290770766"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="290770766"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 17:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="697904404"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2022 17:42:23 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPZ2k-0003PV-1E;
        Sun, 21 Aug 2022 00:42:22 +0000
Date:   Sun, 21 Aug 2022 08:42:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2174:43: sparse: sparse:
 restricted __le32 degrades to integer
Message-ID: <202208210816.46BZqtAB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   9 days ago
config: loongarch-randconfig-s041-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210816.46BZqtAB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/scsi/hisi_sas/ net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2174:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2175:46: sparse: sparse: restricted __le32 degrades to integer
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4440:35: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __le32 [usertype] *[assigned] ptr @@     got unsigned int * @@
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4440:35: sparse:     expected restricted __le32 [usertype] *[assigned] ptr
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4440:35: sparse:     got unsigned int *

vim +2174 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

fa2314081571f5 Xiaofei Tan     2017-10-24  2150  
62413199cd6d29 Xingui Yang     2022-02-24  2151  static bool
60b4a5ee90349a Xiang Chen      2017-06-14  2152  slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
60b4a5ee90349a Xiang Chen      2017-06-14  2153  	       struct hisi_sas_slot *slot)
60b4a5ee90349a Xiang Chen      2017-06-14  2154  {
60b4a5ee90349a Xiang Chen      2017-06-14  2155  	struct task_status_struct *ts = &task->task_status;
60b4a5ee90349a Xiang Chen      2017-06-14  2156  	struct hisi_sas_complete_v3_hdr *complete_queue =
60b4a5ee90349a Xiang Chen      2017-06-14  2157  			hisi_hba->complete_hdr[slot->cmplt_queue];
60b4a5ee90349a Xiang Chen      2017-06-14  2158  	struct hisi_sas_complete_v3_hdr *complete_hdr =
60b4a5ee90349a Xiang Chen      2017-06-14  2159  			&complete_queue[slot->cmplt_queue_slot];
f557e32c0023ea Xiaofei Tan     2017-06-29  2160  	struct hisi_sas_err_record_v3 *record =
f557e32c0023ea Xiaofei Tan     2017-06-29  2161  			hisi_sas_status_buf_addr_mem(slot);
735bcc77e6ba83 John Garry      2018-12-06  2162  	u32 dma_rx_err_type = le32_to_cpu(record->dma_rx_err_type);
735bcc77e6ba83 John Garry      2018-12-06  2163  	u32 trans_tx_fail_type = le32_to_cpu(record->trans_tx_fail_type);
735bcc77e6ba83 John Garry      2018-12-06  2164  	u32 dw3 = le32_to_cpu(complete_hdr->dw3);
60b4a5ee90349a Xiang Chen      2017-06-14  2165  
60b4a5ee90349a Xiang Chen      2017-06-14  2166  	switch (task->task_proto) {
60b4a5ee90349a Xiang Chen      2017-06-14  2167  	case SAS_PROTOCOL_SSP:
60b4a5ee90349a Xiang Chen      2017-06-14  2168  		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
62413199cd6d29 Xingui Yang     2022-02-24  2169  			/*
62413199cd6d29 Xingui Yang     2022-02-24  2170  			 * If returned response frame is incorrect because of data underflow,
62413199cd6d29 Xingui Yang     2022-02-24  2171  			 * but I/O information has been written to the host memory, we examine
62413199cd6d29 Xingui Yang     2022-02-24  2172  			 * response IU.
62413199cd6d29 Xingui Yang     2022-02-24  2173  			 */
62413199cd6d29 Xingui Yang     2022-02-24 @2174  			if (!(complete_hdr->dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
62413199cd6d29 Xingui Yang     2022-02-24  2175  				(complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
62413199cd6d29 Xingui Yang     2022-02-24  2176  				return false;
62413199cd6d29 Xingui Yang     2022-02-24  2177  
60b4a5ee90349a Xiang Chen      2017-06-14  2178  			ts->residual = trans_tx_fail_type;
60b4a5ee90349a Xiang Chen      2017-06-14  2179  			ts->stat = SAS_DATA_UNDERRUN;
735bcc77e6ba83 John Garry      2018-12-06  2180  		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
60b4a5ee90349a Xiang Chen      2017-06-14  2181  			ts->stat = SAS_QUEUE_FULL;
60b4a5ee90349a Xiang Chen      2017-06-14  2182  			slot->abort = 1;
60b4a5ee90349a Xiang Chen      2017-06-14  2183  		} else {
60b4a5ee90349a Xiang Chen      2017-06-14  2184  			ts->stat = SAS_OPEN_REJECT;
60b4a5ee90349a Xiang Chen      2017-06-14  2185  			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
60b4a5ee90349a Xiang Chen      2017-06-14  2186  		}
60b4a5ee90349a Xiang Chen      2017-06-14  2187  		break;
60b4a5ee90349a Xiang Chen      2017-06-14  2188  	case SAS_PROTOCOL_SATA:
60b4a5ee90349a Xiang Chen      2017-06-14  2189  	case SAS_PROTOCOL_STP:
60b4a5ee90349a Xiang Chen      2017-06-14  2190  	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
60b4a5ee90349a Xiang Chen      2017-06-14  2191  		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
60b4a5ee90349a Xiang Chen      2017-06-14  2192  			ts->residual = trans_tx_fail_type;
60b4a5ee90349a Xiang Chen      2017-06-14  2193  			ts->stat = SAS_DATA_UNDERRUN;
735bcc77e6ba83 John Garry      2018-12-06  2194  		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
60b4a5ee90349a Xiang Chen      2017-06-14  2195  			ts->stat = SAS_PHY_DOWN;
60b4a5ee90349a Xiang Chen      2017-06-14  2196  			slot->abort = 1;
60b4a5ee90349a Xiang Chen      2017-06-14  2197  		} else {
60b4a5ee90349a Xiang Chen      2017-06-14  2198  			ts->stat = SAS_OPEN_REJECT;
60b4a5ee90349a Xiang Chen      2017-06-14  2199  			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
60b4a5ee90349a Xiang Chen      2017-06-14  2200  		}
60b4a5ee90349a Xiang Chen      2017-06-14  2201  		hisi_sas_sata_done(task, slot);
60b4a5ee90349a Xiang Chen      2017-06-14  2202  		break;
60b4a5ee90349a Xiang Chen      2017-06-14  2203  	case SAS_PROTOCOL_SMP:
d377f415dddc18 Bart Van Assche 2021-05-23  2204  		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
60b4a5ee90349a Xiang Chen      2017-06-14  2205  		break;
60b4a5ee90349a Xiang Chen      2017-06-14  2206  	default:
60b4a5ee90349a Xiang Chen      2017-06-14  2207  		break;
60b4a5ee90349a Xiang Chen      2017-06-14  2208  	}
62413199cd6d29 Xingui Yang     2022-02-24  2209  	return true;
60b4a5ee90349a Xiang Chen      2017-06-14  2210  }
60b4a5ee90349a Xiang Chen      2017-06-14  2211  

:::::: The code at line 2174 was first introduced by commit
:::::: 62413199cd6d2906c121c2dfa3d7b82fd05f08db scsi: hisi_sas: Modify v3 HW SSP underflow error processing

:::::: TO: Xingui Yang <yangxingui@huawei.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
