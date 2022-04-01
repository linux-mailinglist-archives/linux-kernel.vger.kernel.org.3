Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4094EFC9D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbiDAWKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353139AbiDAWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:10:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C6338BC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:08:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id o13so3343129pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DU/KAvneVMZvyUwbOBCXJHatvzCCAIN7Ytl6QwY8EU=;
        b=cqZTfaay5ukidSBjk5VJHj3uRfyXZLHu+6BwWg5igbNAypA7YFLzCM7eBGIELFcM41
         TMpSn72s+uFhNhHvOAB5qYJ+5aFs9q6EzNHjfSH4UmWO2384Lw5KgI0KRaaf7mMmoWgG
         0XsVQsuI9rNDYkg9VT4YJ+gREdqlf4ss9Jdkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DU/KAvneVMZvyUwbOBCXJHatvzCCAIN7Ytl6QwY8EU=;
        b=rbHKFhSv8nX/81ZckC3Qv2g/6rD+ZVX3gJmxc3TXSvW/eGan8ulM4Mt3KKs71ykIG+
         cA3XTnO7+xvKakksWKDSLY9c/F0bvumgDnJosw8flmFMkvwI60H44ay4f04X0mT1O+yj
         H1xdIt0oJ0IqwhJjetwu5pGiUSr/SiaWG65KKhFKZ9FgNwoUlZE1D0guRiQSsUBRfvaR
         GNp925doMFz2/ctAnXvokmn/hN2lUqpRfYZBmFrNzDFw7CGh1AuJEaPgMX0B8b42Ppuc
         Mc9WqlZjK3xUOCtJvKcnQnXXFAUnN+MPQTVg63Txc8LUNAo/dzqViHLStW8pkdRLMUD+
         CMfw==
X-Gm-Message-State: AOAM5303yfR4uMiHkfg0l4wDC24g0xjMNQskXzXkSL75xOVHgex9lPKS
        qJtBtWGg+IBy/CA9aYkOR73DOA==
X-Google-Smtp-Source: ABdhPJy2sy1C7CXcCxIY6R92ffiHpAxC/4GSwsnETPbbVJrLVIPp8s0futQO1QalpgQMGerY3kwZOw==
X-Received: by 2002:a05:6a00:1702:b0:4fd:aae0:84a1 with SMTP id h2-20020a056a00170200b004fdaae084a1mr12964808pfc.12.1648850930427;
        Fri, 01 Apr 2022 15:08:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:72c9:527e:d936:c24b])
        by smtp.gmail.com with UTF8SMTPSA id y3-20020a056a00190300b004fa2411bb92sm4331229pfi.93.2022.04.01.15.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:08:50 -0700 (PDT)
From:   Daniel Verkamp <dverkamp@chromium.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 1/4] mm/memfd: add F_SEAL_EXEC
Date:   Fri,  1 Apr 2022 15:08:31 -0700
Message-Id: <20220401220834.307660-2-dverkamp@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220401220834.307660-1-dverkamp@chromium.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new F_SEAL_EXEC flag will prevent modification of the exec bits:
written as traditional octal mask, 0111, or as named flags, S_IXUSR |
S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
any of these bits after the seal is applied will fail with errno EPERM.

This will preserve the execute bits as they are at the time of sealing,
so the memfd will become either permanently executable or permanently
un-executable.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..a472ba69596c 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC     0x0020  /* prevent chmod modifying exec bits */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..4ebeab94aa74 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
@@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
 	 *   SEAL_WRITE: Prevent write access to the file
+	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
 	 *
 	 * As we don't require any trust relationship between two parties, we
 	 * must prevent seals from being removed. Therefore, sealing a file
diff --git a/mm/shmem.c b/mm/shmem.c
index 529c9ad3e926..a5ca9675fc29 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1083,6 +1083,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+			return -EPERM;
+		}
+	}
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.35.1.1094.g7c7d902a7c-goog

