Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA351807D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiECJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiECJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D45017067
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:02:27 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2437MqXF008610;
        Tue, 3 May 2022 09:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SYOqM8zFy4vxJdy6VODyZJAP5Ycwa6rAM28oBt1WXQ0=;
 b=lOFjXKMIhYEzGUGxt4qv1wIAltL3uJi2FTpn3aV6IBx1TVERPH3TjcjLJCrQ+rd/AzFl
 1lOA0hkx12/mfGvAB1efYFdPk1wdQ0qDHnMphXbPO5Y2xrDCl35kusAHUizNML4eBEEa
 IZp2jF8+psDHRa+id4o42RbyqG8hhg3AZGwCo/lIibnHoGz9rWeo6gj74z4P4mTbIg2f
 i7rrlNN28YWDQO6bc/dxqI57xR+aMTM4IG2r8hXON4sLvaeTmecKApcjB1pZwFlhaOAT
 qPt4ZzDtz60WzlJnZ36RZPeW+xP8KuuLW6B61X3l1EGqy2YB9O8gz9lACDN2wTOjfYJR gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftyxysdxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:25 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2438vHoJ004852;
        Tue, 3 May 2022 09:02:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftyxysdwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24392EG9024274;
        Tue, 3 May 2022 09:02:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3frvcj3xdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24392LxE49348928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 May 2022 09:02:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108025204F;
        Tue,  3 May 2022 09:02:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id F3CBB5204E;
        Tue,  3 May 2022 09:02:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 9D1CEE0287; Tue,  3 May 2022 11:02:20 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] audit: add call argument to socketcall auditing
Date:   Tue,  3 May 2022 11:02:11 +0200
Message-Id: <20220503090212.1322050-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ve2kozsgKL8-EZO7LBlFvXw_wSCWiJmo
X-Proofpoint-GUID: 4tej_tl14E4_6mmGWr4iad_Rmlqdk6Fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

socketcall auditing misses the call argument:

type=SOCKETCALL msg=audit: nargs=3 a0=10 a1=3 a2=c

which renders socketcall auditing (almost) useless. Add the call
argument so it is possible to decode the actual syscall from the
audit log:

type=SOCKETCALL msg=audit: call=1 nargs=3 a0=10 a1=3 a2=c

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/audit.h | 10 +++++-----
 kernel/audit.h        |  1 +
 kernel/auditsc.c      |  6 ++++--
 net/compat.c          |  2 +-
 net/socket.c          |  2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index d06134ac6245..7d2256f999ab 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -405,7 +405,7 @@ static inline void audit_ptrace(struct task_struct *t)
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
 extern void __audit_bprm(struct linux_binprm *bprm);
-extern int __audit_socketcall(int nargs, unsigned long *args);
+extern int __audit_socketcall(int call, int nargs, unsigned long *args);
 extern int __audit_sockaddr(int len, void *addr);
 extern void __audit_fd_pair(int fd1, int fd2);
 extern void __audit_mq_open(int oflag, umode_t mode, struct mq_attr *attr);
@@ -445,14 +445,14 @@ static inline void audit_bprm(struct linux_binprm *bprm)
 	if (unlikely(!audit_dummy_context()))
 		__audit_bprm(bprm);
 }
-static inline int audit_socketcall(int nargs, unsigned long *args)
+static inline int audit_socketcall(int call, int nargs, unsigned long *args)
 {
 	if (unlikely(!audit_dummy_context()))
-		return __audit_socketcall(nargs, args);
+		return __audit_socketcall(call, nargs, args);
 	return 0;
 }
 
-static inline int audit_socketcall_compat(int nargs, u32 *args)
+static inline int audit_socketcall_compat(int call, int nargs, u32 *args)
 {
 	unsigned long a[AUDITSC_ARGS];
 	int i;
@@ -462,7 +462,7 @@ static inline int audit_socketcall_compat(int nargs, u32 *args)
 
 	for (i = 0; i < nargs; i++)
 		a[i] = (unsigned long)args[i];
-	return __audit_socketcall(nargs, a);
+	return __audit_socketcall(call, nargs, a);
 }
 
 static inline int audit_sockaddr(int len, void *addr)
diff --git a/kernel/audit.h b/kernel/audit.h
index 58b66543b4d5..34e53b6f0ebb 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -153,6 +153,7 @@ struct audit_context {
 	int type;
 	union {
 		struct {
+			int call;
 			int nargs;
 			long args[6];
 		} socketcall;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..c856893041c9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1399,8 +1399,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 	switch (context->type) {
 	case AUDIT_SOCKETCALL: {
 		int nargs = context->socketcall.nargs;
+		int call = context->socketcall.call;
 
-		audit_log_format(ab, "nargs=%d", nargs);
+		audit_log_format(ab, "call=%d nargs=%d", call, nargs);
 		for (i = 0; i < nargs; i++)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
@@ -2684,13 +2685,14 @@ void __audit_bprm(struct linux_binprm *bprm)
  * @args: args array
  *
  */
-int __audit_socketcall(int nargs, unsigned long *args)
+int __audit_socketcall(int call, int nargs, unsigned long *args)
 {
 	struct audit_context *context = audit_context();
 
 	if (nargs <= 0 || nargs > AUDITSC_ARGS || !args)
 		return -EINVAL;
 	context->type = AUDIT_SOCKETCALL;
+	context->socketcall.call = call;
 	context->socketcall.nargs = nargs;
 	memcpy(context->socketcall.args, args, nargs * sizeof(unsigned long));
 	return 0;
diff --git a/net/compat.c b/net/compat.c
index 210fc3b4d0d8..0df955019ecc 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -437,7 +437,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
 	if (copy_from_user(a, args, len))
 		return -EFAULT;
 
-	ret = audit_socketcall_compat(len / sizeof(a[0]), a);
+	ret = audit_socketcall_compat(call, len / sizeof(a[0]), a);
 	if (ret)
 		return ret;
 
diff --git a/net/socket.c b/net/socket.c
index 6887840682bb..ff71f28c96f7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2921,7 +2921,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 	if (copy_from_user(a, args, len))
 		return -EFAULT;
 
-	err = audit_socketcall(nargs[call] / sizeof(unsigned long), a);
+	err = audit_socketcall(call, nargs[call] / sizeof(unsigned long), a);
 	if (err)
 		return err;
 
-- 
2.32.0

