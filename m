Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C147D303
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhLVNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhLVNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:24:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4DC061574;
        Wed, 22 Dec 2021 05:24:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c2so2385306pfc.1;
        Wed, 22 Dec 2021 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMGAKcPlheqSTnjrwtt6w+BWJb1l5shZXKx8WQAuKm4=;
        b=lZs5uqvaugVm6Zxom5x8dpTGquK4K2nqQ5+HKSO58BN8gZf1leO2MkE0FDW9B3q0ME
         PJ53BjRZyH0Jv4r8R5G893BrpzxZGVEViyqzRzFH5ob/N4LoJhtOZGHQl1nl7qH1wqqy
         GD5RkWVvSDdYMaVJD/XBdGcExlpZILabagUHJ82F8AGnVS2GbyuoQqYcJo327zVDkbgg
         7AuOa92cFoj+kX6niHGViz9EufjDMVif+CpBjmsQT4tLXgZTbkMWr8+cdWElny8kW1V8
         3sUNEXC8xCP95tg7Z+syY1ue27+IAvGDG4FB54cCZq2dCtZNVHWWW2QUJPb5mHbgyA/R
         WsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMGAKcPlheqSTnjrwtt6w+BWJb1l5shZXKx8WQAuKm4=;
        b=zamUbjSbrRBRgFUmTusyBL4e6wiVhEIV2aWAGz4ik1754Tg+Kns9yYy9vc9uTQ1am5
         ja337ojM0Ebjcm+MiE0iGIenl1DM5v2MPZD6RlABpKHboiwYKr6M69Lnl1+gAfGi/kdx
         3QwWcER//DEb73WH7uviIOo1qbbmBUvxoNJ8Cs4unyIoUqJ7Z12D/7MEdLda0KD/csqH
         5baB72zBx+DDr0IK9mcWRyRjYigmqmIiw07m3m1HHLt0KLKRkUJPHq19xM+WDJYHbwxV
         fWRulaFKmUJRaM4xQzUq8lNN5PgAoTUtspC2EUmGGjqYvX8/MaOiR/gNFLuHm+WnkLzb
         Nuqw==
X-Gm-Message-State: AOAM532Uiz47pA9Ivl9mKP+B8WKHfV6/05jPIXHGuMEB0wLyJ6gROdr7
        atjyt2Mff9DSxJ0m/7Nw9YI=
X-Google-Smtp-Source: ABdhPJzXrhEhQk1lE4s1qiBRBHR/PkiWdv1vjqfy6zoV/62F4i4Yj+z83T6T6/uDCGTE9DpbS8ijcA==
X-Received: by 2002:aa7:8386:0:b0:4b0:29bf:b0d4 with SMTP id u6-20020aa78386000000b004b029bfb0d4mr2991299pfm.26.1640179451941;
        Wed, 22 Dec 2021 05:24:11 -0800 (PST)
Received: from vimal-VirtualBox.. ([49.207.201.239])
        by smtp.gmail.com with ESMTPSA id j4sm2964261pfj.34.2021.12.22.05.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 05:24:11 -0800 (PST)
From:   Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To:     mcgrof@kernel.org
Cc:     vimal.Agrawal@sophos.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        JBeulich@suse.com, jeffm@suse.com, sam@ravnborg.org,
        linux-kbuild@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, avimalin@gmail.com,
        Vimal Agrawal <vimal.agrawal@sophos.com>
Subject: [PATCH v2] kernel/module.c: heuristic enhancement when INSTALL_MOD_STRIP= "--strip-unneeded" is used
Date:   Wed, 22 Dec 2021 18:53:32 +0530
Message-Id: <20211222132332.7817-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel modules are stripped off symbols (e.g. built by using strip
--strip-unneeded option) then stack traces in dmesg do not show symbol
name for address. It just prints absolute address sometimes (if there
is no good match with any symbol)
e.g.

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
stack trace as absolute address.
There is no easy way in case box crashes as we loose information on load
address of specific module. This changes the symbol decoding (in kernel/
module.c) such that it can print offset from start of section (.text or
.init.text) in case there is no good match with any symbol.

It will now decode address in such cases to [module]+ offset/size or
[module __init]+offset/size depending on where the address lies (in
core/.text or init/.init.text section of module).

One can use objdump/readelf/nm to find symbols with offset from
.init.text and .text sections.

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
[  407.934089] returning module_base_name: [module __init]
[  407.934088] RIP: 0010:[module __init]+0x4/0x7 [test_module]
[  407.934092] returning module_base_name: [module __init]
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
[  407.934242] returning module_base_name: [module]
[  407.934242] RIP: 0010:[module]+0x4/0x7 [test_module]
[  407.934245] returning module_base_name: [module]
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
---
 kernel/module.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 320ec908045f..6e1621303156 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4256,14 +4256,21 @@ static const char *find_kallsyms_symbol(struct module *mod,
 					unsigned long *offset)
 {
 	unsigned int i, best = 0;
-	unsigned long nextval, bestval;
+	unsigned long baseval, nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+	char *module_base_name;
 
 	/* At worse, next value is at end of module */
-	if (within_module_init(addr, mod))
+	if (within_module_init(addr, mod)) {
+		baseval = (unsigned long)mod->init_layout.base;
 		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
-	else
+		module_base_name = "[module __init]";
+
+	} else {
+		baseval = (unsigned long)mod->core_layout.base;
 		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
+		module_base_name = "[module]";
+	}
 
 	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
 
@@ -4294,6 +4301,19 @@ static const char *find_kallsyms_symbol(struct module *mod,
 			nextval = thisval;
 	}
 
+	if ((is_module_text_address(addr) &&
+		(bestval < baseval || bestval > nextval))) {
+		/*
+		 * return MODULE base and offset if we could not find
+		 * any best match for text address
+		 */
+		if (size)
+			*size = nextval - baseval;
+		if (offset)
+			*offset = addr - baseval;
+		return module_base_name;
+	}
+
 	if (!best)
 		return NULL;
 
-- 
2.32.0

