Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1271495C16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAUIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:39:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:22175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbiAUIjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642754383; x=1674290383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RS7d/rieKW2hBYhX4fSMxivDzOWRJaytbe7/otmfuWs=;
  b=VkdtuWuhNhsKWHe/fsgprvlT0ER+e69PJ0pSGnaFkUHsQpDZ9mjgI1co
   tX2SVAz2L1lB+BHER0u7dUyhppwGjx2gSzhLLS8I94AZM6uYFG8yCPPJJ
   bYxdSzzuwBQmKVY66+7Ghv8zmB6Fe05kTrlVnu4P0xrjUAn5oVRoOVFGs
   YeJH4Ifm5U9113Q0tPw8yRl9GuJ2ud4XnnB32adwoEukJDV4OJDivC5S5
   99uwVD2GHZThUyEZAYye/46mvaV0Zu8c0foFIQf04g/aEkf7EOFCB5saF
   XGJu+AWsp+14efJp0GJhd/geaXGTu602TeZclyc8k2UHR3ZZJ7F2Kyocy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="270021419"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="270021419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="626664541"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 00:39:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nApSM-000F7S-Ta; Fri, 21 Jan 2022 08:39:38 +0000
Date:   Fri, 21 Jan 2022 16:39:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
        arei.gonglei@huawei.com
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201211638.IIpjX8Kd-lkp@intel.com>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220121/202201211638.IIpjX8Kd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: sparse: sparse: symbol 'virtio_crypto_rsa_do_req' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
