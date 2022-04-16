Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F3503820
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiDPUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiDPUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D21A220F4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39221B8068B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 20:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E3EC385A1;
        Sat, 16 Apr 2022 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650139542;
        bh=jn4Fb0p0zgj69wGu+MIl+KAGiIxgEfyKdhe6W43bRZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7qTAyLqnZIdl5oWNxK1ausGVD7347i93yHwlX0b47meqTJLg9tDX/HUgYEZQZ4CC
         cS815bJiX4+fTaY69yBf2zQiWXUaerb3G/4uuDr+RYjD0xEyrySeKarXFzQv2JI9nC
         pP0m2NHaVBrbQSvLu4kTMmrOdIjZG9UcM+qi/vu5sgK/0EtQC0ZtFIyf6+ftAQOcTH
         N7abYiRKpyJSY8sO1VKoEGZQuN9NS+SfAkIxoDsnSyXmRHnee6S4Qi4j8C5nro93X8
         2i4UcBlddllzCrqZgo/0r99AqXSia84XlZp14OOhn3tXdhJSFVSDlwT1fmov+KVPXW
         nyXtTOX8NzXhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDFC940407; Sat, 16 Apr 2022 17:05:39 -0300 (-03)
Date:   Sat, 16 Apr 2022 17:05:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf clang: Fix header include for LLVM >= 14
Message-ID: <Ylshkzt+vx7yoOmF@kernel.org>
References: <Ylp0M/VYgHOxtcnF@gentoo.org>
 <YlsfaBgLZvOLAmvD@kernel.org>
 <Ylsf3v4g3ztJPwjQ@kernel.org>
 <YlsgaJEuCQIJnhn4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlsgaJEuCQIJnhn4@kernel.org>
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

Em Sat, Apr 16, 2022 at 05:00:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Apr 16, 2022 at 04:58:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Apr 16, 2022 at 04:56:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Sat, Apr 16, 2022 at 09:45:55AM +0200, Guilherme Amadio escreveu:
> > > > The header TargetRegistry.h has moved in LLVM/clang 14.
> > 
> > > And that part : /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a
> > > seems to imply its llvm 10 that is installed, lemme check:
> > > 
> > > [perfbuilder@five ~]$ dsh ubuntu:20.04
> > > $ bash
> > > perfbuilder@7cfe87e48135:/$ dpkg -l | grep llvm
> > > ii  libllvm10:amd64                    1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, runtime library
> > > ii  libllvm12:amd64                    1:12.0.0-3ubuntu1~20.04.5         amd64        Modular compiler and toolchain technologies, runtime library
> > > ii  llvm                               1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM)
> > > ii  llvm-10                            1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies
> > > ii  llvm-10-dev                        1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, libraries and headers
> > > ii  llvm-10-runtime                    1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, IR interpreter
> > > ii  llvm-10-tools                      1:10.0.0-4ubuntu1                 amd64        Modular compiler and toolchain technologies, tools
> > > ii  llvm-dev                           1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM), libraries and headers
> > > ii  llvm-runtime                       1:10.0-50~exp1                    amd64        Low-Level Virtual Machine (LLVM), bytecode interpreter
> > > perfbuilder@7cfe87e48135:/$ dpkg -l | grep clang
> > > ii  clang                              1:10.0-50~exp1                    amd64        C, C++ and Objective-C compiler (LLVM based)
> > > ii  clang-10                           1:10.0.0-4ubuntu1                 amd64        C, C++ and Objective-C compiler
> > > ii  libclang-10-dev                    1:10.0.0-4ubuntu1                 amd64        Clang library - Development package
> > > ii  libclang-common-10-dev             1:10.0.0-4ubuntu1                 amd64        Clang library - Common development package
> > > ii  libclang-cpp10                     1:10.0.0-4ubuntu1                 amd64        C++ interface to the Clang library
> > > ii  libclang-dev                       1:10.0-50~exp1                    amd64        clang library - Development package
> > > ii  libclang1-10                       1:10.0.0-4ubuntu1                 amd64        C interface to the Clang library
> > > perfbuilder@7cfe87e48135:/$
> > > 
> > > Yeah, so I'll try making it test >= 10, lets see...
> > 
> > perfbuilder@7cfe87e48135:/$ find /usr -name TargetRegistry.h
> > /usr/include/llvm-10/llvm/Support/TargetRegistry.h
> > perfbuilder@7cfe87e48135:/$
> > 
> 
> Sorry, your fix is for the ubuntu 22.04 problem, not the 20.04 one,
> retesting...

Thanks, applied, the bug is fixed on ubuntu 22.04.

- Arnaldo
