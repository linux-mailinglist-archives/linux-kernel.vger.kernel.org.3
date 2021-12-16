Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F024779D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhLPRAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:00:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:43012 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhLPRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639674016; x=1671210016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=efgkmWZYz5r4p+9anPXoJCv+nyf5yNgwZG9WU6thEi4=;
  b=R9T0nOtArHEmJhcpJtcI11ppF7L7cGZAg6aFMhOrhvtgSxYS9TI1OFka
   4VjvdCMSLtXGwTr6YAlT/SP52QVPd9d1VgSbJOsdnnmLSlawM/XkI/5/O
   wpVwPqRl8AXgKPKJgHaBS6pQxtGOagayqC2Mdu1gJXz4MsQKOOJwVE7pn
   zdTyRiHXl3l6Fo3b99eNWN4BHy1UYSsjs8PpsEK4Cnx47UIZc4912pmcR
   TC/YzcEMHxRTcOgYIhASyqXZ1Kw+nsIDkYemvV5EFcb3sZooYr+vQx4an
   oXdwpwh3T0y1N1OJrEpyOiTtkMxN2HQi4ZnxJRpl/1QR92rkJg82Dnt1L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220221218"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220221218"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:00:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="466138693"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 09:00:12 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxu72-0003VG-5X; Thu, 16 Dec 2021 17:00:12 +0000
Date:   Fri, 17 Dec 2021 00:59:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/mm/tlbex.c:2173 build_r4000_tlb_load_handler() warn:
 inconsistent indenting
Message-ID: <202112170029.Rfb3VzGK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: bc431d2153cc290573531601b5004babe7011568 MIPS: Fix fall-through warnings for Clang
date:   5 months ago
config: mips-randconfig-m031-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170029.Rfb3VzGK-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/mips/mm/tlbex.c:2173 build_r4000_tlb_load_handler() warn: inconsistent indenting

Old smatch warnings:
arch/mips/mm/tlbex.c:2603 check_pabits() warn: always true condition '(fillbits >= ((__builtin_constant_p(0)) ?(((0) < 2) ?0:63 - __builtin_clzll(0)):((4 <= 4)) ?__ilog2_u32(0):__ilog2_u64(0))) => (0-u32max >= 0)'

vim +2173 arch/mips/mm/tlbex.c

  2114	
  2115	static void build_r4000_tlb_load_handler(void)
  2116	{
  2117		u32 *p = (u32 *)msk_isa16_mode((ulong)handle_tlbl);
  2118		struct uasm_label *l = labels;
  2119		struct uasm_reloc *r = relocs;
  2120		struct work_registers wr;
  2121	
  2122		memset(p, 0, handle_tlbl_end - (char *)p);
  2123		memset(labels, 0, sizeof(labels));
  2124		memset(relocs, 0, sizeof(relocs));
  2125	
  2126		if (bcm1250_m3_war()) {
  2127			unsigned int segbits = 44;
  2128	
  2129			uasm_i_dmfc0(&p, K0, C0_BADVADDR);
  2130			uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
  2131			uasm_i_xor(&p, K0, K0, K1);
  2132			uasm_i_dsrl_safe(&p, K1, K0, 62);
  2133			uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
  2134			uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
  2135			uasm_i_or(&p, K0, K0, K1);
  2136			uasm_il_bnez(&p, &r, K0, label_leave);
  2137			/* No need for uasm_i_nop */
  2138		}
  2139	
  2140		wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
  2141		build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
  2142		if (m4kc_tlbp_war())
  2143			build_tlb_probe_entry(&p);
  2144	
  2145		if (cpu_has_rixi && !cpu_has_rixiex) {
  2146			/*
  2147			 * If the page is not _PAGE_VALID, RI or XI could not
  2148			 * have triggered it.  Skip the expensive test..
  2149			 */
  2150			if (use_bbit_insns()) {
  2151				uasm_il_bbit0(&p, &r, wr.r1, ilog2(_PAGE_VALID),
  2152					      label_tlbl_goaround1);
  2153			} else {
  2154				uasm_i_andi(&p, wr.r3, wr.r1, _PAGE_VALID);
  2155				uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround1);
  2156			}
  2157			uasm_i_nop(&p);
  2158	
  2159			/*
  2160			 * Warn if something may race with us & replace the TLB entry
  2161			 * before we read it here. Everything with such races should
  2162			 * also have dedicated RiXi exception handlers, so this
  2163			 * shouldn't be hit.
  2164			 */
  2165			WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
  2166	
  2167			uasm_i_tlbr(&p);
  2168	
  2169			switch (current_cpu_type()) {
  2170			default:
  2171				if (cpu_has_mips_r2_exec_hazard) {
  2172					uasm_i_ehb(&p);
> 2173				fallthrough;
  2174	
  2175			case CPU_CAVIUM_OCTEON:
  2176			case CPU_CAVIUM_OCTEON_PLUS:
  2177			case CPU_CAVIUM_OCTEON2:
  2178					break;
  2179				}
  2180			}
  2181	
  2182			/* Examine  entrylo 0 or 1 based on ptr. */
  2183			if (use_bbit_insns()) {
  2184				uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
  2185			} else {
  2186				uasm_i_andi(&p, wr.r3, wr.r2, sizeof(pte_t));
  2187				uasm_i_beqz(&p, wr.r3, 8);
  2188			}
  2189			/* load it in the delay slot*/
  2190			UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO0);
  2191			/* load it if ptr is odd */
  2192			UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO1);
  2193			/*
  2194			 * If the entryLo (now in wr.r3) is valid (bit 1), RI or
  2195			 * XI must have triggered it.
  2196			 */
  2197			if (use_bbit_insns()) {
  2198				uasm_il_bbit1(&p, &r, wr.r3, 1, label_nopage_tlbl);
  2199				uasm_i_nop(&p);
  2200				uasm_l_tlbl_goaround1(&l, p);
  2201			} else {
  2202				uasm_i_andi(&p, wr.r3, wr.r3, 2);
  2203				uasm_il_bnez(&p, &r, wr.r3, label_nopage_tlbl);
  2204				uasm_i_nop(&p);
  2205			}
  2206			uasm_l_tlbl_goaround1(&l, p);
  2207		}
  2208		build_make_valid(&p, &r, wr.r1, wr.r2, wr.r3);
  2209		build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
  2210	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
