Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542E51938A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiEDBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbiEDBnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:43:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6431DA52
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651628375; x=1683164375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yk6eI4gj1J+Vk7fwVGJ76YxhHJuBnn5M1lRY1GwoAs4=;
  b=gAaZrMixGblsD7yK14OoRdpdLdc5sJLZMG0fiNxpsqe0DnyP3Xj8ZJBV
   +PEbQ1fbQuWiIvt54zqI69A9WSLYBIz7O2M5NVpF78XpdntE5YgpGItiM
   C1dTntr5YHunhxS70y3vsrJMlH2w0AqZoua0Z/WRPxMRnKhGTru2zCL2B
   95ZWBu9SUs33j6erMDaqyD3Eg2Iku1fkaNyogY/Ign3SHVdfpZLQtpaFq
   BQfpI2szaVw16BUOYeGGlaBmYSne+rgArYHVH5Ht2DezwXdOFijWhva8R
   +tSeYMjrq+PugOoRgjPCPN31YCqokVGvjeEZn/NllsCjWHU/zNJFtK32K
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248178778"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248178778"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 18:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="631753453"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2022 18:39:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm3zI-000Awu-U7;
        Wed, 04 May 2022 01:39:32 +0000
Date:   Wed, 4 May 2022 09:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nf_conntrack_core.c:1736:8: warning: Local variable
 'tmp' shadows outer variable [shadowVariable]
Message-ID: <202205040943.Gd2qI52I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
commit: b16ac3c4c886f323b06ae942f02ebd2a70bf8840 netfilter: conntrack: include zone id in tuple hash again
date:   8 months ago
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout b16ac3c4c886f323b06ae942f02ebd2a70bf8840
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> net/netfilter/nf_conntrack_core.c:1736:8: warning: Local variable 'tmp' shadows outer variable [shadowVariable]
      u32 tmp = hash_conntrack_raw(&tuple, rid, state->net);
          ^
   net/netfilter/nf_conntrack_core.c:1715:27: note: Shadowed declaration
    struct nf_conntrack_zone tmp;
                             ^
   net/netfilter/nf_conntrack_core.c:1736:8: note: Shadow variable
      u32 tmp = hash_conntrack_raw(&tuple, rid, state->net);
          ^

vim +/tmp +1736 net/netfilter/nf_conntrack_core.c

  1702	
  1703	/* On success, returns 0, sets skb->_nfct | ctinfo */
  1704	static int
  1705	resolve_normal_ct(struct nf_conn *tmpl,
  1706			  struct sk_buff *skb,
  1707			  unsigned int dataoff,
  1708			  u_int8_t protonum,
  1709			  const struct nf_hook_state *state)
  1710	{
  1711		const struct nf_conntrack_zone *zone;
  1712		struct nf_conntrack_tuple tuple;
  1713		struct nf_conntrack_tuple_hash *h;
  1714		enum ip_conntrack_info ctinfo;
  1715		struct nf_conntrack_zone tmp;
  1716		u32 hash, zone_id, rid;
  1717		struct nf_conn *ct;
  1718	
  1719		if (!nf_ct_get_tuple(skb, skb_network_offset(skb),
  1720				     dataoff, state->pf, protonum, state->net,
  1721				     &tuple)) {
  1722			pr_debug("Can't get tuple\n");
  1723			return 0;
  1724		}
  1725	
  1726		/* look for tuple match */
  1727		zone = nf_ct_zone_tmpl(tmpl, skb, &tmp);
  1728	
  1729		zone_id = nf_ct_zone_id(zone, IP_CT_DIR_ORIGINAL);
  1730		hash = hash_conntrack_raw(&tuple, zone_id, state->net);
  1731		h = __nf_conntrack_find_get(state->net, zone, &tuple, hash);
  1732	
  1733		if (!h) {
  1734			rid = nf_ct_zone_id(zone, IP_CT_DIR_REPLY);
  1735			if (zone_id != rid) {
> 1736				u32 tmp = hash_conntrack_raw(&tuple, rid, state->net);
  1737	
  1738				h = __nf_conntrack_find_get(state->net, zone, &tuple, tmp);
  1739			}
  1740		}
  1741	
  1742		if (!h) {
  1743			h = init_conntrack(state->net, tmpl, &tuple,
  1744					   skb, dataoff, hash);
  1745			if (!h)
  1746				return 0;
  1747			if (IS_ERR(h))
  1748				return PTR_ERR(h);
  1749		}
  1750		ct = nf_ct_tuplehash_to_ctrack(h);
  1751	
  1752		/* It exists; we have (non-exclusive) reference. */
  1753		if (NF_CT_DIRECTION(h) == IP_CT_DIR_REPLY) {
  1754			ctinfo = IP_CT_ESTABLISHED_REPLY;
  1755		} else {
  1756			/* Once we've had two way comms, always ESTABLISHED. */
  1757			if (test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
  1758				pr_debug("normal packet for %p\n", ct);
  1759				ctinfo = IP_CT_ESTABLISHED;
  1760			} else if (test_bit(IPS_EXPECTED_BIT, &ct->status)) {
  1761				pr_debug("related packet for %p\n", ct);
  1762				ctinfo = IP_CT_RELATED;
  1763			} else {
  1764				pr_debug("new packet for %p\n", ct);
  1765				ctinfo = IP_CT_NEW;
  1766			}
  1767		}
  1768		nf_ct_set(skb, ct, ctinfo);
  1769		return 0;
  1770	}
  1771	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
