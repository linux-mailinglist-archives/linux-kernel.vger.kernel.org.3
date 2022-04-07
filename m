Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B684F7E94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbiDGMFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiDGMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:04:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B8C1CBE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:02:36 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ0Lh49pyzFpZ4;
        Thu,  7 Apr 2022 20:00:12 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:32 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:32 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>
Subject: [RFC PATCH v3 00/13] objtool: add base support for arm64
Date:   Thu, 7 Apr 2022 20:01:28 +0800
Message-ID: <20220407120141.43801-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables objtool to start doing stack validation on arm64
kernel builds.

The work for objtool has been stopped for a while. Julien and
Raphael worked for this [1] but it seems now nobody is carrying it
on.

To re-bring it to people's vision, this v3 update just makes some
simply changes including rebasing to mainline, code cleanning and
one bug fix.

Previous patch had finished the decoder part of objtool. It passed
my building test with allyesconfig and only few of objfile report
error. Julien had some unorganized commits in his repo [2], mainly
about changes to arm64 code to eliminate some of these errors.

While fixing these problems in next version, I'm also planning to
implement the orc unwinder for arm64, then we can completely test
everything on arm64.

[1] https://lkml.org/lkml/2021/3/3/1135
[2] https://github.com/julien-thierry/linux.git
---
Changs v2 -> v3:
- [04] rebase Julien's version to mainstream and solve conflicts.
- [05, 06, 08] Merge dumplicate "*type = INSN_OTHER".
- [08, 09, 10] When meeting unrecognized instructions such as  datas
	in .text code or 0x0 padding insns, last version used
	"loc->ignorable" to mark and remove them from objtool insn list.

	However there are two problems to do so:
	1. when meeting insns can't be decoded or excluded, objtool will
	just stop.
	2. deleting every insn can cause problems in fellow procedure.

	So I changed "record_invalid_insn" that we can delete one insn or
	just set it ignored. Now check will throw an error and going on when
	meeting undecodable instructions. Also, to prevent the confusion
	between "loc->ignorable" and "insn->ignore" I changed "ignore" to
	"delete".

Changs v1 -> v2:
- Drop gcc plugin in favor of -fno-jump-tables
- miscelaneous fixes and cleanups

--->
Julien Thierry (12):
  tools: Add some generic functions and headers
  tools: arm64: Make aarch64 instruction decoder available to tools
  tools: bug: Remove duplicate definition
  objtool: arm64: Add base definition for arm64 backend
  objtool: arm64: Decode add/sub instructions
  objtool: arm64: Decode jump and call related instructions
  objtool: arm64: Decode other system instructions
  objtool: arm64: Decode load/store instructions
  objtool: arm64: Decode LDR instructions
  objtool: arm64: Accept non-instruction data in code sections
  objtool: arm64: Handle supported relocations in alternatives
  objtool: arm64: Ignore replacement section for alternative callback

Raphael Gault (1):
  objtool: arm64: Enable stack validation for arm64

 arch/arm64/Kconfig                            |    1 +
 arch/arm64/Makefile                           |    4 +
 tools/arch/arm64/include/asm/insn.h           |  565 +++++++
 tools/arch/arm64/lib/insn.c                   | 1464 +++++++++++++++++
 tools/include/asm-generic/bitops/__ffs.h      |   11 +
 tools/include/linux/bug.h                     |    6 +-
 tools/include/linux/kernel.h                  |   21 +
 tools/include/linux/printk.h                  |   40 +
 tools/objtool/Makefile                        |    5 +
 tools/objtool/arch/arm64/Build                |    8 +
 tools/objtool/arch/arm64/decode.c             |  500 ++++++
 .../arch/arm64/include/arch/cfi_regs.h        |   14 +
 tools/objtool/arch/arm64/include/arch/elf.h   |    8 +
 .../arch/arm64/include/arch/endianness.h      |    9 +
 .../objtool/arch/arm64/include/arch/special.h |   22 +
 tools/objtool/arch/arm64/special.c            |   36 +
 tools/objtool/arch/x86/decode.c               |    5 +
 tools/objtool/check.c                         |    6 +
 tools/objtool/include/objtool/arch.h          |    3 +
 tools/objtool/sync-check.sh                   |    5 +
 20 files changed, 2728 insertions(+), 5 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/insn.h
 create mode 100644 tools/arch/arm64/lib/insn.c
 create mode 100644 tools/include/linux/printk.h
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

-- 
2.17.1

