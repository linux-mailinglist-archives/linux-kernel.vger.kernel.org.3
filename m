Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF931503818
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 21:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiDPT7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiDPT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119CB25DC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E9860FF4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 19:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1541C385A3;
        Sat, 16 Apr 2022 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650138988;
        bh=aYoQzfkZ61GnJUgFF7EQ48Vb9Zro8mnlUVqTGSZT3Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg/CIaPngKZyroBXc+AA08J1pojupWfP7JVLQSUWS6OfDLCNfoRST/YGFkhyjTqAU
         HMTfl2FIK8R7/MfGDvfGWpjR3T1bHxyzvdRs3C33WEyZL/KFphU1iBsG0V5QCeg92Z
         rjUL4VxVLh9iAWoesN+JBRxkbte304P1LmuhRthf3zjOGkUhmFspbyfO97hF/QbrH0
         aU7EyXqPHxVS2MX3XleTRfmrjiPLo7SkkKK5wHnFPbsAbCroLGBWmRnhuUgIm9MRmG
         lV42vPsIvMbu+krVJ22t0nBnqeMmuBlmOaS0QquVI4LFM/NvX3RZFzpnz0hgARwPY7
         IkUC6SisM7ngg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8ACD40407; Sat, 16 Apr 2022 16:56:24 -0300 (-03)
Date:   Sat, 16 Apr 2022 16:56:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf clang: Fix header include for LLVM >= 14
Message-ID: <YlsfaBgLZvOLAmvD@kernel.org>
References: <Ylp0M/VYgHOxtcnF@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylp0M/VYgHOxtcnF@gentoo.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 16, 2022 at 09:45:55AM +0200, Guilherme Amadio escreveu:
> The header TargetRegistry.h has moved in LLVM/clang 14.
> 
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>

Applied and ammended the commit log message with some extra info
about the problem, this is the end result:

perf clang: Fix header include for LLVM >= 14

The header TargetRegistry.h has moved in LLVM/clang 14.

Committer notes:

The problem as noticed when building in ubuntu:20.04 with this command
line:

  $ make LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf

  /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
  (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  make[2]: *** [Makefile.perf:677: /tmp/build/perf/perf] Error 1
  make[1]: *** [Makefile.perf:240: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

Fixed after applying this patch.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://twitter.com/GuilhermeAmadio/status/1514970524232921088
Link: http://lore.kernel.org/lkml/Ylp0M/VYgHOxtcnF@gentoo.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

But then the container build just finished and the problem is still
there :-\

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf CC=clang
<SNIP>
  LD      /tmp/build/perf/perf-in.o
  LINK    /tmp/build/perf/perf
/usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
(.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [Makefile.perf:677: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-5.18.0-rc2/tools/perf'
+ exit 1
[perfbuilder@five ~]$
[perfbuilder@five ~]$

And that part : /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a
seems to imply its llvm 10 that is installed, lemme check:

[perfbuilder@five ~]$ dsh ubuntu:20.04
$ bash
perfbuilder@7cfe87e48135:/$ dpkg -l | grep llvm
ii  libllvm10:amd64                    1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, runtime library
ii  libllvm12:amd64                    1:12.0.0-3ubuntu1~20.04.5         amd64        Modular compiler and toolchain technologies, runtime library
ii  llvm                               1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM)
ii  llvm-10                            1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies
ii  llvm-10-dev                        1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, libraries and headers
ii  llvm-10-runtime                    1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, IR interpreter
ii  llvm-10-tools                      1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, tools
ii  llvm-dev                           1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM), libraries and headers
ii  llvm-runtime                       1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM), bytecode interpreter
perfbuilder@7cfe87e48135:/$ dpkg -l | grep clang
ii  clang                              1:10.0-50~exp1                    amd64        C, C++ and Objective-C compiler (LLVM based)
ii  clang-10                           1:10.0.0-4ubuntu1                 amd64        C, C++ and Objective-C compiler
ii  libclang-10-dev                    1:10.0.0-4ubuntu1                 amd64        Clang library - Development package
ii  libclang-common-10-dev             1:10.0.0-4ubuntu1                 amd64        Clang library - Common development package
ii  libclang-cpp10                     1:10.0.0-4ubuntu1                 amd64        C++ interface to the Clang library
ii  libclang-dev                       1:10.0-50~exp1                    amd64        clang library - Development package
ii  libclang1-10                       1:10.0.0-4ubuntu1                 amd64        C interface to the Clang library
perfbuilder@7cfe87e48135:/$

Yeah, so I'll try making it test >= 10, lets see...

- Arnaldo
