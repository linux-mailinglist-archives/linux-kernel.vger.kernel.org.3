Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16554DF66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiFPKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiFPKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:45:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB159B96;
        Thu, 16 Jun 2022 03:45:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53D2521D3B;
        Thu, 16 Jun 2022 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655376342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ULxOKBAy4WHeF0/dTA7hH9Jh74dB9KHeZr7XeBl4+Pg=;
        b=UaY0n8dlgNVMGty9qm6s7IV+Zsc9NVtF92E09/vx16wHyeMVIpXH77aYA8E0PwqlLAZHcr
        fo3YDlysAISklnV5F2pyUFTcS4gEMyVWUAjlMIoh+jREIVk1N9xEDL0PSx5jAmOp+Ttfwa
        etZYR2rFGh92MzShOCCaCkLutcn7/hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655376342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ULxOKBAy4WHeF0/dTA7hH9Jh74dB9KHeZr7XeBl4+Pg=;
        b=R/xbSvanl/cJoXhSie+0fuWqOo6ITx4Wy0vAIDZibTXCQG3IoJ9xlhQwPgNdaxA8M3QZAl
        DOp2jRMLR0sJxyAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0501B2C141;
        Thu, 16 Jun 2022 10:45:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
Date:   Thu, 16 Jun 2022 12:45:41 +0200
Message-Id: <20220616104541.16289-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until the link-vmlinux.sh split (cf. the commit below), the linker was
run with jobserver set in MAKEFLAGS. After the split, the command in
Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
is lost.

Restore it as linkers working in parallel (esp. the LTO ones) make a use
of it.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/Makefile.vmlinux_o | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 3c97a1564947..d032f625b576 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
 endef
 
 vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
-	$(call if_changed_rule,ld_vmlinux.o)
+	+$(call if_changed_rule,ld_vmlinux.o)
 
 targets += vmlinux.o
 
-- 
2.36.1

