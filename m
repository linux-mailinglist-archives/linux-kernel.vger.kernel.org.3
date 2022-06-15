Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0E54CCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347388AbiFOP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiFOP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:26:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32B3190B;
        Wed, 15 Jun 2022 08:26:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gl15so23964844ejb.4;
        Wed, 15 Jun 2022 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3GV4KDQaQ+ciIcjNnKo5j9SK/xK0/b4h2zbURGQkVM=;
        b=eVHx6qGDOqI5RK1OuDadP/4IsU3fiKXgXKj70+5YHr13vVwI3B5hVy9/+MTeZRGhOj
         wu7FoDGoswg8sLQAHNgrh/ynHD5OxdGbaw9LV6FCB0PHkC+HO7vAdGS45kMiMlbbDjK7
         96AHXch4I3UixCGWTr+a89332jr4w6BHCyAEjU9cpO7px8j9qqJ7GQHUipyIlQLfFfwu
         rnM3fDIn9ydJwRVfwHoyAHZVV75KmSSSF3fFnOh6pORXi0JOKUAIP1IxYkbK4z9j0uj9
         zWSsLYWaGxCD5TjDMrwwd2AjOtpxANnv3IuPvwZu9BAi4yxmf/gRHnKJVtkPJAtDr3hU
         diEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3GV4KDQaQ+ciIcjNnKo5j9SK/xK0/b4h2zbURGQkVM=;
        b=JzrMdC+IVJhxMWXCr6xTOyh/w9DMManlnG+1l8Fk/EmoN40/xzTKKHKdtGa7RNOZnU
         Qztfj1YatGR3wTXS7DjzawRHTrTJajXPNcYnX8kyZq/NvpHOpnFm/ZWNQk6p5iTeejwR
         ia91+Dk74Zmw+K1o9m/bOF8OgG3yGMpFy30yzq07nZlyx86bzKf3Ob04ic1EDF72leyn
         uTP4oizJS2b1OwW2aWikUWUiv9tD8AEItt5G3UYZ86LefU4jGqL987amFUSKG/Pe1OkW
         XXLhEQxjlQ+/B/tkngLCRFlv5czAa9BLTpYmUYwjYB7lRfa2ySZv74esozfAnhRGOs+x
         L9iw==
X-Gm-Message-State: AJIora8kn0Ry0B/7LCJ2buzVHjPDVqmXAlulzsZq9rXWjgZpRVisDvEo
        /U6RiGgyJV8yVhsTyVkzcFnoy+Z+ZHNh/g==
X-Google-Smtp-Source: AGRyM1thqj4yMRWakdDLzYMZleVB0/alF5mZ3B6n8DGxpm4shTJgajLkOG7u7tJWSk2w8mVuiK3rXA==
X-Received: by 2002:a17:906:4a13:b0:715:85cc:9224 with SMTP id w19-20020a1709064a1300b0071585cc9224mr308015eju.267.1655306794753;
        Wed, 15 Jun 2022 08:26:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9501224eds.43.2022.06.15.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:26:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] capability: use new capable_any functionality
Date:   Wed, 15 Jun 2022 17:26:16 +0200
Message-Id: <20220615152623.311223-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220502160030.131168-8-cgzones@googlemail.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
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

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - rename to capable_any()
  - simplify checkpoint_restore_ns_capable()
---
 include/linux/capability.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 7316d5339a6e..092cb9773079 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -266,18 +266,17 @@ extern bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
 {
-	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_PERFMON, CAP_SYS_ADMIN);
 }
 
 static inline bool bpf_capable(void)
 {
-	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_BPF, CAP_SYS_ADMIN);
 }
 
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 {
-	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
-		ns_capable(ns, CAP_SYS_ADMIN);
+	return ns_capable_any(ns, CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN);
 }
 
 /* audit system wants to get cap info from files as well */
-- 
2.36.1

