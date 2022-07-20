Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2957B5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiGTLmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGTLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:42:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C3459B1;
        Wed, 20 Jul 2022 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658317361; x=1689853361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kan8sLYiHB+1kxmOtgHMUGFkI4Py16KnYnn3nVJ2gy0=;
  b=Q3eNQNVRDJvjL+ozNU5R3AMV0B8IM9u78DVxEyvpEOqfjrrHeXmMFj2o
   OY4nx67PciguCFEiQFRXb0gAYSxtUQJ8t5zoI+YgbaNDqsp0UMjqGMvzd
   57gw/R1UVL/Vy6MPngp1BQEkCo9bBoSptINt/TiC4kEsUOVwFhwHnhUDg
   LiFRAFYLySYHEkNquoX4lcWscx98gYmoV7qYJRkpMTHd443uYNUlYr4zV
   PS+Mc1lTZ6njfKnW/tH2V6nSQ0GwBcW9ST3m13grEHa++nZ5c0jQQvcmL
   8+FkvnphDJJ5WtPbfQ/EumZkNE468uJvXt0mXP7fX+CL9BsqKt179K65U
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="285520509"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="285520509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 04:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="595210140"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2022 04:42:36 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE867-0000Sl-DA;
        Wed, 20 Jul 2022 11:42:35 +0000
Date:   Wed, 20 Jul 2022 19:41:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, beanhuo@micron.com,
        quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     kbuild-all@lists.01.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Message-ID: <202207201927.zCPpAzRa-lkp@intel.com>
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
[also build test ERROR on mkp-scsi/for-next next-20220719]
[cannot apply to linus/master v5.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Can-Guo/UFS-Multi-Circular-Queue-MCQ/20220719-150436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220720/202207201927.zCPpAzRa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2b7356bcd24efd2d6b69f04dd9fd010c4256cc7e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Can-Guo/UFS-Multi-Circular-Queue-MCQ/20220719-150436
        git checkout 2b7356bcd24efd2d6b69f04dd9fd010c4256cc7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ufs/core/ufs-mcq.c: In function 'ufshcd_mcq_release_resource':
>> drivers/ufs/core/ufs-mcq.c:275:25: error: implicit declaration of function 'devm_iounmap'; did you mean 'pci_iounmap'? [-Werror=implicit-function-declaration]
     275 |                         devm_iounmap(hba->dev, res->base);
         |                         ^~~~~~~~~~~~
         |                         pci_iounmap
   cc1: some warnings being treated as errors


vim +275 drivers/ufs/core/ufs-mcq.c

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
