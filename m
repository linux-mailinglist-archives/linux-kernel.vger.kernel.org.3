Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A673539521
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbiEaQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346248AbiEaQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:57:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C733E14
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F4AFB811BC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22290C385A9;
        Tue, 31 May 2022 16:57:46 +0000 (UTC)
Date:   Tue, 31 May 2022 17:57:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference
 of noderef expression
Message-ID: <YpZJBoxqvaCLRQfX@arm.com>
References: <202205280635.XKlMkfKD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205280635.XKlMkfKD-lkp@intel.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:49:01AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8291eaafed36f575f23951f3ce18407f480e9ecf
> commit: e0838f6373e5cb72516fc4c26bba309097e2a80a arm64/sme: Save and restore streaming mode over EFI runtime calls
> date:   5 weeks ago
> config: arm64-randconfig-s032-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280635.XKlMkfKD-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-14-g5a0004b5-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0838f6373e5cb72516fc4c26bba309097e2a80a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e0838f6373e5cb72516fc4c26bba309097e2a80a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference of noderef expression
> 
> vim +1944 arch/arm64/kernel/fpsimd.c
> 
>   1916	
>   1917	/*
>   1918	 * __efi_fpsimd_end(): clean up FPSIMD after an EFI runtime services call
>   1919	 */
>   1920	void __efi_fpsimd_end(void)
>   1921	{
>   1922		if (!system_supports_fpsimd())
>   1923			return;
>   1924	
>   1925		if (!__this_cpu_xchg(efi_fpsimd_state_used, false)) {
>   1926			kernel_neon_end();
>   1927		} else {
>   1928			if (system_supports_sve() &&
>   1929			    likely(__this_cpu_read(efi_sve_state_used))) {
>   1930				char const *sve_state = this_cpu_ptr(efi_sve_state);
>   1931				bool ffr = true;
>   1932	
>   1933				/*
>   1934				 * Restore streaming mode; EFI calls are
>   1935				 * normal function calls so should not return in
>   1936				 * streaming mode.
>   1937				 */
>   1938				if (system_supports_sme()) {
>   1939					if (__this_cpu_read(efi_sm_state)) {
>   1940						sysreg_clear_set_s(SYS_SVCR_EL0,
>   1941								   0,
>   1942								   SYS_SVCR_EL0_SM_MASK);
>   1943						if (!system_supports_fa64())
> > 1944							ffr = efi_sm_state;

This looks wrong indeed. IIUC, something like below but waiting for Mark
to confirm:

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 819979398127..ac521b3403d6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1965,7 +1965,7 @@ void __efi_fpsimd_end(void)
 							   0,
 							   SVCR_SM_MASK);
 					if (!system_supports_fa64())
-						ffr = efi_sm_state;
+						ffr = false;
 				}
 			}
 
-- 
Catalin
