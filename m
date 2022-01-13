Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CE48E09D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiAMWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:45:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:27900 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbiAMWpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642113910; x=1673649910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y2l0foejg18xzae54Csuj3bO4WRTw2nhXxs5WAHogro=;
  b=JYnOa57mGtV0/j+YVi2b7YdKeQ0//2KfCVLFsc6ZIcXSo8+AfyKPdY3R
   bAaG+dnMxDUg95GKTY1KVf8Gmh74f48K+JViEzKlRY7aZ2C/dF4ljQEY1
   Et3+P6vTS6UTVKFxRRISGkpmMQWkzT87dIhHxPxaCws3Z/BELhjuhifFb
   Zm5lExtfCwkrDGdKM+yKb6b947JFAA2iJqtqhQ4Jdh3h4RFZgxcvlhcwx
   j9r8urikOzHU38myNtVIdvDHl8Ho8EI+MuecPO8piImHNALE3jUJ+YKKK
   XErZRCafP1OvqYGW3C2itTZW4m6gzXDs6o/afP+0PKigyCyTv3gZSNHu1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224110914"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="224110914"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:45:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="624029794"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2022 14:45:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n88q9-0007jE-KE; Thu, 13 Jan 2022 22:45:05 +0000
Date:   Fri, 14 Jan 2022 06:44:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 118/133]
 arch/x86/kernel/acpi/boot.c:1160: undefined reference to `swiotlb_hint_cpus'
Message-ID: <202201140642.CNEqitYj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 8c696e48187c5ffa881e639e1108622debbe6741 [118/133] swiotlb: Split up single swiotlb lock
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220114/202201140642.CNEqitYj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/8c696e48187c5ffa881e639e1108622debbe6741
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout 8c696e48187c5ffa881e639e1108622debbe6741
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/acpi/boot.o: in function `acpi_parse_madt_lapic_entries':
>> arch/x86/kernel/acpi/boot.c:1160: undefined reference to `swiotlb_hint_cpus'


vim +1160 arch/x86/kernel/acpi/boot.c

  1118	
  1119	static int __init acpi_parse_madt_lapic_entries(void)
  1120	{
  1121		int count;
  1122		int x2count = 0;
  1123		int ret;
  1124		struct acpi_subtable_proc madt_proc[2];
  1125	
  1126		if (!boot_cpu_has(X86_FEATURE_APIC))
  1127			return -ENODEV;
  1128	
  1129		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
  1130					      acpi_parse_sapic, MAX_LOCAL_APIC);
  1131	
  1132		if (!count) {
  1133			memset(madt_proc, 0, sizeof(madt_proc));
  1134			madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
  1135			madt_proc[0].handler = acpi_parse_lapic;
  1136			madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
  1137			madt_proc[1].handler = acpi_parse_x2apic;
  1138			ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
  1139					sizeof(struct acpi_table_madt),
  1140					madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
  1141			if (ret < 0) {
  1142				pr_err("Error parsing LAPIC/X2APIC entries\n");
  1143				return ret;
  1144			}
  1145	
  1146			count = madt_proc[0].count;
  1147			x2count = madt_proc[1].count;
  1148		}
  1149		if (!count && !x2count) {
  1150			pr_err("No LAPIC entries present\n");
  1151			/* TBD: Cleanup to allow fallback to MPS */
  1152			return -ENODEV;
  1153		} else if (count < 0 || x2count < 0) {
  1154			pr_err("Error parsing LAPIC entry\n");
  1155			/* TBD: Cleanup to allow fallback to MPS */
  1156			return count;
  1157		}
  1158	
  1159		/* This does not take overrides into consideration */
> 1160		swiotlb_hint_cpus(max(count, x2count));
  1161	
  1162		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
  1163						acpi_parse_x2apic_nmi, 0);
  1164		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
  1165					      acpi_parse_lapic_nmi, 0);
  1166		if (count < 0 || x2count < 0) {
  1167			pr_err("Error parsing LAPIC NMI entry\n");
  1168			/* TBD: Cleanup to allow fallback to MPS */
  1169			return count;
  1170		}
  1171		return 0;
  1172	}
  1173	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
