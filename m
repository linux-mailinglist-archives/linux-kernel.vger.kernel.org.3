Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104646F7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhLJADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:03:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65003 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhLJADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639094396; x=1670630396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn9DS7hISPQiTe0ItoOGPSItTCkQ9fCzmpu8eWvFTQQ=;
  b=VD0tPHAfsZC+YEmBLy3RnKNtKbz0bGk78vsYbLEp+7QP9v8tFBe7d9NY
   tlymBxMADYEWIBDP9cZrYHHNFWYHN763WisyMOSRL5gcxZ9EVkal9nVTR
   B1wTFQrww9Pt1UYplHp6WTmquXb/bffVgN4rGHilPajFVnUMN4jnma3oI
   Gsy/7flk/o6uw5IHmTXC2ZY1d94EyVwbKZrqoJn2kIZcLBHlAhIT64do3
   nYyDrWqQffSgRC+QN2BrfHx5hK1Z3jIQcq74sj02+/2oX+tqhEVUQOJn1
   IEwvBAkDLFuaJKQcedtvgf3RltVTvH7aAqyl9WPYU9xVNyElg+7dBLwDh
   w==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="291872817"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 07:59:55 +0800
IronPort-SDR: v6GZ6FFdNNnrpDLzvkE8BsDg/hGqGGFyDlOg5l4Q1MKncc9wFtyxvyFGUMnh/fDNhPKwziKcpM
 hZfpXzAUoaXLG+KM8+f3epEncsV0zEs0kypPtPt6x3X7HMa/WiO8c6FiLWfeDBcNaQrOAHkYG8
 rqdwdE4AdnlEgVM5uH4ih2iyReYM3f5AxUSrFt4d7zj3qPoPO1IesPCEazEbv51TAtmrSy7mFH
 XmghwhsdASjDADTyW8/2/OuLbQ7PdWQQDT6M3bEA/tHcClPAn1/yteTKsDYRw+FOUVViyfhMZ3
 qgBDeptJKZ8IV+nmFQyTApfE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:32:57 -0800
IronPort-SDR: /0GBX0GSQRINOReKHZHAnOvLjR/K3y/LRW3L6OQ8QGrvnnnvdg96m9JW7/dAs4oBGcnj1SwSPo
 ivcmE+fOFuK9zKZT30PfVH8sTJkgbtb7MBeZ/Cp6Rj0HqoN727/WNSswPt9dbrOaEk8ahxe1F6
 zcC9GJIyT7Zr0U88o2G3PGVZQel4nRV9Zy1cWb2pVSwz2D61vmHfAXFfbbwTC2hkwnu2MZrPFo
 yI/WKHJUwA8NMXFzzD/b+peb/w4NeVOPNGhwz65UV1dpYd5Ye8bfaduddkTaIjlGs0DdNScQIZ
 Wgw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:59:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J99y30YlQz1RwFN
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:59:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1639094394; x=1641686395; bh=Qn9DS7hISPQiTe0Ito
        OGPSItTCkQ9fCzmpu8eWvFTQQ=; b=PXRXqb7P2jYj+HqiqQR4cegIyWFU2OmLVI
        D++hfADINigHHPgn4h07wi4P9W7aG+D/uLRoTeQFV3tlhSllqqNHhFxKI76IZpzB
        eK5MUxAbUOUASmgoAgHLkM435FeflMCP6YAGsiGAc20A6SxfQyedk9yLHG3Q5Xo7
        ff/kkVAAhlWj7wC6MGArgf4QSa/uC2RgRJkt37v6RpKSQeVWHT3ufw4wXfa/dV5q
        zfresTq0NtsXSlpJspSe/InMy2P94AWEsDcyVZBPR7tNuUSk08YPJrhHUwkz5iMt
        TghYt6j0kNMrq6g6uhMrWcehAqvbzlv6Pzr1X/3PHhpnpjHaDu/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WRXl5J3Pesmr for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 15:59:54 -0800 (PST)
Received: from localhost.localdomain (unknown [10.225.165.65])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J99xt332dz1Rwvj;
        Thu,  9 Dec 2021 15:59:45 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, dvhart@infradead.org, arnd@arndb.de,
        alistair23@gmail.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 10 Dec 2021 09:58:56 +1000
Message-Id: <20211209235857.423773-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds a futex waitv syscall wrapper that is exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. As the futex_waitv syscall
always expects a 64-bit time_t this can be tricky for 32-bit systems to
get correct.

In order to avoid userspace incorrectly passing the wrong timeouts let's
expose a public helper function that ensures the kernel is passed the
correct timeout struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/futex_syscall.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index bac621eb319c..f637f05a3be0 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -89,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * __kernel_futex_syscall_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int
+__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsig=
ned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	/* futex_waitv expects a 64-bit time_t */
+	if (sizeof(*timo) =3D=3D sizeof(struct __kernel_timespec))
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clo=
ckid);
+
+	/* If the caller supplied a 32-bit time_t, convert it to 64-bit */
+	if (timo) {
+		struct __kernel_timespec ts_new;
+
+		ts_new.tv_sec =3D timo->tv_sec;
+		ts_new.tv_nsec =3D timo->tv_nsec;
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts_new, =
clockid);
+	} else
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, NULL, clo=
ckid);
+}
+
 #endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

