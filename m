Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE664BA2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiBQOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:22:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiBQOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:22:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6D2B04B0;
        Thu, 17 Feb 2022 06:22:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so7695568eju.3;
        Thu, 17 Feb 2022 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKbGn4VnF077K/SNeC7jeA3ji+PgaLkDsV1uHuyFEfY=;
        b=fMCq3oJKasAOWtpeLVeqCXkK0BfuPeMwW6ID7eddz+BiIEjdIGBx+QMb2Rwiy7u6zC
         FF9EHKhjOBvuJb0HNkSoagqHn7e1Wd4wMYcVlXcLEDrRpAq5s4AtlccEhFsHmavLbQji
         lQicA5GQ4gceDNgEzhk1k7qBVcv0+8SFhko4adSuKdcmgcqvQfuHOG+yTwySBgHgidI5
         ehDDLTsdvSESJ4pSX+eNrveJaPF2kpwWXUiZXsClRvUy8Q9L56qxIboJQpsAHovYCmoF
         BT8V7UegXGkcEOhKqexxf42jeeDprq2CRYAleWdRN9iUjGtrzAClxuwhwph9oD3Ht5/I
         nOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKbGn4VnF077K/SNeC7jeA3ji+PgaLkDsV1uHuyFEfY=;
        b=BUmxak+CtOnWE8VOho330DJ33tccwuQ0j3k6n747Vh1n1FCltNlXXAdsgIHQznm5nv
         p4OlqPeFDVG5fHfIPTbQVSVec9174b0E99xnqVgym7YAdrG94Jgg0AVyMQABJNi/XBb3
         5Fp9ft5ji+o6XqvrHs8s27NSpJ0lZPvGoV+KVIBYPw2Q3bReWQw4VooHAFk3wdl4AQgh
         3CuHbGzXVq2wAxoJp8i7EG0bfvFKc3pAzZ+gCC1t4Fi1JWBqoynqel47FBHoYhyOsZFg
         Iw0Gp57ilL5tBhCV9rwGFWqphbqdsFfkL2NASbfOB4q+BOGc9oz55gklcOlc1O7baaIJ
         +1PQ==
X-Gm-Message-State: AOAM532k+zqbz6+0T+u30doxNqggoE1S4QprVhKR+U2Tx5ID8czR1yh6
        N6hHIWF4iXPiCtzxfG9dVVFP33iZhnrFeQ==
X-Google-Smtp-Source: ABdhPJzHeZ1hq4tKV6RQC0asfUmX6vcSGs/AyrEZloRCSL1Vm0if9C3k5Ms1jH8RgaG5n8S6RYs+WA==
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id r2-20020a170906c28200b006ce369d03d5mr2584779ejz.425.1645107724616;
        Thu, 17 Feb 2022 06:22:04 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id a13sm578436edn.25.2022.02.17.06.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:22:04 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/5] selinux: drop return statement at end of void functions
Date:   Thu, 17 Feb 2022 15:21:29 +0100
Message-Id: <20220217142133.72205-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217142133.72205-1-cgzones@googlemail.com>
References: <20220217142133.72205-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Those return statements at the end of a void function are redundant.

Reported by clang-tidy [readability-redundant-control-flow]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c          | 2 --
 security/selinux/ss/conditional.c | 2 --
 security/selinux/ss/ebitmap.c     | 1 -
 security/selinux/ss/mls.c         | 1 -
 security/selinux/ss/services.c    | 2 --
 5 files changed, 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dafabb4dcc64..1e69f88eb326 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3284,8 +3284,6 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	isec->sid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
-
-	return;
 }
 
 static int selinux_inode_getxattr(struct dentry *dentry, const char *name)
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 2ec6e5cd25d9..c46c419af512 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -566,8 +566,6 @@ void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 		if (node->key.specified & AVTAB_ENABLED)
 			services_compute_xperms_decision(xpermd, node);
 	}
-	return;
-
 }
 /* Determine whether additional permissions are granted by the conditional
  * av table, and if so, add them to the result
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 61fcbb8d0f88..abde349c8321 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -359,7 +359,6 @@ void ebitmap_destroy(struct ebitmap *e)
 
 	e->highbit = 0;
 	e->node = NULL;
-	return;
 }
 
 int ebitmap_read(struct ebitmap *e, void *fp)
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 3f5fd124342c..99571b19d4a9 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -156,7 +156,6 @@ void mls_sid_to_context(struct policydb *p,
 	}
 
 	*scontext = scontextp;
-	return;
 }
 
 int mls_level_isvalid(struct policydb *p, struct mls_level *l)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2f8db93e53b2..6901dc07680d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -529,8 +529,6 @@ static void security_dump_masked_av(struct policydb *policydb,
 	/* release scontext/tcontext */
 	kfree(tcontext_name);
 	kfree(scontext_name);
-
-	return;
 }
 
 /*
-- 
2.35.1

