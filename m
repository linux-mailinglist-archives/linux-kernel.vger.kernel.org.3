Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAD46C541
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhLGVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:00:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:10648 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234641AbhLGVAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:00:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237493838"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237493838"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 12:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="679605087"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2021 12:57:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muhWT-000Mxw-Er; Tue, 07 Dec 2021 20:57:13 +0000
Date:   Wed, 8 Dec 2021 04:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 1/8] net/tls/ecdh.c:144:1: warning: no
 previous prototype for 'ttls_ecdh_read_params'
Message-ID: <202112080428.xNBYfZzC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   21c40b0003975c1afe4b59126aba2c547103ccae
commit: 674ca98f07d168e6fbeea6852b81d3536b26d864 [1/8] Port of Tempesta TLS handshakes to the Linux 5.10.68
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211208/202112080428.xNBYfZzC-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=674ca98f07d168e6fbeea6852b81d3536b26d864
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout 674ca98f07d168e6fbeea6852b81d3536b26d864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash net/sunrpc/ net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/tls/ecdh.c:144:1: warning: no previous prototype for 'ttls_ecdh_read_params' [-Wmissing-prototypes]
     144 | ttls_ecdh_read_params(TlsECDHCtx *ctx, const unsigned char **buf,
         | ^~~~~~~~~~~~~~~~~~~~~
--
>> net/tls/error.c:40:6: warning: no previous prototype for 'ttls_strerror' [-Wmissing-prototypes]
      40 | void ttls_strerror(int ret, char *buf, size_t buflen)
         |      ^~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS


vim +/ttls_ecdh_read_params +144 net/tls/ecdh.c

   135	
   136	/**
   137	 * Read the ServerKeyExhange parameters (RFC 8422 5.4)
   138	 *	struct {
   139	 *		ECParameters	curve_params;
   140	 *		ECPoint		public;
   141	 *	} ServerECDHParams;
   142	 */
   143	int
 > 144	ttls_ecdh_read_params(TlsECDHCtx *ctx, const unsigned char **buf,
   145			      const unsigned char *end)
   146	{
   147		int r;
   148	
   149		if (!(ctx->grp = ttls_ecp_tls_read_group(buf, end - *buf)))
   150			return -EINVAL;
   151	
   152		/*
   153		 * Import a point from a TLS ECPoint record (RFC 8443 5.4)
   154		 *	struct {
   155		 *		opaque point <1..2^8-1>;
   156		 *	} ECPoint;
   157		 */
   158		if (!(r = ttls_ecdh_read_public(ctx, *buf, end - *buf)))
   159			*buf += end - *buf;
   160	
   161		return r;
   162	}
   163	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
