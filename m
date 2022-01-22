Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4153349689E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiAVAUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:20:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:6801 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbiAVAUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642810810; x=1674346810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0fDyxdfVfi2SI/BrQs2v6hQ87V3QCZvB7JxQD35k8k=;
  b=Fli4O6k5tXNkB98n7VWRXG87k9ve9lvOrJgtUryNkoy9XGdDW1t4ngIg
   UmUijdOLtV5o4PuZBPDAuEmehT27JKdYF/gj8gtpUswZorywwJ9gyuHnr
   XUq7eUgQ7eWtmmCq/zNKYWQXfGPn1Z7B/40yYQDfReuWzOVovl/a88Gm0
   lBcnhx8FAw5pGCLb6Lu36Dn5CHBpxx1Vm2CtWpFCObxViuQuX8A4z/O5C
   LiUmIsMmR7EGoIWb8s5wcr/Ac9mqjSN5e0KIk6haR2idxGrwfLI/PqI+9
   kyswrLg+NdELW8obDyqWfr6TfGp5b7hnImLlhKIWujyM7sq2nxWKcO85G
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245553996"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="245553996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="579771673"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2022 16:20:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB48V-000Fnm-1A; Sat, 22 Jan 2022 00:20:07 +0000
Date:   Sat, 22 Jan 2022 08:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
        arei.gonglei@huawei.com
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201220847.wXhZvj4G-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: mips-randconfig-r006-20220117 (https://download.01.org/0day-ci/archive/20220122/202201220847.wXhZvj4G-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: drivers/crypto/virtio/virtio_crypto_akcipher_algo.o: in function `virtio_crypto_rsa_set_key':
   virtio_crypto_akcipher_algo.c:(.text+0x5d8): undefined reference to `rsa_parse_priv_key'
>> mipsel-linux-ld: virtio_crypto_akcipher_algo.c:(.text+0x61c): undefined reference to `rsa_parse_pub_key'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
