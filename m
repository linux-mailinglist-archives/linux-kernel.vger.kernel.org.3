Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA1479892
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhLREXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:23:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:36588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLREXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639801415; x=1671337415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wJNOXl1bnBo9eJgleubDAfJE5BqAgc6KVYQRnRwGwqw=;
  b=fWJF3wv9Aiyo2AYLMs5neDixfogbFZ//1w+81Pv9+6tXNyt8iBbiUUMl
   v+42RkxlWnhteIwmn/4gQjCI/ebp13stSk2Oc3HpTUsG0skc8/8h6WUrN
   5t8kT2DzDmGrEamfaNVvlB4s6Jp979+hhy9Orr3rysL3Zhj0Wmnzp/cBR
   +wQwvP3cVhnu2pWDIceOcyMiJ9QJg0SAWJEOr5eYLwuHqyH7FqhgMfR16
   ceQj/vLEpnZnoCsljaauXY9qcSE5D48ieXHWbA3lU9vXW3voKFKfa+nqM
   RWK2q54Vj/wLgBzBreAVTHPg1PvK2j/gr1Ra4zjth7WDPxwBje4jAxmkL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219897067"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="219897067"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 20:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="466735059"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 20:23:33 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myRFs-0005bM-IS; Sat, 18 Dec 2021 04:23:32 +0000
Date:   Sat, 18 Dec 2021 12:23:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 5/5] drivers/net/hyperv/netvsc.c:1026:5:
 warning: no previous prototype for 'netvsc_dma_map'
Message-ID: <202112181204.uRIUsFfa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
commit: 19fd7ca00201c0525452dcf5a490e4b01674ef4c [5/5] net: netvsc: Add Isolation VM support for netvsc driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112181204.uRIUsFfa-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=19fd7ca00201c0525452dcf5a490e4b01674ef4c
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout 19fd7ca00201c0525452dcf5a490e4b01674ef4c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/hyperv/netvsc.c:1026:5: warning: no previous prototype for 'netvsc_dma_map' [-Wmissing-prototypes]
    1026 | int netvsc_dma_map(struct hv_device *hv_dev,
         |     ^~~~~~~~~~~~~~


vim +/netvsc_dma_map +1026 drivers/net/hyperv/netvsc.c

  1007	
  1008	/* netvsc_dma_map - Map swiotlb bounce buffer with data page of
  1009	 * packet sent by vmbus_sendpacket_pagebuffer() in the Isolation
  1010	 * VM.
  1011	 *
  1012	 * In isolation VM, netvsc send buffer has been marked visible to
  1013	 * host and so the data copied to send buffer doesn't need to use
  1014	 * bounce buffer. The data pages handled by vmbus_sendpacket_pagebuffer()
  1015	 * may not be copied to send buffer and so these pages need to be
  1016	 * mapped with swiotlb bounce buffer. netvsc_dma_map() is to do
  1017	 * that. The pfns in the struct hv_page_buffer need to be converted
  1018	 * to bounce buffer's pfn. The loop here is necessary because the
  1019	 * entries in the page buffer array are not necessarily full
  1020	 * pages of data.  Each entry in the array has a separate offset and
  1021	 * len that may be non-zero, even for entries in the middle of the
  1022	 * array.  And the entries are not physically contiguous.  So each
  1023	 * entry must be individually mapped rather than as a contiguous unit.
  1024	 * So not use dma_map_sg() here.
  1025	 */
> 1026	int netvsc_dma_map(struct hv_device *hv_dev,
  1027			   struct hv_netvsc_packet *packet,
  1028			   struct hv_page_buffer *pb)
  1029	{
  1030		u32 page_count =  packet->cp_partial ?
  1031			packet->page_buf_cnt - packet->rmsg_pgcnt :
  1032			packet->page_buf_cnt;
  1033		dma_addr_t dma;
  1034		int i;
  1035	
  1036		if (!hv_is_isolation_supported())
  1037			return 0;
  1038	
  1039		packet->dma_range = kcalloc(page_count,
  1040					    sizeof(*packet->dma_range),
  1041					    GFP_KERNEL);
  1042		if (!packet->dma_range)
  1043			return -ENOMEM;
  1044	
  1045		for (i = 0; i < page_count; i++) {
  1046			char *src = phys_to_virt((pb[i].pfn << HV_HYP_PAGE_SHIFT)
  1047						 + pb[i].offset);
  1048			u32 len = pb[i].len;
  1049	
  1050			dma = dma_map_single(&hv_dev->device, src, len,
  1051					     DMA_TO_DEVICE);
  1052			if (dma_mapping_error(&hv_dev->device, dma)) {
  1053				kfree(packet->dma_range);
  1054				return -ENOMEM;
  1055			}
  1056	
  1057			/* pb[].offset and pb[].len are not changed during dma mapping
  1058			 * and so not reassign.
  1059			 */
  1060			packet->dma_range[i].dma = dma;
  1061			packet->dma_range[i].mapping_size = len;
  1062			pb[i].pfn = dma >> HV_HYP_PAGE_SHIFT;
  1063		}
  1064	
  1065		return 0;
  1066	}
  1067	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
