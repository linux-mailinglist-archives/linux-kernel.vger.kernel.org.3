Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7634ED397
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiCaF6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiCaF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29EC19752C;
        Wed, 30 Mar 2022 22:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3A6158C;
        Thu, 31 Mar 2022 05:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C072C340ED;
        Thu, 31 Mar 2022 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706164;
        bh=Xfm8BU7UOmG+kisIrZuuaFL9DNbvA4ifq7sBlUpiS3I=;
        h=From:To:Cc:Subject:Date:From;
        b=TeY8XoPxTSxTBBsuLMFC3yf5U/iVPiW1uinSGKoqsUSsba+vu6fOH1B+afZggvbED
         l7XCagxF3jFF/vvAEu2j9c43ZTdyPIPe+0C5WR6evY1D9t+rn+jHPAaUhXxBUFgP3Z
         myMhmV+CGZr5QxQntfiRI9xETMNak8cbTOqYr+GTYXlM0dx+lQaYdBJtM9Av2pWXJr
         pP8hJ0CxcW8Q5sxdIdgK1Lie2UTtA/bPylFBdjA8squuFgaV88p/60VO7mCNoAy6vb
         G00jN6sb9Eb1Ldu9TfShlLyzDz/j8QqPcWVG79Z+dHtEuptoPyq8uOOFFIc4qvvDjx
         urLVx2NUsHcCQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: [PATCH v6 0/4] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Thu, 31 Mar 2022 14:55:59 +0900
Message-Id: <164870615889.127053.9055569952366814752.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 6th version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. This version adds a new patch to use
obj-y instead of lib-y for bootconfig([1/4]) and split the inline asm code into
independent asm file for incremental build with LTO THIN mode issue(*), which
was reported in the previous version [1].

[1] https://lore.kernel.org/all/164847778869.3060675.8115416881394543419.stgit@devnote2/T/#u

You can embed a bootconfig file into the kernel as a default bootconfig,
which will be used if there is no initrd or no bootconfig is attached to initrd. 

This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
path to CONFIG_EMBED_BOOT_CONFIG_FILE. Even if you embed the bootconfig file
to the kernel, it will not be enabled unless you pass "bootconfig" kernel
command line option at boot. Moreover, since this is just a "default"
bootconfig, you can override it with a new bootconfig if you attach another
bootconfig to the initrd (if possible).
CONFIG_EMBED_BOOT_CONFIG_FILE can take both absolute and relative path, but
to simplify and make it independent from the build environment, I recommend
you to use an absolute path for that.

This is requested by Padmanabha at the below thread[2];

[2] https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u

(*) this issue has been reported to github ClangBuiltLinux project [3]

[3] https://github.com/ClangBuiltLinux/linux/issues/1618

and Nick told me that we can avoid this by disabling LTO on that file.

CFLAGS_REMOVE_<file>.o := $(CC_FLAGS_LTO)

But I chose Masahiro's idea to split the inline asm into an independent
asm file, since that can also simplify the Makefile.
The above mitigation should be applied to kernel/configs.c and kernel/kheaders.c
but that should be another story (maybe LTO bugfix?).


Thank you,

---

Masami Hiramatsu (4):
      bootconfig: Make the bootconfig.o as a normal object file
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel


 Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
 MAINTAINERS                              |    1 +
 include/linux/bootconfig.h               |   10 ++++++++++
 init/Kconfig                             |   21 ++++++++++++++++++++
 init/main.c                              |   31 +++++++++++++++---------------
 lib/.gitignore                           |    1 +
 lib/Makefile                             |   10 +++++++++-
 lib/bootconfig-data.S                    |   11 +++++++++++
 lib/bootconfig.c                         |   13 +++++++++++++
 9 files changed, 110 insertions(+), 19 deletions(-)
 create mode 100644 lib/bootconfig-data.S

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
