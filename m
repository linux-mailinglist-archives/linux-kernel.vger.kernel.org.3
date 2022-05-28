Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85739536D10
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiE1NKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiE1NKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:10:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AE14D1C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653743439; x=1685279439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=itXNkvg1e/eilh7u+TdYWivNHbnrgo3z0DFgqEMjGSw=;
  b=AvtFbj8qQlsn7AT1eJpCKOsSEvz7zDqtQ09YWZ4TuHsPNJY/1Gkaza9o
   na4+8qUzqoO4h8/6a4POS/XB8yVERUM7b2Z1ezXrijNwUlWkmGns3DtgA
   G4bo8jkyaeSlcKSUKifmSawferAnNp02mO/XX6mkGooHL1SlNmluj3RN9
   V+uWmZ2Nul3MyEr2JLp0mLOq2Qj3QWpZ60bBEdMCiHrN4by2DOQaMvp9Z
   LZ9coapQf2IIhy9fVLhQlUsP/iqmdRHC432K5yORfcsduvCfQVpFlRdDF
   C5gKqLgnjvzKuk+w5p2+3YoSwSuQs1/NfamFVHKkGc81SZsA1wk5VgfBN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="361056681"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="361056681"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 06:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="610830270"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2022 06:10:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuwDF-0000Dk-OD;
        Sat, 28 May 2022 13:10:37 +0000
Date:   Sat, 28 May 2022 21:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Aleksandrov <nikolay@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn:
 inconsistent indenting
Message-ID: <202205282109.Ow9gLt9u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: 9632233e7de8da43711bb7cd3e054af32fedcc38 net: bridge: multicast: factor out port multicast context
date:   10 months ago
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220528/202205282109.Ow9gLt9u-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn: inconsistent indenting

Old smatch warnings:
net/bridge/br_forward.c:317 br_multicast_flood() error: we previously assumed 'p' could be null (see line 293)

vim +901 net/bridge/br_private.h

   890	
   891	static inline struct net_bridge_port *
   892	br_multicast_rport_from_node_skb(struct hlist_node *rp, struct sk_buff *skb) {
   893		struct net_bridge_mcast_port *mctx;
   894	
   895	#if IS_ENABLED(CONFIG_IPV6)
   896		if (skb->protocol == htons(ETH_P_IPV6))
   897			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   898						ip6_rlist);
   899		else
   900	#endif
 > 901			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   902						ip4_rlist);
   903	
   904		if (mctx)
   905			return mctx->port;
   906		else
   907			return NULL;
   908	}
   909	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
