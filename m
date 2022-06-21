Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA941553E10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356608AbiFUVqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiFUVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:46:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022617E1B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655847994; x=1687383994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CWEH+hJ4sWaTMpZV1KAwZ4owpgOW5f4OMgBPPxu/4JA=;
  b=kDhU9Qd2Tz8v7AaX9QcjCoxM3deXigeDZOcfp1JqVLAoBVcY/mAvh+8P
   09u2WioDxrPky6xmc/XvA8vP8IzsViRMwS98guvAfkYHA/xF87oTo7cO3
   ge5UcV3zxlygomVQCGuIlLi0C+dmayAEFL3BslU/Pis3lTYSFDMITX/EL
   6/QUcNL/9O/zqRWUht4oipLRUynsiVkSSPHa5f6kDkyIjj+ubR8gpk1AY
   BLlmyp/lpHTTOYCGAT6p+9MOspT6Ly2qUBE0PTo/kXZJ+a5TOYBoM6DP7
   Z3Qz/u+5dyJ2VAFubmLBdXdisgCvDrGmvd1TmGDmrFacwznIUsa6q4muw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281314447"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="281314447"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 14:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="643836310"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 14:46:15 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3lhP-0000Sr-Aj;
        Tue, 21 Jun 2022 21:46:15 +0000
Date:   Wed, 22 Jun 2022 05:45:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koby Elbaz <kelbaz@habana.ai>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 17/27]
 drivers/misc/habanalabs/gaudi/gaudi.c:7389:14: warning: variable 'qid_base'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202206220559.zHr8bBNF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   6b6ead0677a7a86645d47f473fde6c13acf04c0f
commit: ae1380530e8c3349fac2e54e4cade040d7b43025 [17/27] habanalabs/gaudi: fix incorrect MME offset calculation
config: riscv-randconfig-r006-20220619 (https://download.01.org/0day-ci/archive/20220622/202206220559.zHr8bBNF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=ae1380530e8c3349fac2e54e4cade040d7b43025
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout ae1380530e8c3349fac2e54e4cade040d7b43025
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/habanalabs/gaudi/gaudi.c:8:
   In file included from drivers/misc/habanalabs/gaudi/gaudiP.h:12:
   In file included from drivers/misc/habanalabs/gaudi/../common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/gaudi/../common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/misc/habanalabs/gaudi/gaudi.c:8:
   In file included from drivers/misc/habanalabs/gaudi/gaudiP.h:12:
   In file included from drivers/misc/habanalabs/gaudi/../common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/gaudi/../common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/misc/habanalabs/gaudi/gaudi.c:8:
   In file included from drivers/misc/habanalabs/gaudi/gaudiP.h:12:
   In file included from drivers/misc/habanalabs/gaudi/../common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/gaudi/../common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/misc/habanalabs/gaudi/gaudi.c:7389:14: warning: variable 'qid_base' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (event_type == GAUDI_EVENT_MME2_QM) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7459:55: note: uninitialized use occurs here
           gaudi_handle_qman_err_generic(hdev, desc, qman_base, qid_base, event_mask);
                                                                ^~~~~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7389:10: note: remove the 'if' if its condition is always true
                   } else if (event_type == GAUDI_EVENT_MME2_QM) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7369:14: note: initialize the variable 'qid_base' to silence this warning
           u32 qid_base;
                       ^
                        = 0
>> drivers/misc/habanalabs/gaudi/gaudi.c:7389:14: warning: variable 'index' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (event_type == GAUDI_EVENT_MME2_QM) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7393:32: note: uninitialized use occurs here
                   qman_base = mmMME0_QM_BASE + index * MME_QMAN_OFFSET;
                                                ^~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7389:10: note: remove the 'if' if its condition is always true
                   } else if (event_type == GAUDI_EVENT_MME2_QM) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/gaudi/gaudi.c:7370:10: note: initialize the variable 'index' to silence this warning
           u8 index;
                   ^
                    = '\0'
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   9 warnings and 20 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_TTM_HELPER && HAS_IOMEM && DRM
   - DRM_HISI_HIBMC && HAS_IOMEM && DRM && PCI && (ARM64 || COMPILE_TEST


vim +7389 drivers/misc/habanalabs/gaudi/gaudi.c

  7364	
  7365	static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
  7366	{
  7367		u64 qman_base;
  7368		char desc[32];
  7369		u32 qid_base;
  7370		u8 index;
  7371	
  7372		switch (event_type) {
  7373		case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
  7374			/* In TPC QM event, notify on TPC assertion. While there isn't
  7375			 * a specific event for assertion yet, the FW generates QM event.
  7376			 * The SW upper layer will inspect an internal mapped area to indicate
  7377			 * if the event is a tpc assertion or tpc QM.
  7378			 */
  7379			*event_mask |= HL_NOTIFIER_EVENT_TPC_ASSERT;
  7380			index = event_type - GAUDI_EVENT_TPC0_QM;
  7381			qid_base = GAUDI_QUEUE_ID_TPC_0_0 + index * QMAN_STREAMS;
  7382			qman_base = mmTPC0_QM_BASE + index * TPC_QMAN_OFFSET;
  7383			snprintf(desc, ARRAY_SIZE(desc), "%s%d", "TPC_QM", index);
  7384			break;
  7385		case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
  7386			if (event_type == GAUDI_EVENT_MME0_QM) {
  7387				index = 0;
  7388				qid_base = GAUDI_QUEUE_ID_MME_0_0;
> 7389			} else if (event_type == GAUDI_EVENT_MME2_QM) {
  7390				index = 2;
  7391				qid_base = GAUDI_QUEUE_ID_MME_1_0;
  7392			}
  7393			qman_base = mmMME0_QM_BASE + index * MME_QMAN_OFFSET;
  7394			snprintf(desc, ARRAY_SIZE(desc), "%s%d", "MME_QM", index);
  7395			break;
  7396		case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
  7397			index = event_type - GAUDI_EVENT_DMA0_QM;
  7398			qid_base = GAUDI_QUEUE_ID_DMA_0_0 + index * QMAN_STREAMS;
  7399			/* skip GAUDI_QUEUE_ID_CPU_PQ if necessary */
  7400			if (index > 1)
  7401				qid_base++;
  7402			qman_base = mmDMA0_QM_BASE + index * DMA_QMAN_OFFSET;
  7403			snprintf(desc, ARRAY_SIZE(desc), "%s%d", "DMA_QM", index);
  7404			break;
  7405		case GAUDI_EVENT_NIC0_QM0:
  7406			qid_base = GAUDI_QUEUE_ID_NIC_0_0;
  7407			qman_base = mmNIC0_QM0_BASE;
  7408			snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM0");
  7409			break;
  7410		case GAUDI_EVENT_NIC0_QM1:
  7411			qid_base = GAUDI_QUEUE_ID_NIC_1_0;
  7412			qman_base = mmNIC0_QM1_BASE;
  7413			snprintf(desc, ARRAY_SIZE(desc), "NIC0_QM1");
  7414			break;
  7415		case GAUDI_EVENT_NIC1_QM0:
  7416			qid_base = GAUDI_QUEUE_ID_NIC_2_0;
  7417			qman_base = mmNIC1_QM0_BASE;
  7418			snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM0");
  7419			break;
  7420		case GAUDI_EVENT_NIC1_QM1:
  7421			qid_base = GAUDI_QUEUE_ID_NIC_3_0;
  7422			qman_base = mmNIC1_QM1_BASE;
  7423			snprintf(desc, ARRAY_SIZE(desc), "NIC1_QM1");
  7424			break;
  7425		case GAUDI_EVENT_NIC2_QM0:
  7426			qid_base = GAUDI_QUEUE_ID_NIC_4_0;
  7427			qman_base = mmNIC2_QM0_BASE;
  7428			snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM0");
  7429			break;
  7430		case GAUDI_EVENT_NIC2_QM1:
  7431			qid_base = GAUDI_QUEUE_ID_NIC_5_0;
  7432			qman_base = mmNIC2_QM1_BASE;
  7433			snprintf(desc, ARRAY_SIZE(desc), "NIC2_QM1");
  7434			break;
  7435		case GAUDI_EVENT_NIC3_QM0:
  7436			qid_base = GAUDI_QUEUE_ID_NIC_6_0;
  7437			qman_base = mmNIC3_QM0_BASE;
  7438			snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM0");
  7439			break;
  7440		case GAUDI_EVENT_NIC3_QM1:
  7441			qid_base = GAUDI_QUEUE_ID_NIC_7_0;
  7442			qman_base = mmNIC3_QM1_BASE;
  7443			snprintf(desc, ARRAY_SIZE(desc), "NIC3_QM1");
  7444			break;
  7445		case GAUDI_EVENT_NIC4_QM0:
  7446			qid_base = GAUDI_QUEUE_ID_NIC_8_0;
  7447			qman_base = mmNIC4_QM0_BASE;
  7448			snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM0");
  7449			break;
  7450		case GAUDI_EVENT_NIC4_QM1:
  7451			qid_base = GAUDI_QUEUE_ID_NIC_9_0;
  7452			qman_base = mmNIC4_QM1_BASE;
  7453			snprintf(desc, ARRAY_SIZE(desc), "NIC4_QM1");
  7454			break;
  7455		default:
  7456			return;
  7457		}
  7458	
  7459		gaudi_handle_qman_err_generic(hdev, desc, qman_base, qid_base, event_mask);
  7460	}
  7461	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
