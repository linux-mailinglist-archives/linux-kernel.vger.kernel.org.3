Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C37500144
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiDMVls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiDMVlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:41:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA6BC12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:39:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so3041651plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYtJLFFMyue0PUgdDcyngnoV+ce40AfkZdXLlaYttr4=;
        b=SjeL9FyijSBw0wI9tU+pR/vtld0Ipfk+WIg7VBb/KtX2qrLa/zp+q3KmHd0YwIChJV
         Fgh7CS9UQsjvwnqeII/FMzVT0Q+FOiswigr9zXpCUT00b3hfcWZLP2QPmAAmdSZkr/W+
         GvN09FD7rLW1yXliW0LRv5Ip7eY7xcxgrMmDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYtJLFFMyue0PUgdDcyngnoV+ce40AfkZdXLlaYttr4=;
        b=uwCyxw90MioP/4xY/QFB3JgVP5SqThUMzXXqJAJZ4J9qYQ8PZYi1NFI74fyjGTvCkO
         CyCmOzz6mVIAutFe7aFJ1Qh3vUmY4ZXytgat5RgYrEuiwcxs6gS1dSg70wy5Mf/FtGey
         KbxJ/3gLJ33cdFmFgeZApxq2+K3KU81PjLO2GuZjgi7jb9UTnu8t2mZleCFu1bTzHgwF
         zoq/KSt/5NLEgDp0/DbooTuT8f7gAiFTkf2O3rZZZTKLkv1GWk00azj8LPbtmmnlDXBp
         iwRcaJVHgZH3aOsHpnli9nVidkKPkutc4YZDxuGWo+F3PdRpwtKJ61EfO5kRFEmLtTrD
         VQJg==
X-Gm-Message-State: AOAM5311mamg7eRBJpojdKsshai06TCcBYMq2eH8tkSb65hwIN1lWpge
        4NdubXkyotPj8lGq3XGDt/Bjfg==
X-Google-Smtp-Source: ABdhPJzZQO6Vd3OkDGAbsIsF8C5XY1Se8z4Z3GJOSAOvOic2Xiz2njo9TE587+X24OO/THFDJ4T9pQ==
X-Received: by 2002:a17:902:e38c:b0:158:a037:c4d0 with SMTP id g12-20020a170902e38c00b00158a037c4d0mr5133513ple.75.1649885961625;
        Wed, 13 Apr 2022 14:39:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm46720pfm.17.2022.04.13.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:39:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Date:   Wed, 13 Apr 2022 14:39:17 -0700
Message-Id: <20220413213917.711770-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6373; h=from:subject; bh=z//JJIc7pJZMG/l5a4mTvEw2CHhY8f+psQTlocBH3uM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiV0ME6OpeUPYhLfXM7xf5vvVDhpl5cVf0nHtyySYK 48gAhuyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYldDBAAKCRCJcvTf3G3AJgH8D/ 4hKNuNj/qud0q7yZyp93Keuh/bLEkpdKqOiJV5h8kVwhXSlMRgrE1irPumQeK6O4o34eU+9ebTx8TG IY/g9t0AKW8TMJQKLIueR5Ku2m8Auod/ArlvYaaKj8ej96C7edL/fSfqLubmhD3mcg6XKCkmpFJ2Em 5K+wVX+WQF+EdEVXkJeI4Z2+KsWjRrvcaZs/0hciSzqRiD0LFS37NlwtUl/1HAlu0cnLfv76VN+cBT ohyh+6Tzwgx36+iwiU/HQDpgewwX5oj6m8u54QZ9zMNa9ii70v4+ytnLDkv1neV6555KOTDHlmlpim E8TkKS8g9Et/saokoQMN++64DvBSh6KBgjV5sdok74131+Kw1mAAWBpTWNEA+nwXrXhv84XKFNrtgm Zo97eTG2kaBJFivIJC9uHTPd1BALv8+ubGONz3nrnoc0D4UT44SFiQ73WyHmzZWCJGkGpQV5YXF4zX KT6Qrqy4JsO6cJRCe0n3aR/LQfuKKoBoViN+xsasF8UrXqZFNiDqPuPFNDx9mn3zkvHEiNA+Hqs4Z2 6Q69HsN6xDG1Uj1uiRkaKPz4bdt+Ew4GLirkirbe2bWqWFY8/wjbWUzfI94Dti5haI12p9LuFQ74l+ A4tYUaK8796Q4j+gjJxc35f9cFA6Y3xCmwWK3cxqMIka6kGJ3CKyjJkwcuUw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

In order to test various backward-edge control flow integrity methods,
add a test that manipulates the return address on the stack. Currently
only arm64 Pointer Authentication and Shadow Call Stack is supported.

 $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT

Under SCS, successful test of the mitigation is reported as:

 lkdtm: Performing direct entry CFI_BACKWARD
 lkdtm: Attempting unchecked stack return address redirection ...
 lkdtm: ok: redirected stack return address.
 lkdtm: Attempting checked stack return address redirection ...
 lkdtm: ok: control flow unchanged.

Under PAC, successful test of the mitigation is reported by the PAC
exception handler.

If the CONFIGs are missing (or the mitigation isn't working), failure
is reported as:

 lkdtm: Performing direct entry CFI_BACKWARD
 lkdtm: Attempting unchecked stack return address redirection ...
 lkdtm: ok: redirected stack return address.
 lkdtm: Attempting checked stack return address redirection ...
 lkdtm: FAIL: stack return address was redirected!
 lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y

Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/cfi.c                | 130 ++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |   1 +
 2 files changed, 131 insertions(+)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index e88f778be0d5..59ba983ff23e 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -42,8 +42,138 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
 
+/*
+ * This can stay local to LKDTM, as there should not be a production reason
+ * to disable PAC && SCS.
+ */
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+# ifdef CONFIG_ARM64_BTI_KERNEL
+#  define __no_pac             "branch-protection=bti"
+# else
+#  define __no_pac             "branch-protection=none"
+# endif
+# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
+#else
+# define __no_ret_protection   __noscs
+#endif
+
+/* The ultimate ROP gadget. */
+static noinline __no_ret_protection
+void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if(*ret_addr == expected)
+		*ret_addr = (addr);
+	else
+		/* Check architecture, stack layout, or compiler behavior... */
+		pr_warn("Eek: return address mismatch! %px != %px\n",
+			*ret_addr, addr);
+}
+
+static noinline
+void set_return_addr(unsigned long *expected, unsigned long *addr)
+{
+	/* Use of volatile is to make sure final write isn't seen as a dead store. */
+	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
+
+	/* Make sure we've found the right place on the stack before writing it. */
+	if(*ret_addr == expected)
+		*ret_addr = (addr);
+	else
+		/* Check architecture, stack layout, or compiler behavior... */
+		pr_warn("Eek: return address mismatch! %px != %px\n",
+			*ret_addr, addr);
+}
+
+static volatile int force_check;
+
+static void lkdtm_CFI_BACKWARD(void)
+{
+	/* Use calculated gotos to keep labels addressable. */
+	void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
+
+	pr_info("Attempting unchecked stack return address redirection ...\n");
+
+	/* Always false */
+	if (force_check) {
+		/*
+		 * Prepare to call with NULLs to avoid parameters being treated as
+		 * constants in -02.
+		 */
+		set_return_addr_unchecked(NULL, NULL);
+		set_return_addr(NULL, NULL);
+		if (force_check)
+			goto *labels[1];
+		if (force_check)
+			goto *labels[2];
+		if (force_check)
+			goto *labels[3];
+		if (force_check)
+			goto *labels[4];
+		return;
+	}
+
+	/*
+	 * Use fallthrough switch case to keep basic block ordering between
+	 * set_return_addr*() and the label after it.
+	 */
+	switch (force_check) {
+	case 0:
+		set_return_addr_unchecked(&&normal, &&redirected);
+		fallthrough;
+	case 1:
+normal:
+		/* Always true */
+		if (!force_check) {
+			pr_err("FAIL: stack return address manipulation failed!\n");
+			/* If we can't redirect "normally", we can't test mitigations. */
+			return;
+		}
+		break;
+	default:
+redirected:
+		pr_info("ok: redirected stack return address.\n");
+		break;
+	}
+
+	pr_info("Attempting checked stack return address redirection ...\n");
+
+	switch (force_check) {
+	case 0:
+		set_return_addr(&&check_normal, &&check_redirected);
+		fallthrough;
+	case 1:
+check_normal:
+		/* Always true */
+		if (!force_check) {
+			pr_info("ok: control flow unchanged.\n");
+			return;
+		}
+
+check_redirected:
+		pr_err("FAIL: stack return address was redirected!\n");
+		break;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL)) {
+		pr_expected_config(CONFIG_ARM64_PTR_AUTH_KERNEL);
+		return;
+	}
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
+		return;
+	}
+	pr_warn("This is probably expected, since this %s was built *without* %s=y nor %s=y\n",
+		lkdtm_kernel_info,
+		"CONFIG_ARM64_PTR_AUTH_KERNEL", "CONFIG_SHADOW_CALL_STACK");
+}
+
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_BACKWARD),
 };
 
 struct crashtype_category cfi_crashtypes = {
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 243c781f0780..9dace01dbf15 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -74,6 +74,7 @@ USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+CFI_BACKWARD call trace:|ok: control flow unchanged
 FORTIFIED_STRSCPY
 FORTIFIED_OBJECT
 FORTIFIED_SUBOBJECT
-- 
2.32.0

