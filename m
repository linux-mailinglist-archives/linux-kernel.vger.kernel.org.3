Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782264C0EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiBWJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiBWJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:01:47 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F07D004;
        Wed, 23 Feb 2022 01:01:19 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3VQ62Nm4z9sSq;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tdaM3LWAsilI; Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3VQ61gF0z9sSZ;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 245DC8B77C;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1i2HwELHuxf6; Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.181])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CCEAE8B77B;
        Wed, 23 Feb 2022 10:01:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21N918Aj1126384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:01:08 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21N918OZ1126383;
        Wed, 23 Feb 2022 10:01:08 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Miscellaneous cleanups
Date:   Wed, 23 Feb 2022 10:00:57 +0100
Message-Id: <cover.1645605431.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645606850; l=1242; s=20211009; h=from:subject:message-id; bh=Uz2+kN1n/x9zpl6zVpcs3EmjKyxlQOcAPNtFojggR/A=; b=SAjF73NBrthBLLzdf4B7fowip1Hi2yVbpPKdDtYN/OjzlpJcb2pv6E2Dt3cTa92VHY5zkNyc/jv+ TeNS53VNCMX4dCLQ62qmyQC1WnNugPwg+7hUniO40YFOw0k7iZR/
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

This series applies on top of Aaron's series "module: core code clean up" v8.

It does some cleanup around the settling of modules's layout page flags:
- Make module_enable_x() independent of CONFIG_ARCH_HAS_STRICT_MODULE_RWX
- Reunify everything into strict_rwx.c
- Change big hammer BUG_ON()s into WARN_ON()s
- Change misleading debug_align() to strict_align()

Changes in v4:
- Rebased on top of Aaron's series "module: core code clean up" v8.

Changes in v2/v3:
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
 kernel/module/strict_rwx.c | 75 +++++++++++++++++++++++++++++++++-----
 5 files changed, 87 insertions(+), 79 deletions(-)

-- 
2.34.1

