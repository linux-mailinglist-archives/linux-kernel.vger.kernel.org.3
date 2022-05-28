Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B5536A12
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbiE1CEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbiE1CEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:04:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37B62A07;
        Fri, 27 May 2022 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653703477; x=1685239477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKpOzm/saM2/CRUSIPJrmqPjQqBfbs2x0FE088yI5cU=;
  b=QfU8mcs/G6H5Di02tzgCE65rMmRtU2VCSpFa5UozRDY2P5CX0tP5DmB/
   aD9z68SWRal7I42Av1pVZsdguM2Q6dzQSGQ6YGE681urbJS41zJvoa/Ol
   o+zfx4XoDR3G8WWVMp5JcbFMXfOZaiRTj39X//ejmjhNAv+yuy6rEJ57G
   DtqAT093TlVkSTEbT7Z5kGUIYq3ktIIukf9RCXiL/Qpb7ajjcaoVwMyA8
   OIUtOzx3YDw5skrAwn+L2vgAs5aocvDqIZaCy1xzsi2Ap6tTFoyVvVSd/
   YAF1aKHOfxLR4aY766wmDMsITkLiUTKU46nMcd5vvIF/pN+Z9wkafIZ9F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="299961782"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="299961782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 19:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="719134865"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2022 19:04:33 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuloe-0005MT-Bh;
        Sat, 28 May 2022 02:04:32 +0000
Date:   Sat, 28 May 2022 10:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Message-ID: <202205280904.vsNCfpph-lkp@intel.com>
References: <20220527212901.29268-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-5-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/iommu-qcom-Use-the-asid-read-from-device-tree-if-specified/20220528-062952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220528/202205280904.vsNCfpph-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0744f7d6ebfff8d6854a24d0f95f8e58885b5212
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Konrad-Dybcio/iommu-qcom-Use-the-asid-read-from-device-tree-if-specified/20220528-062952
        git checkout 0744f7d6ebfff8d6854a24d0f95f8e58885b5212
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/iommu/arm/arm-smmu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu/qcom_iommu.c: In function 'qcom_iommu_tlb_inv_range_nosync':
>> drivers/iommu/arm/arm-smmu/qcom_iommu.c:174:58: warning: left shift count >= width of type [-Wshift-count-overflow]
     174 |                         iova |= (unsigned long)ctx->asid << 48;
         |                                                          ^~


vim +174 drivers/iommu/arm/arm-smmu/qcom_iommu.c

   157	
   158	static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
   159						    size_t granule, bool leaf, void *cookie)
   160	{
   161		struct qcom_iommu_domain *qcom_domain = cookie;
   162		struct iommu_fwspec *fwspec = qcom_domain->fwspec;
   163		unsigned i, reg;
   164	
   165		reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
   166	
   167		for (i = 0; i < fwspec->num_ids; i++) {
   168			struct qcom_iommu_dev *qcom_iommu = qcom_domain->iommu;
   169			struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
   170			size_t s = size;
   171	
   172			if (qcom_iommu->use_aarch64_pt) {
   173				iova >>= 12;
 > 174				iova |= (unsigned long)ctx->asid << 48;
   175			} else {
   176				iova &= (1UL << 12) - 1UL;
   177				iova |= ctx->asid;
   178			}
   179			do {
   180				iommu_writel(ctx, reg, iova);
   181				iova += granule;
   182			} while (s -= granule);
   183		}
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
