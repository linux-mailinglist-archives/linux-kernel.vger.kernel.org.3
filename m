Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C764E8031
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCZJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCZJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:49:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FD24B0B0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:47:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f3so8067406qvz.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B7SpbgCMQv+5yCcAkjFJyzQjT6pt2NifXC9lsW5qSg=;
        b=NpmAWev/N16WKN4wld338PxVITBO9RaPVr/AiJWR/Tpk9ZkmS65sp3fXy0PbruDj8p
         691+5dReWc86SJbwzkI+aj7N3j3vLHifW8nm4a2Mwr5yuRZd+lEvEntSTk2snA/V/weH
         wdPKT7DqRgJ9qtW0JSmbG4iPJvDUyNnWeEIwJd3ufYL9Mb6taDLp+l8m9bD4JK3dcGws
         eNwbVWO+HJOSqTzgED/jzC7gKX7ioVzzEqFSliuvsueHkLlg8XXcK+pRDdxKJZZU+jHc
         3yjmU3t5xnZUyTgplbkiMcFu93/ufnnA8FQIx4DFKjCq+LTxz2FvaouRvipzm8F5VPpr
         wtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B7SpbgCMQv+5yCcAkjFJyzQjT6pt2NifXC9lsW5qSg=;
        b=ASaqLTpo58BJIEBFIPxsvy30pH73l2q7zERcxa8hTQGUxV1EJDyR/1XXgRU0gWRl1A
         sqdH/0wi0PKH7iTUG3Wn1lbR7tVznGgAsuU4LQCou3ZQqMAFKAVor4Gxp1NigweBe+Zl
         u4nV2TJqqG8GvFeK7HWIycaavErvWjVgZdIiRl9omE7tpFkydBuOu+ohy0ckn9RVBL1n
         IgXlYdkjlZt5Dwjoyuq2I4Dt82PN80GVK4r8aPOS7iWY0TXMEPSQ79lqpm/YsOg2DoWL
         XeDbEuuGhf6CiaGUsAdBCSjSDWJx0fDIWmNhL8Ee25o86rKtNvWLo7dqBdjyihQZVH2Q
         CTMQ==
X-Gm-Message-State: AOAM530eI1gCM+bmiSpNANnnHSPAsqNaZ+Qi1VjiQVkei8p2nwWl0MLR
        qlhFrLj8QElx9i1NEwvEYx3Pn4yM8Tg=
X-Google-Smtp-Source: ABdhPJwUVUU6ZzOzYMIyAP6uywRdMOZDfIGhQ81kHZ34vcxcfN8gQN0bMTTGr8IUCHG+3kTs5+Is/g==
X-Received: by 2002:a05:6214:2428:b0:441:5f62:b8c4 with SMTP id gy8-20020a056214242800b004415f62b8c4mr12716057qvb.21.1648288048361;
        Sat, 26 Mar 2022 02:47:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a121100b002e0702457b2sm7106246qtx.20.2022.03.26.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 02:47:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] audit: do a quick exit when syscall number is invalid
Date:   Sat, 26 Mar 2022 09:46:55 +0000
Message-Id: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
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
 kernel/auditsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..806cd57d7f20 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2077,7 +2077,8 @@ void __audit_syscall_exit(int success, long return_code)
 	struct audit_context *context = audit_context();
 
 	if (!context || context->dummy ||
-	    context->context != AUDIT_CTX_SYSCALL)
+	    context->context != AUDIT_CTX_SYSCALL ||
+	    unlikely(context->major < 0 || context->major > NR_syscalls))
 		goto out;
 
 	/* this may generate CONFIG_CHANGE records */
-- 
2.25.1

