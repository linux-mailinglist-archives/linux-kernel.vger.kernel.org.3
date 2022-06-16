Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC054DB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359230AbiFPHZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:25:48 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3475BE62
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:25:47 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25G7OEsF031436;
        Thu, 16 Jun 2022 16:24:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25G7OEsF031436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655364255;
        bh=mQROqItvmSlDcvsqJLeTwZi2M0Fg/DcQgBwBCEmdVDg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZqsGa2m9MAMNFfvnU7Dv450LIdvjIazBcWK0Rb2dBWIcsWzoHwsT1QBZL8pbi5fNN
         z+jFwYTynUZ3Jj9m+9qoPzcwG2dSgCQpig5vRlzO6gkd220kSvNKYBxwpYSe3LeR2M
         5G6a+tSQH15FFr+aJPN9+5f0elbdDXvLqzlhOO3atonpunvHkdC594GeHcWAZC2AdB
         MEircSz/N7DLuDNqToQz042IFNAHOy3Y++1mi6fOIIrD2WkihrA17QBrGwqISA1kfT
         YgWI5x7kIvLTnWgsH6OsESct5ztCtfgq3KJKKfU5nCQ44bTTbvk1nHQj6lx6sy3+p7
         y77yMo+KZGKwQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] x86/purgatory: hard-code obj-y in Makefile
Date:   Thu, 16 Jun 2022 16:24:06 +0900
Message-Id: <20220616072407.2317131-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/Kbuild guards the entire purgatory/ directory, and
CONFIG_KEXEC_FILE is bool type.

$(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..248b009c4061 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
+obj-y += kexec-purgatory.o
-- 
2.32.0

