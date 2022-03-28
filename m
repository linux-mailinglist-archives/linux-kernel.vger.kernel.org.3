Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650E64E8D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 07:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiC1FtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 01:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiC1FtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:49:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D655006F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 22:47:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 10so11469674qtz.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 22:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awOwP9Jzhs17cGP+PeKK0ZA8BbP44Lx7OHHlXGKgDaU=;
        b=DgCfRAFSzBCotgie8rQynAHBECTXSw4S5PIyd1BjLnlwnhke2lkWc9Aknd2N3N86Xw
         JDOo8vCGcIR/bacIgSzVCw/HQFZRFhLkJvv9ieq3JKuZ4BC6j3t8Phhr6GvEMjhQ8JPE
         D3aDaWXyIX167DYlplUZoXinYr2Ik1WLXbFXQyoYvyRu3cEnBkHqOXE1y8st7NoVaXZN
         MiJQrcSY8Gdzd+udet3xP7zRx1YPvyuID0UhGG0ihEGecpUoBpofF1Af0XePkboQVBwC
         wpTTL0PvCy/Zi6cgQc8+jR7w/hUpM4Vw2MWwiN8KcX0VuEORUW+e93tHdQ+Z2M1BSKw6
         o/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awOwP9Jzhs17cGP+PeKK0ZA8BbP44Lx7OHHlXGKgDaU=;
        b=Vj14V3bB61fxccvtxNaL/1bzGBSp4z90vXHOo1LwaHTg5zbGFatvHYtGe+FdgTq/Bx
         Ezm25s+o9IVDFiQyL5dN9cc50SpXLedfMo1JPM9BgxYHtnAk28wjaNBjdkIYmBAyCYHc
         fGu9Ovze74fdSIa+dJdxZMX5CyyqAkIAw+SPHuBHKFGWsnyPbO3DGUDA8y+Elp+mLwKv
         WfzBSXCOpP4XUJRo1j49Qm0BB/aKDiSxorv5UJlnrX63NkLKoCxcf3zxZmfI/sE4RHsv
         XthClULEdzVHoyWunZ06sjBxCnhDvaCeCKsYw3OGBK5ZeQXiikgh0XBkaBGkP/n6nr8s
         h7Qg==
X-Gm-Message-State: AOAM531ijsu/6hsZQHJgoYTkozhfii3MYPGy/kEeBzzBoQmOkVC7myVy
        5KNNK8yMguEiYZuV/1B/JOU=
X-Google-Smtp-Source: ABdhPJw+0suad34DqjR5blS7erhntKhDrIn2UHXMnAju4AEchO/G9ZXmrj07UlDlhEetDgQqiiuAHA==
X-Received: by 2002:a05:622a:c4:b0:2e1:cb5b:9b5c with SMTP id p4-20020a05622a00c400b002e1cb5b9b5cmr20271910qtw.69.1648446450453;
        Sun, 27 Mar 2022 22:47:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 186-20020a370cc3000000b0067d36e3481dsm7237261qkm.17.2022.03.27.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 22:47:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] audit: do a quick exit when syscall number is invalid
Date:   Mon, 28 Mar 2022 05:46:42 +0000
Message-Id: <20220328054641.2372974-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Userspace may use syscall with invalid syscall number by calling
syscall(syscall_num,..). For example we found openSSH may use
syscall with syscall number is -1 in some case. When that happens
we better do a quick handle no need to gohead.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
---
v2:
- fix compile error of arch/alpha, I have no alpha compile environment, so this fix
- is done by code review.
---
 arch/alpha/include/uapi/asm/unistd.h | 1 +
 kernel/auditsc.c                     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 71fd5db06866..8115062216e4 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -13,5 +13,6 @@
 #define __NR_getgid	__NR_getxgid
 
 #include <asm/unistd_32.h>
+#include <asm-generic/unistd.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..ea4915999e01 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2077,7 +2077,8 @@ void __audit_syscall_exit(int success, long return_code)
 	struct audit_context *context = audit_context();
 
 	if (!context || context->dummy ||
-	    context->context != AUDIT_CTX_SYSCALL)
+	    context->context != AUDIT_CTX_SYSCALL ||
+	    unlikely(context->major < 0 || context->major >= NR_syscalls))
 		goto out;
 
 	/* this may generate CONFIG_CHANGE records */
-- 
2.25.1

