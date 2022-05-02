Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716E517386
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355534AbiEBQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386161AbiEBQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AFDEE7;
        Mon,  2 May 2022 09:00:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh6so28686239ejb.0;
        Mon, 02 May 2022 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/k9asq89XDwMG68daWGZty3oeCwoDEDaFSOuEQBtd0=;
        b=Kks+DHgbblcpg3oeQsjmU6As85p9JWAM6iYN03INHpKmsDsZDYUt9RmrNZO+a4yTOj
         3IcLeT4NcmDHllUnAJB3GGxDkNWXGSp3RhnAVE31QSplhnuc8HfzGDFE1orJPHWX9JxU
         eD+R8gvRB50EsPNi3c9tiOztuxPYAbJOSc5MTHUKy0Byz88hfDo62Duf9JXQaY1+/K56
         lhkuInv8yRcfj4eCQDF3Lc2mKyXcLX5MBDDvvov0tQlyTCpwqwThMODe75U7RXq5ytGj
         qe7EfAnsQ1rhxrPvEMey38x7me6Xjkuy5IdEiBlVyrUtE/mo6DEySlwhGFlcmuo/nfSh
         Zmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/k9asq89XDwMG68daWGZty3oeCwoDEDaFSOuEQBtd0=;
        b=Y/7OydD6Hg0HmoNTwXst8xFFeYrYKXqwRlP9IB6d8ggDGZOGcwG8MFuhV+APHmRIS2
         MdPiorXa3iO4MO8FJkU0Phb62wtC1gFd44XNwldl1DhV7vFntphZJg5hNO81gQUmoP8F
         cvG5VvRRpHEbh6zURZzr4UYKbeSa4dwinrG2ZTcODf+fDqEBBWNtAXk1nnjurzNJ0su8
         BuDFDDxDpWmBw6WVl/5VVRbaao6jJE5JtxB5z3p9YdKhoJfl3wzbtau5VMiOXJgyaYH3
         YCFc8Om/6+ypIaIM67883LDs/ilwyFsfMhzjtGPgLwW/wh0MQqV4vPFy2oxIV41jnY+X
         i0WQ==
X-Gm-Message-State: AOAM532Cg8iodUPPPjogh6FPCdkoO7eeBKWkEjzzrdpyhhSCBZly2XQF
        sTDwde/XWQfK1EtaZxOWcxDTlrwDBxlKsg==
X-Google-Smtp-Source: ABdhPJyGrEf0l0QdeT1UVkkGDk/FoP0BwN4rrVHQ6HPsh9J12efhB4B6hiKMIq71/OS1e/S6vs9qBQ==
X-Received: by 2002:a17:907:6e8a:b0:6f4:2a65:eb4b with SMTP id sh10-20020a1709076e8a00b006f42a65eb4bmr8588785ejc.597.1651507257320;
        Mon, 02 May 2022 09:00:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006f3ef214dd3sm3689996ejl.57.2022.05.02.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:00:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] capability: add capable_or to test for multiple caps with exactly one audit message
Date:   Mon,  2 May 2022 18:00:30 +0200
Message-Id: <20220502160030.131168-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502160030.131168-1-cgzones@googlemail.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
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
v2:
   avoid varargs and fix to two capabilities; capable_or3() can be added
   later if needed
---
 include/linux/capability.h |  5 +++++
 kernel/capability.c        | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..a16d1edea9b3 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -207,6 +207,7 @@ extern bool has_ns_capability(struct task_struct *t,
 extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
+extern bool capable_or(int cap1, int cap2);
 extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
@@ -230,6 +231,10 @@ static inline bool has_ns_capability_noaudit(struct task_struct *t,
 {
 	return true;
 }
+static inline bool capable_or(int cap1, int cap2)
+{
+	return true;
+}
 static inline bool capable(int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index 765194f5d678..cd8f3efe6d08 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -435,6 +435,35 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * capable_or - Determine if the current task has one of two superior capabilities in effect
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at one of the two given superior
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
+bool capable_or(int cap1, int cap2)
+{
+	if (ns_capable_noaudit(&init_user_ns, cap1))
+		return ns_capable(&init_user_ns, cap1);
+
+	if (ns_capable_noaudit(&init_user_ns, cap2))
+		return ns_capable(&init_user_ns, cap2);
+
+	return ns_capable(&init_user_ns, cap1);
+}
+EXPORT_SYMBOL(capable_or);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.36.0

