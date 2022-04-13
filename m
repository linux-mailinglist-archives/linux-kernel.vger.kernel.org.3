Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497B500275
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiDMXWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiDMXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5288237FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649891999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4hzYoqP2bjYr5H/5V4CA7nkXnhHLb9eMZqlsek8g8Q8=;
        b=VJS/0RDvN6sLsa4TQYLIFC1hW3DmQSduAl2mPl0zmhauYavfbxmVwz0kEnOtGyaK7cteOs
        GkUn3Vuz5yztFEO79bGBxSbWOa3+8FWY6TVrXQ/zNuDTx+kJxq6oVoCoCY9GWlnMWE6gL3
        P4A7mlEQU8EkTnvQXpQuhUIpzHd2MEQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-Nftky7mROOe2E0Bw0EMyew-1; Wed, 13 Apr 2022 19:19:58 -0400
X-MC-Unique: Nftky7mROOe2E0Bw0EMyew-1
Received: by mail-qv1-f71.google.com with SMTP id m15-20020a0562141bcf00b00443ddcd8a0fso3003009qvc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hzYoqP2bjYr5H/5V4CA7nkXnhHLb9eMZqlsek8g8Q8=;
        b=HXi7OErVFNFBhjWnS2C9OD95rSEGI7jTsLBIA5HeXEw3uhKCPw+XoQktp0aIQ9/W1X
         koJZYKswlxJXffoJUpT6q5oJsrf0A87qBgOnzzJ0o9Sxqikpk382HURHsjepeR0Q8HL+
         CH2hbm2zC3+j7+m5ZCthOFBqJ0Z3smfBTVPxrLCvtxElVYBpNwfipN6dPL52shw6ljLz
         ZJPKcS0z2hsMIUriozq7Nq3teCjFF42fEyq4PuPAuMZZpPs+LVA6ommE8mwTJkLLJft9
         OXTMLY9lldBglJYY8gCN7sQD4qR44UF7af7fcMyZQ2i1tAcwdD33IXSsPAtcvoyi9+6/
         zIaw==
X-Gm-Message-State: AOAM533NldfmS5NcF8dx0HQo+ZVaJ5cCX7CK1HGh4M7mnqjob21I7PLd
        ErnRlroihVyXp3gJbq2CXHBWOJPdLOsvcGDencEib6m89dE65R1V/N6S33GUPuBUFJ7XiE70Ve6
        9hqQltbBd6XFe2zRQz+35IsFx
X-Received: by 2002:a37:bac6:0:b0:663:5fde:226f with SMTP id k189-20020a37bac6000000b006635fde226fmr8699527qkf.137.1649891997492;
        Wed, 13 Apr 2022 16:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUno37iMH16K7JRVkpSAUv84eB0wCq2geWhfcb2p5n2UwIoSl+eTPRiZUCku1XMOLLbIZyWQ==
X-Received: by 2002:a37:bac6:0:b0:663:5fde:226f with SMTP id k189-20020a37bac6000000b006635fde226fmr8699514qkf.137.1649891997216;
        Wed, 13 Apr 2022 16:19:57 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:19:56 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 00/18] objtool: Interface overhaul
Date:   Wed, 13 Apr 2022 16:19:35 -0700
Message-Id: <cover.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
    -h, --hacks           patch some toolchain bugs/limitations
    -i, --ibt             validate and annotate IBT
    -m, --mcount          annotate mcount/fentry calls for ftrace
    -n, --noinstr         validate noinstr rules
    -o, --orc             generate ORC metadata
    -r, --retpoline       validate and annotate retpoline usage
    -S, --sls             validate straight-line-speculation mitigations
    -s, --stackval        validate frame pointer rules
    -t, --static-call     annotate static calls
    -u, --uaccess         validate uaccess rules for SMAP
        --dump <orc>      dump object data

Options:
        --backtrace       unwind on error
        --backup          create .orig files before modification
        --dry-run         don't write modifications
        --module          object is part of a kernel module
        --no-unreachable  skip 'unreachable instruction' warnings
        --stats           print statistics



Josh Poimboeuf (18):
  objtool: Enable unreachable warnings for CLANG LTO
  objtool: Support data symbol printing
  objtool: Add sec+offset to warnings
  objtool: Print data address for "!ENDBR" data warnings
  objtool: Use offstr() to print address of missing ENDBR
  libsubcmd: Fix OPTION_GROUP sorting
  objtool: Reorganize cmdline options
  objtool: Ditch subcommands
  objtool: Add stack validation cmdline option
  objtool: Extricate ibt from stack validation
  objtool: Add CONFIG_OBJTOOL
  objtool: Make stack validation frame-pointer-specific
  objtool: Add static call cmdline option
  objtool: Add toolchain hacks cmdline option
  objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
  objtool: Add HAVE_NOINSTR_VALIDATION
  objtool: Remove --lto and --vmlinux
  objtool: Update documentation

 Makefile                                      |   2 +-
 arch/Kconfig                                  |  15 +-
 arch/x86/Kconfig                              |  20 +-
 arch/x86/Kconfig.debug                        |   2 +-
 arch/x86/include/asm/jump_label.h             |   6 +-
 arch/x86/kernel/alternative.c                 |   6 +-
 include/linux/compiler.h                      |   6 +-
 include/linux/instrumentation.h               |   6 +-
 include/linux/objtool.h                       |   6 +-
 kernel/trace/Kconfig                          |   1 +
 lib/Kconfig.debug                             |  22 +-
 lib/Kconfig.kcsan                             |   3 +-
 lib/Kconfig.ubsan                             |   2 +-
 scripts/Makefile.build                        |  20 +-
 scripts/link-vmlinux.sh                       |  62 +--
 scripts/package/builddeb                      |   2 +-
 tools/include/linux/objtool.h                 |   6 +-
 tools/lib/subcmd/parse-options.c              |  17 +-
 tools/objtool/Build                           |  12 +-
 .../{stack-validation.txt => objtool.txt}     | 122 +++++-
 tools/objtool/Makefile                        |   8 +-
 tools/objtool/arch/x86/decode.c               |   2 +-
 tools/objtool/arch/x86/special.c              |   2 +-
 tools/objtool/builtin-check.c                 | 123 ++++--
 tools/objtool/builtin-orc.c                   |  73 ----
 tools/objtool/check.c                         | 391 +++++++++---------
 tools/objtool/elf.c                           |  11 +-
 tools/objtool/include/objtool/builtin.h       |  36 +-
 tools/objtool/include/objtool/elf.h           |   8 +-
 tools/objtool/include/objtool/warn.h          |  52 +--
 tools/objtool/objtool.c                       | 103 +----
 tools/objtool/weak.c                          |   9 +-
 32 files changed, 594 insertions(+), 562 deletions(-)
 rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)
 delete mode 100644 tools/objtool/builtin-orc.c

-- 
2.34.1

