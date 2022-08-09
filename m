Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA858DFD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiHITIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348535AbiHITHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:07:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00E2A70B;
        Tue,  9 Aug 2022 11:53:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279GdUCX022291;
        Tue, 9 Aug 2022 18:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=wBegZrI6Yy2+0qa5LzfubNn1b6U+pn8guQo1B15Uc/0=;
 b=TnDawfdf3x9tX14cjKyl/S9tba+xwGjNTa9neSjjuM/UYbLBhE1PpAC7iS9W1S5Zcoxm
 nC9f6XVnzR3Zity7FlVEchbVmzZBit//fiE7hi6BzvQcxnl/q5jRA/s0V6MTyoOKP2Iw
 /+268aCPersgUJ80Sy+qCqeEtP8tdu7+b1lWQSATmx3ikbbC/q1ht4wr964hWuZaQKrp
 C56gN1dWkiljqG2RQLR6JrQtTEATIonL5sH2ld8aXCg0auobFxdx2Y5W139JpLxECabi
 EP0HOsSon9GXuG69+JMgOInT5UdLBpPj/+kz9vLHxbuH3B6aQsYjJx/N+0xYCJshY2XW vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsqct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 18:53:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279IXPsb038052;
        Tue, 9 Aug 2022 18:53:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0n3tsx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 18:53:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 279IrR59004359;
        Tue, 9 Aug 2022 18:53:27 GMT
Received: from t460.home (dhcp-10-175-40-68.vpn.oracle.com [10.175.40.68])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3hu0n3tswd-1;
        Tue, 09 Aug 2022 18:53:27 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Date:   Tue,  9 Aug 2022 20:52:29 +0200
Message-Id: <20220809185229.28417-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090072
X-Proofpoint-ORIG-GUID: Dqaosq_BvBC0LPQSk9U-HCf_CNK3skzN
X-Proofpoint-GUID: Dqaosq_BvBC0LPQSk9U-HCf_CNK3skzN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a new user namespace grants you the ability to reach a lot of code
(including loading certain kernel modules) that would otherwise be out of
reach of an attacker. We can reduce the attack surface and block exploits
by ensuring that user namespaces cannot trigger module (auto-)loading.

A cursory search of exploits found online yields the following extremely
non-exhaustive list of vulnerabilities, and shows that the technique is
both old and still in use:

- CVE-2016-8655
- CVE-2017-1000112
- CVE-2021-32606
- CVE-2022-2588
- CVE-2022-27666
- CVE-2022-34918

This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
0 will block requests to load modules when the request originates in a
process running in a user namespace.

For backwards compatibility, the default value of the sysctl is set to
CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
there should be absolutely no change in behaviour unless you opt in either
at compile time or at runtime.

This mitigation obviously offers no protection if the vulnerable module is
already loaded, but for many of these exploits the vast majority of users
will never actually load or use these modules on purpose; in other words,
for the vast majority of users, this would block exploits for the above
list of vulnerabilities.

Testing: Running the reproducer for CVE-2022-2588 fails and results in the
following message in the kernel log:

    [  130.208030] request_module: pid 4107 (a.out) requested kernel module rtnl-link-dummy; denied due to kernel.ns_modules_allowed sysctl

Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Cc: John Haxby <john.haxby@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 ++++++
 init/Kconfig                                | 17 +++++++++
 kernel/kmod.c                               | 39 +++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd10774623..551de7bce836c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -592,6 +592,17 @@ to the guest kernel command line (see
 Documentation/admin-guide/kernel-parameters.rst).
 
 
+ns_modules_allowed
+==================
+
+Control whether processes may trigger module loading inside a user namespace.
+
+= =================================
+0 Deny module loading requests.
+1 Accept module loading requests.
+= =================================
+
+
 numa_balancing
 ==============
 
diff --git a/init/Kconfig b/init/Kconfig
index c984afc489dea..6734373995936 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1226,6 +1226,23 @@ config USER_NS
 
 	  If unsure, say N.
 
+config NS_MODULES_ALLOWED_DEFAULT_ON
+	bool "Allow user namespaces to auto-load kernel modules by default"
+	depends on MODULES
+	depends on USER_NS
+	default y
+	help
+	  This option makes it so that processes running inside user
+	  namespaces may auto-load kernel modules.
+
+	  Say N to mitigate some exploits that rely on being able to
+	  auto-load kernel modules; however, this may also cause some
+	  legitimate programs to fail unless kernel modules are loaded by
+	  hand.
+
+	  You can write 0 or 1 to /proc/sys/kernel/ns_modules_allowed to
+	  change behaviour at run-time.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/kmod.c b/kernel/kmod.c
index b717134ebe170..53e26009410ef 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -105,6 +105,12 @@ static int call_modprobe(char *module_name, int wait)
 	return -ENOMEM;
 }
 
+/*
+ * Allow processes running inside namespaces to trigger module loading?
+ */
+static bool sysctl_ns_modules_allowed __read_mostly =
+	IS_BUILTIN(CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON);
+
 /**
  * __request_module - try to load a kernel module
  * @wait: wait (or not) for the operation to complete
@@ -148,6 +154,21 @@ int __request_module(bool wait, const char *fmt, ...)
 	if (ret)
 		return ret;
 
+	/*
+	 * Disallow if we're in a user namespace and we don't have
+	 * CAP_SYS_MODULE in the init namespace.
+	 */
+	if (current_user_ns() != &init_user_ns && !capable(CAP_SYS_MODULE)) {
+		if (sysctl_ns_modules_allowed) {
+			pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s\n",
+				task_pid_nr(current), current->comm, module_name);
+		} else {
+			pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
+				task_pid_nr(current), current->comm, module_name);
+			return -EPERM;
+		}
+	}
+
 	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
 		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
 				    atomic_read(&kmod_concurrent_max),
@@ -175,3 +196,21 @@ int __request_module(bool wait, const char *fmt, ...)
 	return ret;
 }
 EXPORT_SYMBOL(__request_module);
+
+static struct ctl_table kmod_sysctl_table[] = {
+	{
+		.procname       = "ns_modules_allowed",
+		.data           = &sysctl_ns_modules_allowed,
+		.maxlen         = sizeof(sysctl_ns_modules_allowed),
+		.mode           = 0644,
+		.proc_handler   = proc_dobool,
+	},
+	{ }
+};
+
+static int __init kmod_sysctl_init(void)
+{
+	register_sysctl_init("kernel", kmod_sysctl_table);
+	return 0;
+}
+late_initcall(kmod_sysctl_init);
-- 
2.35.1.46.g38062e73e0

