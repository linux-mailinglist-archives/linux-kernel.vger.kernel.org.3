Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C549022E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiAQGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiAQGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:55:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DFC061574;
        Sun, 16 Jan 2022 22:55:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q75so2318081pgq.5;
        Sun, 16 Jan 2022 22:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfQMAq/Apehq7M5Ow53bRLVJzOggGb2+TxDkeBg8WQY=;
        b=g9FexeYLN6Foe1JOmn8J/R40DoW7gzPiOgFjOGDBHWvZNXFmQXILDJWlwDmhWujVKL
         QkcgEFaeE0w2ojy/mTfdKtiHyDTrQhxnONS0UVyfd5wW031p0oc+OQBMret+HfQLuKa6
         Mr/jDsWuEoP4P4V4WTLJIhjkxE8IS/szltd2qwEXEVvF4hcEY9p/tdrX9XAatiCyDfoI
         gU0EVrSKIJ1xxqjEhfGbcOk1j0m/BkPBKPhQSRZWSkxOP+V/o649Wz+R/QsFh1sxGZN0
         C+muS/UvSDCXb/TxP3NeSjBCFggnpGEm1zVWAAIkiUDMEqNIDhEIPCjqsnpDA3Wb0R0L
         eQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfQMAq/Apehq7M5Ow53bRLVJzOggGb2+TxDkeBg8WQY=;
        b=2Dyvvt7rV3fspI5BF4CvuuJYGzb2mhPtZi6mDeCcKAYXLfWyQxdA/+9lTiGxynG8YU
         qff8amCaQ0uI68aEiuDJXa5kRgWcZmhy7axA8V8YhCdr6DNnfOi3DNp4uEqHyUNAgz+5
         pQWAKJ/Zm/4VlXisTdMrdP2JoYx05nc7Yk+1E4NTg1dfeYBmgmlrtXfVRnOtHZF6kOid
         YxyjYjvZQ8RM9Z5oAE/p/DTJSyHHvUhFXQn74nGr0W2VvqffxP6lnqCnRCiK9S0nxx24
         ydBDkH518xuOMIrJ7lAZwMY9a71kOwf7SHPwZKxObkwTYbiImueVuyl4irqxOZUTOthn
         kFDw==
X-Gm-Message-State: AOAM533eOFfDAVexbQKC1Op8hqS/RQRksXbekI1DpLCVVSsBjY5GqT/z
        nKYYFTO/7nU0aCw6kcvWPAo=
X-Google-Smtp-Source: ABdhPJz0lvhduC7ISc1QJRct9JcjWyVgEI4VVibFWtEEa8MdAOsan7i4Gpg+fhF/LOjeCRdqRc+vKw==
X-Received: by 2002:a05:6a00:1a4a:b0:4c3:18c8:3595 with SMTP id h10-20020a056a001a4a00b004c318c83595mr10488854pfv.61.1642402550243;
        Sun, 16 Jan 2022 22:55:50 -0800 (PST)
Received: from vimal-VirtualBox.. ([49.207.201.237])
        by smtp.gmail.com with ESMTPSA id d11sm12832234pfu.211.2022.01.16.22.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:55:49 -0800 (PST)
From:   Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To:     mcgrof@kernel.org
Cc:     vimal.Agrawal@sophos.com, hch@infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        JBeulich@suse.com, jeffm@suse.com, sam@ravnborg.org,
        linux-kbuild@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, avimalin@gmail.com,
        Vimal Agrawal <vimal.agrawal@sophos.com>
Subject: [PATCH v3] kernel/module.c: heuristic enhancement in case symbols are missing e.g. when INSTALL_MOD_STRIP= "--strip-unneeded" is used
Date:   Mon, 17 Jan 2022 12:24:52 +0530
Message-Id: <20220117065452.83894-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YeBEAavbBh/MnbEF@bombadil.infradead.org>
References: <YeBEAavbBh/MnbEF@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel modules are stripped off symbols for some reason (e.g. built by
using strip --strip-unneeded option) then stack traces in dmesg do not show
symbol name for address. It just prints absolute address sometimes (if
there is no good match with any symbol)
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
---
 kernel/module.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 24dab046e16c..4de15c06e760 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4270,14 +4270,21 @@ static const char *find_kallsyms_symbol(struct module *mod,
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
 
@@ -4308,6 +4315,19 @@ static const char *find_kallsyms_symbol(struct module *mod,
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

