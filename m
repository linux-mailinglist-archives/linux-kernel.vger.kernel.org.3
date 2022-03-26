Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E264E84B1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 00:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiCZXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 19:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCZXyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 19:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA720F66;
        Sat, 26 Mar 2022 16:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0108360EB2;
        Sat, 26 Mar 2022 23:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42134C340E8;
        Sat, 26 Mar 2022 23:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648338792;
        bh=5G6+y4voRT6pv5UqQZ9GZx4exTKwS4ILxBmp+y5LBOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DcdjiBA+3SzHg4pxkcAAPTgWspF5lDIuAM27Sc2mm3EQvv9pg8HCabZAPedNrl9nK
         QQAOAyBhtHaCjKiGHnGwc7t1CpoZLahlOE8lb/ivNOWd6IbGKdseT0MmCCh6ZuxlFC
         6oi+sIAGpHoDEPIzSn5tGSiDiZuFAywzVwfpxreR5i/9Y7BAjqdq6fc1N+yt72Ynej
         7/T6kFfJjXathOk+5G9zu8PgHvB50Z9Uqm7lj7g47o7fr8CdJnEDzfIsoBSy4UwYdi
         UT6MTWcHMuSXUFBJ7IrR1PVupW887gL3kZQYH4Ty/HlSoFLeVrPze61FduR87rykki
         DSKam4Xvpr1ng==
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
Subject: [PATCH v4 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Sun, 27 Mar 2022 08:53:06 +0900
Message-Id: <164833878595.2575750.1483106296151574233.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 4th version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. I've fixed Makefile to determine
update by checking the contents of embedding bootconfig file with filechk macro.
Thanks Masahiro! Here is the previous version [1] (sorry, I missed to update the
version tag in that series)

[1] https://lore.kernel.org/all/164724890153.731226.1478494969800777757.stgit@devnote2/T/#u

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

According to the report from Padmanabha[3], the embedded bootconfig data may not
be updated if you do incremental build the kernel with CONFIG_LTO. This is
under investigation.

[3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u

Thank you,

---

Masami Hiramatsu (3):
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel


 Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++---
 include/linux/bootconfig.h               |   10 ++++++++++
 init/Kconfig                             |   21 ++++++++++++++++++++
 init/main.c                              |   31 +++++++++++++++---------------
 lib/.gitignore                           |    1 +
 lib/Makefile                             |   10 ++++++++++
 lib/bootconfig.c                         |   23 ++++++++++++++++++++++
 7 files changed, 108 insertions(+), 18 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
