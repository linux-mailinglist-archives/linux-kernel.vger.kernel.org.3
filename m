Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916214D7929
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiCNBzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCNBzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:55:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E99321B6;
        Sun, 13 Mar 2022 18:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B39E2B80CAA;
        Mon, 14 Mar 2022 01:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A41C340E8;
        Mon, 14 Mar 2022 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647222838;
        bh=CvpvrASUJIVEEli1BWz2c038fnfHgRtVIsm0V2TZ6pA=;
        h=From:To:Cc:Subject:Date:From;
        b=s7J/Kh0TgkewmYZbhLwi3y/OiTkF+GuBqKr9H/q4BveZRBDlLEwvsEQjCrfNSF7Cb
         A0b/4ZF1X2GK0Is6jFgQg/US2sxa6tCLZTcADAH6MdqlftRf+192lT/mt5NTofbNz0
         9pgrHNnIwYe+E4q3jne8L/H7x6uDh/j4OczJfb0olE3xxk4gjSKCdc3zXNqlZC62cR
         cc5m6llXRfelAEfBtabbTDi8DP2U+5krvX1kUysEJrhjAm9QxlYGXc8JKWNSJUg4d6
         Vr7030mDxyavRujsC5N37Ex5IQM/TwlGcQUZtNCjjxpNVsNHEnm++jrBSxouBMfJbF
         xWmuXPIvCvBNA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Mon, 14 Mar 2022 10:53:53 +0900
Message-Id: <164722283333.689258.144495814460576707.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 2nd version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. You can embed a bootconfig file into
the kernel as a default bootconfig, which will be used if there is no initrd or no
bootconfig is attached to initrd.

This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
path to CONFIG_EMBED_BOOT_CONFIG_FILE. Even if you embed the bootconfig file
to the kernel, it will not be enabled unless you pass "bootconfig" kernel
command line option at boot. Moreover, since this is just a "default"
bootconfig, you can override it with a new bootconfig if you attach another
bootconfig to the initrd (if possible).
CONFIG_EMBED_BOOT_CONFIG_FILE can take both absolute and relative path, but
to simplify and make it independent from the build environment, I recommend
you to use an absolute path for that.

This is requested by Padmanabha at the below thread;

 https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u

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
 lib/Makefile                             |   12 ++++++++++++
 lib/bootconfig.c                         |   23 ++++++++++++++++++++++
 7 files changed, 110 insertions(+), 18 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
