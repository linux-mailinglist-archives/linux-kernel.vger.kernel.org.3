Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92455A85EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHaSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHaSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBAB9E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w63-20020a25c742000000b006960ac89fedso2773995ybe.18
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=HMnrAce4vWD3UCA7lMg2iTbiqidDXP3N3F6sBkVh6kA=;
        b=eptYYARpDhhvHfa2enq2HomA+8RjHyMXfGJJl4oe6djSqcQFOPAig8gbLpsABe8yXq
         OMj3SA6IAcf8NwGVsmCaYZoD+UeorfMMNsPm2D6WY/4GLSKJJIvKA1/FcLwWAm+V1Aio
         PEJXbg9147fZoOx7Pl6cvWv7DsSwszHIB7luuRgoBx9GbmFDZ2nhdumltWAXfzuACtRv
         M8mi+hGEjyYRJCvvK8V+6BJAqqBTxJU1N9PoDVo1lCiWf8AbFPD7CWy4za+a5EWn80u9
         1p7YbxOLD0Rpt0VDiFAHThf2RFnzotJYi8ki8bK57JW6p+3csDgYVZrQTTvszf0V7WU/
         Catw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=HMnrAce4vWD3UCA7lMg2iTbiqidDXP3N3F6sBkVh6kA=;
        b=r7+AlJPZHmdniihsVWXvdd2fuX4ZnRGMRZ03Sa1m4r0XLZV/dePB9VrwaX6M6dTwT0
         lkPZtnkyTbc15AN7Mlxg9T6m589VNQzy3/nMRtNgGiD+83VodHjqgma8bNoe2p+XHas0
         IzJBeU7lQnXipM6za6jy0GnCtcniPq4bnfOB8PjeFwwvwlxh0dqX2zSZi/3nIvhU5DvH
         uNtblkKe8jXOPpk4Z8wPZjEd8StfeOMr4I73jzS0PXQ9klAGHtlSAi4+v67w2+CBnikU
         mh7gktd/hyf898T3jz2MJuV8JCKxnCWTxZFKqqdpwDgXr4ke+mq1Up41Lr0qzHDcx4Bx
         9npw==
X-Gm-Message-State: ACgBeo2PDHP2IlEHGtuTYF4qwEoek+noJaIbO02J1dfEL2vG81PiFBSE
        7eAI1gvYeotr9X29WhPiVzq66nrr/Jv8vPTtwEE=
X-Google-Smtp-Source: AA6agR4HPXKyje7xDSih23ECowddXTnlM8omhB/HfshCPDzUrBPoRUAAnBwmr6M7l4LvcGfkA2OwfmoMhigVBQ0feKs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:5f5d:95d5:9a3:d41])
 (user=ndesaulniers job=sendgmr) by 2002:a81:1243:0:b0:337:7a6e:9984 with SMTP
 id 64-20020a811243000000b003377a6e9984mr20145246yws.64.1661971452512; Wed, 31
 Aug 2022 11:44:12 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:44:03 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661971447; l=2027;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=MJ8zIIzbHDfP7Z3iWSiaUiv1c1n3/TDVg9Pl6Q1NkNc=;
 b=SLBxGFb8Uf8kJ3PXOwa6d70wUc9fm9s1Y8AVDT56OZAq30m5l4vm2Bm0fO5aCLmnwPjH1GzhwYdl
 mZtY1qPvB13iqhak8C0rk03P3rz7kYlC514lL/fGzXXEDli2SjpI
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831184408.2778264-1-ndesaulniers@google.com>
Subject: [PATCH v2 0/5] fix debug info for asm and DEBUG_INFO_SPLIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

Alexey reported that the fraction of unknown filename instances in
kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
to assembler defined symbols, which regressed as a result of:

commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")

In that commit, I allude to restoring debug info for assembler defined
symbols in a follow up patch, but it seems I forgot to do so in

commit a66049e2cf0e ("Kbuild: make DWARF version a choice")

Do so requires a fixup for as-option, which seems to be failing when
used in scripts/Makefile.debug.

Also includes a fix for DEBUG_INFO_SPLIT while I'm here.  Dmitrii
reports that this has been broken since gcc-11+ & clang-12+. I'm
guessing no one uses this .config option...since no one else has
reported it being broken yet...

Changes from v1 -> v2:
* 5 patches now, rather than 3.
* Split change to arch/x86/boot/compressed/Makefile off of first patch,
  as per Masahiro.
* Introduce compiler specific macros, as per Bill, and eradicate
  cc-ifversion while I'm at it.
* Update commit message of final patch to refer to 866ced950bcd.

v1: https://lore.kernel.org/llvm/20220826181035.859042-1-ndesaulniers@google.com/


Nick Desaulniers (5):
  x86/boot/compressed: prefer cc-option for CFLAGS additions
  Makefile.compiler: Use KBUILD_AFLAGS for as-option
  Makefile.compiler: replace cc-ifversion with compiler-specific macros
  Makefile.debug: re-enable debug info for .S files
  Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT

 Documentation/kbuild/makefiles.rst          | 44 +++++++++++++++------
 Makefile                                    |  4 +-
 arch/x86/boot/compressed/Makefile           |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 12 ++----
 scripts/Makefile.compiler                   | 21 +++++++---
 scripts/Makefile.debug                      | 26 ++++++++----
 6 files changed, 72 insertions(+), 37 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

