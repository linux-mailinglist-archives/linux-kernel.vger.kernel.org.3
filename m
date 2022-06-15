Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786254CD52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiFOPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiFOPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:44:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32A27FE4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:44:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n28so16769701edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIYHj2NDDVJF0mLEUCRKi8z+1RCVVfN+BTacNAukPpw=;
        b=po1vSreM0raRRhJTH2s6hbL1OoicpZRJIzx1kny61eOzRFKf5Wl3FyQyZuvRdH0sAC
         CCaQ4gDJQGG4KcVGolFDLpTNNmxGveMhUix8MUOB89uzxzlDAbyliwHetrEujAJMtRoz
         Ar2iwPqVMNBH7VRs6axqYGj+9iHBsUBRFIUbs+63/A0Jy+dcl7QG32oe+p5sPhxjopjw
         egTW44l+j3ZnCZCv5Ddzl0dGyMhj2mchQ1K+CKMSrDmGzEyNpZrFFRs1KiMcTwLF6Oxy
         gZyr2doVI9Pk6w7lmktk1K8B8wW9y+hPtCziH2FzdPztNl9xDcXGWVPZzqVTC3zfWlNW
         bx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIYHj2NDDVJF0mLEUCRKi8z+1RCVVfN+BTacNAukPpw=;
        b=ztR7+8vLzunuTw4lnp7jVKp+inyINWADBpTHJl3LgTMdVk7V8v3kOgrNTpWG7loTsB
         J8ykZzNMG9t39cGvutUBtjg08sFf8gvQqBvSTRKltgUBBsQD5UTPXZjSOZOzvtfNziPz
         0EOLDuqssAVRQHDcSccM65Pm8YAtJYLkPML696dPwGTfxre5oSinIBalKqZiLESVZxeK
         M2ttE2klYj0HBQFZXSBG4b7oakDg1OoIRzj25h5+/AONso2J/WpyjzUEy/C2vCgCKwhW
         JOZRXkKSuYAcyhsD4nM3jVmZGUb/3hflHvKu7JWpub4Kc1hEuygTY2xsSm/ALGeZf8Oi
         VnPg==
X-Gm-Message-State: AJIora+HJlC8iryCOtrTatVRFb8vfaLsoNVODPFI9CnzPkmwkazR9Kr0
        KdeVZ+P9Oho1nw8amYDGC8s=
X-Google-Smtp-Source: AGRyM1uIdf6lGVqDTBpiuV6lalY5X15IoR8lN+vH9hNuevBwaTVs9SmxryASV5GPJ9URZxh1WmS1zw==
X-Received: by 2002:a50:fc0d:0:b0:42d:c1ae:28bc with SMTP id i13-20020a50fc0d000000b0042dc1ae28bcmr485584edr.24.1655307877878;
        Wed, 15 Jun 2022 08:44:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d5c2000000b0042dd630eb2csm9494587eds.96.2022.06.15.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:44:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: free module name
Date:   Wed, 15 Jun 2022 17:44:31 +0200
Message-Id: <20220615154432.314974-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the type of the record last as the helper `audit_free_module()`
depends on it.

    unreferenced object 0xffff888153b707f0 (size 16):
      comm "modprobe", pid 1319, jiffies 4295110033 (age 1083.016s)
      hex dump (first 16 bytes):
        62 69 6e 66 6d 74 5f 6d 69 73 63 00 6b 6b 6b a5  binfmt_misc.kkk.
      backtrace:
        [<ffffffffa07dbf9b>] kstrdup+0x2b/0x50
        [<ffffffffa04b0a9d>] __audit_log_kern_module+0x4d/0xf0
        [<ffffffffa03b6664>] load_module+0x9d4/0x2e10
        [<ffffffffa03b8f44>] __do_sys_finit_module+0x114/0x1b0
        [<ffffffffa1f47124>] do_syscall_64+0x34/0x80
        [<ffffffffa200007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index f3a2abd6d1a1..3a8c9d744800 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1014,10 +1014,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
-	ctx->type = 0;
 	audit_free_module(ctx);
 	ctx->fds[0] = -1;
 	audit_proctitle_free(ctx);
+	ctx->type = 0; /* reset last for audit_free_*() */
 }
 
 static inline struct audit_context *audit_alloc_context(enum audit_state state)
-- 
2.36.1

