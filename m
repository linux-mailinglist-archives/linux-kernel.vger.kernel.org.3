Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01D1517A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiEBWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiEBWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:52:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD3D558E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651531735; x=1683067735;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/pDjDneyjwgNJpDMN5wO7esLEMqgdDQZo4u8PWBiJKE=;
  b=dN7wbM2ZSKZvgH8wBVjnHjKEHW0z2nmX5VBtx8ofyQQioyGbsau0SQ8W
   dNH+AilL+3hswMiQZNLkZhYZIr3Udjhdxdfwom4qi+IXcrnu3/j1Dg4rz
   O30mFSuIDe8JFFjtobub/d3bJ0aFZ8uokbgpqSbq/tQrBeFwDHzQeCyUN
   isXma4thMaj8/er/ZMkweCN0FF/P2IWKNKI9hsprK44YDUA35wYXWX4ga
   oaCI91owwHbnz0t3rG7dZqRR6FOcCjNqpK9/WhK78tAi7AvoWEcoqkdyp
   mISHg/AZWox31aIhecwGCdHeCFHRLODFgf5RytaeDppJyEJEyIYZYVxPT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353786968"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353786968"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="653024657"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2022 15:48:54 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nleqb-0009x1-B6;
        Mon, 02 May 2022 22:48:53 +0000
Date:   Tue, 03 May 2022 06:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/stringop-overflow] BUILD REGRESSION
 841e98dddf647582547543eba0a1e3e8c8f8db9c
Message-ID: <62705fab.KPRuiM/Lf3t5oMFA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/stringop-overflow
branch HEAD: 841e98dddf647582547543eba0a1e3e8c8f8db9c  Makefile: Enable -Wstringop-overflow

Error/Warning reports:

https://lore.kernel.org/lkml/202204281117.CPeehgnR-lkp@intel.com
https://lore.kernel.org/lkml/202204281235.5QhYdg1I-lkp@intel.com
https://lore.kernel.org/lkml/202204282134.8kzHtDU9-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/i915/intel_pm.c:3106:9: error: 'intel_read_wm_latency' accessing 16 bytes in a region of size 10 [-Werror=stringop-overflow=]
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
drivers/scsi/fcoe/fcoe.c:744:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
drivers/scsi/qedf/qedf_main.c:3520:30: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
lib/zstd/decompress/huf_decompress.c:700:5: warning: 'HUF_fillDTableX2.constprop' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds.constprop' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds.constprop' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:462:9: warning: 'free_pmds.constprop' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds.constprop' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds.constprop' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
cc1: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
drivers/char/xillybus/xillybus_core.c:1059:50: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1461:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:2584:25: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/i915/intel_pm.c:3106:9: warning: 'intel_read_wm_latency' accessing 16 bytes in a region of size 10 [-Wstringop-overflow=]
drivers/hwmon/pc87360.c:1609:44: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/infiniband/hw/mlx4/main.c:297:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
drivers/mtd/nand/raw/nand_bbt.c:584:32: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
fs/omfs/file.c:170:9: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
lib/test_kasan.c:194:63: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/test_kasan.c:274:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/vsprintf.c:2881:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/vsprintf.c:2894:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/vsprintf.c:2940:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/vsprintf.c:3379:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
lib/vsprintf.c:3392:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-buildonly-randconfig-r001-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-buildonly-randconfig-r003-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- alpha-randconfig-c024-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-m031-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r002-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r011-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r013-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r014-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r025-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- alpha-randconfig-r035-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-alldefconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-allmodconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-axs103_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-buildonly-randconfig-r002-20220428
|   |-- drivers-mtd-nand-raw-nand_bbt.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-nsim_700_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-nsimosci_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-randconfig-c024-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r005-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r015-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r021-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r024-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r031-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r032-20220428
|   `-- drivers-char-xillybus-xillybus_core.c:warning:writing-byte-into-a-region-of-size
|-- arc-randconfig-r033-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r036-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-r043-20220428
|   |-- drivers-mtd-nand-raw-nand_bbt.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arc-randconfig-s031-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-at91_dt_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-buildonly-randconfig-r003-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-buildonly-randconfig-r004-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-cerfcube_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arm-clps711x_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-eseries_pxa_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arm-exynos_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-ezx_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-gemini_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-imx_v6_v7_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-imxrt_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arm-integrator_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-lpd270_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arm-nhk8815_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-omap2plus_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-randconfig-c002-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-randconfig-c002-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-randconfig-r014-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-randconfig-r021-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-trizeps4_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm-viper_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm64-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r002-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r004-20220428
|   |-- fs-omfs-file.c:warning:writing-bytes-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r005-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r006-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- csky-buildonly-randconfig-r001-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- csky-buildonly-randconfig-r006-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- csky-defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- h8300-allnoconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- h8300-allyesconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-buildonly-randconfig-r001-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-buildonly-randconfig-r004-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-buildonly-randconfig-r004-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-randconfig-r011-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- h8300-randconfig-r021-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-randconfig-r024-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-randconfig-r032-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- h8300-randconfig-r034-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- h8300-randconfig-s032-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-allyesconfig
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-debian-10.3
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-debian-10.3-kselftests
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-defconfig
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a001
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a003
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a005
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a012
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a014
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a016
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-c001
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-c021
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-m021
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-s001
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-s002
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- i386-tinyconfig
|   `-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-alldefconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- ia64-allmodconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-allnoconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- ia64-allyesconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-buildonly-randconfig-r002-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-buildonly-randconfig-r006-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-randconfig-m031-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-randconfig-r014-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-randconfig-r024-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- ia64-randconfig-r026-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-allmodconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-allyesconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-buildonly-randconfig-r003-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-bvme6000_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-m5208evb_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- m68k-multi_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-c003-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-c023-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-m031-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-p002-20220428
|   |-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-r016-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-r024-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- m68k-randconfig-s031-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-allmodconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-buildonly-randconfig-r002-20220427
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- microblaze-buildonly-randconfig-r004-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-buildonly-randconfig-r006-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-mmu_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- microblaze-randconfig-c023-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-c023-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-r012-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-r025-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-r026-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-r031-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- microblaze-randconfig-r032-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-allmodconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-capcella_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-ci20_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-cobalt_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-db1xxx_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-ip32_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-maltasmvp_eva_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-maltaup_xpa_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- mips-randconfig-r015-20220428
|   |-- arch-mips-boot-compressed-..-..-..-..-lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-randconfig-r016-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-randconfig-r021-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- mips-randconfig-r025-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- nios2-alldefconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- nios2-allyesconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- nios2-buildonly-randconfig-r004-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- nios2-defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- nios2-randconfig-r026-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- nios2-randconfig-r034-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- openrisc-allnoconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- openrisc-buildonly-randconfig-r005-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- openrisc-or1ksim_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- openrisc-randconfig-c003-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- openrisc-randconfig-r002-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- openrisc-randconfig-r016-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-buildonly-randconfig-r004-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-c004-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-c023-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r016-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r021-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r024-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r025-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r025-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- parisc64-defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-allmodconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-amigaone_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-arches_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-buildonly-randconfig-r006-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-mpc85xx_cds_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-ppc64_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-ppc6xx_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-pq2fads_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-randconfig-p002-20220429
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-randconfig-r012-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-randconfig-r016-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc-randconfig-r031-20220428
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-c003-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-c004-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-c024-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-p001-20220429
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-r034-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-r035-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-r036-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- powerpc64-randconfig-s032-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-allnoconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-nommu_virt_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-randconfig-c004-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-randconfig-r003-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- riscv-rv32_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-allmodconfig
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-defconfig
|   |-- drivers-infiniband-hw-mlx4-main.c:warning:writing-bytes-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-randconfig-m031-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-randconfig-r003-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-randconfig-r022-20220427
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-randconfig-r034-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-randconfig-s032-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- s390-zfcpdump_defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-allmodconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-allnoconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-allyesconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-buildonly-randconfig-r001-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-buildonly-randconfig-r002-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-edosk7705_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-magicpanelr2_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-polaris_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-randconfig-r023-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-se7206_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sh-se7619_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-se7712_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-sh7710voipgw_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sh-shmin_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sparc-allyesconfig
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-randconfig-c003-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-randconfig-c024-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-randconfig-r012-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sparc-randconfig-r014-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-randconfig-r023-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc-sparc64_defconfig
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-alldefconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sparc64-buildonly-randconfig-r001-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-c004-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-p001-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-r001-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-r005-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-r024-20220427
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- sparc64-randconfig-r026-20220428
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- sparc64-randconfig-s032-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-allmodconfig
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-allyesconfig
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-defconfig
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-kexec
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a002
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a004
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a006
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a011
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- cc1:warning:writing-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a013
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-a015
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-c001
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-c002
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- x86_64-randconfig-c022
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-m001
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-s021
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-randconfig-s022
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-rhel-8.3
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-rhel-8.3-func
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-rhel-8.3-kselftests
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-rhel-8.3-kunit
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:warning:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- x86_64-rhel-8.3-syz
|   |-- arch-x86-mm-pgtable.c:warning:free_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- arch-x86-mm-pgtable.c:warning:preallocate_pmds.constprop-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-i915-intel_pm.c:error:intel_read_wm_latency-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-bnx2fc-bnx2fc_fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-fcoe-fcoe.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- drivers-scsi-qedf-qedf_main.c:warning:fcoe_wwn_from_mac-accessing-bytes-in-a-region-of-size
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-common_defconfig
|   `-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|-- xtensa-randconfig-r002-20220428
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-randconfig-r004-20220428
|   |-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-randconfig-r011-20220427
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-randconfig-r023-20220428
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
|-- xtensa-randconfig-r035-20220428
|   |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size
`-- xtensa-smp_lx200_defconfig
    |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
    `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2.constprop-accessing-bytes-in-a-region-of-size

elapsed time: 6997m

configs tested: 173
configs skipped: 5

gcc tested configs:
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                         at91_dt_defconfig
powerpc                       ppc64_defconfig
sh                             shx3_defconfig
sh                        sh7763rdp_defconfig
mips                           ci20_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
riscv                            allyesconfig
arc                                 defconfig
arm                            lart_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
s390                       zfcpdump_defconfig
s390                                defconfig
arm                        trizeps4_defconfig
arc                          axs103_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
powerpc                    amigaone_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
arm                       imx_v6_v7_defconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
m68k                          multi_defconfig
arm                          exynos_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        cerfcube_defconfig
sh                           se7722_defconfig
mips                           jazz_defconfig
ia64                             alldefconfig
parisc                              defconfig
mips                         cobalt_defconfig
sh                          lboxre2_defconfig
arm                         nhk8815_defconfig
sh                           se7712_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
arm                     eseries_pxa_defconfig
arm                           imxrt_defconfig
mips                    maltaup_xpa_defconfig
openrisc                    or1ksim_defconfig
arm                      integrator_defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
m68k                       bvme6000_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                        edosk7760_defconfig
um                             i386_defconfig
mips                       capcella_defconfig
sh                         ap325rxa_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
powerpc                     tqm8540_defconfig
powerpc                     ppa8548_defconfig
arm64                            allyesconfig
arm                         hackkit_defconfig
mips                      bmips_stb_defconfig
arm                           sama7_defconfig
powerpc                  mpc885_ads_defconfig
arm                       cns3420vb_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
hexagon                          alldefconfig
mips                           ip28_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r045-20220428
riscv                randconfig-r042-20220428
s390                 randconfig-r044-20220428
hexagon              randconfig-r041-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
