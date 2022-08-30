Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413865A60D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiH3KeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3KeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:34:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BFA61F2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661855656; x=1693391656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UmE9G5WYbcf6gjWp81kIsNp2P30UbhH4t6g5LEz3WGo=;
  b=VKn7E4QpsupSwIil7j5x2ytRHcil+kMapwxDBcvUXughw2EbOi8QlvuY
   RA/dV1wJRIdsX+4H5arwWESHVuqQRfVwVx8ibpo2wfqeFGZNFHJALgQzX
   qD20xzzK91CfJcn3W4hahCy3gWrdz87Lz7cmKp0rBL9SpMQ4ip9T1Xgmi
   3y6CJCTiRP5taCRJKSQJ7gewhT+5HFEpgMWf6BvOn7mC/hidXwphgz+2B
   4uN/gS8ZQAZ6ZQPu3HQZCLpWDWfcWZk5cb4ChOsanrzjXItl8U3HtASY9
   SJ3JAleugw7KjLpO1bIpGdQPLU9Iq4n7lo6tRoKFE5F0Uxj3s7FECf+MZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359103329"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="359103329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="753982171"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2022 03:34:13 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSyZQ-0000Be-2m;
        Tue, 30 Aug 2022 10:34:12 +0000
Date:   Tue, 30 Aug 2022 18:33:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 186/314] vmlinux.o: warning:
 objtool: vmw_port_hb_in+0x114: stack state mismatch: cfa1=5+16 cfa2=4+8
Message-ID: <202208301832.2HlmZGf8-lkp@intel.com>
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

Hi Isaku,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 9d5abec402aef6791b3a57d9cefe3cad2dcd2cb9 [186/314] [REVERTME] fix undefined symbol of cc_init
config: x86_64-randconfig-a002-20220829 (https://download.01.org/0day-ci/archive/20220830/202208301832.2HlmZGf8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/9d5abec402aef6791b3a57d9cefe3cad2dcd2cb9
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 9d5abec402aef6791b3a57d9cefe3cad2dcd2cb9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: vmw_port_hb_in+0x114: stack state mismatch: cfa1=5+16 cfa2=4+8
>> vmlinux.o: warning: objtool: vmw_port_hb_out+0x11a: stack state mismatch: cfa1=5+16 cfa2=4+8


objdump-func vmlinux.o vmw_port_hb_in:
0000 000000000098e34a <vmw_port_hb_in>:
0000   98e34a:	55                   	push   %rbp
0001   98e34b:	48 89 e5             	mov    %rsp,%rbp
0004   98e34e:	41 57                	push   %r15
0006   98e350:	49 89 f7             	mov    %rsi,%r15
0009   98e353:	41 56                	push   %r14
000b   98e355:	41 55                	push   %r13
000d   98e357:	49 89 fd             	mov    %rdi,%r13
0010   98e35a:	41 54                	push   %r12
0012   98e35c:	49 89 d4             	mov    %rdx,%r12
0015   98e35f:	53                   	push   %rbx
0016   98e360:	48 83 ec 10          	sub    $0x10,%rsp
001a   98e364:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
0023   98e36d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
0027   98e371:	31 c0                	xor    %eax,%eax
0029   98e373:	84 c9                	test   %cl,%cl
002b   98e375:	75 24                	jne    98e39b <vmw_port_hb_in+0x51>
002d   98e377:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e37e <vmw_port_hb_in+0x34>	98e37a: R_X86_64_PC32	.bss+0x113a6d4
0034   98e37e:	b8 00 00 01 00       	mov    $0x10000,%eax
0039   98e383:	4c 8d 4d c8          	lea    -0x38(%rbp),%r9
003d   98e387:	41 be 68 58 4d 56    	mov    $0x564d5868,%r14d
0043   98e38d:	41 bb 01 00 00 00    	mov    $0x1,%r11d
0049   98e393:	41 ba 1e 00 04 00    	mov    $0x4001e,%r10d
004f   98e399:	eb 76                	jmp    98e411 <vmw_port_hb_in+0xc7>
0051   98e39b:	31 ff                	xor    %edi,%edi
0053   98e39d:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e3a4 <vmw_port_hb_in+0x5a>	98e3a0: R_X86_64_PC32	.bss+0x113a6bc
005a   98e3a4:	e8 00 00 00 00       	call   98e3a9 <vmw_port_hb_in+0x5f>	98e3a5: R_X86_64_PLT32	cc_platform_has-0x4
005f   98e3a9:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e3b0 <vmw_port_hb_in+0x66>	98e3ac: R_X86_64_PC32	.bss+0x113a6c4
0066   98e3b0:	84 c0                	test   %al,%al
0068   98e3b2:	75 c3                	jne    98e377 <vmw_port_hb_in+0x2d>
006a   98e3b4:	41 0f b7 55 00       	movzwl 0x0(%r13),%edx
006f   98e3b9:	41 8b 75 04          	mov    0x4(%r13),%esi
0073   98e3bd:	4c 89 e1             	mov    %r12,%rcx
0076   98e3c0:	4c 89 ff             	mov    %r15,%rdi
0079   98e3c3:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e3ca <vmw_port_hb_in+0x80>	98e3c6: R_X86_64_PC32	.bss+0x113a6cc
0080   98e3ca:	45 8b 45 08          	mov    0x8(%r13),%r8d
0084   98e3ce:	b8 68 58 4d 56       	mov    $0x564d5868,%eax
0089   98e3d3:	bb 00 00 01 00       	mov    $0x10000,%ebx
008e   98e3d8:	c1 e2 10             	shl    $0x10,%edx
0091   98e3db:	83 ca 01             	or     $0x1,%edx
0094   98e3de:	55                   	push   %rbp
0095   98e3df:	4c 89 c5             	mov    %r8,%rbp
0098   98e3e2:	66 ba 59 56          	mov    $0x5659,%dx
009c   98e3e6:	f3 6c                	rep insb (%dx),%es:(%rdi)
009e   98e3e8:	5d                   	pop    %rbp
009f   98e3e9:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e3f0 <vmw_port_hb_in+0xa6>	98e3ec: R_X86_64_PC32	.bss+0x113a6dc
00a6   98e3f0:	48 89 d8             	mov    %rbx,%rax
00a9   98e3f3:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
00ad   98e3f7:	eb 65                	jmp    98e45e <vmw_port_hb_in+0x114>
00af   98e3f9:	4c 89 ff             	mov    %r15,%rdi
00b2   98e3fc:	44 89 c1             	mov    %r8d,%ecx
00b5   98e3ff:	4c 89 ce             	mov    %r9,%rsi
00b8   98e402:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e409 <vmw_port_hb_in+0xbf>	98e405: R_X86_64_PC32	.bss+0x113a71c
00bf   98e409:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
00c1   98e40b:	4d 29 c4             	sub    %r8,%r12
00c4   98e40e:	4d 01 c7             	add    %r8,%r15
00c7   98e411:	4d 85 e4             	test   %r12,%r12
00ca   98e414:	74 41                	je     98e457 <vmw_port_hb_in+0x10d>
00cc   98e416:	41 0f b7 55 00       	movzwl 0x0(%r13),%edx
00d1   98e41b:	41 8b 75 04          	mov    0x4(%r13),%esi
00d5   98e41f:	44 89 f0             	mov    %r14d,%eax
00d8   98e422:	44 89 db             	mov    %r11d,%ebx
00db   98e425:	41 b8 04 00 00 00    	mov    $0x4,%r8d
00e1   98e42b:	41 8b 7d 08          	mov    0x8(%r13),%edi
00e5   98e42f:	44 89 d1             	mov    %r10d,%ecx
00e8   98e432:	4d 39 c4             	cmp    %r8,%r12
00eb   98e435:	4d 0f 46 c4          	cmovbe %r12,%r8
00ef   98e439:	c1 e2 10             	shl    $0x10,%edx
00f2   98e43c:	66 ba 58 56          	mov    $0x5658,%dx
00f6   98e440:	ed                   	in     (%dx),%eax
00f7   98e441:	0f ba e1 10          	bt     $0x10,%ecx
00fb   98e445:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
00ff   98e449:	48 89 c8             	mov    %rcx,%rax
0102   98e44c:	72 ab                	jb     98e3f9 <vmw_port_hb_in+0xaf>
0104   98e44e:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e455 <vmw_port_hb_in+0x10b>	98e451: R_X86_64_PC32	.bss+0x113a6e4
010b   98e455:	eb 07                	jmp    98e45e <vmw_port_hb_in+0x114>
010d   98e457:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 98e45e <vmw_port_hb_in+0x114>	98e45a: R_X86_64_PC32	.bss+0x113a724
0114   98e45e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0118   98e462:	65 48 2b 14 25 28 00 00 00 	sub    %gs:0x28,%rdx
0121   98e46b:	74 05                	je     98e472 <vmw_port_hb_in+0x128>
0123   98e46d:	e8 00 00 00 00       	call   98e472 <vmw_port_hb_in+0x128>	98e46e: R_X86_64_PLT32	__stack_chk_fail-0x4
0128   98e472:	5a                   	pop    %rdx
0129   98e473:	59                   	pop    %rcx
012a   98e474:	5b                   	pop    %rbx
012b   98e475:	41 5c                	pop    %r12
012d   98e477:	41 5d                	pop    %r13
012f   98e479:	41 5e                	pop    %r14
0131   98e47b:	41 5f                	pop    %r15
0133   98e47d:	5d                   	pop    %rbp
0134   98e47e:	31 d2                	xor    %edx,%edx
0136   98e480:	31 c9                	xor    %ecx,%ecx
0138   98e482:	31 f6                	xor    %esi,%esi
013a   98e484:	31 ff                	xor    %edi,%edi
013c   98e486:	45 31 c0             	xor    %r8d,%r8d
013f   98e489:	45 31 c9             	xor    %r9d,%r9d
0142   98e48c:	45 31 d2             	xor    %r10d,%r10d
0145   98e48f:	45 31 db             	xor    %r11d,%r11d
0148   98e492:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
