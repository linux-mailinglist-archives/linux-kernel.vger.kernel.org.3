Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05D9529F88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiEQKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiEQKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:34:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBCB2A251
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:33:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1014960wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT4nAMW0JAIoBqHcxFaOVaEG/FIz0IGVyrQwEE8krKQ=;
        b=DzZEglSrqiIKJu4XPZSnm7RMxXwoe2M/l6p8kdXi29lLtxNYuXDiqg6k0S7aB2phHX
         dNzpk4HRW70bIeSHT/grf2TP5pgNAxEjt7hL7+HxJNYtP8imphsgpYeRlPZzDwWZTKmV
         djfMK/3qxX6Qudbv2AmAW4GkEkN0Do/KnFx1eY4WijMfAZdm3YhsC104fnV4pYfMI8HY
         wgBmAS/KzDFw/5ZtbZOf/kaHoV6qyfktBr9pd0kN33rOLulbmluy5X1j6SVj4/ql2X7H
         zVRmGBt3zJMsR7yNEI/X8aIbp7tvZw/5vgwQVc5kwVAIoRmJHuZ7UKfeBLwuVm0tuaGk
         dvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT4nAMW0JAIoBqHcxFaOVaEG/FIz0IGVyrQwEE8krKQ=;
        b=qPvxuE2NSgCAhNXM/dhW7aS60RcNsBHYq177Ew4erHicqiyjEaEjkOB+pf6SmtTRFp
         by1P+Z7uS4pKH7w/jNXlKwVapkOTK1EzFTJKClzYxxRAbTcr+YyC8msvPhuEpWQoNpza
         4GWigwJ7HWD2bW5CeiXY8vRsSpo+AFp6lofSPG6lsqcpZeaHvKO3Arr6wzdCFCcvi7eE
         K1G8H/nzWoPnYgoF6/EYIgJHffQIPuVFoXErNA4VGsde+tVkZYKJtO0jLlSalqfgYFyn
         69dU2iAiUTtr3XDeIDHEErtShGBZb/J4MEWqHRfSkhXleMUYcROa8fybhNrf1LdkCCZW
         5Btg==
X-Gm-Message-State: AOAM531OVHIh+Ls6YGRCUja+sTHs3pJLH5osCUhPE2UaZtomsgzNtBME
        1wGBxV5O6Wwc5B1ll4Nkm78=
X-Google-Smtp-Source: ABdhPJy/gP0zztsRD7vtob5K4N2IXiX51B0oHXonzekvifaJBRxYe2NMZeb+82HipnJoeQV2fN375g==
X-Received: by 2002:a7b:c4d9:0:b0:394:41a:d36f with SMTP id g25-20020a7bc4d9000000b00394041ad36fmr20695339wmk.152.1652783634498;
        Tue, 17 May 2022 03:33:54 -0700 (PDT)
Received: from desk.. (p200300c55f3c02010000000000000003.dip0.t-ipconnect.de. [2003:c5:5f3c:201::3])
        by smtp.gmail.com with ESMTPSA id u28-20020adfa19c000000b0020d10a249eesm3296988wru.13.2022.05.17.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:33:54 -0700 (PDT)
From:   Julian Orth <ju.orth@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     ju.orth@gmail.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/1] audit,io_uring,io-wq: call __audit_uring_exit for dummy contexts
Date:   Tue, 17 May 2022 12:32:53 +0200
Message-Id: <20220517103253.22601-2-ju.orth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517103253.22601-1-ju.orth@gmail.com>
References: <20220517103253.22601-1-ju.orth@gmail.com>
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

Not calling the function for dummy contexts will cause the context to
not be reset. During the next syscall, this will cause an error in
__audit_syscall_entry:

	WARN_ON(context->context != AUDIT_CTX_UNUSED);
	WARN_ON(context->name_count);
	if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
		audit_panic("unrecoverable error in audit_syscall_entry()");
		return;
	}

These problematic dummy contexts are created via the following call
chain:

       exit_to_user_mode_prepare
    -> arch_do_signal_or_restart
    -> get_signal
    -> task_work_run
    -> tctx_task_work
    -> io_req_task_submit
    -> io_issue_sqe
    -> audit_uring_entry

Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 include/linux/audit.h | 2 +-
 kernel/auditsc.c      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index d06134ac6245..cece70231138 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -339,7 +339,7 @@ static inline void audit_uring_entry(u8 op)
 }
 static inline void audit_uring_exit(int success, long code)
 {
-	if (unlikely(!audit_dummy_context()))
+	if (unlikely(audit_context()))
 		__audit_uring_exit(success, code);
 }
 static inline void audit_syscall_entry(int major, unsigned long a0,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..f3a2abd6d1a1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1959,6 +1959,12 @@ void __audit_uring_exit(int success, long code)
 {
 	struct audit_context *ctx = audit_context();
 
+	if (ctx->dummy) {
+		if (ctx->context != AUDIT_CTX_URING)
+			return;
+		goto out;
+	}
+
 	if (ctx->context == AUDIT_CTX_SYSCALL) {
 		/*
 		 * NOTE: See the note in __audit_uring_entry() about the case
-- 
2.36.1

