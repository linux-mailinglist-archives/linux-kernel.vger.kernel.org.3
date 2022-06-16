Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCC54E61E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377961AbiFPPbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377940AbiFPPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:31:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724D4132A;
        Thu, 16 Jun 2022 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655393466; x=1686929466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wj9r9CuSdiIkzUo1Tfr3bxXXszNFSDpXmy9xq7XvWus=;
  b=jYP7TjveHEazgpWSAjag//eX8xbaBVerWqUJD25kFVOU1zhq/pxXuWns
   36hNE7cbblc9jewklAG0A9X4dNABEg6JPH/ebv/wlVE99Vj+f1g1M6D3G
   ElVgWJXRanE7uF2PD1kFjwgqLPurHXRc2EzLGaMK2fL5ji2d5qZMas+JX
   sWIcjg8qDzxlnKbS2PXGvc7OdFJ3zKc8GNwRL1tAK+PtXqaECpysLGktd
   DPS74F8KJJn13JuB81uRt7QbcK190NjLqB6zfD27fnPGxN0fh6kt8SrxN
   tMg3KRgZjxT92PlOt2ilT2v//OahtkUql0wf+Fdscg0DtJmCnvsEwmYLx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279989356"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="279989356"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="762897900"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 08:31:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1rSZ-000OUj-RM;
        Thu, 16 Jun 2022 15:31:03 +0000
Date:   Thu, 16 Jun 2022 23:30:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     kbuild-all@lists.01.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] selinux: Let the caller free the momory in
 *mnt_opts on error
Message-ID: <202206162324.W061Fv9o-lkp@intel.com>
References: <20220616115052.221803-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616115052.221803-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220616]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiu-Jianfeng/selinux-Let-the-caller-free-the-momory-in-mnt_opts-on-error/20220616-195514
base:    c6d7e3b385f19869ab96e9404c92ff1abc34f2c8
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162324.W061Fv9o-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ea1d224d611591b835ce446dea3e769eb2d5492f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiu-Jianfeng/selinux-Let-the-caller-free-the-momory-in-mnt_opts-on-error/20220616-195514
        git checkout ea1d224d611591b835ce446dea3e769eb2d5492f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   security/selinux/hooks.c:951: warning: Function parameter or member 'token' not described in 'selinux_add_opt'
   security/selinux/hooks.c:951: warning: Function parameter or member 's' not described in 'selinux_add_opt'
   security/selinux/hooks.c:951: warning: Function parameter or member 'mnt_opts' not described in 'selinux_add_opt'
>> security/selinux/hooks.c:951: warning: expecting prototype for NOTE(). Prototype was for selinux_add_opt() instead


vim +951 security/selinux/hooks.c

^1da177e4c3f41 Linus Torvalds   2005-04-16   946  
ea1d224d611591 Xiu Jianfeng     2022-06-16   947  /**
ea1d224d611591 Xiu Jianfeng     2022-06-16   948   * NOTE: the caller is resposible for freeing the memory even if on error.
ea1d224d611591 Xiu Jianfeng     2022-06-16   949   */
ba6418623385ab Al Viro          2018-12-14   950  static int selinux_add_opt(int token, const char *s, void **mnt_opts)
^1da177e4c3f41 Linus Torvalds   2005-04-16  @951  {
bd3236557bb256 Al Viro          2018-12-13   952  	struct selinux_mnt_opts *opts = *mnt_opts;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   953  	u32 *dst_sid;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   954  	int rc;
c9180a57a9ab2d Eric Paris       2007-11-30   955  
6cd9d4b9789156 Paul Moore       2021-12-21   956  	if (token == Opt_seclabel)
6cd9d4b9789156 Paul Moore       2021-12-21   957  		/* eaten and completely ignored */
169d68efb03b72 Al Viro          2018-12-14   958  		return 0;
2e08df3c7c4e4e Bernard Zhao     2021-12-10   959  	if (!s)
ea1d224d611591 Xiu Jianfeng     2022-06-16   960  		return -EINVAL;
c9180a57a9ab2d Eric Paris       2007-11-30   961  
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   962  	if (!selinux_initialized(&selinux_state)) {
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   963  		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   964  		return -EINVAL;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   965  	}
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   966  
bd3236557bb256 Al Viro          2018-12-13   967  	if (!opts) {
6cd9d4b9789156 Paul Moore       2021-12-21   968  		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
bd3236557bb256 Al Viro          2018-12-13   969  		if (!opts)
bd3236557bb256 Al Viro          2018-12-13   970  			return -ENOMEM;
ba6418623385ab Al Viro          2018-12-14   971  		*mnt_opts = opts;
bd3236557bb256 Al Viro          2018-12-13   972  	}
2e08df3c7c4e4e Bernard Zhao     2021-12-10   973  
c9180a57a9ab2d Eric Paris       2007-11-30   974  	switch (token) {
c9180a57a9ab2d Eric Paris       2007-11-30   975  	case Opt_context:
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   976  		if (opts->context_sid || opts->defcontext_sid)
6cd9d4b9789156 Paul Moore       2021-12-21   977  			goto err;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   978  		dst_sid = &opts->context_sid;
c9180a57a9ab2d Eric Paris       2007-11-30   979  		break;
c9180a57a9ab2d Eric Paris       2007-11-30   980  	case Opt_fscontext:
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   981  		if (opts->fscontext_sid)
6cd9d4b9789156 Paul Moore       2021-12-21   982  			goto err;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   983  		dst_sid = &opts->fscontext_sid;
c9180a57a9ab2d Eric Paris       2007-11-30   984  		break;
c9180a57a9ab2d Eric Paris       2007-11-30   985  	case Opt_rootcontext:
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   986  		if (opts->rootcontext_sid)
6cd9d4b9789156 Paul Moore       2021-12-21   987  			goto err;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   988  		dst_sid = &opts->rootcontext_sid;
c9180a57a9ab2d Eric Paris       2007-11-30   989  		break;
c9180a57a9ab2d Eric Paris       2007-11-30   990  	case Opt_defcontext:
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   991  		if (opts->context_sid || opts->defcontext_sid)
6cd9d4b9789156 Paul Moore       2021-12-21   992  			goto err;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   993  		dst_sid = &opts->defcontext_sid;
11689d47f09571 David P. Quigley 2009-01-16   994  		break;
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   995  	default:
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   996  		WARN_ON(1);
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   997  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16   998  	}
70f4169ab421b2 Ondrej Mosnacek  2022-02-02   999  	rc = security_context_str_to_sid(&selinux_state, s, dst_sid, GFP_KERNEL);
70f4169ab421b2 Ondrej Mosnacek  2022-02-02  1000  	if (rc)
70f4169ab421b2 Ondrej Mosnacek  2022-02-02  1001  		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
70f4169ab421b2 Ondrej Mosnacek  2022-02-02  1002  			s, rc);
70f4169ab421b2 Ondrej Mosnacek  2022-02-02  1003  	return rc;
e2e0e09758a6f7 Gen Zhang        2019-06-12  1004  
6cd9d4b9789156 Paul Moore       2021-12-21  1005  err:
ba6418623385ab Al Viro          2018-12-14  1006  	pr_warn(SEL_MOUNT_FAIL_MSG);
ba6418623385ab Al Viro          2018-12-14  1007  	return -EINVAL;
e0007529893c1c Eric Paris       2008-03-05  1008  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  1009  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
