Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE618507296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354432AbiDSQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354390AbiDSQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A207713F9F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sr2Ym9hi3FIE3E+IMnlmi7HV0lVpM9KeC2p4CZB6abk=;
        b=EgJaTsRE08LvueNEMdqxagQIkiuv01gTw2x7LFZwZ0N0wHx4oA7u+YHodGoZUoPYQAq2H7
        EM/4rdqCE6a3Bf4nieIqbk7h/GHXlxXfnSalvOxOaptudwZHcf8DY4TuLStleKAz1eG4yW
        qkTeo7Bh4Zj63AB7vs60YTaw2ujztAg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-c0-ZtdEbPdmGdUP529XHDQ-1; Tue, 19 Apr 2022 12:05:19 -0400
X-MC-Unique: c0-ZtdEbPdmGdUP529XHDQ-1
Received: by mail-qt1-f197.google.com with SMTP id d18-20020ac81192000000b002ebdd6ef307so10754340qtj.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sr2Ym9hi3FIE3E+IMnlmi7HV0lVpM9KeC2p4CZB6abk=;
        b=4wQpmUMj4jDVMcmIfbW7ibUVEyb7RP0YXNvtMH7pAd+44URkWyr4AY9R/DxxzMfxPH
         SGFWkieHUmenzFaZAU69T5DEjOao6X9aa1rVMVNzLnFfDTLzXblQsK1wlOdzp0sGctN4
         3a5lEk3Wc+S10BwzMyAlGKDVGBm5VARLYOvIoE6bCC5GAtGMZc/iKdQ3j/SIEtpPEASL
         aaBwWr6QNkt8ATkyXlpta2ysoWgcSA/WF+7gE1EsybFr4vPdyncOT3o82v4AiZFuGh5Q
         PzHqOyHxXjtGO0txVl5fbRrt0BQjExZKqXUydAtZjG7uspd6YTatGGvP1smpgx80aG+5
         C1SA==
X-Gm-Message-State: AOAM533Adh6W4BHya2yZJIOaDRwf97zOKHyvV635C6tliarZTO3xJ+vU
        +XxtY7IFbch+P7pMxDZ+rhHCa86moXEXq7hhV4/KuYYKXyCl4dsEF/d16k8x7xM3qc5Pgz5iDBA
        YxQFCHLKznRbLmBBDazA7A6hw
X-Received: by 2002:ac8:5c84:0:b0:2f1:f250:d8d2 with SMTP id r4-20020ac85c84000000b002f1f250d8d2mr10806191qta.101.1650384318415;
        Tue, 19 Apr 2022 09:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVOspozxBG8j5+XeC3VIzeIS3fAxz+VTZQHkh6PIcIX9CWfQOg/d0HGiU0K6DhAUoQ234yQg==
X-Received: by 2002:ac8:5c84:0:b0:2f1:f250:d8d2 with SMTP id r4-20020ac85c84000000b002f1f250d8d2mr10806163qta.101.1650384318183;
        Tue, 19 Apr 2022 09:05:18 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm207251qtk.97.2022.04.19.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:05:17 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: Add CONFIG_HAVE_UACCESS_VALIDATION
Date:   Tue, 19 Apr 2022 09:05:09 -0700
Message-Id: <d393d5e2fe73aec6e8e41d5c24f4b6fe8583f2d8.1650384225.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow an arch specify that it has objtool uaccess validation with
CONFIG_HAVE_UACCESS_VALIDATION.  For now, doing so unconditionally
selects CONFIG_OBJTOOL.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig            | 4 ++++
 arch/x86/Kconfig        | 1 +
 scripts/Makefile.build  | 2 +-
 scripts/link-vmlinux.sh | 4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1e19da774e55..694e0c2bc369 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1041,6 +1041,10 @@ config HAVE_NOINSTR_HACK
 config HAVE_NOINSTR_VALIDATION
 	bool
 
+config HAVE_UACCESS_VALIDATION
+	bool
+	select OBJTOOL
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1320d9a3da3..1a207a805102 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -257,6 +257,7 @@ config X86
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f89d3fcff39f..de0d88f32f58 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -236,7 +236,7 @@ objtool_args =								\
 	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
-	--uaccess							\
+	$(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)		\
 	$(if $(linked-object), --link)					\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d7f26f02f142..3e23a1babad4 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -153,7 +153,9 @@ objtool_link()
 			objtoolopt="${objtoolopt} --static-call"
 		fi
 
-		objtoolopt="${objtoolopt} --uaccess"
+		if is_enabled CONFIG_HAVE_UACCESS_VALIDATION; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
 	fi
 
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
-- 
2.34.1

