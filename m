Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6846C02B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhLGQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:04:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:42160 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238825AbhLGQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:04:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298400934"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="298400934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 08:01:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461312003"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2021 08:01:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muctv-000MkV-4J; Tue, 07 Dec 2021 16:01:07 +0000
Date:   Wed, 8 Dec 2021 00:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?K=FChnel?= <thomas.kuehnel@avm.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?K=FChnel?= <thomas.kuehnel@avm.de>,
        Nicolas Schier <n.schier@avm.de>
Subject: Re: [PATCH 1/3] fs/ntfs3: fix endian conversion in ni_fname_name
Message-ID: <202112072356.fmLjngs7-lkp@intel.com>
References: <20211207102454.576906-2-thomas.kuehnel@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207102454.576906-2-thomas.kuehnel@avm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Thomas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1]

url:    https://github.com/0day-ci/linux/commits/Thomas-K-hnel/fs-ntfs3-Fixes-for-big-endian-systems/20211207-184206
base:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: arm64-randconfig-s031-20211207 (https://download.01.org/0day-ci/archive/20211207/202112072356.fmLjngs7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/d2fb837ced1828c5a57feac3690d3cc8a36b2fdc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Thomas-K-hnel/fs-ntfs3-Fixes-for-big-endian-systems/20211207-184206
        git checkout d2fb837ced1828c5a57feac3690d3cc8a36b2fdc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ntfs3/frecord.c:1615:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le16 const [usertype] *s1 @@     got unsigned short const * @@
   fs/ntfs3/frecord.c:1615:28: sparse:     expected restricted __le16 const [usertype] *s1
   fs/ntfs3/frecord.c:1615:28: sparse:     got unsigned short const *

vim +1615 fs/ntfs3/frecord.c

  1578	
  1579	/* ni_fname_name
  1580	 *
  1581	 * Return: File name attribute by its value.
  1582	 */
  1583	struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
  1584					     const struct cpu_str *uni,
  1585					     const struct MFT_REF *home_dir,
  1586					     struct mft_inode **mi,
  1587					     struct ATTR_LIST_ENTRY **le)
  1588	{
  1589		struct ATTRIB *attr = NULL;
  1590		struct ATTR_FILE_NAME *fname;
  1591		struct le_str *fns;
  1592	
  1593		*le = NULL;
  1594	
  1595		/* Enumerate all names. */
  1596	next:
  1597		attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, mi);
  1598		if (!attr)
  1599			return NULL;
  1600	
  1601		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
  1602		if (!fname)
  1603			goto next;
  1604	
  1605		if (home_dir && memcmp(home_dir, &fname->home, sizeof(*home_dir)))
  1606			goto next;
  1607	
  1608		if (!uni)
  1609			goto next;
  1610	
  1611		if (uni->len != fname->name_len)
  1612			goto next;
  1613	
  1614		fns = (struct le_str *)&fname->name_len;
> 1615		if (ntfs_cmp_names(uni->name, uni->len, fns->name, fns->len, NULL,
  1616				       false))
  1617			goto next;
  1618	
  1619		return fname;
  1620	}
  1621	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
