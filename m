Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7D595346
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiHPHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHPHBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:01:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2687B2A9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616865; x=1692152865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vrP+0E2wM06vndHVK8FzukeuQqgXtzGCdO4W7xOwShE=;
  b=BdvUHiWeDsQq4WbIJ5izd//IORSuJwKLrpW/0fgL1J4MnTV+tHhvKCs8
   qJJAkklXE7qhNPJ33QYAdv6jeJieOPxUL/gWho2aNX3D2Uroae8Wls0A6
   uzbGLTCD1bjhEUQYCPMnJSb0DGfXwUwX6x0SHWsEoed7bKmZcJ0kb0duy
   +SZ6HEqcYV5EIblWCmkNBQAO4y1GbEIppj2r7qNcdz3EmEuTeBpd9CAgF
   km/G+lzRdrrOTxBqKbpV9j4qGnhR/hKUaKbHReo8OjjxGyMPb0/rcQYPC
   n+QmasdtzzJRhx5gmcBOqUvbjI/3hNgwi73LjydhKP0X8CAyVFI3Q0DCL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272498016"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="272498016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="639856793"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 19:27:43 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNmIw-0001NS-31;
        Tue, 16 Aug 2022 02:27:42 +0000
Date:   Tue, 16 Aug 2022 10:27:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 33/59] vmlinux.o:
 warning: objtool: __asan_load1+0x4e: return with UACCESS disabled from a
 UACCESS-safe function
Message-ID: <202208161059.g8xuz85y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   9bbf33b92f4c755dd56f4d9bc1b40e94fdd1fff7
commit: c5803edfd11acd1bb56cd1878381c0c8b0902828 [33/59] objtool: Fix find_{symbol,func}_containing()
config: x86_64-randconfig-c002-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161059.g8xuz85y-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c5803edfd11acd1bb56cd1878381c0c8b0902828
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout c5803edfd11acd1bb56cd1878381c0c8b0902828
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: __asan_load1+0x4e: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_store1_noabort+0x51: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_load2+0x74: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_store2_noabort+0x77: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_load4_noabort+0x73: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_store4_noabort+0x76: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_load8_noabort+0x7c: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_store8_noabort+0x7f: return with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_load16+0x6d: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_store16+0x70: return with UACCESS disabled from a UACCESS-safe function
>> vmlinux.o: warning: objtool: __asan_loadN+0x14: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_storeN_noabort+0x17: return with UACCESS enabled


objdump-func vmlinux.o __asan_load1:
0000 00000000004af802 <__asan_load1>:
0000   4af802:	f3 0f 1e fa          	endbr64
0004   4af806:	55                   	push   %rbp
0005   4af807:	48 89 e5             	mov    %rsp,%rbp
0008   4af80a:	48 8b 4d 08          	mov    0x8(%rbp),%rcx
000c   4af80e:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
0010   4af812:	74 2f                	je     4af843 <__asan_load1+0x41>
0012   4af814:	48 b8 ff ff ff ff ff 7f ff ff 	movabs $0xffff7fffffffffff,%rax
001c   4af81e:	48 39 c7             	cmp    %rax,%rdi
001f   4af821:	76 20                	jbe    4af843 <__asan_load1+0x41>
0021   4af823:	48 89 fa             	mov    %rdi,%rdx
0024   4af826:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0029   4af82b:	48 c1 ea 03          	shr    $0x3,%rdx
002d   4af82f:	48 c1 e0 2a          	shl    $0x2a,%rax
0031   4af833:	8a 04 02             	mov    (%rdx,%rax,1),%al
0034   4af836:	84 c0                	test   %al,%al
0036   4af838:	74 15                	je     4af84f <__asan_load1+0x4d>
0038   4af83a:	89 fa                	mov    %edi,%edx
003a   4af83c:	83 e2 07             	and    $0x7,%edx
003d   4af83f:	38 d0                	cmp    %dl,%al
003f   4af841:	7f 0c                	jg     4af84f <__asan_load1+0x4d>
0041   4af843:	31 d2                	xor    %edx,%edx
0043   4af845:	be 01 00 00 00       	mov    $0x1,%esi
0048   4af84a:	e8 00 00 00 00       	call   4af84f <__asan_load1+0x4d>	4af84b: R_X86_64_PLT32	kasan_report-0x4
004d   4af84f:	5d                   	pop    %rbp
004e   4af850:	c3                   	ret
004f   4af851:	cc                   	int3

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
