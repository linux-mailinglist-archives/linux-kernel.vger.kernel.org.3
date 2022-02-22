Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8194BFC37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiBVPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiBVPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:17:21 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577B6D192;
        Tue, 22 Feb 2022 07:16:54 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32nw6165z9sSr;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WgYKq8Sgp9fd; Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32nw5Fx8z9sSX;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A0E738B77C;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7htoJC5EZX_Z; Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A0958B77A;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MFGgTZ1087705
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:16:42 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MFGfXt1087704;
        Tue, 22 Feb 2022 16:16:41 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Miscellaneous cleanups
Date:   Tue, 22 Feb 2022 16:16:30 +0100
Message-Id: <cover.1645542893.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542983; l=1193; s=20211009; h=from:subject:message-id; bh=pmY6zc0jN0qdHfhzeIcJWO8uf2S3v3i7G32QX398RpQ=; b=05T1fkNXvM6i7/duiYk925TtV9O8tCWbpWu9g2UKczIhSzLOSQisWqD0a2OfECm4eil7KTESUNrJ DrFHfP/HD/ie34WPspGF4kNB1apXmlw5UHlMqVhyHhpm8SNuiNFO
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

Changes in v2/v3:
- Rebased on top of my series "Allocate module text and data separately" v5
- Moved the Kconfig patch out of this series, it is an independent change

Sorry for the mess in v2.

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

