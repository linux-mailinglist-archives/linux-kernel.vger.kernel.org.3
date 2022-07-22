Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABF57DA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiGVGsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiGVGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:48:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12598C171
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658472506; x=1690008506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qrLJjSHnNl593T5koXe6erYE6Q/hVICL/Ib5w3Y98fo=;
  b=iYwHzeUyOc3Y8JlNgENALI7veVXZGxL4KZunRnoJdOwe6IPmv8z+6pyV
   xIkSnudDaSiRHXYZMScubQ2fcTIWCKVWP886CCmXZ0dNku24LrBIoEhbf
   STzXnNdOsM32MJJgBnrNHpVszenV7PeRjLS9iQFBhW6RSnDiC6MXkmHMg
   4BJyxwpS75743PREOyIiltbKSXa1rK1pdnnCG51zmNA72q5BfrBAM3+ky
   UXfjvnEkf2B/q8dajHZp1LiCEdx1vqc/DU1RkZY3nG4ycMlbs4nULegOq
   /TMjc53G3itXi12RLUHONtgtQMBuG9lFT+LWfeov3m6RXb81XNKpVz1I0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288005694"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="288005694"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 23:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="844675769"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2022 23:48:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEmSW-00015d-0d;
        Fri, 22 Jul 2022 06:48:24 +0000
Date:   Fri, 22 Jul 2022 14:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v3-wip 6/6] drivers/nvme/host/pci.c:967:7:
 warning: variable 'nprps_left' is uninitialized when used here
Message-ID: <202207221447.1b5HzBgh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v3-wip
head:   4625fa7adf745334c0a2eb635121d587df797b29
commit: 4625fa7adf745334c0a2eb635121d587df797b29 [6/6] nvme-pci: implement dma_map support
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220722/202207221447.1b5HzBgh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=4625fa7adf745334c0a2eb635121d587df797b29
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v3-wip
        git checkout 4625fa7adf745334c0a2eb635121d587df797b29
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/pci.c:967:7: warning: variable 'nprps_left' is uninitialized when used here [-Wuninitialized]
                   if (nprps_left <= last_prp + 1) {
                       ^~~~~~~~~~
   drivers/nvme/host/pci.c:893:49: note: initialize the variable 'nprps_left' to silence this warning
           int index, offset, i, length, nprps, nprps_left;
                                                          ^
                                                           = 0
   drivers/nvme/host/pci.c:1935:7: warning: variable 'pages_per' set but not used [-Wunused-but-set-variable]
                   int pages_per = nvme_pages;
                       ^
   2 warnings generated.


vim +/nprps_left +967 drivers/nvme/host/pci.c

   886	
   887	static blk_status_t nvme_premapped(struct nvme_dev *dev, struct request *req,
   888					   struct nvme_rw_command *cmnd,
   889					   struct nvme_iod *iod)
   890	{
   891		static const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
   892		dma_addr_t prp_list_start, prp_list_end, prp_dma;
   893		int index, offset, i, length, nprps, nprps_left;
   894		void **list = nvme_pci_iod_list(req);
   895		struct nvme_dma_mapping *mapping;
   896		struct dma_pool *pool;
   897		__le64 *prp_list;
   898		bool needs_sync;
   899	
   900		mapping = blk_rq_dma_tag(req);
   901		offset = blk_rq_dma_offset(req) + mapping->offset;
   902		index = offset >> NVME_CTRL_PAGE_SHIFT;
   903		offset = offset & (NVME_CTRL_PAGE_SIZE - 1);
   904		needs_sync = rq_data_dir(req) == WRITE &&
   905			 dma_need_sync(dev->dev, le64_to_cpu(mapping->prps[index]));
   906	
   907		/*
   908		 * XXX: For PAGE_SIZE > NVME_CTRL_PAGE_SIZE, is it faster to save the
   909		 * PRP list implementation and sync multiple partial pages, more
   910		 * efficient to sync PAGE_SIZE and build the PRP list per-IO from a
   911		 * host PAGE_SIZE representation, or cleverly sync physically
   912		 * contiguous regions?
   913		 */
   914		if (needs_sync) {
   915			dma_sync_single_for_device(dev->dev,
   916				le64_to_cpu(mapping->prps[index]),
   917				NVME_CTRL_PAGE_SIZE - offset, DMA_TO_DEVICE);
   918		}
   919	
   920		length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
   921		cmnd->dptr.prp1 = cpu_to_le64(le64_to_cpu(mapping->prps[index++]) + offset);
   922	
   923		if (length <= 0)
   924			return BLK_STS_OK;
   925	
   926		if (length <= NVME_CTRL_PAGE_SIZE) {
   927			if (needs_sync)
   928				dma_sync_single_for_device(dev->dev,
   929					le64_to_cpu(mapping->prps[index]),
   930					NVME_CTRL_PAGE_SIZE, DMA_TO_DEVICE);
   931			cmnd->dptr.prp2 = mapping->prps[index];
   932			return BLK_STS_OK;
   933		}
   934	
   935		nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
   936		prp_list_start = mapping->prp_dma_addr + 8 * index;
   937		prp_list_end = prp_list_start + 8 * nprps;
   938	
   939		/* Optimization when remaining list fits in one nvme page */
   940		if ((prp_list_start >> NVME_CTRL_PAGE_SHIFT) ==
   941		    (prp_list_end >> NVME_CTRL_PAGE_SHIFT)) {
   942			cmnd->dptr.prp2 = cpu_to_le64(prp_list_start);
   943			goto sync;
   944		}
   945	
   946		if (nprps <= (256 / 8)) {
   947			pool = dev->prp_small_pool;
   948			iod->npages = 0;
   949		} else {
   950			pool = dev->prp_page_pool;
   951			iod->npages = 1;
   952		}
   953	
   954		prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
   955		if (!prp_list) {
   956			iod->npages = -1;
   957			return BLK_STS_RESOURCE;
   958		}
   959	
   960		list[0] = prp_list;
   961		iod->first_dma = prp_dma;
   962		i = 0;
   963		for (;;) {
   964			dma_addr_t next_prp_dma;
   965			__le64 *next_prp_list;
   966	
 > 967			if (nprps_left <= last_prp + 1) {
   968				memcpy(prp_list, &mapping->prps[index], nprps_left * 8);
   969				break;
   970			}
   971	
   972			memcpy(prp_list, &mapping->prps[index],
   973			       NVME_CTRL_PAGE_SIZE - 8);
   974			nprps_left -= last_prp;
   975			index += last_prp;
   976	
   977			next_prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &next_prp_dma);
   978			if (!next_prp_list)
   979				goto free_prps;
   980	
   981			prp_list[last_prp] = cpu_to_le64(next_prp_dma);
   982			prp_list = next_prp_list;
   983			prp_dma = next_prp_dma;
   984			list[iod->npages++] = prp_list;
   985		}
   986		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
   987	
   988	sync:
   989		if (!needs_sync)
   990			return BLK_STS_OK;
   991	
   992		for (i = 0; i < nprps; i++)
   993			dma_sync_single_for_device(dev->dev,
   994				le64_to_cpu(mapping->prps[index++]),
   995				NVME_CTRL_PAGE_SIZE, DMA_TO_DEVICE);
   996		return BLK_STS_OK;
   997	
   998	free_prps:
   999		nvme_free_prps(dev, req);
  1000		return BLK_STS_RESOURCE;
  1001	}
  1002	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
