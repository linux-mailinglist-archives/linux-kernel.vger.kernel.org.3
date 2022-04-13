Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C124FF78C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiDMN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiDMN0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:26:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478D56426;
        Wed, 13 Apr 2022 06:24:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks6so3965746ejb.1;
        Wed, 13 Apr 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pP1xeAExqb4CTu9bCs4vgB8bqAXDBS1r1plYZ1IQFXE=;
        b=KmrO8j4blCHo3zwskk1V4txTvdy+CeQQ05IFh0SIWyuztV7kB1/bDej6/+TDhDtYnh
         gWSoFDWr3EY7jkQeCPKYkgJT6DQiXb6D5tecFIUImICPUifjeHqYL45DlWDMFHthlOYj
         RO08LavvKAR1TMwi1lHLFXXRLUngg2BjVAPMJcmnc2NnPvm1ky/Y9Mo6P9ptwK64nAja
         xQxVbBXne2z5de3uSJx16+MJ5zkzpgfui3M1Fmnt8Yn5AqSpqzKGF4dnXp92L3DB9oXG
         +JOxZfBV0Kgp24twotigFv+ruGu9v0zc24ON0kS9GIgMFqxqChXjUM/HPfTC83/oItUH
         1wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pP1xeAExqb4CTu9bCs4vgB8bqAXDBS1r1plYZ1IQFXE=;
        b=OfhLKoO8hdLr3ibczz82yf6La7UWPBS2Rq351YZTvTS/c2cBYUpcddQkFamv28OKC+
         3zZPxg8JbciFtL201+rrgPjy1YIt5NlD8PxurXQY6o/fV18aTdKRfymKR5wA7dBa55KS
         haQtTCKzmNium0EVGncq0UX0qxDSQucK1a0eKO8tVivyo0egHpb7zQFcyQoL6kOjAqQr
         8iI87Bt75piJ0Yx4JSKsdm7nVCrm8IGkfIfgzAq3pd6E35/3LXH+l+/q4H5+0nTG+Yqn
         Ntk/zJ6Mocmoq2iImuItHHHXSFsKRNHmaFopK3xCb4z/xjo9t8AuwAg7oAzEy1Frg1Tt
         06TA==
X-Gm-Message-State: AOAM530knR0RYCaGRjSTQosggkZPhY6zGfsE+VqD5nshZy5O/PXxAwQp
        fNjWaOcKGRTatwpOKNa0raFEX9McGBduEPFY
X-Google-Smtp-Source: ABdhPJyeQ1veR9cCtq/ZMPTQQkrUbxN2ENwiLlTIwAaUcb0mJg0b6O8QTvO0SP+9P0o5dKkVBZo3Og==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr37375034ejc.118.1649856240896;
        Wed, 13 Apr 2022 06:24:00 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm14214299ejy.132.2022.04.13.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:24:00 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:23:59 +0200
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20220413132359.GA8987@pswork>
References: <164833878595.2575750.1483106296151574233.stgit@devnote2>
 <20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami Hiramatsu,

Sorry for long delay, was out of town.

>On Sun, Mar 27, 2022 at 11:55:26AM +0900, Masami Hiramatsu wrote:
> Hi Padmanabha,
> 
> On Sun, 27 Mar 2022 08:53:06 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > 
> > KNOWN ISSUE:
> > 
> > According to the report from Padmanabha[3], the embedded bootconfig data may not
> > be updated if you do incremental build the kernel with CONFIG_LTO. This is
> > under investigation.
> 
> I tried to test this version with LTO_CLANG_FULL and LTO_CLANG_THIN with
> switching the embedded bootconfig file by CONFIG_EMBED_BOOT_CONFIG_FILE (on x86).
> 
> I found that when I use LTO_CLANG_FULL, the embedded bootconfig was updated
> correctly.
> But with the LTO_CLANG_THIN, the embedded bootconfig was *NOT* updated.
> 
> I used the latest prebuild llvm 15.0.0 on x86 [4]. Padmanabha, can you confirm
> with this latest LLVM? I guess something wrong with your old LLVM.
> 
> [4] https://download.01.org/0day-ci/cross-package/clang-latest/clang-latest/clang.tar.xz
>

Thanks for the link for prebuilt llvm 15.0.0.

[p1] https://www.spinics.net/lists/kernel/msg4307362.html

With llvm 15.0.0 and latest patchset v8 for bootconfig [p1] on arm64 the
test observations are:

For bootconfig:

I dont observe anymore an issue with incremental builds, irresepctive of LTO
type selected: FULL/THIN.

For config.gz:

The test observations is exactly similar to yours.
With LTO_CLANG_THIN configs were *NOT* updated.
But with LTO_CLANG_FULL confs were updated.

Test results validates and confirms your earlier analysis on issue with
inline asm and .incbin directive and THIN_LTO. 

> Here is the test procedure.
> 
> 1. Prepare 2 different bootconfig files (bconf1, bconf2).
> 2. Configure kernel with LTO_CLANG and setting the full path of bconf1 to
>    CONFIG_EMBED_BOOT_CONFIG_FILE.
> 3. Build the kernel
> 4. Boot the kernel with "bootconfig" in the kernel cmdline.
> 5. Check the /proc/bootconfig is same as bconf1.
> 6. Reconfigure kernel with the full path of *bconf2* to CONFIG_EMBED_BOOT_CONFIG_FILE.
> 7. Rebuild the kernel (no cleanup)
> 8. Boot the kernel with "bootconfig" in the kernel cmdline.
> 9. Check the /proc/bootconfig is same as bconf2.
> 
> So with LTO_CLANG_FULL, at the step 9 /proc/bootconfig shows bconf2, but with
> LTO_CLANG_THIN, it shows bconf1.
> 
> In both cases, build log showed that the default.bconf was updated (I confirmed the
> lib/default.bconf is updated)
> 
>   UPD     lib/default.bconf
>   CC      lib/bootconfig.o
>   AR      lib/lib.a
> 
> 
> Here is my guess. I found that when we enable LTO_CLANG, the compiler compiles
> C source file into LLVM IR bitcode.
> 
> $ file work/linux/build-x86_64/lib/bootconfig.o 
> work/linux/build-x86_64/lib/bootconfig.o: LLVM IR bitcode
> 
> This means at this point the object file doesn't include the lib/default.bconf
> because it will be embedded by assembler. The bitcode seems only have the
> inline asm code (which only has an .incbin directive) as a constatns block[5].
>
> [5]
>   Block ID #11 (CONSTANTS_BLOCK):
>       Num Instances: 32
>          Total Size: 54305b/6788.12B/1697W
>     Percent of file: 19.9792%
>        Average Size: 1697.03/212.13B/53W
>   Tot/Avg SubBlocks: 0/0.000000e+00
>     Tot/Avg Abbrevs: 4/1.250000e-01
>     Tot/Avg Records: 486/1.518750e+01
>     Percent Abbrevs: 80.8642%
> 
>         Record Histogram:
>                   Count    # Bits     b/Rec   % Abv  Record Kind
>                     219      4860      22.2  100.00  INTEGER
>                     144      1728      12.0  100.00  SETTYPE
>                      41       656      16.0          NULL
>                      39      2970      76.2          CE_INBOUNDS_GEP
>                      26      3504     134.8  100.00  CSTRING
>                      10     37720    3772.0          INLINEASM
>                       4        96      24.0  100.00  CE_CAST
>                       1        58                    CE_CMP
>                       1        52                    CE_SELECT
>                       1        46                    CE_BINOP
> 
> And when the LLVM runs LTO with THIN mode, it might not update (not rebuild to
> machine code) that inline asm code block because that block is not updated.
> I confirmed that the block (bootconfig.o) is not updated after rebuilding
> the kernel as below.
>
Yes, thanks for details. Analysis is in sync with observations from test
results.

Thanks and Regards,
Padmanabha.S
> After step 3.
> $ llvm-bcanalyzer work/linux/build-x86_64/lib/bootconfig.o > bconf.dump1
> After step 7.
> $ llvm-bcanalyzer work/linux/build-x86_64/lib/bootconfig.o > bconf.dump2
> $ diff bconf.dump*
> (No difference)
> 
> Thank you,
> 
> > 
> > [3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (3):
> >       bootconfig: Check the checksum before removing the bootconfig from initrd
> >       bootconfig: Support embedding a bootconfig file in kernel
> >       docs: bootconfig: Add how to embed the bootconfig into kernel
> > 
> > 
> >  Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++---
> >  include/linux/bootconfig.h               |   10 ++++++++++
> >  init/Kconfig                             |   21 ++++++++++++++++++++
> >  init/main.c                              |   31 +++++++++++++++---------------
> >  lib/.gitignore                           |    1 +
> >  lib/Makefile                             |   10 ++++++++++
> >  lib/bootconfig.c                         |   23 ++++++++++++++++++++++
> >  7 files changed, 108 insertions(+), 18 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
