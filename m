Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6F47C827
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhLUUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:15:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:3038 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhLUUPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640117717; x=1671653717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJvqQorkXrS87WtDhS0TzCOphESf+W3KbpYX/JmpUog=;
  b=D7ni8Q0J/SLr+0TRCfuGo/7UhoT9Q38XtjA/99k5oIl0fmjmfTuzuZQi
   JsiXPZRmOAO9i9vYqcXtPc37zpeMYlBwLNoMuy2q4S+4O0r96q+9lRJiX
   AG+ppUNnkQiYdE+Q48No+a9Hu1UTmT8Hy2+dzELGEz+fHHfELTxQPw3fu
   JSK7qC7SQf/Jefthv/Fs9G2n/qhlAk8g49kzXi7RhmDu79IMo2xN9rZoA
   bAoxmrF6Ont4aHYKCM8rt+L7XQYthZ5Er0+HdLcpKC8iX1AMvL/fYD/CO
   gqQY59l8jbqJpT8vdyTQOD+Xs1JzLq2h3WNKp6s+qPXKGrlTSce41Ex9e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220496182"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="220496182"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 12:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="616890631"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 12:15:15 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzlXW-0009VY-8b; Tue, 21 Dec 2021 20:15:14 +0000
Date:   Wed, 22 Dec 2021 04:14:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <202112220446.QXGU4ozn-lkp@intel.com>
References: <20211221175047.341782-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221175047.341782-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jason,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on char-misc/char-misc-testing herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v5.16-rc6 next-20211221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jason-A-Donenfeld/random-use-BLAKE2s-instead-of-SHA1-in-extraction/20211222-021452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20211222/202112220446.QXGU4ozn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/79f40c8f3c427b4f4819dca21ea159bc3c0350f0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jason-A-Donenfeld/random-use-BLAKE2s-instead-of-SHA1-in-extraction/20211222-021452
        git checkout 79f40c8f3c427b4f4819dca21ea159bc3c0350f0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: lib/crypto/blake2s.o: in function `blake2s_mod_init':
>> blake2s.c:(.init.text+0x1): undefined reference to `blake2s_selftest'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
