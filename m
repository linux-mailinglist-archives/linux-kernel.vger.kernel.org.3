Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFDF591F99
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiHNK46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiHNK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:56:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B523219288
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660474614; x=1692010614;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=om7XZRvumqY+m6uisuzq9vwO454bHP3t/2OAgQ4ncsY=;
  b=HAKWGNMTyVIN9Uh2ognGtisXewt0/zds8LCqYlAlBrTjG3cVbV8Ab2At
   qhs5bfsP+POC8/2vDx0IxFTUKLCPgKwMuDCOinEH9+j/xpYBJH3gpwyJm
   wSI4iXJlvidLtH7xTmsHmxbxuBuvnOwsACl6aR+mV2zxfpjUNO4MJrhrH
   2KhPgCKu7QapV6CCOlDjLC10t2diMCdgWmRIht8XoLnPwDloF6YZFIJYY
   G398KM2LKi5LWEoz5VPKKL4XxF2DnNFF9rblcSzj8UnHYp40ykvuSq8mj
   Nt7EF7yk+af+3coxxweEP4jMGMCk7GBgv6/r/mEJIbYGEmue48aSZhoxU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291815163"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291815163"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 03:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934193452"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 03:56:50 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNBIX-0002mH-2Z;
        Sun, 14 Aug 2022 10:56:49 +0000
Date:   Sun, 14 Aug 2022 18:56:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:ip_tunnel 31/36] net/ipv4/ipip.c:247:54: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202208141837.tcObXYYV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux ip_tunnel
head:   f6d5ecb4aceaf8c0da5503832a20129ac8c935df
commit: d979e3037463d961efe6c673bed1e4cc496ab2ce [31/36] net, tunnels: convert __be16 tunnel flags to bitmaps
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220814/202208141837.tcObXYYV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/alobakin/linux/commit/d979e3037463d961efe6c673bed1e4cc496ab2ce
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin ip_tunnel
        git checkout d979e3037463d961efe6c673bed1e4cc496ab2ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash net/ipv4/ net/ipv6/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/ipip.c:247:54: sparse: sparse: Using plain integer as NULL pointer
--
>> net/ipv6/ip6_tunnel.c:935:56: sparse: sparse: Using plain integer as NULL pointer

vim +247 net/ipv4/ipip.c

1b69e7e6c4da1e8 Simon Horman       2016-07-07  214  
1b69e7e6c4da1e8 Simon Horman       2016-07-07  215  static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
^1da177e4c3f415 Linus Torvalds     2005-04-16  216  {
fd58156e456d9f6 Pravin B Shelar    2013-03-25  217  	struct net *net = dev_net(skb->dev);
fd58156e456d9f6 Pravin B Shelar    2013-03-25  218  	struct ip_tunnel_net *itn = net_generic(net, ipip_net_id);
d979e3037463d96 Alexander Lobakin  2022-05-04  219  	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
cfc7381b3002756 Alexei Starovoitov 2016-09-15  220  	struct metadata_dst *tun_dst = NULL;
^1da177e4c3f415 Linus Torvalds     2005-04-16  221  	struct ip_tunnel *tunnel;
3d7b46cd20e300b Pravin B Shelar    2013-06-17  222  	const struct iphdr *iph;
3c97af99a5aa17f Eric Dumazet       2010-09-27  223  
d979e3037463d96 Alexander Lobakin  2022-05-04  224  	__set_bit(IP_TUNNEL_NO_KEY_BIT, flags);
d979e3037463d96 Alexander Lobakin  2022-05-04  225  
3d7b46cd20e300b Pravin B Shelar    2013-06-17  226  	iph = ip_hdr(skb);
d979e3037463d96 Alexander Lobakin  2022-05-04  227  	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags, iph->saddr,
d979e3037463d96 Alexander Lobakin  2022-05-04  228  				  iph->daddr, 0);
fd58156e456d9f6 Pravin B Shelar    2013-03-25  229  	if (tunnel) {
1b69e7e6c4da1e8 Simon Horman       2016-07-07  230  		const struct tnl_ptk_info *tpi;
1b69e7e6c4da1e8 Simon Horman       2016-07-07  231  
1b69e7e6c4da1e8 Simon Horman       2016-07-07  232  		if (tunnel->parms.iph.protocol != ipproto &&
1b69e7e6c4da1e8 Simon Horman       2016-07-07  233  		    tunnel->parms.iph.protocol != 0)
1b69e7e6c4da1e8 Simon Horman       2016-07-07  234  			goto drop;
1b69e7e6c4da1e8 Simon Horman       2016-07-07  235  
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  236  		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  237  			goto drop;
1b69e7e6c4da1e8 Simon Horman       2016-07-07  238  #if IS_ENABLED(CONFIG_MPLS)
1b69e7e6c4da1e8 Simon Horman       2016-07-07  239  		if (ipproto == IPPROTO_MPLS)
1b69e7e6c4da1e8 Simon Horman       2016-07-07  240  			tpi = &mplsip_tpi;
1b69e7e6c4da1e8 Simon Horman       2016-07-07  241  		else
1b69e7e6c4da1e8 Simon Horman       2016-07-07  242  #endif
1b69e7e6c4da1e8 Simon Horman       2016-07-07  243  			tpi = &ipip_tpi;
1b69e7e6c4da1e8 Simon Horman       2016-07-07  244  		if (iptunnel_pull_header(skb, 0, tpi->proto, false))
737e828bdbdaf2f Li Hongjun         2013-08-28  245  			goto drop;
cfc7381b3002756 Alexei Starovoitov 2016-09-15  246  		if (tunnel->collect_md) {
cfc7381b3002756 Alexei Starovoitov 2016-09-15 @247  			tun_dst = ip_tun_rx_dst(skb, 0, 0, 0);
cfc7381b3002756 Alexei Starovoitov 2016-09-15  248  			if (!tun_dst)
cfc7381b3002756 Alexei Starovoitov 2016-09-15  249  				return 0;
cfc7381b3002756 Alexei Starovoitov 2016-09-15  250  		}
7ad136fd288c0e0 Guillaume Nault    2021-06-25  251  		skb_reset_mac_header(skb);
7ad136fd288c0e0 Guillaume Nault    2021-06-25  252  
cfc7381b3002756 Alexei Starovoitov 2016-09-15  253  		return ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
^1da177e4c3f415 Linus Torvalds     2005-04-16  254  	}
^1da177e4c3f415 Linus Torvalds     2005-04-16  255  
^1da177e4c3f415 Linus Torvalds     2005-04-16  256  	return -1;
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  257  
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  258  drop:
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  259  	kfree_skb(skb);
eccc1bb8d4b4cf6 stephen hemminger  2012-09-25  260  	return 0;
^1da177e4c3f415 Linus Torvalds     2005-04-16  261  }
^1da177e4c3f415 Linus Torvalds     2005-04-16  262  

:::::: The code at line 247 was first introduced by commit
:::::: cfc7381b3002756b1dcada32979e942aa3126e31 ip_tunnel: add collect_md mode to IPIP tunnel

:::::: TO: Alexei Starovoitov <ast@fb.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
