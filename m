Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029AC58C7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiHHLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiHHLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:49:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932BB1401C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:49:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278BY1Ak011491;
        Mon, 8 Aug 2022 11:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TUk20v686jjVDbNCF1C6cMxuvG5lTGNKhANJW0otYCY=;
 b=NM2PVCnPmYJkCRdV/MKQ7dmGWMRO23MHpXlygQWcbAorT/rGvS16vivPvXS/dc7Wy00c
 P3yOX5thoJn87pWNDmcUlL8ZlQLSPidZPmK3sXWF0wU7O6jINGUqE7bQ/scDNqCBD5pb
 W8v5hcor6bUwzFD/wnb5Q60YpfrJclMM2P6hejEL9OYBrld4w2Sk5TTdARiYDZJmxWcl
 qkvjoS2Hmd7LROf3/F9+NTXNjfyffgJIOMs7zPnxhwZU0ZWXpmjofzjVySR45Gx3TcOD
 MLOwSdTXrWxqOHBaDmM2q9gyFPJEyap8gCrHn5bkpRw6OQoQpKi/D1deIwHqx9cq/vg6 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1qrgcsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:49:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278BYn0j018598;
        Mon, 8 Aug 2022 11:49:23 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1qrgcs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:49:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278BcwCc023040;
        Mon, 8 Aug 2022 11:49:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3hsfx8sk2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:49:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278BnIRw25952636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 11:49:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB0011C054;
        Mon,  8 Aug 2022 11:49:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF52311C04C;
        Mon,  8 Aug 2022 11:49:14 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.59.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 11:49:14 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH 00/16] objtool: Enable and implement --mcount option on powerpc
Date:   Mon,  8 Aug 2022 17:18:52 +0530
Message-Id: <20220808114908.240813-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PEwyEVFKuEEdmaqyfM3rlav85oiEHxEf
X-Proofpoint-GUID: 9ZS9fp7TodVg2Gebqr5x_xMGlE71wh4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=923 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables and implements objtool --mcount
option on powerpc. This applies atop powerpc/merge branch.


Christophe Leroy (4):
  objtool: Fix SEGFAULT
  objtool: Use target file endianness instead of a compiled constant
  objtool: Use target file class size instead of a compiled constant
  powerpc: Fix objtool unannotated intra-function call warnings on PPC32

Sathvika Vasireddy (12):
  powerpc: Replace unreachable() with it's builtin variant in WARN_ON()
  powerpc: override __ALIGN() and __ALIGN_STR() macros
  powerpc: Fix objtool unannotated intra-function call warnings
  powerpc: curb objtool unannotated intra-function call warnings
  powerpc: Skip objtool from running on drivers/crypto/vmx/aesp8-ppc.o
  powerpc: Skip objtool from running on VDSO files
  objtool: Add --mnop as an option to --mcount
  objtool: Read special sections with alts only when specific options are selected
  objtool: Use macros to define arch specific reloc types
  objtool: Add arch specific function arch_ftrace_match()
  objtool/powerpc: Enable objtool to be built on ppc
  objtool/powerpc: Add --mcount specific implementation

 Makefile                                      |  4 +-
 arch/powerpc/Kconfig                          |  2 +
 arch/powerpc/include/asm/asm.h                |  7 ++
 arch/powerpc/include/asm/bug.h                |  2 +-
 arch/powerpc/include/asm/linkage.h            |  4 +
 arch/powerpc/kernel/cpu_setup_6xx.S           | 26 +++--
 arch/powerpc/kernel/cpu_setup_fsl_booke.S     |  8 +-
 arch/powerpc/kernel/entry_32.S                |  8 +-
 arch/powerpc/kernel/entry_64.S                |  2 +
 arch/powerpc/kernel/exceptions-64s.S          |  7 +-
 arch/powerpc/kernel/head_40x.S                |  5 +-
 arch/powerpc/kernel/head_64.S                 |  7 +-
 arch/powerpc/kernel/head_8xx.S                |  5 +-
 arch/powerpc/kernel/head_book3s_32.S          | 29 ++++--
 arch/powerpc/kernel/head_fsl_booke.S          |  5 +-
 arch/powerpc/kernel/misc_64.S                 |  4 +-
 arch/powerpc/kernel/swsusp_32.S               |  5 +-
 arch/powerpc/kernel/vdso/Makefile             |  2 +
 arch/powerpc/kernel/vector.S                  |  4 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S       |  4 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       | 25 +++--
 arch/powerpc/kvm/fpu.S                        | 17 +++-
 arch/powerpc/platforms/52xx/lite5200_sleep.S  | 15 ++-
 arch/x86/Kconfig                              |  1 +
 drivers/crypto/vmx/Makefile                   |  2 +
 scripts/Makefile.lib                          |  1 +
 tools/objtool/arch/powerpc/Build              |  2 +
 tools/objtool/arch/powerpc/decode.c           | 96 +++++++++++++++++++
 .../arch/powerpc/include/arch/cfi_regs.h      | 11 +++
 tools/objtool/arch/powerpc/include/arch/elf.h | 10 ++
 .../arch/powerpc/include/arch/special.h       | 21 ++++
 tools/objtool/arch/powerpc/special.c          | 19 ++++
 tools/objtool/arch/x86/decode.c               |  8 ++
 tools/objtool/arch/x86/include/arch/elf.h     |  2 +
 .../arch/x86/include/arch/endianness.h        |  9 --
 tools/objtool/builtin-check.c                 | 14 +++
 tools/objtool/check.c                         | 51 +++++-----
 tools/objtool/elf.c                           |  8 +-
 tools/objtool/include/objtool/arch.h          |  2 +
 tools/objtool/include/objtool/builtin.h       |  1 +
 tools/objtool/include/objtool/elf.h           |  8 ++
 tools/objtool/include/objtool/endianness.h    | 32 +++----
 tools/objtool/orc_dump.c                      | 11 ++-
 tools/objtool/orc_gen.c                       |  4 +-
 tools/objtool/special.c                       |  3 +-
 45 files changed, 408 insertions(+), 105 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm.h
 create mode 100644 tools/objtool/arch/powerpc/Build
 create mode 100644 tools/objtool/arch/powerpc/decode.c
 create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
 create mode 100644 tools/objtool/arch/powerpc/special.c
 delete mode 100644 tools/objtool/arch/x86/include/arch/endianness.h

-- 
2.31.1

