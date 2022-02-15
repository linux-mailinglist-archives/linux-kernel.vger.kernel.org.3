Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B654F4B7621
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbiBOTEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbiBOTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:04:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD034F9541;
        Tue, 15 Feb 2022 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644951850; x=1676487850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OY5rlKrPl7iXMWmlVQVIRd4Ut3dm2c9g9Y247Vf0NLE=;
  b=mbdBiv2fguhDFcdzPUSaiodaaHimArqz8k9ixMGfhPX9dT8hiNSK9A35
   +D8SW8JTkQ3BCs8KCrxbY7zv4QU2Dr+pVST/v+VH5Kih8AsG8pkYFmTmX
   09HuXPHkk+SopwueXtvIEKS7OvrVuS0173Ut0MPkKchIn35ari4iFcLoE
   EUkZiZRh/U9qx8YzKvG9jUOJgnKXulYK6AMo5ZNsvB+eulvipqEpyQBrL
   N3Ei+C5goajidTGNdVUT2gwapSShOk4qEHTfotu1os7bpGVFsbaxOjmrH
   G/JE4UnKpTH4nduMeb6ZEQCVYpAaMployKG1VKtFWn1ZMExFttJNHNkz5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="233974166"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="233974166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497393288"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 11:04:08 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK37K-0009ww-M0; Tue, 15 Feb 2022 19:04:02 +0000
Date:   Wed, 16 Feb 2022 03:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 1/1] crypto: cavium/nitrox - don't cast parameter in
 bit operations
Message-ID: <202202160202.jG0FQRzi-lkp@intel.com>
References: <20220215160641.51683-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215160641.51683-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linux/master linus/master v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/crypto-cavium-nitrox-don-t-cast-parameter-in-bit-operations/20220216-000941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220216/202202160202.jG0FQRzi-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/51e27f6f33d377023ec5e097d18acb18f992f551
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/crypto-cavium-nitrox-don-t-cast-parameter-in-bit-operations/20220216-000941
        git checkout 51e27f6f33d377023ec5e097d18acb18f992f551
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/crypto/cavium/nitrox/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/crypto/cavium/nitrox/nitrox_mbx.c: In function 'nitrox_pf2vf_mbox_handler':
   drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:9: error: implicit declaration of function 'DEFINE_BITMAP'; did you mean 'DEFINE_IDA'? [-Werror=implicit-function-declaration]
     126 |         DEFINE_BITMAP(csr, 64);
         |         ^~~~~~~~~~~~~
         |         DEFINE_IDA
   drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:23: error: 'csr' undeclared (first use in this function)
     126 |         DEFINE_BITMAP(csr, 64);
         |                       ^~~
   drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:23: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/crypto/cavium/nitrox/nitrox_mbx.c:127:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     127 |         u64 value, reg_addr;
         |         ^~~
   cc1: some warnings being treated as errors


vim +127 drivers/crypto/cavium/nitrox/nitrox_mbx.c

cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  121  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  122  void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  123  {
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  124  	struct nitrox_vfdev *vfdev;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  125  	struct pf2vf_work *pfwork;
51e27f6f33d377 Andy Shevchenko   2022-02-15  126  	DEFINE_BITMAP(csr, 64);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04 @127  	u64 value, reg_addr;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  128  	u32 i;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  129  	int vfno;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  130  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  131  	/* loop for VF(0..63) */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  132  	reg_addr = NPS_PKT_MBOX_INT_LO;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  133  	value = nitrox_read_csr(ndev, reg_addr);
51e27f6f33d377 Andy Shevchenko   2022-02-15  134  	bitmap_from_u64(csr, value);
51e27f6f33d377 Andy Shevchenko   2022-02-15  135  	for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  136  		/* get the vfno from ring */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  137  		vfno = RING_TO_VFNO(i, ndev->iov.max_vf_queues);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  138  		vfdev = ndev->iov.vfdev + vfno;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  139  		vfdev->ring = i;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  140  		/* fill the vf mailbox data */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  141  		vfdev->msg.value = pf2vf_read_mbox(ndev, vfdev->ring);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  142  		pfwork = kzalloc(sizeof(*pfwork), GFP_ATOMIC);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  143  		if (!pfwork)
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  144  			continue;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  145  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  146  		pfwork->vfdev = vfdev;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  147  		pfwork->ndev = ndev;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  148  		INIT_WORK(&pfwork->pf2vf_resp, pf2vf_resp_handler);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  149  		queue_work(ndev->iov.pf2vf_wq, &pfwork->pf2vf_resp);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  150  		/* clear the corresponding vf bit */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  151  		nitrox_write_csr(ndev, reg_addr, BIT_ULL(i));
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  152  	}
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  153  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  154  	/* loop for VF(64..127) */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  155  	reg_addr = NPS_PKT_MBOX_INT_HI;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  156  	value = nitrox_read_csr(ndev, reg_addr);
51e27f6f33d377 Andy Shevchenko   2022-02-15  157  	bitmap_from_u64(csr, value);
51e27f6f33d377 Andy Shevchenko   2022-02-15  158  	for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  159  		/* get the vfno from ring */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  160  		vfno = RING_TO_VFNO(i + 64, ndev->iov.max_vf_queues);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  161  		vfdev = ndev->iov.vfdev + vfno;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  162  		vfdev->ring = (i + 64);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  163  		/* fill the vf mailbox data */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  164  		vfdev->msg.value = pf2vf_read_mbox(ndev, vfdev->ring);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  165  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  166  		pfwork = kzalloc(sizeof(*pfwork), GFP_ATOMIC);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  167  		if (!pfwork)
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  168  			continue;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  169  
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  170  		pfwork->vfdev = vfdev;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  171  		pfwork->ndev = ndev;
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  172  		INIT_WORK(&pfwork->pf2vf_resp, pf2vf_resp_handler);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  173  		queue_work(ndev->iov.pf2vf_wq, &pfwork->pf2vf_resp);
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  174  		/* clear the corresponding vf bit */
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  175  		nitrox_write_csr(ndev, reg_addr, BIT_ULL(i));
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  176  	}
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  177  }
cf718eaa8f9b2c Srikanth, Jampala 2018-12-04  178  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
