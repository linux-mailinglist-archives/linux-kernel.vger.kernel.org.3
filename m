Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9BA46F7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhLJADN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:03:13 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54731 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhLJADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639094380; x=1670630380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlKhXOYedERl0RnaiJfzDiGiWKuwt2kGz1yDJoQfWVE=;
  b=dlwXNxrIrjLye8fAA4UQgXZlBmfC6ITtHxTh0ZUqq9P0q2/N1wpU8XCr
   QgoSTVfGmjX919uEjYycM+KL3arS7U/sQxYsz+H9mRHQzlxvjonz4/UY6
   5x4FFPVHbqgihqJvP7O7Qt4R7TNtBNWkWJBDVZWBMQTSjD/1MjAI8lpEg
   HIOhYkgzKAqhxLBkfsl9XCsJtqvmjlOlmU8e3zdslVBrOmxS8OMewtg/8
   WX6Nr+Bf6Q24a+MgIXTVeqDWXkwTgfRPhI7sUvKnUYCT6NUvb2ErLq2Yj
   7sKidxFF42DBlkuv12Xa5jJgJosX5nVzGJcMS+HD+/wtUWvQcWXawbeXx
   w==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="188897240"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 07:59:39 +0800
IronPort-SDR: IayuJhsOJ+uQ73zFzCnkeilepX+oAzzMj4+uS6CXi8w49RSGKqQmqfXxj7fueTFvPcoy4aAlAY
 DjPwAlRRBT50wvE9Ke9rjd40Z/JNOQ74GHgl/XUGq2LNpDpXA/Mqz5crHRIEV/lZuxp0uREAZh
 iNn76k7hDrwVP2QIu1xLOqxIhSFn32bI5ZwzWiMTgWzarSnE6smLKG3RX/XDA5F5w8tGucZN5U
 a2FzN0M7OD2t0zevn19WQbaNxFpk61g4J4mjwbI1uRmnmeon1Ym1C+3Vx34SPO9BbNsVNgAKk3
 z6YAJhLU8lPvK163rg7o87pA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:32:40 -0800
IronPort-SDR: BEpTeet8vBeD9bq85FFIEAKp+EDPIDN6T8CE3whDExG7rBAxC3f2nRR5YzCA+ZFKK0HEbeI422
 4fRS8tulzHvYBr6qDhbI4cONr2oPLJRnSSsD6xK+EtdyxW7ytUjK2HyJ5moT5mbXhk36Ywc6ff
 E4evezCshD5AeMUk2I1WC3CcW7cki1q1y1iH8oywbg34T4yO2qviv3/mIvhDMg2G+HtcChUOiI
 O4BOOC2voHD0sa43u47yvfPe2ldxe+dGze99EZZrmIiPyndyceBpd759juSQBKXCrtFlfKY9/r
 kl8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:59:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J99xk1JdDz1Rwvh
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:59:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1639094376; x=1641686377; bh=SlKhXOYedERl0RnaiJ
        fzDiGiWKuwt2kGz1yDJoQfWVE=; b=XWNNrYA778qVXx+tzjvNJWzY7Rn+4Sdp+R
        rrRh+A+RYkLp9pM5p2fpDBN1sb65SUq2Q6JXFMql0qnqBWCQWwTGwoBxPvHP4W+y
        nj8rC3FrnwfOYFnfi0sfiJ7i+3TpsvJX5xCV3orSFPwqM1lGyIxBjK2Z/Gb7WsNC
        KbrLjNr+PkRUPcGQyje0GLojeRGK9TtoxMAkCH6OFbYZTUjphqBE8OB2garkhCiY
        W/RHcO2YSG/NFIrRrwR0jt1YP01qZVFj1mlDiL4b+mYFnJkBkJg2BMr8U7O3dawx
        sW/8j/pKP/MFY2MRamo7IU4T/d5pqAh9w+1tWetTWTJ+NLVEfwZw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9-Ibb8lgRqb3 for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 15:59:36 -0800 (PST)
Received: from localhost.localdomain (unknown [10.225.165.65])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J99xX5Qz6z1RtVG;
        Thu,  9 Dec 2021 15:59:28 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, dvhart@infradead.org, arnd@arndb.de,
        alistair23@gmail.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/6] uapi: futex: Add a futex syscall
Date:   Fri, 10 Dec 2021 09:58:54 +1000
Message-Id: <20211209235857.423773-3-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds two futex syscall wrappers that are exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. This has mostly been because
the overloading of one of the arguments makes it impossible to provide a
single type safe function.

Until recently the single syscall has worked fine. With the introduction
of a 64-bit time_t futex call on 32-bit architectures, this has become
more complex. The logic of handling the two possible futex syscalls is
complex and often implemented incorrectly.

This patch adds two futex syscall functions that correctly handle the
time_t complexity for userspace.

This idea is based on previous discussions:
https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=3DRtm-Wb08ym2TNiuAZgX=
hYrThcWTw@mail.gmail.com/

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 000000000000..bac621eb319c
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Futex syscall helper functions
+ *
+ * Copyright (C) 2021 Western Digital.  All Rights Reserved.
+ *
+ * Author: Alistair Francis <alistair.francis@wdc.com>
+ */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <unistd.h>
+#include <errno.h>
+#include <linux/futex.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+
+/**
+ * __kernel_futex_syscall_timeout() - __NR_futex/__NR_futex_time64 sysca=
ll wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @timeout:  an absolute struct timespec
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_timeout(volatile uint32_t *uaddr, int op, uint32_=
t val,
+		      struct timespec *timeout, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2=
, val3);
+
+		if (ret =3D=3D 0 || errno !=3D ENOSYS)
+			return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts_old;
+
+		ts_old.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts_old.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op, val, &ts_old, uaddr2, val3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+/**
+ * __kernel_futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 sy=
scall wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @nr_requeue:  an op specific meaning
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_nr_requeue(volatile uint32_t *uaddr, int op, uint=
32_t val,
+			 uint32_t nr_requeue, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uad=
dr2, val3);
+
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

