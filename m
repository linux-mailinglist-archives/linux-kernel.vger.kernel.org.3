Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635D505CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbiDRQxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbiDRQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC08232987
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fyzXINo6y2QrduRhxp75HTMIHm/ydfaEUWJWblGQAqE=;
        b=ahU2arIgWRnBmkT1V0p1diTgyO0RGKO+lp+GbmIivmzpzeLXsFwCB7lCRu/B84WoJSbh78
        KdXqB0cDyTkrJyV/JodsGSa3wEbqSY+QIh12PnMjZ09YdluJ+RxHTcDyCdG3HSXso1ag8x
        l1BfupdrIfqy4ZB6U4JtgIsDQJpAfRE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-oOW2zVPYMjODZdrpz6Ny5g-1; Mon, 18 Apr 2022 12:50:52 -0400
X-MC-Unique: oOW2zVPYMjODZdrpz6Ny5g-1
Received: by mail-qk1-f197.google.com with SMTP id ay14-20020a05620a178e00b0069a9c319c64so10756020qkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fyzXINo6y2QrduRhxp75HTMIHm/ydfaEUWJWblGQAqE=;
        b=RtzCOvxz5GgMNO8g8G2tTISOxlyFI+kR3FAKGbWK+CQOjGP3m8dvNVgxd2J2KLrILY
         v5hA9Ls6A6aF77meX8ZpfUJ3gRX9SAn6SacCfy1kXySIfgQq63jLgR5NiBbDBC2DusBF
         G9gqexmYhnE3/tvNG9PrUZHG96EIp8jQGdqBMXIt0sENxlD/gelyW7+WYcqY/Sb9cXb4
         kpgYUqfcBrSdso8wtHaytKDqw9X5pnuEDfxlUZstZDQy49uP4g5w2oqIezuVzyoem0+E
         l5ckvPZOidGNLHL0zYbdHfQij8ZZewW8Hssd/JVFsBI9dCX4piVSpvQqSaCBEnGJZzoZ
         VMqA==
X-Gm-Message-State: AOAM530F2HZXwA6dEzieKY9F9cAI5X+1bM2V2Evq7v2lHXJriBRYKNk3
        qPjzUwMdjq1My+CcTzBQiZkmXc595gtY9/w/q7hJqGhHX0RefY+xzShJsBcPpy4C35D8QHUvTuP
        Xj31D5623uvgvfyjxA2oZKdYE
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr6906614qkb.443.1650300651973;
        Mon, 18 Apr 2022 09:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGS7XNj9k6vkLVulKPyUGJigJpGiBiFPW9pzDfAR7seHumvCYupquhlpx2IBMy2+usjgwkbg==
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr6906602qkb.443.1650300651711;
        Mon, 18 Apr 2022 09:50:51 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:51 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 00/25] objtool: Interface overhaul
Date:   Mon, 18 Apr 2022 09:50:19 -0700
Message-Id: <cover.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- extricate sls
- fix ibt regressions in v1
- fix issues found by improved ibt logic
- split '--hacks' into two
- add objdump-func script
- remove "()" in function address strings
- add '--sec-address' option
- add '--link'


Objtool's interface has some issues:

- Several features are done unconditionally, without any way to turn
  them off.  Some of them might be surprising.  This makes objtool
  tricky to use, and prevents porting individual features to other
  arches.

- The config dependencies are too coarse-grained.  Objtool enablement is
  tied to CONFIG_STACK_VALIDATION, but it has several other features
  independent of that.

- The objtool subcmds ("check" and "orc") are clumsy: "check" is really
  a subset of "orc", so it has all the same options.  The subcmd model
  has never really worked for objtool, as it only has a single purpose:
  "do some combination of things on an object file".

- The '--lto' and '--vmlinux' options are nonsensical and have
  surprising behavior.


Overhaul the interface:

- get rid of subcmds

- make all features individually selectable

- remove and/or clarify confusing/obsolete options

- update the documentation

- fix some bugs found along the way


TODO: rename files...


$ tools/objtool/objtool --help

 Usage: objtool <actions> [<options>] file.o

Actions:
    -h, --hacks[=<jump_label,noinstr>]
                          patch toolchain bugs/limitations
    -i, --ibt             validate and annotate IBT
    -l, --sls             validate straight-line-speculation mitigations
    -m, --mcount          annotate mcount/fentry calls for ftrace
    -n, --noinstr         validate noinstr rules
    -o, --orc             generate ORC metadata
    -r, --retpoline       validate and annotate retpoline usage
    -s, --stackval        validate frame pointer rules
    -t, --static-call     annotate static calls
    -u, --uaccess         validate uaccess rules for SMAP
        --dump[=<orc>]    dump metadata

Options:
        --backtrace       unwind on error
        --backup          create .orig files before modification
        --dry-run         don't write modifications
        --link            object is a linked object
        --module          object is part of a kernel module
        --no-unreachable  skip 'unreachable instruction' warnings
        --sec-address     print section addresses in warnings
        --stats           print statistics



Josh Poimboeuf (25):
  objtool: Enable unreachable warnings for CLANG LTO
  libsubcmd: Fix OPTION_GROUP sorting
  x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
  x86/retpoline: Add ANNOTATE_ENDBR for retpolines
  x86/uaccess: Add ENDBR to __put_user_nocheck*()
  x86/xen: Add ANNOTATE_ENDBR to startup_xen()
  objtool: Reorganize cmdline options
  objtool: Ditch subcommands
  objtool: Don't print parentheses in function addresses
  objtool: Print data address for "!ENDBR" data warnings
  objtool: Use offstr() to print address of missing ENDBR
  objtool: Add option to print section addresses
  scripts: Create objdump-func helper script
  objtool: Make stack validation optional
  objtool: Rework ibt and extricate from stack validation
  objtool: Extricate sls from stack validation
  objtool: Add CONFIG_OBJTOOL
  objtool: Make stack validation frame-pointer-specific
  objtool: Make static call annotation optional
  objtool: Make jump label hack optional
  objtool: Make noinstr hacks optional
  objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
  objtool: Add HAVE_NOINSTR_VALIDATION
  objtool: Remove --lto and --vmlinux in favor of --link
  objtool: Update documentation

 Makefile                                      |   2 +-
 arch/Kconfig                                  |  18 +-
 arch/x86/Kconfig                              |  21 +-
 arch/x86/Kconfig.debug                        |   2 +-
 arch/x86/include/asm/jump_label.h             |   6 +-
 arch/x86/include/asm/static_call.h            |   1 +
 arch/x86/kernel/alternative.c                 |   6 +-
 arch/x86/lib/putuser.S                        |   4 +
 arch/x86/lib/retpoline.S                      |   2 +-
 arch/x86/xen/xen-head.S                       |   1 +
 include/linux/compiler.h                      |   6 +-
 include/linux/instrumentation.h               |   6 +-
 include/linux/objtool.h                       |   6 +-
 kernel/trace/Kconfig                          |   1 +
 lib/Kconfig.debug                             |  22 +-
 lib/Kconfig.kcsan                             |   4 +-
 lib/Kconfig.ubsan                             |   2 +-
 scripts/Makefile.build                        |  23 +-
 scripts/link-vmlinux.sh                       |  66 ++-
 scripts/objdump-func                          |  18 +
 scripts/package/builddeb                      |   2 +-
 tools/include/linux/objtool.h                 |   6 +-
 tools/lib/subcmd/parse-options.c              |  17 +-
 tools/objtool/Build                           |  12 +-
 .../{stack-validation.txt => objtool.txt}     | 122 ++++-
 tools/objtool/Makefile                        |   8 +-
 tools/objtool/arch/x86/decode.c               |   2 +-
 tools/objtool/arch/x86/special.c              |   2 +-
 tools/objtool/builtin-check.c                 | 156 ++++--
 tools/objtool/builtin-orc.c                   |  73 ---
 tools/objtool/check.c                         | 456 ++++++++++--------
 tools/objtool/elf.c                           |  11 +-
 tools/objtool/include/objtool/builtin.h       |  34 +-
 tools/objtool/include/objtool/elf.h           |  12 +-
 tools/objtool/include/objtool/warn.h          |  35 +-
 tools/objtool/objtool.c                       | 103 +---
 tools/objtool/weak.c                          |   9 +-
 37 files changed, 719 insertions(+), 558 deletions(-)
 create mode 100755 scripts/objdump-func
 rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)
 delete mode 100644 tools/objtool/builtin-orc.c

-- 
2.34.1

