Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F34E8536
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 04:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiC0C5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 22:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiC0C5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 22:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F373C41981;
        Sat, 26 Mar 2022 19:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E037B80BA9;
        Sun, 27 Mar 2022 02:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879D2C340E8;
        Sun, 27 Mar 2022 02:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648349731;
        bh=NPWbAvL7cuLkuOpOb1ozj+CvWozFHnqgxcgdL9eIxEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KXZ4yBSETfpeuCbiDs/Eg4c8vd6dM7q/8f8f6ICue6C/PlIQQu/CscOlIInFuc76K
         mtG+Y9PPfoeoCpZkgMo4bzgX1qG1FbttNsaB/J8jVkZA+XIcg+pe/WWLobZ1HoZwk7
         ryhGkIO3cMFKwP+I0iC4JyL2vSXP0fE31y5uppAge+W29T6y70+wGgyO45aIlVx5GG
         A/3yQfcK/ro/rmLGtltu9JCNScYKDetw1p0IKLVQ6Ztj/FIN2S9+0M6fxkr0svVFUC
         2NB7NMs5hsqnb4lHEszaONO+7fvE6zr9gbqe1N/vuLMk+p+WzRpwleAgSRhj1RORfS
         a+5oNkkoXekvQ==
Date:   Sun, 27 Mar 2022 11:55:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
Message-Id: <20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org>
In-Reply-To: <164833878595.2575750.1483106296151574233.stgit@devnote2>
References: <164833878595.2575750.1483106296151574233.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Padmanabha,

On Sun, 27 Mar 2022 08:53:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> 
> KNOWN ISSUE:
> 
> According to the report from Padmanabha[3], the embedded bootconfig data may not
> be updated if you do incremental build the kernel with CONFIG_LTO. This is
> under investigation.

I tried to test this version with LTO_CLANG_FULL and LTO_CLANG_THIN with
switching the embedded bootconfig file by CONFIG_EMBED_BOOT_CONFIG_FILE (on x86).

I found that when I use LTO_CLANG_FULL, the embedded bootconfig was updated
correctly.
But with the LTO_CLANG_THIN, the embedded bootconfig was *NOT* updated.

I used the latest prebuild llvm 15.0.0 on x86 [4]. Padmanabha, can you confirm
with this latest LLVM? I guess something wrong with your old LLVM.

[4] https://download.01.org/0day-ci/cross-package/clang-latest/clang-latest/clang.tar.xz

Here is the test procedure.

1. Prepare 2 different bootconfig files (bconf1, bconf2).
2. Configure kernel with LTO_CLANG and setting the full path of bconf1 to
   CONFIG_EMBED_BOOT_CONFIG_FILE.
3. Build the kernel
4. Boot the kernel with "bootconfig" in the kernel cmdline.
5. Check the /proc/bootconfig is same as bconf1.
6. Reconfigure kernel with the full path of *bconf2* to CONFIG_EMBED_BOOT_CONFIG_FILE.
7. Rebuild the kernel (no cleanup)
8. Boot the kernel with "bootconfig" in the kernel cmdline.
9. Check the /proc/bootconfig is same as bconf2.

So with LTO_CLANG_FULL, at the step 9 /proc/bootconfig shows bconf2, but with
LTO_CLANG_THIN, it shows bconf1.

In both cases, build log showed that the default.bconf was updated (I confirmed the
lib/default.bconf is updated)

  UPD     lib/default.bconf
  CC      lib/bootconfig.o
  AR      lib/lib.a


Here is my guess. I found that when we enable LTO_CLANG, the compiler compiles
C source file into LLVM IR bitcode.

$ file work/linux/build-x86_64/lib/bootconfig.o 
work/linux/build-x86_64/lib/bootconfig.o: LLVM IR bitcode

This means at this point the object file doesn't include the lib/default.bconf
because it will be embedded by assembler. The bitcode seems only have the
inline asm code (which only has an .incbin directive) as a constatns block[5].

[5]
  Block ID #11 (CONSTANTS_BLOCK):
      Num Instances: 32
         Total Size: 54305b/6788.12B/1697W
    Percent of file: 19.9792%
       Average Size: 1697.03/212.13B/53W
  Tot/Avg SubBlocks: 0/0.000000e+00
    Tot/Avg Abbrevs: 4/1.250000e-01
    Tot/Avg Records: 486/1.518750e+01
    Percent Abbrevs: 80.8642%

        Record Histogram:
                  Count    # Bits     b/Rec   % Abv  Record Kind
                    219      4860      22.2  100.00  INTEGER
                    144      1728      12.0  100.00  SETTYPE
                     41       656      16.0          NULL
                     39      2970      76.2          CE_INBOUNDS_GEP
                     26      3504     134.8  100.00  CSTRING
                     10     37720    3772.0          INLINEASM
                      4        96      24.0  100.00  CE_CAST
                      1        58                    CE_CMP
                      1        52                    CE_SELECT
                      1        46                    CE_BINOP

And when the LLVM runs LTO with THIN mode, it might not update (not rebuild to
machine code) that inline asm code block because that block is not updated.
I confirmed that the block (bootconfig.o) is not updated after rebuilding
the kernel as below.

After step 3.
$ llvm-bcanalyzer work/linux/build-x86_64/lib/bootconfig.o > bconf.dump1
After step 7.
$ llvm-bcanalyzer work/linux/build-x86_64/lib/bootconfig.o > bconf.dump2
$ diff bconf.dump*
(No difference)

Thank you,

> 
> [3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       bootconfig: Check the checksum before removing the bootconfig from initrd
>       bootconfig: Support embedding a bootconfig file in kernel
>       docs: bootconfig: Add how to embed the bootconfig into kernel
> 
> 
>  Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++---
>  include/linux/bootconfig.h               |   10 ++++++++++
>  init/Kconfig                             |   21 ++++++++++++++++++++
>  init/main.c                              |   31 +++++++++++++++---------------
>  lib/.gitignore                           |    1 +
>  lib/Makefile                             |   10 ++++++++++
>  lib/bootconfig.c                         |   23 ++++++++++++++++++++++
>  7 files changed, 108 insertions(+), 18 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
