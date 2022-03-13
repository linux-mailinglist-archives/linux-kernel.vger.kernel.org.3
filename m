Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE84D759B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiCMN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCMN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878A5EBF8;
        Sun, 13 Mar 2022 06:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93911B80C9E;
        Sun, 13 Mar 2022 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB707C340E8;
        Sun, 13 Mar 2022 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647179773;
        bh=49ahMuVXxqXMyt89yNWAq5YEkn+FI4r2gRQSYHmOZrI=;
        h=From:To:Cc:Subject:Date:From;
        b=nuElmcwEzGH/oSe2cGOWfzYNg+/DpDaloYcSkCXBCRB5DO8EzSTs9gwT8j0m6CYFI
         x5q5voQ+3tmLyAkdHvhnGrl2mx7TQI67x8M1z37+AYT0o88lCmOPRYT0njByre/7V/
         B2gpmwTibBkX/1RjV50kpMVnRtV9ry+b9O/48OVGpEdH5nBMOswUyn2PYCiZLd17s0
         ITHPNIFWHtPAGn7du4/pDlmh3buCQmPYz9eiCFHk7C+XOtv4F5pK2Onz7YFPQn88JU
         HhHKHK7bY+MwAd1hAuwUdDZRUHreF6npWR4naNlGCyfYeiNfqCmF/C+hGHsTe+SigA
         wjYvRUst5v6JQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Sun, 13 Mar 2022 22:56:08 +0900
Message-Id: <164717976871.656425.6189991392886085524.stgit@devnote2>
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

Here are the patchset to enable kernel embedded bootconfig for non-initrd
kernel boot environment. You can embed a bootconfig file into the kernel
as a default bootconfig, which will be used if there is no initrd or no
bootconfig is attached to initrd.

This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
path to CONFIG_EMBED_BOOT_CONFIG_FILE. Even if you embed the bootconfig file
to the kernel, it will not be enabled unless you pass "bootconfig" kernel
command line option at boot. Moreover, since this is just a "default"
bootconfig, you can override it with a new bootconfig if you attach another
bootconfig to the initrd (if possible).

This is requested by Padmanabha at the below thread;

 https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u

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
 lib/Makefile                             |   12 ++++++++++++
 lib/bootconfig.c                         |   23 ++++++++++++++++++++++
 7 files changed, 111 insertions(+), 18 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
