Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA015885B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiHCCTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:19:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC23A54AC7;
        Tue,  2 Aug 2022 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659493186; x=1691029186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPHASRO1Q4mcyIgeegJjXVGGp5M+MrqmwUvQvwVQFrU=;
  b=HS4bQLnDBc0v7DAZ56YFIAj1zmLDUYZQiKyg1kbCFFoODlXJigg/WUEy
   tHqYGqvbeJjIe7jFza5lbt0jcjci5LyNkPpfDnfKnBKYMilRsH8NIfkSh
   bpPhdt1/d3oZVYh64IDLUH/jnCcaJoR6SsjnM0PNf+8yF6D+THUFPoUK4
   VrtIhMMnzE8hwgcKa1Cj/et7nAI21C+My8NTQJS5IHgSvrkF3T2NWIUdf
   18XK2twPxa+vTLXsvOm83TUL54oMd+86iLVG1xvAsA1CYUzuLTRuf2FZS
   BZTIWp5bLrMd4ZRpaK/C7xYpPNeYD2hHZ1Gghq4nMzK8CkXtO8tPOGlD1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272611473"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="272611473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="630959183"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2022 19:19:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ3z4-000Ggt-27;
        Wed, 03 Aug 2022 02:19:42 +0000
Date:   Wed, 3 Aug 2022 10:19:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     kbuild-all@lists.01.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Subject: Re: [PATCH 2/2] crypto: ccp - Fail the PSP initialization when
 writing psp data file failed
Message-ID: <202208031012.z1rYKkYA-lkp@intel.com>
References: <20220802185534.735338-3-jackyli@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802185534.735338-3-jackyli@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master kvm/queue linus/master v5.19 next-20220802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Li/Improve-error-handling-during-INIT_EX-file-initialization/20220803-025617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220803/202208031012.z1rYKkYA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3c3fe5b1821e961cbfe1f3724a5256e6e04bbe92
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacky-Li/Improve-error-handling-during-INIT_EX-file-initialization/20220803-025617
        git checkout 3c3fe5b1821e961cbfe1f3724a5256e6e04bbe92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/crypto/ccp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/crypto/ccp/psp-dev.h:13,
                    from drivers/crypto/ccp/sev-dev.c:30:
   drivers/crypto/ccp/sev-dev.c: In function 'sev_write_init_ex_file':
>> drivers/crypto/ccp/sev-dev.c:252:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
     252 |                         "SEV: could not open file for write, error %ld\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/crypto/ccp/sev-dev.c:251:17: note: in expansion of macro 'dev_err'
     251 |                 dev_err(sev->dev,
         |                 ^~~~~~~
   drivers/crypto/ccp/sev-dev.c:252:70: note: format string is defined here
     252 |                         "SEV: could not open file for write, error %ld\n",
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long int
         |                                                                    %d


vim +252 drivers/crypto/ccp/sev-dev.c

3d725965f836a7a David Rientjes 2021-12-07  235  
3c3fe5b1821e961 Jacky Li       2022-08-02  236  static int sev_write_init_ex_file(void)
3d725965f836a7a David Rientjes 2021-12-07  237  {
3d725965f836a7a David Rientjes 2021-12-07  238  	struct sev_device *sev = psp_master->sev_data;
3d725965f836a7a David Rientjes 2021-12-07  239  	struct file *fp;
3d725965f836a7a David Rientjes 2021-12-07  240  	loff_t offset = 0;
3d725965f836a7a David Rientjes 2021-12-07  241  	ssize_t nwrite;
3d725965f836a7a David Rientjes 2021-12-07  242  
3d725965f836a7a David Rientjes 2021-12-07  243  	lockdep_assert_held(&sev_cmd_mutex);
3d725965f836a7a David Rientjes 2021-12-07  244  
3d725965f836a7a David Rientjes 2021-12-07  245  	if (!sev_init_ex_buffer)
3c3fe5b1821e961 Jacky Li       2022-08-02  246  		return 0;
3d725965f836a7a David Rientjes 2021-12-07  247  
05def5cacfa0bd5 Jacky Li       2022-04-14  248  	fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
3d725965f836a7a David Rientjes 2021-12-07  249  	if (IS_ERR(fp)) {
3c3fe5b1821e961 Jacky Li       2022-08-02  250  		int ret = PTR_ERR(fp);
3d725965f836a7a David Rientjes 2021-12-07  251  		dev_err(sev->dev,
3d725965f836a7a David Rientjes 2021-12-07 @252  			"SEV: could not open file for write, error %ld\n",
3c3fe5b1821e961 Jacky Li       2022-08-02  253  			ret);
3c3fe5b1821e961 Jacky Li       2022-08-02  254  		return ret;
3d725965f836a7a David Rientjes 2021-12-07  255  	}
3d725965f836a7a David Rientjes 2021-12-07  256  
3d725965f836a7a David Rientjes 2021-12-07  257  	nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
3d725965f836a7a David Rientjes 2021-12-07  258  	vfs_fsync(fp, 0);
3d725965f836a7a David Rientjes 2021-12-07  259  	filp_close(fp, NULL);
3d725965f836a7a David Rientjes 2021-12-07  260  
3d725965f836a7a David Rientjes 2021-12-07  261  	if (nwrite != NV_LENGTH) {
3d725965f836a7a David Rientjes 2021-12-07  262  		dev_err(sev->dev,
3d725965f836a7a David Rientjes 2021-12-07  263  			"SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
3d725965f836a7a David Rientjes 2021-12-07  264  			NV_LENGTH, nwrite);
3c3fe5b1821e961 Jacky Li       2022-08-02  265  		return -EIO;
3d725965f836a7a David Rientjes 2021-12-07  266  	}
3d725965f836a7a David Rientjes 2021-12-07  267  
3d725965f836a7a David Rientjes 2021-12-07  268  	dev_dbg(sev->dev, "SEV: write successful to NV file\n");
3c3fe5b1821e961 Jacky Li       2022-08-02  269  
3c3fe5b1821e961 Jacky Li       2022-08-02  270  	return 0;
3d725965f836a7a David Rientjes 2021-12-07  271  }
3d725965f836a7a David Rientjes 2021-12-07  272  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
