Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB249A91F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1322155AbiAYDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:21:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:50542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1318872AbiAYDHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643080043; x=1674616043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=engvKbl+jC8slbfHM9iBDpf0HIyr8rPy13E1UZzS8gc=;
  b=LO37sapKSlZfA91fg4SGosGItOt7SoooLeIlP1PdazMMlFnYGWlfkBoL
   /FTLhJ3WazZRmh2CVJHzWR3mvSW1fSdWShTJy7OUVzAf/144qctAE2CbA
   I+jH4/rVJFtRf+MwQl4ZWaTc+e8MUHe3rOsICgJAlpKsSQMQkZ/Ij81aD
   x3wFO1yEBFmh1pYVjMKnHPbDCbkWTiEabkC8ErvBuIN83BVyD9Yj+0ytA
   33AqHtj49EUlKohv6rEYHFWq8ioR6ryrWLsYyi6FG0cgy65+tfCZ0wXPH
   I45iuSu+dfdjpufcqS2mvNHEBGDj550a1baoyuNB7GKM6R/FKYJGVlmxj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233573112"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="233573112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="673846638"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2022 19:07:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCCAy-000JGx-4b; Tue, 25 Jan 2022 03:07:20 +0000
Date:   Tue, 25 Jan 2022 11:06:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, kjlu@umn.edu,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / tables: Fix a NULL pointer dereference in
 acpi_table_initrd_override()
Message-ID: <202201251123.ScbhjE9a-lkp@intel.com>
References: <20220124164251.52466-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124164251.52466-1-zhou1615@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linux/master linus/master v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhou-Qingyang/ACPI-tables-Fix-a-NULL-pointer-dereference-in-acpi_table_initrd_override/20220125-004517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-r011-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251123.ScbhjE9a-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/924d4e212d2041e2af120ade3599fdc00e0b12fd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhou-Qingyang/ACPI-tables-Fix-a-NULL-pointer-dereference-in-acpi_table_initrd_override/20220125-004517
        git checkout 924d4e212d2041e2af120ade3599fdc00e0b12fd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/tables.c:710:4: error: void function 'acpi_table_initrd_scan' should not return a value [-Wreturn-type]
                           return AE_NO_MEMORY;
                           ^      ~~~~~~~~~~~~
   1 error generated.


vim +/acpi_table_initrd_scan +710 drivers/acpi/tables.c

   695	
   696	static void __init acpi_table_initrd_scan(void)
   697	{
   698		int table_offset = 0;
   699		int table_index = 0;
   700		u32 table_length;
   701		struct acpi_table_header *table;
   702	
   703		if (!acpi_tables_addr)
   704			return;
   705	
   706		while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
   707			table = acpi_os_map_memory(acpi_tables_addr + table_offset,
   708						   ACPI_HEADER_SIZE);
   709			if (!table) {
 > 710				return AE_NO_MEMORY;
   711			}
   712	
   713			if (table_offset + table->length > all_tables_size) {
   714				acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
   715				WARN_ON(1);
   716				return;
   717			}
   718	
   719			table_length = table->length;
   720	
   721			/* Skip RSDT/XSDT which should only be used for override */
   722			if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_RSDT) ||
   723			    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_XSDT)) {
   724				acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
   725				goto next_table;
   726			}
   727			/*
   728			 * Mark the table to avoid being used in
   729			 * acpi_table_initrd_override(). Though this is not possible
   730			 * because override is disabled in acpi_install_physical_table().
   731			 */
   732			if (test_and_set_bit(table_index, acpi_initrd_installed)) {
   733				acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
   734				goto next_table;
   735			}
   736	
   737			pr_info("Table Upgrade: install [%4.4s-%6.6s-%8.8s]\n",
   738				table->signature, table->oem_id,
   739				table->oem_table_id);
   740			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
   741			acpi_install_physical_table(acpi_tables_addr + table_offset);
   742	next_table:
   743			table_offset += table_length;
   744			table_index++;
   745		}
   746	}
   747	#else
   748	static acpi_status
   749	acpi_table_initrd_override(struct acpi_table_header *existing_table,
   750				   acpi_physical_address *address,
   751				   u32 *table_length)
   752	{
   753		*table_length = 0;
   754		*address = 0;
   755		return AE_OK;
   756	}
   757	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
