Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3864536EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiE1Wrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiE1Wrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 18:47:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5DE5BE6F;
        Sat, 28 May 2022 15:47:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t14-20020a9d66ce000000b0060af9ed4b87so5339847otm.9;
        Sat, 28 May 2022 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKshfHkC5Pvf7ig5EiZ4GmSmW76KnvCWjyhV6RL/CDU=;
        b=UwshPpQ3sv/eETtkjsspaFEbkyclPdvMYuf8CQ4Sn6hG2bEMM5qxfNc3Pb7jrYWQ4F
         0fNtNnhxPe0veQ8CPqxyUgnC/l97XfyLlZ497jO8Rx2CHz1gzOssU0HjhlXRsFPhsUZk
         KBugrFVKBwr6/k9jenpSUTVUilY4zY4OeuxaVZDRNZxi/Hi7651QEuZ7Saju5+RuHNWd
         qckO+i5aZsUjhbCGOAJPUsQwor+yJpyq3lC4c+kAMk0Krsnldcd1gV1XqDdMJrQHoUKN
         XKQ8PoSs/5/G7bidV8+wHJ0V4i76l2fBL4rUwR+f1JkHJZHnrmKl21JpeRA8V1Utrv+K
         PPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TKshfHkC5Pvf7ig5EiZ4GmSmW76KnvCWjyhV6RL/CDU=;
        b=XLYxNlZb2OMSjSC/hjB/HG2B3FunAe5jf2XJxVaEOBlNNzd91pbDZCxjMhj/dn/cKy
         z61rWEEQpucV2HAlUpe9BQWNRkyNMdjNMXfR/cBUo6G3wp6JtYa+hp+tIjPi3PlIYQ3c
         BPrNYzAqkXxXkxsxNBp670IFPfsjxxJ8AXXRawkfWArc1X0CF5G3wUxN05vIlszuAtM9
         CWnv+FtQC9RYmeEQl3brtXZbi7qE0uugkFMEi8zympjWvQ4db5B3h1Lgg8+6vifYPhL3
         DdZl7lyVFBzPjbTzCWiZUzXBwKTYVAm6a9rTOqWpEVM/B9pbb4dDHCjVePGD+WPEgcUy
         ozuw==
X-Gm-Message-State: AOAM530bNjg00BCyL7T3qPeAzQL6FQ+jx2/X3iJ175otIDCiLQTA8Am6
        eL71iitmYV1EFiEFoFLuzAk=
X-Google-Smtp-Source: ABdhPJzfxwBZO8/g/x9lRQ5QRk4I7bGfdsN1gA1y2exJEV+YZZXTThQMguwqH9qoNE8Ad3BAzHwvfg==
X-Received: by 2002:a05:6830:b85:b0:605:4e76:f077 with SMTP id a5-20020a0568300b8500b006054e76f077mr18436775otv.211.1653778067577;
        Sat, 28 May 2022 15:47:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r33-20020a056870582100b000f169cbbb32sm1865092oap.43.2022.05.28.15.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 15:47:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 May 2022 15:47:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v6 01/10] modpost: extract symbol versions from *.cmd
 files
Message-ID: <20220528224745.GA2501857@roeck-us.net>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <20220513113930.10488-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513113930.10488-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 13, 2022 at 08:39:21PM +0900, Masahiro Yamada wrote:
> Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
> versions into ELF objects. Then, modpost extracts the version CRCs
> from them.
> 
[ ... ]
> This commit changes modpost to extract CRCs from *.cmd files instead of
> from ELF objects.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

This patch results in

._muldi3_di.o.cmd: No such file or directory

when building parisc64:defconfig, and

._divsi3.o.cmd: No such file or directory

when building csky:allmodconfig.

Reverting this patch (and the subsequent kbuild patches to avoid
conflicts) fixes the problem for both architectures. In case it
helps, the complete build log when rebuilding an image for csky
is as follows.

#
# No change to .config
#
  HOSTCC  scripts/mod/modpost.o
  HOSTLD  scripts/mod/modpost
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  SO2S    arch/csky/kernel/vdso/vdso-syms.S
  AS      arch/csky/kernel/vdso/vdso-syms.o
  AR      arch/csky/kernel/vdso/built-in.a
  AR      arch/csky/kernel/built-in.a
  CHK     kernel/kheaders_data.tar.xz
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
._divsi3.o.cmd: No such file or directory
make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
make: *** [Makefile:1159: vmlinux] Error 2

This was seen with gcc 11.2 and 11.3.

Guenter

---
bisect on mainline:

# bad: [9d004b2f4fea97cde123e7f1939b80e77bf2e695] Merge tag 'cxl-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect start 'HEAD' 'v5.18'
# good: [86c87bea6b42100c67418af690919c44de6ede6e] Merge tag 'devicetree-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good 86c87bea6b42100c67418af690919c44de6ede6e
# good: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good c011dd537ffe47462051930413fed07dbdc80313
# bad: [df202b452fe6c6d6f1351bad485e2367ef1e644e] Merge tag 'kbuild-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad df202b452fe6c6d6f1351bad485e2367ef1e644e
# good: [d4dcdc53c492a7b9fa9031cb85e238b21208ada2] Merge tag 'qcom-arm64-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
git bisect good d4dcdc53c492a7b9fa9031cb85e238b21208ada2
# good: [ae862183285cbb2ef9032770d98ffa9becffe9d5] Merge tag 'arm-dt-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good ae862183285cbb2ef9032770d98ffa9becffe9d5
# good: [cc3c470ae4ad758b8ddad825ab199f7eaa8b0a9e] Merge tag 'arm-drivers-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good cc3c470ae4ad758b8ddad825ab199f7eaa8b0a9e
# good: [ecf0aa5317b0ad6bb015128a5b763c954fd58708] Merge tag 'arm-multiplatform-5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good ecf0aa5317b0ad6bb015128a5b763c954fd58708
# good: [4484054816cab940fc2fde23fa989174fec889d0] modpost: use doubly linked list for dump_lists
git bisect good 4484054816cab940fc2fde23fa989174fec889d0
# good: [16477cdfefdb494235a675cc80563d736991d833] Merge tag 'asm-generic-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
git bisect good 16477cdfefdb494235a675cc80563d736991d833
# good: [a44abaca0e196cfeef2374ed663b97daa1ad112a] modpost: move *.mod.c generation to write_mod_c_files()
git bisect good a44abaca0e196cfeef2374ed663b97daa1ad112a
# good: [69c4cc99bbcbf3ef2e1901b569954e9226180840] modpost: add sym_find_with_module() helper
git bisect good 69c4cc99bbcbf3ef2e1901b569954e9226180840
# bad: [7b4537199a4a8480b8c3ba37a2d44765ce76cd9b] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
git bisect bad 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
# bad: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
git bisect bad f292d875d0dc700b3af0bef04c5abc1dc7b3b62c
# first bad commit: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files

---
bisect on kbuild-5.19:

# bad: [5ce2176b81f77366bd02c27509b83049f0020544] genksyms: adjust the output format to modpost
# good: [3123109284176b1532874591f7c81f3837bbdc17] Linux 5.18-rc1
git bisect start 'HEAD' 'v5.18-rc1'
# good: [70ddb48db4aaddd3c2a7d8802463e15b21ce8525] modpost: move struct namespace_list to modpost.c
git bisect good 70ddb48db4aaddd3c2a7d8802463e15b21ce8525
# good: [e76cc48d8e6df5d949284132981db73d2dd8c6b5] modpost: make sym_add_exported() always allocate a new symbol
git bisect good e76cc48d8e6df5d949284132981db73d2dd8c6b5
# good: [78e9e56af3858bf2c52c065daa6c8bee0d72048c] kbuild: record symbol versions in *.cmd files
git bisect good 78e9e56af3858bf2c52c065daa6c8bee0d72048c
# good: [69c4cc99bbcbf3ef2e1901b569954e9226180840] modpost: add sym_find_with_module() helper
git bisect good 69c4cc99bbcbf3ef2e1901b569954e9226180840
# bad: [7b4537199a4a8480b8c3ba37a2d44765ce76cd9b] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
git bisect bad 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
# bad: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
git bisect bad f292d875d0dc700b3af0bef04c5abc1dc7b3b62c
# first bad commit: [f292d875d0dc700b3af0bef04c5abc1dc7b3b62c] modpost: extract symbol versions from *.cmd files
