Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5795953DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiHPHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiHPHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:34:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5293342F8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660623648; x=1692159648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ss3JPIsizc4O1hbW1uiOpuh5DzbDeJaGxu7EbeugaE=;
  b=S7J1/7eyX2Vl6mjHjjz5jcdOet6uQj+kB8CI0Bl+RldMu30C24UAcl4A
   NVR5FDC91kCVkqgQ1bR5U6a+7pAfwD9yDy7+p4QWfI1e1SPEujZXo/yUk
   vQSOILlQIlHcIbQk37JddqIT+a4h0QyiOfMX3QngAcIoWS6c0f6CtGeOb
   WTMX4up03ANXCmhFKxVojly0F3JmRHHK7US8e6ndcgiboeO1gMvIybv7V
   Qck8Rd+Dc7a2m23s2FS/sE6pfJ2nuFQ+j5rvKommovvPFeHMyu6CXu1h3
   rqk4KBesc6/oznRF3fM7btAg126Woh5B1kRjL7zXHzPPtsoxdI7v1IHKx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="318112048"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="318112048"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733152958"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2022 21:20:45 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNo4L-0001SR-11;
        Tue, 16 Aug 2022 04:20:45 +0000
Date:   Tue, 16 Aug 2022 12:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 33/59] vmlinux.o:
 warning: objtool: __asan_store16+0xc6: return with UACCESS disabled from a
 UACCESS-safe function
Message-ID: <202208161228.E0YHsmq2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   9bbf33b92f4c755dd56f4d9bc1b40e94fdd1fff7
commit: c5803edfd11acd1bb56cd1878381c0c8b0902828 [33/59] objtool: Fix find_{symbol,func}_containing()
config: x86_64-randconfig-m001-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161228.E0YHsmq2-lkp@intel.com/config)
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

>> vmlinux.o: warning: objtool: __asan_store16+0xc6: return with UACCESS disabled from a UACCESS-safe function
>> vmlinux.o: warning: objtool: __asan_load16+0xb8: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_store8_noabort+0xd4: return with UACCESS enabled
>> vmlinux.o: warning: objtool: __asan_load8+0xce: return with UACCESS disabled from a UACCESS-safe function
>> vmlinux.o: warning: objtool: __asan_store4+0xda: return with UACCESS disabled from a UACCESS-safe function
>> vmlinux.o: warning: objtool: __asan_load4+0xd4: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_store2_noabort+0xc8: return with UACCESS enabled
>> vmlinux.o: warning: objtool: __asan_load2+0xc2: return with UACCESS disabled from a UACCESS-safe function
>> vmlinux.o: warning: objtool: __asan_store1+0xbb: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_load1_noabort+0xb5: return with UACCESS enabled
>> vmlinux.o: warning: objtool: __asan_storeN+0x34: return with UACCESS disabled from a UACCESS-safe function
   vmlinux.o: warning: objtool: __asan_loadN_noabort+0x31: return with UACCESS enabled


objdump-func vmlinux.o __asan_store16:
0000 00000000008cb8c0 <__asan_store16>:
0000   8cb8c0:	f3 0f 1e fa          	endbr64
0004   8cb8c4:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb8cc <__asan_store16+0xc>	8cb8c7: R_X86_64_PC32	.bss+0xe7439b
000c   8cb8cc:	48 8b 0c 24          	mov    (%rsp),%rcx
0010   8cb8d0:	48 83 ff ef          	cmp    $0xffffffffffffffef,%rdi
0014   8cb8d4:	0f 87 83 00 00 00    	ja     8cb95d <__asan_store16+0x9d>
001a   8cb8da:	48 b8 ff ff ff ff ff 7f ff ff 	movabs $0xffff7fffffffffff,%rax
0024   8cb8e4:	48 39 c7             	cmp    %rax,%rdi
0027   8cb8e7:	0f 86 9b 00 00 00    	jbe    8cb988 <__asan_store16+0xc8>
002d   8cb8ed:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0037   8cb8f7:	48 89 fa             	mov    %rdi,%rdx
003a   8cb8fa:	48 c1 ea 03          	shr    $0x3,%rdx
003e   8cb8fe:	0f b7 14 02          	movzwl (%rdx,%rax,1),%edx
0042   8cb902:	40 f6 c7 07          	test   $0x7,%dil
0046   8cb906:	75 19                	jne    8cb921 <__asan_store16+0x61>
0048   8cb908:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb910 <__asan_store16+0x50>	8cb90b: R_X86_64_PC32	.bss+0xe743cb
0050   8cb910:	66 85 d2             	test   %dx,%dx
0053   8cb913:	75 1d                	jne    8cb932 <__asan_store16+0x72>
0055   8cb915:	31 c0                	xor    %eax,%eax
0057   8cb917:	31 d2                	xor    %edx,%edx
0059   8cb919:	31 c9                	xor    %ecx,%ecx
005b   8cb91b:	31 f6                	xor    %esi,%esi
005d   8cb91d:	31 ff                	xor    %edi,%edi
005f   8cb91f:	c3                   	ret
0060   8cb920:	cc                   	int3
0061   8cb921:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb929 <__asan_store16+0x69>	8cb924: R_X86_64_PC32	.bss+0xe743c3
0069   8cb929:	66 85 d2             	test   %dx,%dx
006c   8cb92c:	0f 84 81 00 00 00    	je     8cb9b3 <__asan_store16+0xf3>
0072   8cb932:	ba 01 00 00 00       	mov    $0x1,%edx
0077   8cb937:	be 10 00 00 00       	mov    $0x10,%esi
007c   8cb93c:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb944 <__asan_store16+0x84>	8cb93f: R_X86_64_PC32	.bss+0xe743eb
0084   8cb944:	e8 00 00 00 00       	call   8cb949 <__asan_store16+0x89>	8cb945: R_X86_64_PLT32	kasan_report-0x4
0089   8cb949:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb951 <__asan_store16+0x91>	8cb94c: R_X86_64_PC32	.bss+0xe743f3
0091   8cb951:	31 c0                	xor    %eax,%eax
0093   8cb953:	31 d2                	xor    %edx,%edx
0095   8cb955:	31 c9                	xor    %ecx,%ecx
0097   8cb957:	31 f6                	xor    %esi,%esi
0099   8cb959:	31 ff                	xor    %edi,%edi
009b   8cb95b:	c3                   	ret
009c   8cb95c:	cc                   	int3
009d   8cb95d:	ba 01 00 00 00       	mov    $0x1,%edx
00a2   8cb962:	be 10 00 00 00       	mov    $0x10,%esi
00a7   8cb967:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb96f <__asan_store16+0xaf>	8cb96a: R_X86_64_PC32	.bss+0xe743a3
00af   8cb96f:	e8 00 00 00 00       	call   8cb974 <__asan_store16+0xb4>	8cb970: R_X86_64_PLT32	kasan_report-0x4
00b4   8cb974:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb97c <__asan_store16+0xbc>	8cb977: R_X86_64_PC32	.bss+0xe743ab
00bc   8cb97c:	31 c0                	xor    %eax,%eax
00be   8cb97e:	31 d2                	xor    %edx,%edx
00c0   8cb980:	31 c9                	xor    %ecx,%ecx
00c2   8cb982:	31 f6                	xor    %esi,%esi
00c4   8cb984:	31 ff                	xor    %edi,%edi
00c6   8cb986:	c3                   	ret
00c7   8cb987:	cc                   	int3
00c8   8cb988:	ba 01 00 00 00       	mov    $0x1,%edx
00cd   8cb98d:	be 10 00 00 00       	mov    $0x10,%esi
00d2   8cb992:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb99a <__asan_store16+0xda>	8cb995: R_X86_64_PC32	.bss+0xe743b3
00da   8cb99a:	e8 00 00 00 00       	call   8cb99f <__asan_store16+0xdf>	8cb99b: R_X86_64_PLT32	kasan_report-0x4
00df   8cb99f:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb9a7 <__asan_store16+0xe7>	8cb9a2: R_X86_64_PC32	.bss+0xe743bb
00e7   8cb9a7:	31 c0                	xor    %eax,%eax
00e9   8cb9a9:	31 d2                	xor    %edx,%edx
00eb   8cb9ab:	31 c9                	xor    %ecx,%ecx
00ed   8cb9ad:	31 f6                	xor    %esi,%esi
00ef   8cb9af:	31 ff                	xor    %edi,%edi
00f1   8cb9b1:	c3                   	ret
00f2   8cb9b2:	cc                   	int3
00f3   8cb9b3:	48 8d 57 0f          	lea    0xf(%rdi),%rdx
00f7   8cb9b7:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb9bf <__asan_store16+0xff>	8cb9ba: R_X86_64_PC32	.bss+0xe743d3
00ff   8cb9bf:	48 89 d6             	mov    %rdx,%rsi
0102   8cb9c2:	48 c1 ee 03          	shr    $0x3,%rsi
0106   8cb9c6:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
010a   8cb9ca:	84 c0                	test   %al,%al
010c   8cb9cc:	0f 84 43 ff ff ff    	je     8cb915 <__asan_store16+0x55>
0112   8cb9d2:	83 e2 07             	and    $0x7,%edx
0115   8cb9d5:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb9dd <__asan_store16+0x11d>	8cb9d8: R_X86_64_PC32	.bss+0xe743db
011d   8cb9dd:	38 d0                	cmp    %dl,%al
011f   8cb9df:	0f 8f 30 ff ff ff    	jg     8cb915 <__asan_store16+0x55>
0125   8cb9e5:	48 83 05 00 00 00 00 01 	addq   $0x1,0x0(%rip)        # 8cb9ed <__asan_store16+0x12d>	8cb9e8: R_X86_64_PC32	.bss+0xe743e3
012d   8cb9ed:	e9 40 ff ff ff       	jmp    8cb932 <__asan_store16+0x72>
0132   8cb9f2:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
013d   8cb9fd:	0f 1f 00             	nopl   (%rax)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
