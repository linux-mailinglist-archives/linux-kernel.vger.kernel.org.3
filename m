Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394EE51E63C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384289AbiEGKB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiEGKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:01:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD912657
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651917459; x=1683453459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KS6oebMwuSHVGzZ2GgRSjsO7NX3usahPrS23SFzgck8=;
  b=nsCU6GIDV128lVsU6ryST2gGdP6iosbGi0huH7q7IRSjRHIrLdDOLblV
   V9dLBndRdWfi31/wO1dCnP+reNzsBjiaQWOfAbvQcx3a6m85tPDvgMGYz
   60Iznziib/OQZq+4t4dzVhidQ+5hojEU9JBhH5tVjf0jxIpxpej3Jl8Nt
   iddm1AfLUkHTSefy/HeKc7p2b1VpiY+nzq2aPk+oHxzp1lwQxzKulK062
   CwcMcrsdzz3RhoYZgt9L28i8gN5M06OI5cxPAO+VSAq+yKnsCivTueQOZ
   dTAv//zptu6Fk3n6z2xuJ3DLHeRavg9XzBC6zFcOVrHyndVlOClWpVNPI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="331685504"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="331685504"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 02:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="622201886"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2022 02:57:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnHBw-000ERk-FD;
        Sat, 07 May 2022 09:57:36 +0000
Date:   Sat, 7 May 2022 17:57:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/proton-pack.c:302:5: warning: Redundant assignment
 of 'cb' to itself. [selfAssignment]
Message-ID: <202205071746.wrApww8H-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b97bac0756a81cda5afd45417a99b5bccdcff67
commit: ea8f8c99a28199f6e067581b8626d192b07750f2 arm64: spectre-v2: Favour CPU-specific mitigation at EL2
date:   1 year, 7 months ago
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout ea8f8c99a28199f6e067581b8626d192b07750f2
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:302:5: warning: Redundant assignment of 'cb' to itself. [selfAssignment]
    cb = spectre_v2_get_sw_mitigation_cb() ?: cb;
       ^

vim +/cb +302 arch/arm64/kernel/proton-pack.c

   272	
   273	static enum mitigation_state spectre_v2_enable_fw_mitigation(void)
   274	{
   275		bp_hardening_cb_t cb;
   276		enum mitigation_state state;
   277	
   278		state = spectre_v2_get_cpu_fw_mitigation_state();
   279		if (state != SPECTRE_MITIGATED)
   280			return state;
   281	
   282		if (spectre_v2_mitigations_off())
   283			return SPECTRE_VULNERABLE;
   284	
   285		switch (arm_smccc_1_1_get_conduit()) {
   286		case SMCCC_CONDUIT_HVC:
   287			cb = call_hvc_arch_workaround_1;
   288			break;
   289	
   290		case SMCCC_CONDUIT_SMC:
   291			cb = call_smc_arch_workaround_1;
   292			break;
   293	
   294		default:
   295			return SPECTRE_VULNERABLE;
   296		}
   297	
   298		/*
   299		 * Prefer a CPU-specific workaround if it exists. Note that we
   300		 * still rely on firmware for the mitigation at EL2.
   301		 */
 > 302		cb = spectre_v2_get_sw_mitigation_cb() ?: cb;
   303		install_bp_hardening_cb(cb);
   304		return SPECTRE_MITIGATED;
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
