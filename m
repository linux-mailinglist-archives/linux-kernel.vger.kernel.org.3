Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237CD59CDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiHWBJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiHWBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:09:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9781704B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:09:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a21-20020a62bd15000000b005360da6b25aso3907246pff.23
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=M/JM19ZHtL1XTdax2o6PuALS08ie5QAbDLPLMfS+iXo=;
        b=iIN0B0+ASu+zORuo0inJfY9E/y+0i0ZJO6ydKUDztQDbYESqexW4Vn+bMswdRnogez
         tMpcCEvVmdAs5Eb0k+50Xmg466CjqAYl2+CzuBoaZ2w9HHWwteaJ7MicoxbMPiEl6MWP
         0rXsg8fwxEU1awWFblUHsxs3UR2G6q3Mda0lQnrD6OS76APXSY7eHbv25JVkvOFsaFVe
         o8og1lBFwySLFvYdS149wu7S6VTeiZjuMRP3iIB0OHSP57j1qs3Y9f9VKrEl1LWCzFRm
         PoixhzArl6HgsS2iI16/rTdgqBMOL4b0nu0RTjv3/GPywnrMmw7UvzmlHqJn2dXcC7jF
         2gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=M/JM19ZHtL1XTdax2o6PuALS08ie5QAbDLPLMfS+iXo=;
        b=O8l39Oh9heF9JDE4B/qI+uGefH7ijmqtli8XPaTm0X9htFW6iX2h8r9o5tc1Ptrhb1
         7rjpCUEW0VWCy1m1IPFwHj3fhLYOpYT0Q77ZdzouzMmSGBmYcEcCwCIiB759mRRJ0wG4
         twd/4jMLL4nkICclu2dPm5jpqLHrWKZDs0XgYAE77L3y+TVHpFMRCLtECqZLXLj2WFhY
         hh0XXWo4VGblJgwl2sQItmBcGCZ07OShS9sn1wK+6FJQP/VDQPRQxR6UvITDtzB7qYmJ
         z6lozGRDom/0LoVZQHHjYkw2VsorC2TcF8bdCg2Trv9fGaUXBp1py2QjFDPAqwCLZJ02
         i/Uw==
X-Gm-Message-State: ACgBeo0f4BnPzaAI3O5zoxTSK6Th3fOvBC6bs1EDCSK6NG6/ySGQyQ1N
        oCdQIAFlARtHX7yitb+RCkNtoGJe+lt2xA==
X-Google-Smtp-Source: AA6agR6wH5XNsVgXV17MAXE+RE2KZb02sNclcB9HbmFS+v6H+hCamZxOwxGKSIdgmRw7okfWKlNl5bCElJvx3g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:230e:b0:172:ccb3:f4de with SMTP
 id d14-20020a170903230e00b00172ccb3f4demr14574237plh.18.1661216940306; Mon,
 22 Aug 2022 18:09:00 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:08:30 +0800
Message-Id: <20220823010830.2675419-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] arch: um: Mark the stack non-executable to fix a binutils warning
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Gow <davidgow@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since binutils 2.39, ld will print a warning if any stack section is
executable, which is the default for stack sections on files without a
.note.GNU-stack section.

This was fixed for x86 in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments"),
but remained broken for UML, resulting in several warnings:

/usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

Link both the VDSO and vmlinux with -z noexecstack, fixing the warnings
about .note.GNU-stack sections. In addition, pass --no-warn-rwx-segments
to dodge the remaining warnings about LOAD segments with RWX permissions
in the kallsyms objects. (Note that this flag is apparently not
available on lld, so hide it behind a test for BFD, which is what the
x86 patch does.)

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/Makefile          | 9 ++++++++-
 arch/x86/um/vdso/Makefile | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f2fe63bfd819..75d5c704b3a8 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -132,10 +132,17 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
+# Avoid binutils 2.39+ warnings by marking the stack non-executable and
+# ignorning warnings for the kallsyms sections.
+LINK_RWXSECTION = -Wl,-z,noexecstack
+ifeq ($(CONFIG_LD_IS_BFD),y)
+LINK_RWXSECTION += -Wl,--no-warn-rwx-segments
+endif
+
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
-export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LINK_RWXSECTION) $(LD_FLAGS_CMDLINE)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 8c0396fd0e6f..6fbe97c52c99 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -65,7 +65,7 @@ quiet_cmd_vdso = VDSO    $@
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
 GCOV_PROFILE := n
 
 #
-- 
2.37.1.595.g718a3a8f04-goog

