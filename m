Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97A154CCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352157AbiFOP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352074AbiFOP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:27:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE39241622;
        Wed, 15 Jun 2022 08:26:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so16704547edi.1;
        Wed, 15 Jun 2022 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeBacwC7QoG4uHMYPIBhJXRexZhC0Zyxi68OZuIzOYs=;
        b=p/inubw9GuUiAitKwaHB86XBjWAoYQBbzVCdsy//hGtr/nQ14zEoYEuMidA06nRvTE
         edmThp4AlrlXzBUSdccI3+mGZxbWZi/qY9qysZ40/VQ0SG23ZZoC2D7BJC9Wr5L7XHYQ
         2ySwJ5VIapL+UemMXrkUUdzs8rQ785G6S5ZleB6bJY6sgOnEL0T9Y9tkcWYdJ3rNL/p/
         B+hIZDoTOd50pH34Ei0bzfh4AcK92h8qxU7SlsqH3Nn1S5ToL7tX6sxpErZ4xmY2ygo5
         rTGRDJThjnhg0S/o2V8Wyy+GgADl29W7A56EmrN5VykmNle/XcE5z4hM3dxmzpfVqvlL
         /T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeBacwC7QoG4uHMYPIBhJXRexZhC0Zyxi68OZuIzOYs=;
        b=yGdHCHLxMWvfcybddIkupwHsNAxN8Dev0X0P6GjrracX4PsIY/UlrjHwtWNsumAl4L
         10oa2B7PqY09622ZYU4hnNWNYl58k4700BxC1xI76kYV3e1oUDp+H5ZE0ta4qWbhqkvi
         WQEqF7ItvSBkad/pew+Mw9jsT9rJMt88LYuMHZb1GI7VVXuVHEu73C7rp3NQUluvjcAJ
         E1e69D7B67IkZAe1l/m42YnOnXY9RtI6/zm4jyIgycM2CgEhZQdt+yaE2wDnALIvDu5V
         Iu6F11HJv4ltkndT6EOLVvpzK0U6kPc5wSaHyb8NpylPYucNKY5AccjPg5gIAHJX0bKm
         173A==
X-Gm-Message-State: AJIora870cu3LIQACsjvgzY5hQ+0NnbgRuYjleN2lBMF1XlHz04RPT3Z
        0JwMsxCDHr83JWQsso9Ovx988nTSWTX1/w==
X-Google-Smtp-Source: AGRyM1v6VpM3Yfy9b6yYhk8AqVkrGFLmAa1XteahlY/B+xc2h2zsyvQyXPezo4hsPHNVXXDGxiACvQ==
X-Received: by 2002:a05:6402:195:b0:431:5499:35eb with SMTP id r21-20020a056402019500b00431549935ebmr343888edv.346.1655306813348;
        Wed, 15 Jun 2022 08:26:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9501224eds.43.2022.06.15.08.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:26:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] capability: add any wrapper to test for multiple caps with exactly one audit message
Date:   Wed, 15 Jun 2022 17:26:23 +0200
Message-Id: <20220615152623.311223-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615152623.311223-1-cgzones@googlemail.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
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

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability will create an AVC denial.
Using this function with the least invasive capability as left most
argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writers
to only allow the least invasive one and SELinux domains pass this check
with only capability:sys_nice or capability:sys_admin allowed without
any AVC denial message.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
   - rename to capable_any()
   - fix typo in function documentation
   - add ns_capable_any()
v2:
   avoid varargs and fix to two capabilities; capable_or3() can be added
   later if needed
---
 include/linux/capability.h | 10 +++++++
 kernel/capability.c        | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..7316d5339a6e 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -208,7 +208,9 @@ extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
 extern bool capable(int cap);
+extern bool capable_any(int cap1, int cap2);
 extern bool ns_capable(struct user_namespace *ns, int cap);
+extern bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
@@ -234,10 +236,18 @@ static inline bool capable(int cap)
 {
 	return true;
 }
+static inline bool capable_any(int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable(struct user_namespace *ns, int cap)
 {
 	return true;
 }
+static inline bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index 765194f5d678..ab9b889c3f4d 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -435,6 +435,59 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @ns:  The usernamespace we want the capability in
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	if (ns_capable_noaudit(ns, cap1))
+		return ns_capable(ns, cap1);
+
+	if (ns_capable_noaudit(ns, cap2))
+		return ns_capable(ns, cap2);
+
+	return ns_capable(ns, cap1);
+}
+EXPORT_SYMBOL(ns_capable_any);
+
+/**
+ * capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool capable_any(int cap1, int cap2)
+{
+	return ns_capable_any(&init_user_ns, cap1, cap2);
+}
+EXPORT_SYMBOL(capable_any);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.36.1

