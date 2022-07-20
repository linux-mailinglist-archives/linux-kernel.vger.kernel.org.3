Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCD57BB77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGTQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:37:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643A52DD5;
        Wed, 20 Jul 2022 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658335020; x=1689871020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OIDH+HrZlHRBE1ZuSvOPWqWqsoLOZVIP03udR607o7E=;
  b=DmZ+PHmKXvhWRCuGctaxmCh9Y/CDyT8qR462OsG6SYoxc+7lejr0OWhk
   QTM6ySXQ0haIKvtVpyfpWzFWlMaxoUFMi15l8DqkbSo4ao7jqURjPkBRd
   N1gkQAMEEgF7ug6i9coXJlrIVISkOmGpvNL2sGITV02KCixImclNyVbaM
   OYezlyJDRLRePDLnruSUki0wY3ohN/3aVYbyXaC5oxLBtL4VyjZW3XoUL
   nh8sU/YYG4LL0u9YtLRFg7YqKIFZSSRdBuvtyB0mcVRPC/ER4Tr50fC5P
   aTFNWWCsqhpvorOgce9Jf8qv8p3Os41pq8dJ7MHWOjSP7EjTz1/sOH0Me
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="350817090"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="350817090"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665929373"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 09:36:54 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oECgv-0000iP-Sz;
        Wed, 20 Jul 2022 16:36:53 +0000
Date:   Thu, 21 Jul 2022 00:36:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, beanhuo@micron.com,
        quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Message-ID: <202207210049.FUSfJIAA-lkp@intel.com>
References: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,

I love your patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next next-20220720]
[cannot apply to linus/master v5.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Can-Guo/UFS-Multi-Circular-Queue-MCQ/20220719-150436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-a005-20220718 (https://download.01.org/0day-ci/archive/20220721/202207210049.FUSfJIAA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dd5635541cd7bbd62cd59b6694dfb759b6e9a0d8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b7356bcd24efd2d6b69f04dd9fd010c4256cc7e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Can-Guo/UFS-Multi-Circular-Queue-MCQ/20220719-150436
        git checkout 2b7356bcd24efd2d6b69f04dd9fd010c4256cc7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ufs/core/ufs-mcq.c:275:4: error: call to undeclared function 'devm_iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           devm_iounmap(hba->dev, res->base);
                           ^
   1 error generated.


vim +/devm_iounmap +275 drivers/ufs/core/ufs-mcq.c

   265	
   266	static void ufshcd_mcq_release_resource(struct ufs_hba *hba)
   267	{
   268		struct ufshcd_res_info_t *res;
   269		int i;
   270	
   271		for (i = RES_MCQ; i < RES_MAX; i++) {
   272			res = &hba->res[i];
   273	
   274			if(res->base) {
 > 275				devm_iounmap(hba->dev, res->base);
   276				res->base = NULL;
   277			}
   278	
   279			if (res->is_alloc)
   280				devm_kfree(hba->dev, res->resource);
   281		}
   282	}
   283	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
