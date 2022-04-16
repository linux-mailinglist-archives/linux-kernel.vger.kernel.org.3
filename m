Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C047750347F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiDPGlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDPGlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:41:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99137100E0E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:38:44 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KgNmp6FmVz1HC0n;
        Sat, 16 Apr 2022 14:38:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 14:38:42 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 14:38:41 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>,
        <acme@redhat.com>, <irogers@google.com>, <f.fainelli@gmail.com>,
        <mpetlan@redhat.com>, <leo.yan@linaro.org>, <john@metanate.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf llvm: fix check feature libclang faled to cope with latest llvm
Date:   Sat, 16 Apr 2022 14:37:43 +0800
Message-ID: <20220416063743.254755-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For llvm13, perf build check libclang failed even if llmv libraries have been
installed in the system. The output file is as follows:

  # cat ./build/feature/test-clang.make.output
  /usr/local/lib/libLLVMSupport.a(Path.cpp.o): In function `llvm::sys::fs::expandTildeExpr(llvm::SmallVectorImpl<char>&)':
  Path.cpp:(.text._ZN4llvm3sys2fsL15expandTildeExprERNS_15SmallVectorImplIcEE+0x13b): warning: Using 'getpwnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
  /usr/local/lib/libLLVMSupport.a(Path.cpp.o): In function `llvm::sys::path::home_directory(llvm::SmallVectorImpl<char>&) [clone .localalias.6]':
  Path.cpp:(.text._ZN4llvm3sys4path14home_directoryERNS_15SmallVectorImplIcEE+0x88): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
  /usr/local/lib/libclangDriver.a(Darwin.cpp.o): In function `clang::driver::toolchains::Darwin::addProfileRTLibs(llvm::opt::ArgList const&, llvm::SmallVector<char const*, 16u>&) const':
  Darwin.cpp:(.text._ZNK5clang6driver10toolchains6Darwin16addProfileRTLibsERKN4llvm3opt7ArgListERNS3_11SmallVectorIPKcLj16EEE+0x217): undefined reference to `llvm::getInstrProfSectionName[abi:cxx11](llvm::InstrProfSectKind, llvm::Triple::ObjectFormatType, bool)'
  collect2: error: ld returned 1 exit status

Because relevant link library is missing. For llvm13, getInstrProfSectionName
interface is in libLLVMInstrumentation, which is part of BPF component library.

The solution has been verified in the llvm13 environment, as following:

  # make OUTPUT= CC=gcc CXX=g++ CFLAGS=  CXXFLAGS=  \
    LDFLAGS="-static -Wl,-z,noexecstack"  \
    -C /home/aa/linux/tools/build/feature test-clang.bin V=1
  make: Entering directory '/home/aa/linux/tools/build/feature'
  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp -static -Wl,-z,noexecstack > test-clang.make.output 2>&1 -std=gnu++14                                   \
          -I/usr/local/include            \
          -L/usr/local/lib                \
          -Wl,--start-group -lclangBasic -lclangDriver    \
            -lclangFrontend -lclangEdit -lclangLex        \
            -lclangAST -Wl,--end-group                    \
          -lLLVMBPFDisassembler -lLLVMMCDisassembler -lLLVMBPFAsmParser -lLLVMBPFCodeGen -lLLVMSelectionDAG -lLLVMipo -lLLVMInstrumentation -lLLVMVectorize -lLLVMLinker -lLLVMIRReader -lLLVMAsmParser -lLLVMFrontendOpenMP -lLLVMBPFDesc -lLLVMBPFInfo -lLLVMAsmPrinter -lLLVMDebugInfoMSF -lLLVMDebugInfoDWARF -lLLVMCodeGen -lLLVMTarget -lLLVMScalarOpts -lLLVMInstCombine -lLLVMAggressiveInstCombine -lLLVMTransformUtils -lLLVMBitWriter -lLLVMAnalysis -lLLVMProfileData -lLLVMObject -lLLVMTextAPI -lLLVMMCParser -lLLVMMC -lLLVMDebugInfoCodeView -lLLVMBitReader -lLLVMOption -lLLVMCore -lLLVMRemarks -lLLVMBitstreamReader -lLLVMBinaryFormat -lLLVMSupport -lLLVMDemangle    \
          -lrt -ldl -lpthread -lm -lz -ltinfo -lxml2              \
          > test-clang.make.output 2>&1
  make: Leaving directory '/home/aa/linux/tools/build/feature'

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index de66e1cc0734..af667972cb88 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -322,7 +322,7 @@ $(OUTPUT)test-clang.bin:
 		-Wl,--start-group -lclangBasic -lclangDriver	\
 		  -lclangFrontend -lclangEdit -lclangLex	\
 		  -lclangAST -Wl,--end-group 			\
-		$(shell $(LLVM_CONFIG) --libs Core option)	\
+		$(shell $(LLVM_CONFIG) --libs Core option BPF)	\
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
 
-- 
2.30.GIT

