Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CEF4BFC19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiBVPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiBVPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:13:20 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DDF128DC3;
        Tue, 22 Feb 2022 07:12:49 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32j26cVzz9sSq;
        Tue, 22 Feb 2022 16:12:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCWT0e3TqUio; Tue, 22 Feb 2022 16:12:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32hw65M6z9sSy;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C16708B778;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZJy2lnn-NPtI; Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 26A578B783;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MFCN5K1087440
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:12:23 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MFCMJv1087439;
        Tue, 22 Feb 2022 16:12:22 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Miscellaneous cleanups
Date:   Tue, 22 Feb 2022 16:12:12 +0100
Message-Id: <cover.1645542447.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542739; l=1161; s=20211009; h=from:subject:message-id; bh=yWnidpNwQqTmogbI6NL0MkqckePag1l3+nftVvrPgA8=; b=q6qUG/KlVPJ2FhLjI5+PqvTMEO94z9i+VbliaN/BEc/ZKgZNb2XCtqCYjoOrIa2S3y/imoT78/Q5 q4Es8nsmDiJ8f4UY06SOk7zpB06EcDSdv0M7BJPxiIRm46biUyDk
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

This series applies on top of my series "Allocate module text and data separately" v5.

It does some cleanup around the settling of modules's layout page flags:
- Make module_enable_x() independent of CONFIG_ARCH_HAS_STRICT_MODULE_RWX
- Reunify everything into strict_rwx.c
- Change big hammer BUG_ON()s into WARN_ON()s
- Change misleading debug_align() to strict_align()

Changes in v2:
- Rebased on top of my series "Allocate module text and data separately" v5
- Moved the Kconfig patch out of this series, it is an independent change

Christophe Leroy (4):
  module: Make module_enable_x() independent of
    CONFIG_ARCH_HAS_STRICT_MODULE_RWX
  module: Move module_enable_x() and frob_text() in strict_rwx.c
  module: Rework layout alignment to avoid BUG_ON()s
  module: Rename debug_align() as strict_align()

 kernel/module/Makefile     |  3 +-
 kernel/module/internal.h   | 26 +++----------
 kernel/module/kallsyms.c   |  4 +-
 kernel/module/main.c       | 58 ++++++-----------------------
 kernel/module/strict_rwx.c | 76 +++++++++++++++++++++++++++++++++-----
 5 files changed, 88 insertions(+), 79 deletions(-)

-- 
2.34.1

