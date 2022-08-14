Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADA3591F98
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiHNK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHNK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:56:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF219287
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660474612; x=1692010612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ngTkddyQQ57/5OaOn5jKaDO5NfEW+AQbExsQ+8fuv0k=;
  b=nw4rr2wf8sdXpDgir75Lw/rULrtGV+AcrNQeR1Cx1uY5s/hOMBVqmxEL
   //YUfNDHMDF9Nxss+irGjpGK/fIelQ900TAMRVvPkZy7iC8FF5jxGUapq
   cTIBKJZmzOToTYx8sU0kxUarDuGTEkCvcC8lUKmhP5k09B6x3o7+Yfc4i
   gIpQvo4bQLpWyAt7PmsLJ1LIh6GWyGoBiNRQV9bzpsoCErHCy9wPDdVNI
   GIzr+eF89RenA2Mmm7U2OJRyNfy37/jsCuo4pE3OujGL0IGkcK49gRpnq
   eJCucD13jjzXyDFoq7Ytpn4FdhqJucDosM8Vu/EDx6jZ1sdwY1NiKR40/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291815162"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291815162"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 03:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934193450"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 03:56:50 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNBIX-0002mF-2X;
        Sun, 14 Aug 2022 10:56:49 +0000
Date:   Sun, 14 Aug 2022 18:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:ip_tunnel 31/36] net/ipv4/ip_tunnel_core.c:151:51: sparse:
 sparse: Using plain integer as NULL pointer
Message-ID: <202208141847.or6l2m39-lkp@intel.com>
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
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220814/202208141847.or6l2m39-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/ip_tunnel_core.c:151:51: sparse: sparse: Using plain integer as NULL pointer

vim +151 net/ipv4/ip_tunnel_core.c

2d26f0a3c0e22f Eric Dumazet      2013-10-19  124  
63d008a4e9ee86 Jiri Benc         2015-09-22  125  struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
63d008a4e9ee86 Jiri Benc         2015-09-22  126  					     gfp_t flags)
63d008a4e9ee86 Jiri Benc         2015-09-22  127  {
63d008a4e9ee86 Jiri Benc         2015-09-22  128  	struct metadata_dst *res;
63d008a4e9ee86 Jiri Benc         2015-09-22  129  	struct ip_tunnel_info *dst, *src;
63d008a4e9ee86 Jiri Benc         2015-09-22  130  
3fcece12bc1b6d Jakub Kicinski    2017-06-23  131  	if (!md || md->type != METADATA_IP_TUNNEL ||
3fcece12bc1b6d Jakub Kicinski    2017-06-23  132  	    md->u.tun_info.mode & IP_TUNNEL_INFO_TX)
63d008a4e9ee86 Jiri Benc         2015-09-22  133  		return NULL;
63d008a4e9ee86 Jiri Benc         2015-09-22  134  
f52f11ec8ad49f Xin Long          2019-11-06  135  	src = &md->u.tun_info;
f52f11ec8ad49f Xin Long          2019-11-06  136  	res = metadata_dst_alloc(src->options_len, METADATA_IP_TUNNEL, flags);
63d008a4e9ee86 Jiri Benc         2015-09-22  137  	if (!res)
63d008a4e9ee86 Jiri Benc         2015-09-22  138  		return NULL;
63d008a4e9ee86 Jiri Benc         2015-09-22  139  
63d008a4e9ee86 Jiri Benc         2015-09-22  140  	dst = &res->u.tun_info;
63d008a4e9ee86 Jiri Benc         2015-09-22  141  	dst->key.tun_id = src->key.tun_id;
63d008a4e9ee86 Jiri Benc         2015-09-22  142  	if (src->mode & IP_TUNNEL_INFO_IPV6)
63d008a4e9ee86 Jiri Benc         2015-09-22  143  		memcpy(&dst->key.u.ipv6.dst, &src->key.u.ipv6.src,
63d008a4e9ee86 Jiri Benc         2015-09-22  144  		       sizeof(struct in6_addr));
63d008a4e9ee86 Jiri Benc         2015-09-22  145  	else
63d008a4e9ee86 Jiri Benc         2015-09-22  146  		dst->key.u.ipv4.dst = src->key.u.ipv4.src;
d979e3037463d9 Alexander Lobakin 2022-05-04  147  	bitmap_copy(dst->key.tun_flags, src->key.tun_flags,
d979e3037463d9 Alexander Lobakin 2022-05-04  148  		    __IP_TUNNEL_FLAG_NUM);
63d008a4e9ee86 Jiri Benc         2015-09-22  149  	dst->mode = src->mode | IP_TUNNEL_INFO_TX;
f52f11ec8ad49f Xin Long          2019-11-06  150  	ip_tunnel_info_opts_set(dst, ip_tunnel_info_opts(src),
f52f11ec8ad49f Xin Long          2019-11-06 @151  				src->options_len, 0);
63d008a4e9ee86 Jiri Benc         2015-09-22  152  
63d008a4e9ee86 Jiri Benc         2015-09-22  153  	return res;
63d008a4e9ee86 Jiri Benc         2015-09-22  154  }
63d008a4e9ee86 Jiri Benc         2015-09-22  155  EXPORT_SYMBOL_GPL(iptunnel_metadata_reply);
63d008a4e9ee86 Jiri Benc         2015-09-22  156  

:::::: The code at line 151 was first introduced by commit
:::::: f52f11ec8ad49f697e5158ff87c39b44dab45f51 lwtunnel: add options process for arp request

:::::: TO: Xin Long <lucien.xin@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
