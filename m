Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9401A4BA3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiBQOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiBQOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:50:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF22B2C6F;
        Thu, 17 Feb 2022 06:50:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx21so7800480ejb.13;
        Thu, 17 Feb 2022 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bX4TrrpbZWiTDtSIiT+79S67gmaAnm5bGwmVO1NuSaM=;
        b=INiSgLKiZpd7dkFaBTgJO5utgSFoQdXv4fgSV9t8ZaT0Aa4oE8no3YEP0fG0z87iP6
         0neFvpN6KRJaAgF7vHhHZgilrvEAg1ujDmhaU0aBe/zbnRaiCDGgsWqERRjGbz6lzmA/
         M5/z+urnhGk/sNEsVFVP8L5xp1uM2O9v/XlZIFF/MYUubGAl3paCezVSNmdIheyiR5dz
         4BQW3IfODw9WJSASxFdJ+ZRvvYYcHKZAmfgbsO94ReZgKARUBeW6tPT9fQ4H2Iu6B715
         V95114focf3bSh6vfrpYGa5hdJDKkqe56stHtsTZu3oIcuvpmX3na3MGV9sZtli5icWv
         t+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bX4TrrpbZWiTDtSIiT+79S67gmaAnm5bGwmVO1NuSaM=;
        b=yDhqVP0X8++vzP3prPMKkjN+8eYiTafWngNQnxag1FI/faG3DtPRjbMsP+no7EWMFC
         WQaCL714C0W/ntlPReELamQJJAYM2LykE4EYbJeRJwhsQhA190WUzqPRGYwgrgJknV8y
         O3Mm01IiHhp2Z/66eyWcDww3hw1CmLxqMN3BNpU4pfoywZ/RF9ncL8/HzZHKnYJCWd77
         KHUk4flxd/S1Xpf2AgS3WyoSOBZpH45kKPGHZFZKrKexIo6ULOo9XNloW4U9CutC2rAE
         5leukRfl19HKaBfmuanhhs5OdVLBi6GfIyMUCp8t/0SwesERepKAC2HDGPIAiMC2QD7s
         joSw==
X-Gm-Message-State: AOAM533dcP+HTWzDTvbDBjM0UR8ozeGpjOcurpgrMLDxQ5HvRvsS9CGL
        yWyPtZAS3FUeD5iPDMnZHLH0vd0dTyMrQQ==
X-Google-Smtp-Source: ABdhPJwpRuHRfCrHVQHWKpujlie3WcZ/GvHjEtRFarRLhOXe19/veEIQOXoHV7bx7XTQb50KV2pzBA==
X-Received: by 2002:a17:906:c405:b0:6ce:7100:8cf1 with SMTP id u5-20020a170906c40500b006ce71008cf1mr2795143ejz.722.1645109433610;
        Thu, 17 Feb 2022 06:50:33 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id c11sm3580270edx.42.2022.02.17.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:50:33 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] capability: add capable_or to test for multiple caps with exactly one audit message
Date:   Thu, 17 Feb 2022 15:49:55 +0100
Message-Id: <20220217145003.78982-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217145003.78982-1-cgzones@googlemail.com>
References: <20220217145003.78982-1-cgzones@googlemail.com>
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

Add the interface `capable_or()` as an alternative to or multiple
`capable()` calls, like `capable_or(CAP_SYS_NICE, CAP_SYS_ADMIN)`
instead of `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
`capable_or()` will in particular generate exactly one audit message,
either for the left most capability in effect or, if the task has none,
the first one.
This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability will create an avc denial.
Using this function with the least invasive capability as left most
argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
to only allow the least invasive one and SELinux domains pass this check
with only capability:sys_nice or capability:sys_admin allowed without
any avc denial message.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/capability.h |  6 +++++
 kernel/capability.c        | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..5c55687a9a05 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -207,6 +207,8 @@ extern bool has_ns_capability(struct task_struct *t,
 extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
+#define capable_or(...) _capable_or_impl((sizeof((int[]){__VA_ARGS__}) / sizeof(int)), __VA_ARGS__)
+extern bool _capable_or_impl(int count, ...);
 extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
@@ -230,6 +232,10 @@ static inline bool has_ns_capability_noaudit(struct task_struct *t,
 {
 	return true;
 }
+static inline bool capable_or(int first_cap, ...)
+{
+	return true;
+}
 static inline bool capable(int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..5b73a58b914e 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -434,6 +434,54 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * _capable_or - Determine if the current task has one of multiple superior capabilities in effect
+ * @cap: The capabilities to be tested for
+ *
+ * Return true if the current task has at least one of the given superior capabilities currently
+ * available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit message, either for the
+ * left most capability in effect or (if the task has none of the tested capabilities) the first
+ * capabilit in the test list.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool _capable_or_impl(int count, ...)
+{
+	va_list args;
+	const struct cred *cred = current_cred();
+	int cap, first_cap, i;
+
+	BUG_ON(count < 1);
+	BUG_ON(count > CAP_LAST_CAP);
+
+	va_start(args, count);
+
+	for (i = 0; i < count; i++) {
+		int ret;
+
+		cap = va_arg(args, int);
+		if (i == 0)
+			first_cap = cap;
+
+		ret = security_capable(cred, &init_user_ns, cap, CAP_OPT_NOAUDIT);
+		if (ret == 0)
+			goto out;
+	}
+
+	/* if none of the capabilities was allowed, create an audit event for the first one */
+	cap = first_cap;
+
+out:
+	va_end(args);
+	return ns_capable(&init_user_ns, cap);
+}
+EXPORT_SYMBOL(_capable_or_impl);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.35.1

