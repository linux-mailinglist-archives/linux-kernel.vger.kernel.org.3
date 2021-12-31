Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CA482543
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhLaRJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:09:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:5867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhLaRJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640970544; x=1672506544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mDXZTBMOVLtUoZSEauTALat78Hj4BDtqet/RojZ9xSc=;
  b=RIOoI2f2ftqgLIR+77t6EMQfuppY9JWtFe8eVuiLORgzzmLAKG++XpNb
   ydz0KFxPUAQUq6Ds3He1xV+MX2qCAyQm1QjUxCyw+8RUMYpeZc7NbgSq2
   3OTiG3lj9T/6XLtdDQlDjQXlHOBF9jQ3RzEQuApi2fObVMsADIuq6+fMf
   usrW7F6PTktBG51JWz0weZwGBtVTrC87gH+ElODRDver+acwQEDoZ4qzd
   AeIJ6CjuBPnfIZJ6h1enx4hM1W6WEPG5LqqyjuVVpWln/TC8dVT+ump34
   wzcGu4bUpO1V8ZNiLBXzEgoKvyxXLL9z3KNLSwDHYSVrLY8ae9zF6WgOP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="221825323"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="221825323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 09:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="619676116"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 09:09:03 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3LOo-000BR3-EB; Fri, 31 Dec 2021 17:09:02 +0000
Date:   Sat, 1 Jan 2022 01:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [driver-core:debugfs_cleanup 4/5] fs/d_path.c:59 prepend() warn:
 unsigned 'p->len' is never less than zero.
Message-ID: <202201010156.bJvO7Gaw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
head:   a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
commit: e95d5bed5d58c2f5352969369827e7135fa2261e [4/5] fs: make d_path-like functions all have unsigned size
config: i386-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20220101/202201010156.bJvO7Gaw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
fs/d_path.c:59 prepend() warn: unsigned 'p->len' is never less than zero.

vim +59 fs/d_path.c

b0cfcdd9b9672e Linus Torvalds 2021-07-16  55  
b0cfcdd9b9672e Linus Torvalds 2021-07-16  56  static bool prepend(struct prepend_buffer *p, const char *str, int namelen)
b0cfcdd9b9672e Linus Torvalds 2021-07-16  57  {
b0cfcdd9b9672e Linus Torvalds 2021-07-16  58  	// Already overflowed?
b0cfcdd9b9672e Linus Torvalds 2021-07-16 @59  	if (p->len < 0)
b0cfcdd9b9672e Linus Torvalds 2021-07-16  60  		return false;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  61  
b0cfcdd9b9672e Linus Torvalds 2021-07-16  62  	// Will overflow?
b0cfcdd9b9672e Linus Torvalds 2021-07-16  63  	if (p->len < namelen) {
b0cfcdd9b9672e Linus Torvalds 2021-07-16  64  		// Fill as much as possible from the end of the name
b0cfcdd9b9672e Linus Torvalds 2021-07-16  65  		str += namelen - p->len;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  66  		p->buf -= p->len;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  67  		prepend_copy(p->buf, str, p->len);
b0cfcdd9b9672e Linus Torvalds 2021-07-16  68  		p->len = -1;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  69  		return false;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  70  	}
b0cfcdd9b9672e Linus Torvalds 2021-07-16  71  
b0cfcdd9b9672e Linus Torvalds 2021-07-16  72  	// Fits fully
ad08ae586586ea Al Viro        2021-05-12  73  	p->len -= namelen;
ad08ae586586ea Al Viro        2021-05-12  74  	p->buf -= namelen;
b0cfcdd9b9672e Linus Torvalds 2021-07-16  75  	return prepend_copy(p->buf, str, namelen);
7a5cf791a74764 Al Viro        2018-03-05  76  }
7a5cf791a74764 Al Viro        2018-03-05  77  

:::::: The code at line 59 was first introduced by commit
:::::: b0cfcdd9b9672ea90642f33d6c0dd8516553adf2 d_path: make 'prepend()' fill up the buffer exactly on overflow

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
