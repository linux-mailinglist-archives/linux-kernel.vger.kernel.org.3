Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BE477563
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhLPPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:08:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:22953 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238287AbhLPPIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639667289; x=1671203289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ija0ZVC63d5tmY1UacmgKZZnP8TFRkHeWivJpLv4MTQ=;
  b=niZhWvmCrI90lSUea1Z9Z9djJmg655l7kLqtbs+X7udNPW18LcCi8tHV
   2FOAof7IBeZR7qTCx1jKm+CuxjhIcJnL63VXre4dBztvcpQu9Bnbu47wI
   PH7YjWrtVww3GVsMtPnvxPeoLX56HScJ/eKRAdSh3DvGrRwMOC4wErOij
   H3vY8nwTf1C2pJJ8JlfGola3TWmmYxw/7X2rU9b3j2i/KsUqWo/awTOOV
   62vBntYjVIqotHXGxaO/k6S+VnWEp6OJm9jySfh7idLgS4O8Wl+9Xs8+p
   qHOzEbB0JuAdMWXqBgh53RNQZ2Pn4h2daXYu6KI9NMlRUmjjTEghF50+u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219528824"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219528824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 07:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="482854504"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2021 07:07:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxsLb-0003NC-RQ; Thu, 16 Dec 2021 15:07:07 +0000
Date:   Thu, 16 Dec 2021 23:06:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 2/2] mm: reimplement si_mem_available()
Message-ID: <202112162327.HwWtuYUQ-lkp@intel.com>
References: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on driver-core/driver-core-testing linux/master linus/master v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qi-Zheng/add-MemAvailable-to-per-node-meminfo/20211216-204828
base:   https://github.com/hnaz/linux-mm master
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211216/202112162327.HwWtuYUQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/7980664f23d619d15a3931fe1ab7d1dbafad7c88
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qi-Zheng/add-MemAvailable-to-per-node-meminfo/20211216-204828
        git checkout 7980664f23d619d15a3931fe1ab7d1dbafad7c88
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: mm/page_alloc.o: in function `si_mem_available':
>> page_alloc.c:(.text+0x3083): undefined reference to `si_meminfo_node'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
