Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE454EFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiFQECc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiFQEC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:02:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9AB666A2;
        Thu, 16 Jun 2022 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655438548; x=1686974548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j5wLzy77/z/grAkh6Tlx6HTEGbcHtSNLg/CF7fdBZo0=;
  b=ONiALVnUtAYfmdJ7qX9T5xAnW1mljVUHU1yhlWwOtfMbzgkyhKRKW9le
   FqWyAq4bcvVpAOHzaVmBz8bjyuiZkvc1uCyqI7HZu8cZvqWagoeU4jOkZ
   SkrI0jnHxtDsMZT//BaUfpr7J4RM92jP2YiaroXnylY7Q8JAfTahkCR8Y
   liMp0JesEAb6h55jpLowa25qmdtnVoSKVBSqoAX01mYqQJA5rtDuayJY7
   QlO4Ae9oNIT3Et47zcW77zdeq/gLXPZVDzlJINack/Yxp4e13FI7ujeT7
   StQ9zSjSOw6LC0vaTusgDwQo6HcJNAdaGD2fPpw2ch3pWkNp0T7rxlOnM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304863528"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304863528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 21:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831868406"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 21:02:26 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o23Bh-000P33-SK;
        Fri, 17 Jun 2022 04:02:25 +0000
Date:   Fri, 17 Jun 2022 12:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kernel-team@cloudflare.com,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: [PATCH] crypto: rsa - implement Chinese Remainder Theorem for
 faster private key operations
Message-ID: <202206171143.kiPGMh0V-lkp@intel.com>
References: <20220616201550.1827-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616201550.1827-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ignat,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ignat-Korchagin/crypto-rsa-implement-Chinese-Remainder-Theorem-for-faster-private-key-operations/20220617-041735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220617/202206171143.kiPGMh0V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a81c4debaedb63c8b5af51564fdf596d560a23af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ignat-Korchagin/crypto-rsa-implement-Chinese-Remainder-Theorem-for-faster-private-key-operations/20220617-041735
        git checkout a81c4debaedb63c8b5af51564fdf596d560a23af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mpi_sub" [crypto/rsa_generic.ko] undefined!
>> ERROR: modpost: "mpi_mul" [crypto/rsa_generic.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
