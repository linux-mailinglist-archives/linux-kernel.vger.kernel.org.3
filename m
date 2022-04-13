Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2A4FEEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiDMFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiDMFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:55:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD94938DB5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:53:29 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220413055327epoutp045174ae472f5b0c8ee6bfed6b3e745ca6~lXuwvWAjs3151831518epoutp04y
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:53:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220413055327epoutp045174ae472f5b0c8ee6bfed6b3e745ca6~lXuwvWAjs3151831518epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649829207;
        bh=6ZhMkWjEBIJMwwmZrasFz3lnjYzy1QYa0020sLjnlnw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ix202Pd/TcRXELtr81kvcWHm6dq4szeQ8/G7KwfO7ao5jRoldd/nxfvpyzshbaQP1
         Lv+FO2w1BN1IYzXQi5BnYpWB7flv/nzv2m2SnF5hq03iLpO6z2UOhVLA7VZg+4NWuZ
         G+ykDDCVmfXe1T1qaICTTEVwdlgxDj5Dl7GZaxtE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220413055326epcas5p163aff4ce081824980e5b9b89a78814e1~lXuv5m_WI2502325023epcas5p1Z;
        Wed, 13 Apr 2022 05:53:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.27.09952.55566526; Wed, 13 Apr 2022 14:53:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2~lXuoeD5FZ1332113321epcas5p3U;
        Wed, 13 Apr 2022 05:53:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220413055318epsmtrp2a9352d11863a347cf6fef962b20559cd~lXuocrkWZ2060120601epsmtrp2N;
        Wed, 13 Apr 2022 05:53:18 +0000 (GMT)
X-AuditID: b6c32a4b-4cbff700000226e0-ba-6256655562b6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.3F.03370.D4566526; Wed, 13 Apr 2022 14:53:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220413055313epsmtip2c2981e443d8654693a34ce6935b2bc7e~lXukmP6jd0059200592epsmtip2c;
        Wed, 13 Apr 2022 05:53:13 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        wedsonaf@google.com, boqun.feng@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     swboyd@chromium.org, ojeda@kernel.org, ast@kernel.org,
        gary@garyguo.net, mbenes@suse.cz, ndesaulniers@google.com,
        void@manifault.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all
 cases
Date:   Wed, 13 Apr 2022 11:23:05 +0530
Message-Id: <20220413055305.1768223-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxzeuff23tJZd62PnYHKrHMDpgW3gSdK3LLIdpNF4uIrYQ9X4Aaa
        8SitDDAxq4PJYzIalTDaylNjW5BS1iqC0q3UQKEsQ2JAHgFHgWwNC1AIaAnMcjHzv+/3PX6P
        k8PHRblkIF+WdpZVpElTxKSAuN0eGrrvFHsqPmJRhnSmehIV/1CGofmnQxSqt1zA0PDlKQr1
        ujwAOa5qcNTXoiNRe+VFAo3oBzA0oJ4AaEa9iiFD5U2A9JdmeGh1fIGH2grGMNRqriFRx/AE
        huzOawDduWki0QXvKEAFtQbw0TZGq+olmIXHf2DM9cJnGHNXM0IxeW2DFFPVlMnkOaZ5TJOx
        kGQ6f/ERTIXzc8ZVdxtjfrYYAWOyPCIYV5WDYrxNO4+9FieITmRTZN+xivDD3wiSVaulhPz6
        7uy24lpKBUa3FwE+H9IfwCV9ThEQ8EV0K4D9ozNkEQh4XswBqL3McIIXQN/gOO4X/IHqBgfJ
        CS0A3tI+orhiHkB3ez/wu0haAo0t9wi/sIVeAbC74clagdM3MNjs06y5NtPHYI350lpfgt4D
        56p/XOOF9GGoqecWgXQwLH+4SHH8JugsdxN+jD/nc61a3N8U0vkB0DM7hnGBI7DmrmE9vBn+
        02GhOBwIvf/eJ7mrs6BV/T2XzQPQpru67v8QunureX4PTodCU0s4R++ApV0NGDd3Iyz2uddH
        CWFzxQu8B+Y9buRxOAh6Z2cJDjPQrH+GcY/6FTT/asHUIFjz0jmal87R/D+5CuBG8AYrV6Ym
        scpI+ftpbJZEKU1VZqYlSRLSU5vA2j8N+6wZ/DU2I7EDjA/sAPJx8RZhyTsn40XCRGnOOVaR
        fkaRmcIq7SCIT4hfF3YlNUpFdJL0LPsty8pZxQsV4wcEqrDJe12+gQchkzJnhr5UnhuXWGA7
        PvH7iQVPVojjYMzcDmurz3P64/QjJ6+goaPRx9/au9JiK+z74u2irZ2vGLdniCNCEg7Su18l
        ag8Mmq1ROkf+Ytj+0/2btO4le5DuJ8F0VqQ1lKxOn1LNO4cO3YhS3Y8fMbBnFjp2amtykiOF
        1i9L3nv6ZCpGsTzuCRU/LBucPKqe7oZ/D82WneumXLER7bYNdT3b+upS8x/I8t2tjqXFtv5K
        +bu6QwmS3Nhbcecl5ZR3uMu01RyzHH1lBecZGz9hDlCdaVF/iiqCey5m2Hbt/dTQeKJkQ8/G
        8659sZblN8cEd2Rfx0T95p7OznaFiwllsnR/GK5QSv8DAGiHuxYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvK5valiSwfcfVhZz1q9hs+htms5k
        8eXnbXaLNVsamSzuTHrObnHxzGtGiyNTZjFbXN41h83i8Pw2Fou7K24wWdyY8JTR4sOE/0wW
        K+cvZ7RY0fOB1eL/46+sFvs6HjBZ7N64iM3i+J2nTBaHTs5ltNi+fD2bRePn+4wWHYtXMjqI
        ecxuuMji8fXmOSaPJZ2/mDx2zrrL7tGy7xa7x4JNpR4tR96yemxa1cnmcWLGbxaPeScDPc6s
        3sbk0bdlFaPH+i1XWTzOLDjC7vF5k1wAfxSXTUpqTmZZapG+XQJXRsP/qSwFS5Qr9vUuZm9g
        vC/TxcjJISFgIrFw3RG2LkYuDiGBHYwSO+9MZoZISEv8/PeeBcIWllj57zk7RNEnRolti18w
        gSTYBPQkVu3awwKSEBHoYpL4uOM/E4jDLLCZSeL/y/Vgo4QF/CSWnzsHNopFQFXi08JWRhCb
        V8BOYtaaD2wQK+QlZl76zg4RF5Q4OfMJWD0zULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJue
        W2xYYJSXWq5XnJhbXJqXrpecn7uJERyhWlo7GPes+qB3iJGJg/EQowQHs5IIb796aJIQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTAcfJ2o+sjzq3PO5
        6s7X/1FpfXZfrulP+ML1uPY9z+JOtRoe36Oc8az6EiHyPyxeR4XuD+dfNGtL58b9t6UMNu1d
        Wrraa9tuJhH9nGkp3v3v5mxp5VzZcS/qZPTU3X1zAhkr83NUEm9d2xYb+WbZzRfK5063Ryid
        597IIHyMzzZIMG/Jr8WXE0O/B5zbp/t3JduU+QoVTmE+D/t5UrYJm26rD/JM3x7/6tut8zqr
        9sVkzRQx6Lv7/EjB2x8RtZlx0lcv/eWtfjJf+8HHhOC9iTPfN/j6ZDG9PKRlvatlkqtffJ7a
        EoW3JacjM+IeLlC6p7Th4Gv2rJ7/n9reG5cz8PP94cpuna5tVrf1ckpyuhJLcUaioRZzUXEi
        AN2FOmQ/AwAA
X-CMS-MailID: 20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2
References: <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms_show_value return false if KALLSYMS is disabled,
but it's used in module.c also.
Thus when KALLSYMS is disabled, system will not print module
load address:

/ # insmod crash.ko
/ # lsmod
crash 12288 0 - Live 0x0000000000000000 (O)

After change (making definition generic)
============
/ # lsmod
crash 12288 0 - Live 0xffff800000ec0000 (O)
/ # cat /proc/modules
crash 12288 0 - Live 0xffff800000ec0000 (O)
/ #

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h | 11 +++--------
 kernel/kallsyms.c        | 35 -----------------------------------
 lib/vsprintf.c           | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index e5ad6e31697d..efabb8c18492 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,6 +24,9 @@
 struct cred;
 struct module;
 
+/* How and when do we show kallsyms values? */
+extern bool kallsyms_show_value(const struct cred *cred);
+
 static inline int is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
@@ -93,9 +96,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
-/* How and when do we show kallsyms values? */
-extern bool kallsyms_show_value(const struct cred *cred);
-
 #else /* !CONFIG_KALLSYMS */
 
 static inline unsigned long kallsyms_lookup_name(const char *name)
@@ -158,11 +158,6 @@ static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, u
 	return -ERANGE;
 }
 
-static inline bool kallsyms_show_value(const struct cred *cred)
-{
-	return false;
-}
-
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e8d2262ef2d2..71ef15ba20c7 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -818,41 +818,6 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
-static inline int kallsyms_for_perf(void)
-{
-#ifdef CONFIG_PERF_EVENTS
-	extern int sysctl_perf_event_paranoid;
-	if (sysctl_perf_event_paranoid <= 1)
-		return 1;
-#endif
-	return 0;
-}
-
-/*
- * We show kallsyms information even to normal users if we've enabled
- * kernel profiling and are explicitly not paranoid (so kptr_restrict
- * is clear, and sysctl_perf_event_paranoid isn't set).
- *
- * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
- * block even that).
- */
-bool kallsyms_show_value(const struct cred *cred)
-{
-	switch (kptr_restrict) {
-	case 0:
-		if (kallsyms_for_perf())
-			return true;
-		fallthrough;
-	case 1:
-		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
-				     CAP_OPT_NOAUDIT) == 0)
-			return true;
-		fallthrough;
-	default:
-		return false;
-	}
-}
-
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/*
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 49ef55ffabd7..4bc96a4f3a00 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -870,6 +870,42 @@ static char *default_pointer(char *buf, char *end, const void *ptr,
 
 int kptr_restrict __read_mostly;
 
+static inline int kallsyms_for_perf(void)
+{
+#ifdef CONFIG_PERF_EVENTS
+	extern int sysctl_perf_event_paranoid;
+
+	if (sysctl_perf_event_paranoid <= 1)
+		return 1;
+#endif
+	return 0;
+}
+
+/*
+ * We show kallsyms information even to normal users if we've enabled
+ * kernel profiling and are explicitly not paranoid (so kptr_restrict
+ * is clear, and sysctl_perf_event_paranoid isn't set).
+ *
+ * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
+ * block even that).
+ */
+bool kallsyms_show_value(const struct cred *cred)
+{
+	switch (kptr_restrict) {
+	case 0:
+		if (kallsyms_for_perf())
+			return true;
+		fallthrough;
+	case 1:
+		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
+				     CAP_OPT_NOAUDIT) == 0)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
 static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
 			 struct printf_spec spec)
-- 
2.17.1

