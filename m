Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FB496783
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiAUVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:44:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:17681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbiAUVoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642801448; x=1674337448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8p41zx7lhw7bUtkcYKDSxXkPejlpXaQYhHjrWI+euIg=;
  b=MXqpyPDIR91KhvvjRmuJYdCvNgyvA8k+8BoqfJ/wUenWm7O+nGfXldGf
   +9e/gde/SqahzC3ZLk2up9v4aL8hoy7wMizgKnZBua9lagTlfGISPMWJN
   Kj+UHMFbiYE1uXMRenk71Glrb/g08UM/B6w1g0Gfx2ce6KsXkhnTqxtZa
   H0fWB0yec3sqq+QBKeVi9nlIiAUWBaG36BWaLeRtSkBSjf4hSwMz5D3Hb
   se3ZAEJ7YT/4sv913Jmh3sP01o+2oPU5pPXmT/3FGaZ54ig4I39e7qYJ6
   xwAuKY0Brn1qCRr9N7gbX/wZNLZQTtJRYuxSyfm7uce9kCyN/pJnw4DeG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="233106510"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="233106510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 13:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="694779862"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 13:44:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB1hU-000Fgy-87; Fri, 21 Jan 2022 21:44:04 +0000
Date:   Sat, 22 Jan 2022 05:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
        arei.gonglei@huawei.com
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201220521.kldW6vYy-lkp@intel.com>
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
config: nios2-randconfig-c024-20220120 (https://download.01.org/0day-ci/archive/20220122/202201220521.kldW6vYy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/crypto/virtio/virtio_crypto_akcipher_algo.o: in function `virtio_crypto_rsa_set_key':
   virtio_crypto_akcipher_algo.c:(.text+0x4d4): undefined reference to `rsa_parse_priv_key'
   virtio_crypto_akcipher_algo.c:(.text+0x4d4): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_priv_key'
>> nios2-linux-ld: virtio_crypto_akcipher_algo.c:(.text+0x514): undefined reference to `rsa_parse_pub_key'
   virtio_crypto_akcipher_algo.c:(.text+0x514): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_pub_key'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
