Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5815848A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiG1XZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG1XZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:25:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379A664D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:25:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so28396047b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ael+Xw1J3hpNqWnsPLjWAcNCuOln3wAME0FmX5C5/D0=;
        b=OD5qAfUOw26zs0c9O8XattPxnErxJcTmrRUvRW9NLULPdBmvAPDVVgqCFB2mtcjjTC
         EBWuKi53V8VKPAGxCIdcjcMTCHT6I6aFpSYhZn5XYzgJvG54yF7ureB9Mt2HGPuNDqRg
         rXqkh+fPwFC7jhTcxWOqunRSHUMjawAeoW7mcMdXBnsaATxMGUlhZJs+STNrO2dN17Ce
         k7s8JphaNXmTYX9T6h/K90mG8I1HOJ5QBjN3O+ruZHRl9Nz9p3zAx7hVhVx7sNPYjcYL
         Ufn8TJNgXCOHRbnf8r1dKNIcY27Nsq9BC3BOdLYVa9SM1JkXCH6ij8tZEyE+5onf0G8N
         RneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ael+Xw1J3hpNqWnsPLjWAcNCuOln3wAME0FmX5C5/D0=;
        b=6sLTr64YyudtOQwUksGFzQRCVY84QsaZFQ40SYWAXQbFTvPnEJCgngMWVMIse+3EVD
         SQ6GMVBtRh8fMoEQRI2v++XUo6e8WskqG7mZafDLnJjZsi1TgiKlv7mbFRPP7zs1sIR6
         mGSH8hY7Erlslg4KqdkQmrFXcPVAwzFfEuK+eUrN5zmTRj6jbR8mUzBMYPC3lbV4agH5
         sKc2FYAluvjyBN37cJ+8IYFGTw77MlCP7+xif9Kjz2iMWhuc3d0nkeMq05yOT7vifYi7
         RGebMuDofiisp1QsVg749NW9FXzlC7kKJNxSAKBvS9fnttZEc5ImPI4SwiuTjDZAhxXF
         hXFQ==
X-Gm-Message-State: ACgBeo2bQjVAE46EZeGmsc//UKyyBYhsx3Yf4/GjT8ZLjv5ECEjPyIlL
        ZqVDRdOLRnf9G79cjQ+u4vLPRwCckG9zJ2a6zYumtNiGhu2U6wRty10mIBBAD9zfDFEiQksN7xU
        K0epll5vXCK9Xx4Kr/NKpCRehNm7eF2c0YkJYqiH6W/WeGgU5SZ1Po/Gscg9jrgqoDygreW/mJ4
        M=
X-Google-Smtp-Source: AA6agR595SvSJWUcjzvNRJ1QDIXDi+nD4did+TnlQ+Rf5czhpzmeDmlvzPevPfOCKjWIOcGijYKp/00uQhxSNg==
X-Received: from neelnatu0.svl.corp.google.com ([2620:15c:2cd:202:43b7:b885:e5ef:2f3])
 (user=neelnatu job=sendgmr) by 2002:a05:6902:1503:b0:676:a752:fc4b with SMTP
 id q3-20020a056902150300b00676a752fc4bmr773110ybu.438.1659050726683; Thu, 28
 Jul 2022 16:25:26 -0700 (PDT)
Date:   Thu, 28 Jul 2022 16:24:34 -0700
Message-Id: <20220728232434.1666488-1-neelnatu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] lib/cmdline: avoid page fault in next_arg
From:   Neel Natu <neelnatu@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An argument list like "arg=val arg2 \"" can trigger a page fault
if the page pointed by 'args[0xffffffff]' is not mapped and potential
memory corruption otherwise (unlikely but possible if the bogus
address is mapped and contents happen to match the ascii value
of the quote character).

The fix is to ensure that we load 'args[i-1]' only when (i > 0).

Prior to this commit the following command would trigger an
unhandled page fault in the kernel:

root@(none):/linus/fs/fat# insmod ./fat.ko  "foo=bar \""
[   33.870507] BUG: unable to handle page fault for address: ffff888204252608
[   33.872180] #PF: supervisor read access in kernel mode
[   33.873414] #PF: error_code(0x0000) - not-present page
[   33.874650] PGD 4401067 P4D 4401067 PUD 0
[   33.875321] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[   33.876113] CPU: 16 PID: 399 Comm: insmod Not tainted 5.19.0-dbg-DEV #4
[   33.877193] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   33.878739] RIP: 0010:next_arg+0xd1/0x110
[   33.879399] Code: 22 75 1d 41 c6 04 01 00 41 80 f8 22 74 18 eb 35 4c 89 0e 45 31 d2 4c 89 cf 48 c7 02 00 00 00 00 41 80 f8 22 75 1f 41 8d 42 ff <41> 80 3c 01 22 75 14 41 c6 04 01 00 eb 0d 48 c7 02 00 00 00 00 41
[   33.882338] RSP: 0018:ffffc90001253d08 EFLAGS: 00010246
[   33.883174] RAX: 00000000ffffffff RBX: ffff888104252608 RCX: 0fc317bba1c1dd00
[   33.884311] RDX: ffffc90001253d40 RSI: ffffc90001253d48 RDI: ffff888104252609
[   33.885450] RBP: ffffc90001253d10 R08: 0000000000000022 R09: ffff888104252609
[   33.886595] R10: 0000000000000000 R11: ffffffff82c7ff20 R12: 0000000000000282
[   33.887748] R13: 00000000ffff8000 R14: 0000000000000000 R15: 0000000000007fff
[   33.888887] FS:  00007f04ec7432c0(0000) GS:ffff88813d300000(0000) knlGS:0000000000000000
[   33.890183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.891111] CR2: ffff888204252608 CR3: 0000000100f36005 CR4: 0000000000170ee0
[   33.892241] Call Trace:
[   33.892641]  <TASK>
[   33.892989]  parse_args+0x8f/0x220
[   33.893538]  load_module+0x138b/0x15a0
[   33.894149]  ? prepare_coming_module+0x50/0x50
[   33.894879]  ? kernel_read_file_from_fd+0x5f/0x90
[   33.895639]  __se_sys_finit_module+0xce/0x130
[   33.896342]  __x64_sys_finit_module+0x1d/0x20
[   33.897042]  do_syscall_64+0x44/0xa0
[   33.897622]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   33.898434] RIP: 0033:0x7f04ec85ef79
[   33.899009] Code: 48 8d 3d da db 0d 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 9e 0d 00 f7 d8 64 89 01 48
[   33.901912] RSP: 002b:00007fffae81bfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   33.903081] RAX: ffffffffffffffda RBX: 0000559c5f1d2640 RCX: 00007f04ec85ef79
[   33.904191] RDX: 0000000000000000 RSI: 0000559c5f1d12a0 RDI: 0000000000000003
[   33.905304] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   33.906421] R10: 0000000000000003 R11: 0000000000000246 R12: 0000559c5f1d12a0
[   33.907526] R13: 0000000000000000 R14: 0000559c5f1d25f0 R15: 0000559c5f1d12a0
[   33.908631]  </TASK>
[   33.908986] Modules linked in: fat(+) [last unloaded: fat]
[   33.909843] CR2: ffff888204252608
[   33.910375] ---[ end trace 0000000000000000 ]---
[   33.911172] RIP: 0010:next_arg+0xd1/0x110
[   33.911796] Code: 22 75 1d 41 c6 04 01 00 41 80 f8 22 74 18 eb 35 4c 89 0e 45 31 d2 4c 89 cf 48 c7 02 00 00 00 00 41 80 f8 22 75 1f 41 8d 42 ff <41> 80 3c 01 22 75 14 41 c6 04 01 00 eb 0d 48 c7 02 00 00 00 00 41
[   33.914643] RSP: 0018:ffffc90001253d08 EFLAGS: 00010246
[   33.915446] RAX: 00000000ffffffff RBX: ffff888104252608 RCX: 0fc317bba1c1dd00
[   33.916544] RDX: ffffc90001253d40 RSI: ffffc90001253d48 RDI: ffff888104252609
[   33.917636] RBP: ffffc90001253d10 R08: 0000000000000022 R09: ffff888104252609
[   33.918727] R10: 0000000000000000 R11: ffffffff82c7ff20 R12: 0000000000000282
[   33.919821] R13: 00000000ffff8000 R14: 0000000000000000 R15: 0000000000007fff
[   33.920908] FS:  00007f04ec7432c0(0000) GS:ffff88813d300000(0000) knlGS:0000000000000000
[   33.922125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.923017] CR2: ffff888204252608 CR3: 0000000100f36005 CR4: 0000000000170ee0
[   33.924098] Kernel panic - not syncing: Fatal exception
[   33.925776] Kernel Offset: disabled
[   33.926347] Rebooting in 10 seconds..

Signed-off-by: Neel Natu <neelnatu@google.com>
---
 lib/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 5546bf588780..90ed997d9570 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -260,7 +260,7 @@ char *next_arg(char *args, char **param, char **val)
 				args[i-1] = '\0';
 		}
 	}
-	if (quoted && args[i-1] == '"')
+	if (quoted && i > 0 && args[i-1] == '"')
 		args[i-1] = '\0';
 
 	if (args[i]) {
-- 
2.37.1.455.g008518b4e5-goog

