Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D54B7822
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiBOUgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:36:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiBOUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:36:23 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01752D76E7;
        Tue, 15 Feb 2022 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644957372; x=1676493372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BRsO1OXc58Y4YpX42/iVa8NoeQ33hVpixGdTGcSifYA=;
  b=bw6gKlZqH8V1gSEOxV+Hh7vVu9osWm+xggC9h3X3DDbCluKky2s1F39w
   491wd/UTPsno2ReHtGBHripCR7rhARGXBoFHvR8TDcOH/CtMeeDncIg4X
   O9O+BKnAU61Mfx/V0ND8zsNzNQ5r95jpdTulE7FU+PSCNRn5ITABwEu/6
   pWl3n4/Hc2eo4D3hsa/x6A/QiQCjKw8OdskUJxQiRVWfZg/r6IH+VB6Z6
   D0p7BvVUbJln+jY3czLFfuNFB4l6n2T9UVJ8YOsFHLMUf63FzTUzSl0DC
   m0MWoH20wED1IzvgigrPGkuVNQDvsxOCPszZHpRjibzj6Zx6PawIRE9pA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311189333"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311189333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 12:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497465016"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 12:36:05 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK4YO-000A0L-Cq; Tue, 15 Feb 2022 20:36:04 +0000
Date:   Wed, 16 Feb 2022 04:35:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 1/1] crypto: cavium/nitrox - don't cast parameter in
 bit operations
Message-ID: <202202160443.hqpSAgbP-lkp@intel.com>
References: <20220215160641.51683-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215160641.51683-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linux/master linus/master v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/crypto-cavium-nitrox-don-t-cast-parameter-in-bit-operations/20220216-000941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220216/202202160443.hqpSAgbP-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/51e27f6f33d377023ec5e097d18acb18f992f551
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/crypto-cavium-nitrox-don-t-cast-parameter-in-bit-operations/20220216-000941
        git checkout 51e27f6f33d377023ec5e097d18acb18f992f551
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/crypto/cavium/nitrox/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/crypto/cavium/nitrox/nitrox_mbx.c: In function 'nitrox_pf2vf_mbox_handler':
>> drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:2: error: implicit declaration of function 'DEFINE_BITMAP'; did you mean 'DEFINE_TIMER'? [-Werror=implicit-function-declaration]
     126 |  DEFINE_BITMAP(csr, 64);
         |  ^~~~~~~~~~~~~
         |  DEFINE_TIMER
>> drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:16: error: 'csr' undeclared (first use in this function); did you mean 'msr'?
     126 |  DEFINE_BITMAP(csr, 64);
         |                ^~~
         |                msr
   drivers/crypto/cavium/nitrox/nitrox_mbx.c:126:16: note: each undeclared identifier is reported only once for each function it appears in
   drivers/crypto/cavium/nitrox/nitrox_mbx.c:127:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     127 |  u64 value, reg_addr;
         |  ^~~
   cc1: some warnings being treated as errors


vim +126 drivers/crypto/cavium/nitrox/nitrox_mbx.c

   121	
   122	void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
   123	{
   124		struct nitrox_vfdev *vfdev;
   125		struct pf2vf_work *pfwork;
 > 126		DEFINE_BITMAP(csr, 64);
   127		u64 value, reg_addr;
   128		u32 i;
   129		int vfno;
   130	
   131		/* loop for VF(0..63) */
   132		reg_addr = NPS_PKT_MBOX_INT_LO;
   133		value = nitrox_read_csr(ndev, reg_addr);
   134		bitmap_from_u64(csr, value);
   135		for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
   136			/* get the vfno from ring */
   137			vfno = RING_TO_VFNO(i, ndev->iov.max_vf_queues);
   138			vfdev = ndev->iov.vfdev + vfno;
   139			vfdev->ring = i;
   140			/* fill the vf mailbox data */
   141			vfdev->msg.value = pf2vf_read_mbox(ndev, vfdev->ring);
   142			pfwork = kzalloc(sizeof(*pfwork), GFP_ATOMIC);
   143			if (!pfwork)
   144				continue;
   145	
   146			pfwork->vfdev = vfdev;
   147			pfwork->ndev = ndev;
   148			INIT_WORK(&pfwork->pf2vf_resp, pf2vf_resp_handler);
   149			queue_work(ndev->iov.pf2vf_wq, &pfwork->pf2vf_resp);
   150			/* clear the corresponding vf bit */
   151			nitrox_write_csr(ndev, reg_addr, BIT_ULL(i));
   152		}
   153	
   154		/* loop for VF(64..127) */
   155		reg_addr = NPS_PKT_MBOX_INT_HI;
   156		value = nitrox_read_csr(ndev, reg_addr);
   157		bitmap_from_u64(csr, value);
   158		for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
   159			/* get the vfno from ring */
   160			vfno = RING_TO_VFNO(i + 64, ndev->iov.max_vf_queues);
   161			vfdev = ndev->iov.vfdev + vfno;
   162			vfdev->ring = (i + 64);
   163			/* fill the vf mailbox data */
   164			vfdev->msg.value = pf2vf_read_mbox(ndev, vfdev->ring);
   165	
   166			pfwork = kzalloc(sizeof(*pfwork), GFP_ATOMIC);
   167			if (!pfwork)
   168				continue;
   169	
   170			pfwork->vfdev = vfdev;
   171			pfwork->ndev = ndev;
   172			INIT_WORK(&pfwork->pf2vf_resp, pf2vf_resp_handler);
   173			queue_work(ndev->iov.pf2vf_wq, &pfwork->pf2vf_resp);
   174			/* clear the corresponding vf bit */
   175			nitrox_write_csr(ndev, reg_addr, BIT_ULL(i));
   176		}
   177	}
   178	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
