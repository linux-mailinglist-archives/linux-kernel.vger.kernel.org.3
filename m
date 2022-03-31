Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B74ED573
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiCaI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiCaI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8B46B0F;
        Thu, 31 Mar 2022 01:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A08BB81FF9;
        Thu, 31 Mar 2022 08:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8031C340F3;
        Thu, 31 Mar 2022 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648715063;
        bh=NTL6oAj1oZo3g+gFKE5BexhVc8mfh6anikK59yMzql8=;
        h=From:To:Cc:Subject:Date:From;
        b=n6SQyrlG6BlUSN5ZMpswatMLQEzGiXEXyf3r8CxnsWFfvgZWXsFP6uuR2gESv56Le
         cHjvbJD2AmCXrdZu9nCokMW8CReg7cnHIKMWDUgVQ4Rwl1pZN36y7MSYWwXJsiW7oE
         S/3sJ8Mvz/3ad9btY5oOKmNHU9gY4ZQ/pOBiPmVf9nP53//q0amjY1p1OrYNEWklqs
         QgXt3XWEJ7S2duStpkNqxOEZGfolZHpZtRZBIV5ah6a6V8gAP5972IcO/4FNkHff6l
         I0R+qzq1Gz/SeZ/bb4vYhjHfQG6barbpmj6vELJuVNtY0iMrYatfez7MzceQ9Sub3H
         52uZUXooc9HFg==
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
Subject: [PATCH v7 0/4] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Thu, 31 Mar 2022 17:24:17 +0900
Message-Id: <164871505771.178991.7870442736805590948.stgit@devnote2>
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

Here are the 7th version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. This version renames the Kconfig
options, make the embedded data readonly, fixes some issues.
Here is the previous version [1].

[1] https://lore.kernel.org/all/164870615889.127053.9055569952366814752.stgit@devnote2/T/#u

You can embed a bootconfig file into the kernel as a default bootconfig,
which will be used if there is no initrd or no bootconfig is attached to initrd. 

This needs 2 options: CONFIG_BOOT_CONFIG_EMBED=y and set the file
path to CONFIG_BOOT_CONFIG_EMBED_FILE. Even if you embed the bootconfig file
to the kernel, it will not be enabled unless you pass "bootconfig" kernel
command line option at boot. Moreover, since this is just a "default"
bootconfig, you can override it with a new bootconfig if you attach another
bootconfig to the initrd (if possible).
The CONFIG_BOOT_CONFIG_EMBED_FILE can take both absolute and relative path.

This is requested by Padmanabha at the below thread[2];

[2] https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u

This had an issue about incremental build and LTO THIN mode issue because
of using '.incbin' directive in inline asm. Now it is solved by separating
it as an asm file.

Thank you,

---

Masami Hiramatsu (4):
      bootconfig: Make the bootconfig.o as a normal object file
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel


 Documentation/admin-guide/bootconfig.rst |   31 ++++++++++++++++++++++--
 MAINTAINERS                              |    1 +
 include/linux/bootconfig.h               |   10 ++++++++
 init/Kconfig                             |   21 ++++++++++++++++-
 init/main.c                              |   38 +++++++++++++++---------------
 lib/.gitignore                           |    1 +
 lib/Makefile                             |   10 +++++++-
 lib/bootconfig-data.S                    |   10 ++++++++
 lib/bootconfig.c                         |   13 ++++++++++
 9 files changed, 111 insertions(+), 24 deletions(-)
 create mode 100644 lib/bootconfig-data.S

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
