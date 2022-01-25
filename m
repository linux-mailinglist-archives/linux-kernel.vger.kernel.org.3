Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4B549B5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578269AbiAYORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387944AbiAYOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:14:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F2C06173B;
        Tue, 25 Jan 2022 06:14:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so62892277edd.12;
        Tue, 25 Jan 2022 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRMo8oBZ8+mVDMCIjAmqszLdgAaOe0du5QVx8CbR6LU=;
        b=Keg/CfUa7pgzGJokONpw5J5CoQdeJfQqPtdVD6pzALAt/5u/vrr/8n8G8ue+OvxStH
         x8obD8gvX1gNPUmXJ5C8lBmA05Px0E+0bak7zTXR1xCy30MR/t14N5WJaOSdD416v8Aq
         Tmwt6y0Orx8j4kkOIw2agGeErFRRPB3zTXEJSpNkaeTbmy70JrdSfGQ4ErcciKmP4WNN
         l3eS+LOGgfQtD/vA3IUTkX0BeDihIgKSxkIfZi4AcjOZtb8aQt/o48/zhlg4Y63aOYU+
         0sbBtjJVjUBzrIt7Jf/L9pUxZbtmPrwPnM4Iag8Bw9nLcmIanFTMsIqPfpx/cjoLtPUB
         q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRMo8oBZ8+mVDMCIjAmqszLdgAaOe0du5QVx8CbR6LU=;
        b=LqWeb7g7eK1gS2VFleRrNHKUZ4r8LSOIAUKroCRkau663+nVdjEP8BUDJKBalWX48w
         D4m/Mc91xJC1J43zF31cUxbqCbV/GXlm/EJ1zO+IVKhtUvF7KFjrQbkSMrKk+penYR/J
         +tKJ0OqPbaQsd26z+GfQU8tQbjbgeY3pbW4ORyuyf21BkINdCBDncm5GsFRSZbfKmOiK
         QOLOyQfq8TW6VQtujUy67ur7Ao8bSvZ1BwQkoaAgcYqN5L8LTB5iK2jgZFLK2fCHcMxK
         cg3rDS9rIqmQClsweMr60CRzoqDj6WMR6P5Sryd9J3Eo3kx3IIg9buly0gtWnGIy3DIh
         UPMA==
X-Gm-Message-State: AOAM53320OoAY+JF87Jp5v1WXjaF/vIiSu9Kjn1EdjQ8PgDELxnDK2Py
        efzW2WZXuFAOeu2VjFmBJ/v0WzqGLvnj2A==
X-Google-Smtp-Source: ABdhPJxzNTfugb/8TN28oCuJEKaHituBsPLKKjb+mWflGgyqXKjhjIHzmLU75UQmOIYSLm9pI2z8Fw==
X-Received: by 2002:a05:6402:c8c:: with SMTP id cm12mr20320905edb.78.1643120091453;
        Tue, 25 Jan 2022 06:14:51 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/9] selinux: declare name parameter of hash_eval const
Date:   Tue, 25 Jan 2022 15:14:13 +0100
Message-Id: <20220125141422.32655-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

String literals are passed as second argument to hash_eval(). Also the
parameter is already declared const in the DEBUG_HASHES configuration.

Reported by clang [-Wwrite-strings]:

    security/selinux/ss/policydb.c:1881:26: error: passing 'const char [8]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
            hash_eval(&p->range_tr, rangetr);
                                    ^~~~~~~~~
    security/selinux/ss/policydb.c:707:55: note: passing argument to parameter 'hash_name' here
    static inline void hash_eval(struct hashtab *h, char *hash_name)
                                                          ^
    security/selinux/ss/policydb.c:2099:32: error: passing 'const char [11]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
            hash_eval(&p->filename_trans, filenametr);
                                          ^~~~~~~~~~~~
    security/selinux/ss/policydb.c:707:55: note: passing argument to parameter 'hash_name' here
    static inline void hash_eval(struct hashtab *h, char *hash_name)
                                                          ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0ae1b718194a..67e03f6e8966 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -704,7 +704,7 @@ static void symtab_hash_eval(struct symtab *s)
 }
 
 #else
-static inline void hash_eval(struct hashtab *h, char *hash_name)
+static inline void hash_eval(struct hashtab *h, const char *hash_name)
 {
 }
 #endif
-- 
2.34.1

