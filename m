Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C946882F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhLDXMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:12:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:31713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232699AbhLDXMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:12:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235885616"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="235885616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 15:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="501638141"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2021 15:09:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mte9Q-000JXh-J8; Sat, 04 Dec 2021 23:09:04 +0000
Date:   Sun, 5 Dec 2021 07:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202112050707.cAZoYQWK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bbef3c7a63d2a4cb0f3f839db9e767f168c5e348
commit: ba37b7caf1ed2395cc84d8f823ff933975f1f789 net: ethernet: mtk_eth_soc: add support for initializing the PPE
date:   9 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050707.cAZoYQWK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba37b7caf1ed2395cc84d8f823ff933975f1f789
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ba37b7caf1ed2395cc84d8f823ff933975f1f789
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:     expected unsigned int
   drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:60:27: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:158:46: sparse: sparse: cast to restricted __be16

vim +60 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c

    47	
    48	static void
    49	mtk_print_addr(struct seq_file *m, u32 *addr, bool ipv6)
    50	{
    51		u32 n_addr[4];
    52		int i;
    53	
    54		if (!ipv6) {
    55			seq_printf(m, "%pI4h", addr);
    56			return;
    57		}
    58	
    59		for (i = 0; i < ARRAY_SIZE(n_addr); i++)
  > 60			n_addr[i] = htonl(addr[i]);
    61		seq_printf(m, "%pI6", n_addr);
    62	}
    63	
    64	static void
    65	mtk_print_addr_info(struct seq_file *m, struct mtk_flow_addr_info *ai)
    66	{
    67		mtk_print_addr(m, ai->src, ai->ipv6);
    68		if (ai->src_port)
    69			seq_printf(m, ":%d", *ai->src_port);
    70		seq_printf(m, "->");
    71		mtk_print_addr(m, ai->dest, ai->ipv6);
    72		if (ai->dest_port)
    73			seq_printf(m, ":%d", *ai->dest_port);
    74	}
    75	
    76	static int
    77	mtk_ppe_debugfs_foe_show(struct seq_file *m, void *private, bool bind)
    78	{
    79		struct mtk_ppe *ppe = m->private;
    80		int i, count;
    81	
    82		for (i = 0, count = 0; i < MTK_PPE_ENTRIES; i++) {
    83			struct mtk_foe_entry *entry = &ppe->foe_table[i];
    84			struct mtk_foe_mac_info *l2;
    85			struct mtk_flow_addr_info ai = {};
    86			unsigned char h_source[ETH_ALEN];
    87			unsigned char h_dest[ETH_ALEN];
    88			int type, state;
    89			u32 ib2;
    90	
    91	
    92			state = FIELD_GET(MTK_FOE_IB1_STATE, entry->ib1);
    93			if (!state)
    94				continue;
    95	
    96			if (bind && state != MTK_FOE_STATE_BIND)
    97				continue;
    98	
    99			type = FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, entry->ib1);
   100			seq_printf(m, "%05x %s %7s", i,
   101				   mtk_foe_entry_state_str(state),
   102				   mtk_foe_pkt_type_str(type));
   103	
   104			switch (type) {
   105			case MTK_PPE_PKT_TYPE_IPV4_HNAPT:
   106			case MTK_PPE_PKT_TYPE_IPV4_DSLITE:
   107				ai.src_port = &entry->ipv4.orig.src_port;
   108				ai.dest_port = &entry->ipv4.orig.dest_port;
   109				fallthrough;
   110			case MTK_PPE_PKT_TYPE_IPV4_ROUTE:
   111				ai.src = &entry->ipv4.orig.src_ip;
   112				ai.dest = &entry->ipv4.orig.dest_ip;
   113				break;
   114			case MTK_PPE_PKT_TYPE_IPV6_ROUTE_5T:
   115				ai.src_port = &entry->ipv6.src_port;
   116				ai.dest_port = &entry->ipv6.dest_port;
   117				fallthrough;
   118			case MTK_PPE_PKT_TYPE_IPV6_ROUTE_3T:
   119			case MTK_PPE_PKT_TYPE_IPV6_6RD:
   120				ai.src = &entry->ipv6.src_ip;
   121				ai.dest = &entry->ipv6.dest_ip;
   122				ai.ipv6 = true;
   123				break;
   124			}
   125	
   126			seq_printf(m, " orig=");
   127			mtk_print_addr_info(m, &ai);
   128	
   129			switch (type) {
   130			case MTK_PPE_PKT_TYPE_IPV4_HNAPT:
   131			case MTK_PPE_PKT_TYPE_IPV4_DSLITE:
   132				ai.src_port = &entry->ipv4.new.src_port;
   133				ai.dest_port = &entry->ipv4.new.dest_port;
   134				fallthrough;
   135			case MTK_PPE_PKT_TYPE_IPV4_ROUTE:
   136				ai.src = &entry->ipv4.new.src_ip;
   137				ai.dest = &entry->ipv4.new.dest_ip;
   138				seq_printf(m, " new=");
   139				mtk_print_addr_info(m, &ai);
   140				break;
   141			}
   142	
   143			if (type >= MTK_PPE_PKT_TYPE_IPV4_DSLITE) {
   144				l2 = &entry->ipv6.l2;
   145				ib2 = entry->ipv6.ib2;
   146			} else {
   147				l2 = &entry->ipv4.l2;
   148				ib2 = entry->ipv4.ib2;
   149			}
   150	
   151			*((__be32 *)h_source) = htonl(l2->src_mac_hi);
   152			*((__be16 *)&h_source[4]) = htons(l2->src_mac_lo);
   153			*((__be32 *)h_dest) = htonl(l2->dest_mac_hi);
   154			*((__be16 *)&h_dest[4]) = htons(l2->dest_mac_lo);
   155	
   156			seq_printf(m, " eth=%pM->%pM etype=%04x"
   157				      " vlan=%d,%d ib1=%08x ib2=%08x\n",
 > 158				   h_source, h_dest, ntohs(l2->etype),
   159				   l2->vlan1, l2->vlan2, entry->ib1, ib2);
   160		}
   161	
   162		return 0;
   163	}
   164	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
