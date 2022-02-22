Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AFC4BF63B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiBVKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBVKkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:02 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DDF1520E8;
        Tue, 22 Feb 2022 02:39:37 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wdj50Q3z9sT5;
        Tue, 22 Feb 2022 11:39:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jHFHTioKnTHE; Tue, 22 Feb 2022 11:39:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wdb75Wnz9sT7;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD0808B779;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AkWqTYERrSeL; Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A466F8B778;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MAd6mW1076201
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:39:06 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MAd61Y1076200;
        Tue, 22 Feb 2022 11:39:06 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Miscellaneous cleanups
Date:   Tue, 22 Feb 2022 11:38:54 +0100
Message-Id: <cover.1645526008.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645526317; l=1607; s=20211009; h=from:subject:message-id; bh=cKv9KKgoBNSylrpIT7tpBILHSR+/VwOi4Ee53d73y/M=; b=3G8kaiPC30bMdAc7W04K5X+LfCarmXMwNbhA7Rw1TOD784E36VjuZ2j4ZyQJIjRfbd3WZhncdg3T 7oGR42phCX2F6ScuKbctOZ8xOUz6xS1TFRysSYjSC9fgYtorsCSy
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applies on top of my series "Allocate module text and data separately" v4.

It contains some cleanups to the module core.

First patch brings back signature.c out of kernel/module/ as this file
is not directly linked to modules. Ideally this change should be squashed
in first patch of Aaron's series.

Second patch moves Kconfig's module related stuff in a dedicated Kconfig.

Patches 3-6 do some cleanup around the settling of modules's layout page flags.

Christophe Leroy (6):
  module: Have kernel/module/ dedicated to CONFIG_MODULES
  module: Move module's Kconfig item in kernel/module/
  module: Make module_enable_x() independent of
    CONFIG_ARCH_HAS_STRICT_MODULE_RWX
  module: Move module_enable_x() and frob_text() in strict_rwx.c
  module: Rework layout alignment to avoid BUG_ON()s
  module: Rename debug_align() as strict_align()

 init/Kconfig                                  | 286 +-----------------
 kernel/Makefile                               |   3 +-
 kernel/module/Kconfig                         | 286 ++++++++++++++++++
 kernel/module/Makefile                        |   6 +-
 kernel/module/internal.h                      |  26 +-
 kernel/module/kallsyms.c                      |   4 +-
 kernel/module/main.c                          |  58 +---
 kernel/module/strict_rwx.c                    |  76 ++++-
 .../signature.c => module_signature.c}        |   0
 9 files changed, 377 insertions(+), 368 deletions(-)
 create mode 100644 kernel/module/Kconfig
 rename kernel/{module/signature.c => module_signature.c} (100%)

-- 
2.34.1

