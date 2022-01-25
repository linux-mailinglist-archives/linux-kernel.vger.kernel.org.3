Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806449B605
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578475AbiAYOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578086AbiAYOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:14:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE1C061753;
        Tue, 25 Jan 2022 06:14:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n10so47531977edv.2;
        Tue, 25 Jan 2022 06:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiRyUdK+Th3jYryTsLsyc7X3KP1ePUO9wmCn+4PrUBo=;
        b=Z+8iOa0upC3i/zyphaOtyFRqvXOAh4xIReWOwanfDLcuBAi9U1bHB31LDIKeD9OPGu
         gq2oeKrW+7VQK8NmgvhpZuhu3XPitQYBpLWY4ibNBPlcaw6bK15M2x6buZZOEHDi0oUc
         4ZV0//Q4kqfuFm5ZNq0f+FTRS4JsnPBjCCdrOpJ6GU3zL2FsD2fR0Yqgq2mAx3hnVPac
         tq4K8ItBgto3JVoG9jk6nnK8w6e1zRoNMC8k9l71Pe6BzcHwe3x0ftMQry6DVles3tzc
         YFdCl2ynVfEE/R+ZzlaMRgi3gZVBBXSmEKqYYZbtCXWlyFyxotNLpRhS6/PJIOjlNT8J
         t3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiRyUdK+Th3jYryTsLsyc7X3KP1ePUO9wmCn+4PrUBo=;
        b=cbCJNN4anKhJbdXwQMNZqPkZJ0aM71mXlwsWNf/35g3rreGbgGally4AjWHGaf9+w7
         UkwErVuHjo9p7OLow1vsFT3yC0EGpVaa59RozHDDSNUlSSMORwF4x3hAkYhMmDHFIJvy
         0SB3EmRrdr79yL5eMr3NYhcIS97bYfUDphYndodMKrELouj0VQg8Nnp1chHA8bSmXaR4
         wgbSLpdsaI0McqlNwqhcOMO76aQYK43MqXg8nI0GZ8BhSIH0/7dJzU8vQZYUQ1WVse+w
         ZQXhXN3dwQxAcZAttG8KMXYWOzMV9PR0puDGe7y48r30nxY4N6CguZkvDUXbd/p5c868
         HiNw==
X-Gm-Message-State: AOAM530mvMQbt77htpE4PHjSqYzbl+r9Ww3xb1IElxZd2rzooQC3Wh9M
        cSvlEVmGlpfjn4qExcNr1Gf8pYeIKlnm2A==
X-Google-Smtp-Source: ABdhPJzS+btJYf02Pr9DsYD4BhgRElcRbIqG+uBOD9x2GfMkuiaz6UX+pzcgEH7AEyad2bdXwMQO7A==
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr17103251ejj.232.1643120096662;
        Tue, 25 Jan 2022 06:14:56 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:56 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 5/9] selinux: drop cast to same type
Date:   Tue, 25 Jan 2022 15:14:15 +0100
Message-Id: <20220125141422.32655-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the lvalue scontextp and rvalue scontext are of the type char*.
Drop the redundant explicit cast not needed since commit 9a59daa03df7
("SELinux: fix sleeping allocation in security_context_to_sid"), where
the type of scontext changed from const char* to char*.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5a7df45bdab1..2f8db93e53b2 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1452,7 +1452,7 @@ static int string_to_context_struct(struct policydb *pol,
 	/* Parse the security context. */
 
 	rc = -EINVAL;
-	scontextp = (char *) scontext;
+	scontextp = scontext;
 
 	/* Extract the user. */
 	p = scontextp;
-- 
2.34.1

