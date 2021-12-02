Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28575466228
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357239AbhLBLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:20:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31703 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhLBLUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443842; x=1669979842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cnkxM+v3e7Rw5Wac6Yp3jXRam56qrhimBukSct1R/EI=;
  b=nB4ruPEP9C3RqHln3eE7OTZw9ofpuFCiJ/GLWBjzC7Y2dp6iLM9s6Z+G
   7i44EXhXmtI0JryWd8CgIsN1cFGJPA99DCwQlUHz9p+H/oL0W7Zo2rJuz
   2g5HndR4nLqq+fXwzwcby++l5EVYmz5b0STGGSMCQ9V01ZLkjNjrY4Anu
   MT6zNgMBWFpVFei1Odtg39CxLltlsWJu1Yr8GF0sjECkKMdv/LujCSB4L
   TN8jUzwK2kH0v9zKsYBwbgeJjSseFtLHirzhfY9aViPXNtcurvGkdlDru
   BhBr6e48tnOlJjCSUHmzJM7cyPvCawoCHvKHW5e8aEiQU3Vtkq7wuuW/4
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="187279433"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:21 +0800
IronPort-SDR: ATC+37qDiGYFVSzMv+uqV7C4YFPINaNpeo+CItLic8zhNSapkEZyr1ojzq892QEX6feHFEEONw
 Sbz+kBZ9rpPhJ2cfwFiDFN5m54QONHj6fHD2x0XoctoLZVA7YjtvjzqFzZuSOrt06fhIWdTZe2
 BwJ/bZcvvvvmrI4exQFtViOCyBId7uimkQqsSfZ45L0/M+A5ODDAHcovQvWeKICtVXNT4Rouvg
 T35iuvnul0ws1T8TDVtZMsDlBipAMHoaXEIB6z17QbadgG5dJii6kxC/YVCs9WvuM907qpvUo2
 aiRi/Z2WRxtHeNCiLuFAczex
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:50:31 -0800
IronPort-SDR: LzgE9q4RM81fLmIqlQ+/iPEfNDeR/Vz/hxC6vBsPPGp9WLj2c5SO39gV8cL0KTgSnQvkH5MtGF
 Y6qVgOf+WbYAHV6l8EBMO+xAGvd+JuItBMyuDZt8o6R3XQj0pqck993dr2NKSWBoPXcv6OuXs2
 htw4QOfbThl52eu3iDadQkF/0PdiekaslwVjxxin/UVXmqo9zFBmtoaPlL7X67pLINQdromST0
 +9VRkb+jC0TVpYobcMOiZm3E6Ln7lxNZamzscEQ75hY9JSAXNvarFgESPH3f2nidrEa+QPgRK4
 /rc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YMK6S96z1Rx11
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:17:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1638443836;
         x=1641035837; bh=cnkxM+v3e7Rw5Wac6Yp3jXRam56qrhimBukSct1R/EI=; b=
        NvOX2HEUID+K9U/so1rCf3rt2od4i2D5D8/9KReU2Gzgn+rYbD1QBg12XrmxeN+5
        UajHyKG/Lg/9QyhVEAlDkyNy86gyogoJxBh/gvKWiEEX/XKEdfJRe4DMACztqDzy
        6Jx/frBFwSNaokMKMe2EzULbRiRoTaGp3T54dTOfhqvIK0DnKiuGn5uuxmdOETVw
        1TRdcCr6aNL4vkoMePsDpStDYGurY3GCbLkjS8AZ5sO86ukxYsHLj2iHYeipJIgw
        EqVcCUX5TTEE4ms3zDEWJxgdESrjz9y0AGgV4jdw7rFzuN9blRh45pdLKARuxpXy
        /25lvYU7EF4mLMAK2/4nNQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LeryXS5WwEF1 for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:16 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YM56Fjkz1RtVG;
        Thu,  2 Dec 2021 03:17:05 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 1/6] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Thu,  2 Dec 2021 21:16:54 +1000
Message-Id: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

This also converts the futex calls to be y2038 safe (when built for a
5.1+ kernel).

This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
"Revert "perf bench futex: Add support for 32-bit systems with 64-bit tim=
e_t"".

The original commit was reverted as including linux/time_types.h would
fail to compile on older kernels. This commit doesn't include
linux/time_types.h to avoid this issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/perf/bench/futex.h | 52 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc..385d2bdfaa9f 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,6 +8,7 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -28,7 +29,17 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * This is copied from linux/time_types.h.
+ * We copy this here to avoid compilation failures when running
+ * on systems that don't ship with linux/time_types.h.
+ */
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	long			tv_nsec;	/* nanoseconds */
+};
+
+/**
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +60,49 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op | opflags, val, timeo=
ut,
+				  uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, =
val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op | opflags, val, ts32, uaddr2, val=
3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op | opflags, val, NULL, uaddr2, val=
3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, nr_re=
queue,
+			   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op | opflags, val, nr_requeue, uaddr2=
, val3);
+#endif
 }
=20
 /**
--=20
2.31.1

