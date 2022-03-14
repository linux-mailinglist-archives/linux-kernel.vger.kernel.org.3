Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57F24D7E33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiCNJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiCNJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F40366BF;
        Mon, 14 Mar 2022 02:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 249CDB80D58;
        Mon, 14 Mar 2022 09:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACD8C340F4;
        Mon, 14 Mar 2022 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248905;
        bh=SQc+UTx2z9nWkBbXQjaaLYW5PShn2QiO/6tP4M7JjXo=;
        h=From:To:Cc:Subject:Date:From;
        b=Pd9xqODXAxKQ3f2nHLNo1y1DdODe3hgVMrF5tguNRwFXJ9BJAD8UJKXhIuiYkGEI7
         X17Z7JxbMTRGGfamSuNMJZXB58u6/xBumgaVvCfzhiSNdHIFZ+NNfTaph2EMAxF1le
         gOHPk5RuK5UsfModCWlwMjpnliYbWr2M41grCmdiGeX9zZ0vj2bliJUNf3oc+HvoKd
         apttjHWXR3EGOZXplApfiyvKdsrrQWZrKj4CmbEEvRmzbtUkk+kAbckDFmaZsB3xfy
         3KvV0UgIoTq1GA356p+HW7RVn8zr23CpyEdBLytMd0yaNvhn4KJEM5Ghh473VF0x12
         LmGERpdCVl7Ow==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/3] bootconfig: Support embedding a bootconfig in kernel for non initrd boot
Date:   Mon, 14 Mar 2022 18:08:21 +0900
Message-Id: <164724890153.731226.1478494969800777757.stgit@devnote2>
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

Here are the 3rd version of the patchset to enable kernel embedded bootconfig
for non-initrd kernel boot environment. In this version, I fixed some typo in
the document patch [3/3].

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
