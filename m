Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623644AD75D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiBHLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiBHLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:02:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70344C03FEC0;
        Tue,  8 Feb 2022 03:02:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so1117290pjm.2;
        Tue, 08 Feb 2022 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC04a195i1zvZt11lWzbiso1M82DwOlOuX2AuxB9O58=;
        b=UhdTUDLycpQZpVNf8jlWDX+gExRIqMUNrl4WNEAHorGKILuaG0cajSvVg4n2nUlKM8
         7PWAc3dm3t68KFFDHQFE0PlXpIK+U8tKv1GRMvlvsV42xhfhHn9kJFwjUX1nYhKsnEFs
         hnf7WVSyVUOxzTnSL2o1F3XapDI0SSsrgdRGlwlJE4ciXGABFhB+LLk5M1TO3kvzshAB
         S7Wz757V9kcK/XbZZQMHoTx1fL+Keh6raFoAkA0JqwXfxN/8ZF7sQKfHvLcEygd48S0E
         9U7PkZwWCNiOTeayY9qV7LNkeFBgixKwAXXsI3Ba94ERN0PEhxHx9MBTJ7QLMuI1ZybY
         UnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC04a195i1zvZt11lWzbiso1M82DwOlOuX2AuxB9O58=;
        b=ruL9nT8oSNk14oacvd+LLp1W/9thcFfHPEr3SOFNYs49btEPh5jLv9um3R/Gi7GqHZ
         Fxl3YgDZzffSqSAIxt7zTrtkLafd9Q/8Um8HbwrDH+G8GwqXcq1/onbOxfNghiBBHmiD
         u8YSwx9ifDHxmdcd/5msYT020MPU9/AIaj0eQR57Y6RmKqgaGiG/iDtDll7M8jGNedjE
         Y//+4S78LcKXstcuMktWdnv8zIuQm5PGPcldBffPUathOg+/86pLlvOdo8li2O3mgv9Z
         VhEgBuOF4peNFbOJchkp3+Gs63kCWxaAA2j0kcOyrJ1CQ5+EnvhNTeyyx83vK/F94diW
         pm7A==
X-Gm-Message-State: AOAM533Oz7zndfrDWkpQOxkgTwLphAxmiVcr4WhvIpqfBEDGvqJtTyq8
        Vlxc31S0Vu+TdMX3nTt6YTE=
X-Google-Smtp-Source: ABdhPJx5XPyRKUW58UZe5unsM1B6JEeuOeEyZH4w4NWnRpFInGg4RagyKOT4aqaz0rH+dfOnzTqa8Q==
X-Received: by 2002:a17:90b:390a:: with SMTP id ob10mr754002pjb.110.1644318169614;
        Tue, 08 Feb 2022 03:02:49 -0800 (PST)
Received: from vimal-VirtualBox.. ([49.207.201.237])
        by smtp.gmail.com with ESMTPSA id nu15sm2675935pjb.5.2022.02.08.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:02:49 -0800 (PST)
From:   Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To:     mcgrof@kernel.org
Cc:     hch@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, JBeulich@suse.com, jeffm@suse.com,
        sam@ravnborg.org, linux-kbuild@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, avimalin@gmail.com,
        vimal.agrawal@sophos.com, nishit.shah@sophos.com,
        gregkh@linuxfoundation.org,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@Sophos.com>
Subject: [PATCH v6] modules: add heuristic when stripping unneeded symbols
Date:   Tue,  8 Feb 2022 16:32:31 +0530
Message-Id: <20220208110231.2896-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
References: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel modules are stripped off symbols for some reason then stack
traces in dmesg do not show symbol name for address. It just prints
absolute address sometimes (if there is no good match with any symbol)

This was seen with OpenWrt which uses option INSTALL_MOD_STRIP=
"--strip-unneeded" at kernel/module build/install time, and so modules
are stripped off unneeded symbols.

[245864.699580]  do_nmi+0x12f/0x370
[245864.699583]  end_repeat_nmi+0x16/0x50
[245864.699585] RIP: 0010:0xffffffffc06b67ec                           <<<<<<<<
[245864.699585] RSP: 0000:ffffaaa540cffe48 EFLAGS: 00000097
[245864.699586] RAX: 0000000000000001 RBX: ffff93357a729000 RCX: 0000000000000001
[245864.699587] RDX: ffff93357a729050 RSI: 0000000000000000 RDI: ffff93357a729000
[245864.699588] RBP: ffff9335cf521300 R08: 0000000000000001 R09: 0000000000000004
[245864.699588] R10: ffffaaa545b23ed0 R11: 0000000000000001 R12: ffffffffc06b61a0
[245864.699589] R13: ffffaaa540cffe60 R14: ffff9335c77fa3c0 R15: ffff9335cf51d7c0
[245864.699590]  ? 0xffffffffc06b61a0
[245864.699592]  ? 0xffffffffc06b67ec                                  <<<<<<<<
[245864.699593]  ? 0xffffffffc06b67ec
[245864.699594]  </NMI>

Note RIP: 0010:0xffffffffc06b67ec and 0xffffffffc06b67ec printed in above
stack trace as absolute address. There is no easy way in case box crashes
as we loose information on load address of specific module.

This changes the symbol decoding (in kernel/module.c) such that it can
print offset from start of section (.text or .init.text) in case there
is no good match with any symbol.

It will now decode address in such cases to [module]+ offset/size or
[module __init]+offset/size depending on where the address lies (in
core/.text or init/.init.text section of module).

One can use objdump/readelf/nm to find symbols with offset from .init.text
and .text sections.

steps to reproduce the problem:
-------------------------------
1. Add WARN_ON_ONCE(1) in module e.g. test_module.c
2. Build and strip the module using --strip-unneeded option
3. Load the module and check RIP in dmesg

tests done:
-----------
1. Added WARN_ON_ONE(1) in functions of a module for testing
-------------------------------------------------------------
[  407.934085] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
[  407.934087] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  407.934088] RIP: 0010:[module __init]+0x4/0x7 [test_module]
[  407.934097] Code: Unable to access opcode bytes at RIP 0xffffffffc07edfda.
[  407.934098] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
[  407.934100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  407.934101] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
[  407.934102] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
[  407.934103] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
[  407.934104] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
[  407.934105] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
[  407.934107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.934108] CR2: ffffffffc07edfda CR3: 00000000063ea006 CR4: 00000000000706f0
[  407.934113] Call Trace:
[  407.934114]  <TASK>
[  407.934116]  ? init_module+0x55/0xff9 [test_module]
...
[  407.934232] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
[  407.934234] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  407.934242] RIP: 0010:[module]+0x4/0x7 [test_module]
[  407.934248] Code: Unable to access opcode bytes at RIP 0xffffffffc07e1fda.
[  407.934249] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
[  407.934251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  407.934252] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
[  407.934253] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
[  407.934254] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
[  407.934255] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
[  407.934256] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
[  407.934257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.934258] CR2: ffffffffc07e1fda CR3: 00000000063ea006 CR4: 00000000000706f0
[  407.934260] Call Trace:
[  407.934260]  <TASK>
[  407.934261]  ? init_module+0x5a/0xff9 [test_module]

note that it is able to decode RIP to an offset from module start or
init start now.

tested on linux->next (tag next-20211220)

Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
Acked-by: Nishit Shah <nishit.shah@sophos.com>
Suggested-by: Dirk VanDerMerwe <Dirk.VanDerMerwe@Sophos.com>
---
 kernel/module.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 24dab046e16c..635e631c92f1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4260,6 +4260,19 @@ static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned
 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
 }
 
+/*
+ * Check if module address (addr) passed is as per init passed
+ * if init is true then check in init layout
+ * else check in core layout
+ */
+bool match_address_layout(struct module *mod, unsigned long addr, bool init)
+{
+	if (init)
+		return within_module_init(addr, mod);
+	else
+		return within_module_core(addr, mod);
+}
+
 /*
  * Given a module and address, find the corresponding symbol and return its name
  * while providing its size and offset if needed.
@@ -4270,14 +4283,22 @@ static const char *find_kallsyms_symbol(struct module *mod,
 					unsigned long *offset)
 {
 	unsigned int i, best = 0;
-	unsigned long nextval, bestval;
+	unsigned long baseval, nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	char *module_base_name;
+	bool is_init_address = false;
 
 	/* At worse, next value is at end of module */
-	if (within_module_init(addr, mod))
+	if (within_module_init(addr, mod)) {
+		baseval = (unsigned long)mod->init_layout.base;
 		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
-	else
+		module_base_name = "[module __init]";
+		is_init_address = true;
+	} else {
+		baseval = (unsigned long)mod->core_layout.base;
 		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
+		module_base_name = "[module]";
+	}
 
 	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
 
@@ -4300,7 +4321,8 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
-		if (thisval <= addr && thisval > bestval) {
+		if ((thisval <= addr && thisval > bestval) &&
+			(match_address_layout(mod, thisval, is_init_address))) {
 			best = i;
 			bestval = thisval;
 		}
@@ -4308,8 +4330,20 @@ static const char *find_kallsyms_symbol(struct module *mod,
 			nextval = thisval;
 	}
 
-	if (!best)
+	if (!best) {
+		if (is_module_text_address(addr)) {
+			/*
+			 * return MODULE base and offset if we could not find
+			 * any best match for text address
+			 */
+			if (size)
+				*size = nextval - baseval;
+			if (offset)
+				*offset = addr - baseval;
+			return module_base_name;
+		}
 		return NULL;
+	}
 
 	if (size)
 		*size = nextval - bestval;
-- 
2.32.0

