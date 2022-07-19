Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56149579567
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiGSIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGSIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:41:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46628205C1;
        Tue, 19 Jul 2022 01:41:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C8BE034A06;
        Tue, 19 Jul 2022 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658220112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4IwtKgVrBQfJjnt1jdw4py3dKEs3tHhhDUJgnRuAiI=;
        b=dbYienbZamQI5KxKNpQOngqwP+yH2Up281vDCGa4ya6dJE8M8mJF5/ePX1PePs57SatNzV
        v72wgTxehxZ6Ijsoa0XDGeVXAm6WEHlE4F+Nw2qJK7K7eCma36W88WkeUsMxTmNlExEboL
        eOmidB/DR2CAbuOsDoJcoUwnKVQ4bYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658220112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4IwtKgVrBQfJjnt1jdw4py3dKEs3tHhhDUJgnRuAiI=;
        b=xbw/6FcBWjJgdDAkIa6WLOzenYEEyRAMQsYdap9tx63d4ypOvnl5kuj+uUMfub3dyIzTkI
        1fx4wJoqIqXfDnCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 812192C141;
        Tue, 19 Jul 2022 08:41:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Signed-off-by : Martin Liska" <mliska@suse.cz>
Subject: [PATCH v2 1/2] kbuild: pass jobserver to cmd_ld_vmlinux.o
Date:   Tue, 19 Jul 2022 10:41:48 +0200
Message-Id: <20220719084149.29950-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
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
of it. In this case, it is gcc producing this warning otherwise:
lto-wrapper: warning: jobserver is not available: ‘--jobserver-auth=’ is not present in ‘MAKEFLAGS’

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Signed-off-by: Martin Liska <mliska@suse.cz>
Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2] only commit message updated

 scripts/Makefile.vmlinux_o | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 84019814f33f..886db0659d9c 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -65,7 +65,7 @@ define rule_ld_vmlinux.o
 endef
 
 vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
-	$(call if_changed_rule,ld_vmlinux.o)
+	+$(call if_changed_rule,ld_vmlinux.o)
 
 targets += vmlinux.o
 
-- 
2.37.1

