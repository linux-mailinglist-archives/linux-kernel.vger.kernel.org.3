Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C44CB11B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbiCBVQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiCBVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:16:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F370D5E;
        Wed,  2 Mar 2022 13:15:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 078A8B82231;
        Wed,  2 Mar 2022 21:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC45C004E1;
        Wed,  2 Mar 2022 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646255753;
        bh=gDOb3uOTmYK1tCwXGMDSEdWNLGwvH0XEN6bnN2kAsvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXVm2vOnX8XTJh2+7pn5cnlIt0vFWSaKMjEtJypOFlbyW61g5stwJOuuXs9wB0qWp
         g96RQ0gvNK7h3l9RZtscgGQQC4Tn7jqoL0Rw9+hNC9lWwmOWDveb1MfVA8u5jAXrJZ
         woSji1ElKcWhd47BE7kOy0gFWRZBya7zAaTfgqEqOW0ele327T6pti9IYSbzTQFz99
         bKTfsgNI0OIjNB0xdcYPbtMcnGgIsr7X9BOi5QDzWBuL3QyNMVyrtlK1k5AS0UJwQ8
         se0Z69L6kOClY2WcSdtA9ekR0iqxkpdjvwP+B9PoUz1l32wd7M8PMXF0chVijCQeCP
         eRhElaUPHByPg==
Date:   Wed, 2 Mar 2022 14:15:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, x86@kernel.org, joao@overdrivepizza.com,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
Message-ID: <Yh/egU1LZudfrgVy@dev-arch.thelio-3990X>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
 <Yh+dMJsH+ZMPfqwD@thelio-3990X>
 <CAKwvOdmouBTe5pH3JoP6EEfwNT5=6WvX3oCEZRxO0Dkf38S14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liu8GtapZ3xLnrsC"
Content-Disposition: inline
In-Reply-To: <CAKwvOdmouBTe5pH3JoP6EEfwNT5=6WvX3oCEZRxO0Dkf38S14w@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liu8GtapZ3xLnrsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2022 at 11:18:07AM -0800, Nick Desaulniers wrote:
> On Wed, Mar 2, 2022 at 8:37 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Tue, Mar 01, 2022 at 01:16:04PM -0800, Nick Desaulniers wrote:
> > > As per our previous discussion
> > > https://lore.kernel.org/linux-kbuild/CAKwvOd=x9E=7WcCiieso-CDiiU-wMFcXL4W3V5j8dq7BL5QT+w@mail.gmail.com/
> > > I'm still of the opionion that this should be solved by modifications
> > > (permanent or one off) to one's $PATH.
> >
> > However, I think we could still address Peter's complaint of "there
> > should be an easier way for me to use the tools that are already in my
> > PATH" with his first iteration of this patch [1], which I feel is
> > totally reasonable:
> >
> > $ make LLVM=-14
> >
> > It is still easy to use (in fact, it is shorter than 'CC=clang-14') and
> > it does not change anything else about how we build with LLVM. We would
> > just have to add something along the lines of
> >
> > "If your LLVM tools have a suffix like Debian's (clang-14, ld.lld-14,
> > etc.), use LLVM=<suffix>.
> 
> "If your LLVM tools have a suffix and you prefer to test an explicit
> version rather than the unsuffixed executables ..."

Ack, I included this.

> > $ make LLVM=-14"
> >
> > to Documentation/kbuild/llvm.rst.
> >
> > I might change the patch not to be so clever though:
> >
> > ifneq ($(LLVM),)
> > ifneq ($(LLVM),1)
> > LLVM_SFX := $(LLVM)
> > endif
> > endif
> >
> > [1]: https://lore.kernel.org/r/YXqpFHeY26sEbort@hirez.programming.kicks-ass.net/
> 
> I'd be much more amenable to that approach.

Sounds good, tentative patch attached, it passes all of my testing.
There is an instance of $(LLVM) in tools/testing/selftests/lib.mk that I
did not touch, as that will presumably have to go through the selftests
tree. I can send a separate patch for that later.

Peter, is this approach okay with you? If so, would you like to be
co-author or should I use a suggested-by tag?

Cheers,
Nathan

--liu8GtapZ3xLnrsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-kbuild-Allow-a-suffix-with-LLVM.patch"

From 83219caafbb7dbc2e41e3888ba5079d342aff633 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 2 Mar 2022 13:28:14 -0700
Subject: [PATCH] kbuild: Allow a suffix with $(LLVM)

The LLVM variable allows a developer to quickly switch between the GNU
and LLVM tools. However, it does not handle versioned binaries, such as
the ones shipped by Debian, as LLVM=1 just defines the build variables
with the unversioned binaries.

There was some discussion during the review of the patch that introduces
LLVM=1 around this, ultimately coming to the conclusion that developers
can just add the folder that contains the unversioned binaries to their
PATH, as Debian's versioned suffixed binaries are really just symlinks
to the unversioned binaries in /usr/lib/llvm-#/bin:

$ realpath /usr/bin/clang-14
/usr/lib/llvm-14/bin/clang

$ PATH=/usr/lib/llvm-14/bin:$PATH make ... LLVM=1

However, it is simple enough to support this scheme directly in the
Kbuild system by allowing the developer to specify the version suffix
with LLVM=, which is shorter than the above suggestion:

$ make ... LLVM=-14

It does not change the meaning of LLVM=1 (which will continue to use
unversioned binaries) and it does not add too much additional complexity
to the existing $(LLVM) code, while allowing developers to quickly test
their series with different versions of the whole LLVM suite of tools.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/kbuild/llvm.rst  |  7 +++++++
 Makefile                       | 24 ++++++++++++++----------
 tools/scripts/Makefile.include | 20 ++++++++++++--------
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index d32616891dcf..5805a8473a36 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -60,6 +60,13 @@ They can be enabled individually. The full list of the parameters: ::
 	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
 	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
 
+If your LLVM tools have a suffix and you prefer to test an explicit version rather
+than the unsuffixed executables, use ``LLVM=<suffix>``. For example: ::
+
+	make LLVM=-14
+
+will use ``clang-14``, ``ld.lld-14``, etc.
+
 The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
 disable it.
 
diff --git a/Makefile b/Makefile
index daeb5c88b50b..89b61e693258 100644
--- a/Makefile
+++ b/Makefile
@@ -424,8 +424,12 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 ifneq ($(LLVM),)
-HOSTCC	= clang
-HOSTCXX	= clang++
+ifneq ($(LLVM),1)
+LLVM_SFX := $(LLVM)
+endif
+
+HOSTCC	= clang$(LLVM_SFX)
+HOSTCXX	= clang++$(LLVM_SFX)
 else
 HOSTCC	= gcc
 HOSTCXX	= g++
@@ -443,14 +447,14 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 # Make variables (CC, etc...)
 CPP		= $(CC) -E
 ifneq ($(LLVM),)
-CC		= clang
-LD		= ld.lld
-AR		= llvm-ar
-NM		= llvm-nm
-OBJCOPY		= llvm-objcopy
-OBJDUMP		= llvm-objdump
-READELF		= llvm-readelf
-STRIP		= llvm-strip
+CC		= clang$(LLVM_SFX)
+LD		= ld.lld$(LLVM_SFX)
+AR		= llvm-ar$(LLVM_SFX)
+NM		= llvm-nm$(LLVM_SFX)
+OBJCOPY		= llvm-objcopy$(LLVM_SFX)
+OBJDUMP		= llvm-objdump$(LLVM_SFX)
+READELF		= llvm-readelf$(LLVM_SFX)
+STRIP		= llvm-strip$(LLVM_SFX)
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 79d102304470..ab3b2a7dcc94 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,11 +52,15 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-$(call allow-override,CC,clang)
-$(call allow-override,AR,llvm-ar)
-$(call allow-override,LD,ld.lld)
-$(call allow-override,CXX,clang++)
-$(call allow-override,STRIP,llvm-strip)
+ifneq ($(LLVM),1)
+LLVM_SFX := $(LLVM)
+endif
+
+$(call allow-override,CC,clang$(LLVM_SFX))
+$(call allow-override,AR,llvm-ar$(LLVM_SFX))
+$(call allow-override,LD,ld.lld$(LLVM_SFX))
+$(call allow-override,CXX,clang++$(LLVM_SFX))
+$(call allow-override,STRIP,llvm-strip$(LLVM_SFX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -69,9 +73,9 @@ endif
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
 ifneq ($(LLVM),)
-HOSTAR  ?= llvm-ar
-HOSTCC  ?= clang
-HOSTLD  ?= ld.lld
+HOSTAR  ?= llvm-ar$(LLVM_SFX)
+HOSTCC  ?= clang$(LLVM_SFX)
+HOSTLD  ?= ld.lld$(LLVM_SFX)
 else
 HOSTAR  ?= ar
 HOSTCC  ?= gcc

base-commit: fb184c4af9b9f4563e7a126219389986a71d5b5b
-- 
2.35.1


--liu8GtapZ3xLnrsC--
