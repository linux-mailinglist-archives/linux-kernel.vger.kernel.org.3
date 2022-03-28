Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A254E9987
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbiC1Obn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbiC1Obj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08F3EF13;
        Mon, 28 Mar 2022 07:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9BE6122F;
        Mon, 28 Mar 2022 14:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD272C004DD;
        Mon, 28 Mar 2022 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477794;
        bh=byiE8FZ883BrjGw8gfIztJdTINfyzJFcS+KRzQJss3M=;
        h=From:To:Cc:Subject:Date:From;
        b=rrgEezYG/4cPc4oou3FM0jWLFHkwN45btCIqU4Bx0pGbjxjngdZuXXlLPbcdE8Rq7
         FmBtEZfNY+CLpzWy99qk17y3bvylWiF3OCR/eO6ZZAT0yj1J26QSr3vowekLj91s+X
         QzZV2tq5M6WB3LxDG+Yk+Ywoxv3W25S+eOoKtAxqTKZXjp2KU+LD6uptY17KiWnK9I
         U2zM0IMs3ODG9gesiN/d3xglAwNrfMo0UI4/Ordt6O8SH4T2/mcmAybZa4wVhW6++e
         H+6eMQFTG+wkv6EV4zd2Uu1X7gi0EJmrl4txArc+Bbt2oFdBYsOErx5Syw25UQuutr
         /5fBWENqK7hkA==
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
Subject: [PATCH v5 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Mon, 28 Mar 2022 23:29:49 +0900
Message-Id: <164847778869.3060675.8115416881394543419.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 5th version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. This version fixes to sort .gitignore
and fixes lib/Makefile to cleanup default.bconf correctly and to allow user
to specify a relative path to CONFIG_EMBED_BOOT_CONFIG_FILE. (Thanks Masahiro!)
Also this update the document patch about the relative path.
Here is the previous thread [1].

[1] https://lore.kernel.org/all/164833878595.2575750.1483106296151574233.stgit@devnote2/T/#u

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


KNOWN ISSUE:

According to the report from Padmanabha[3] and my analysis [4], the embedded
bootconfig data may not be updated if you do incremental build the kernel
with CONFIG_LTO_CLANG_THIN.

[3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
[4] https://lore.kernel.org/all/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/

This seems like clang's LTO Thin mode issue. It may not detect the inline
asm depends on external files.

I think the possible workaround is to split the inline asm which includes
'.incbin' directive into an asm file. But this should be done in another
seires because there are other features which uses '.incbin'. (e.g.
/proc/config.gz)

Thank you,

---

Masami Hiramatsu (3):
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel


 Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
 include/linux/bootconfig.h               |   10 ++++++++++
 init/Kconfig                             |   21 ++++++++++++++++++++
 init/main.c                              |   31 +++++++++++++++---------------
 lib/.gitignore                           |    1 +
 lib/Makefile                             |    9 +++++++++
 lib/bootconfig.c                         |   23 ++++++++++++++++++++++
 7 files changed, 108 insertions(+), 18 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
