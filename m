Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D958CCDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiHHRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbiHHRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:41:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A212A9;
        Mon,  8 Aug 2022 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980491; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mQW2IujmsdsUsW34qxOE4YfSHlUJeCynQdqfBBLGIY=;
        b=FxGb5nxvZxYH337FCdmCvaubP/Jk6LIC3Yvt4apRCVZ6JnrxJuQrv1e7a6GxSvTko9RzAQ
        kHpHt5jTR+pEkQqCuI7zTYi4MaUOpBwesMlnnAaaqRDaVbeVDKBeOTUy8d5KjkJk7BfHXQ
        EmPJFZBT1i5AEgNjRHtv/K6F/CnJYYo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Subject: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
Date:   Mon,  8 Aug 2022 19:40:38 +0200
Message-Id: <20220808174107.38676-2-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the _EXPORT_DEV_PM_OPS() internal macro. It was not used anywhere
outside pm.h and pm_runtime.h, so it is safe to update it.

Before, this macro would take a few parameters to be used as sleep and
runtime callbacks. This made it unsuitable to use with different
callbacks, for instance the "noirq" ones.

It is now semantically different: instead of creating a conditionally
exported dev_pm_ops structure, it only contains part of the definition.

This macro should however never be used directly (hence the trailing
underscore). Instead, the following four macros are provided:
- EXPORT_DEV_PM_OPS(name)
- EXPORT_GPL_DEV_PM_OPS(name)
- EXPORT_NS_DEV_PM_OPS(name, ns)
- EXPORT_NS_GPL_DEV_PM_OPS(name, ns)

For instance, it is now possible to conditionally export noirq
suspend/resume PM functions like this:

EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) = {
    NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
};

The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these new macros.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>

 include/linux/pm.h         | 37 +++++++++++++++++++++++--------------
 include/linux/pm_runtime.h | 20 ++++++++++++--------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 871c9c49ec9d..93cd34f00822 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -375,19 +375,20 @@ const struct dev_pm_ops name = { \
 }
 
 #ifdef CONFIG_PM
-#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec, ns)		\
-	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn); \
-	__EXPORT_SYMBOL(name, sec, ns)
+#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+	const struct dev_pm_ops name;					\
+	__EXPORT_SYMBOL(name, sec, ns);					\
+	const struct dev_pm_ops name
 #else
-#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
-			   runtime_resume_fn, idle_fn, sec, ns) \
-static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
-					 resume_fn, runtime_suspend_fn, \
-					 runtime_resume_fn, idle_fn)
+#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+	static __maybe_unused const struct dev_pm_ops __static_##name
 #endif
 
+#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
+#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "_gpl", "")
+#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "_gpl", #ns)
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
@@ -399,13 +400,21 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
 
 #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
+	EXPORT_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
+	EXPORT_GPL_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
+	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
+	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	}
 
 /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 9e4d056967c6..ba2077d9e366 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -40,17 +40,21 @@
 			   resume_fn, idle_fn)
 
 #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "", "")
+	EXPORT_DEV_PM_OPS(name) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "_gpl", "")
+	EXPORT_GPL_DEV_PM_OPS(name) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "", #ns)
+	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
-			   suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
+	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	}
 
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
-- 
2.35.1

