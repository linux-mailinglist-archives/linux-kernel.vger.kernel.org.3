Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10546622C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357257AbhLBLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:21:13 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43073 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357256AbhLBLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443869; x=1669979869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTuTMZR7mHk5WuMQ4CKbLXlaRLZp274pvCDzMBGKakM=;
  b=fp1A7vJs3RcKb5PWlJWsPd4MgvPvwJWkAOX2J6gyik52LR1SQeaKf4NZ
   grsCGeIOSM5WhS4y5Grs5lkf81IX8deLjBVWeJuhNrskSdpWo8OtZomLj
   KfdYORMq8letRnUJQkHAqOAFZqTrWMUFAB7s3afOdoiXfeqrn168xNugT
   lGETlWsjpNnpfoOAqs+6WYSuo0p3F/IOwmbqx4A3wWmlJB811Nhkd5Avi
   0Dlo/gyAyjtER7qUEkyRiQIdmPTZM+WDX+tPu+P4FO76ofKV46uEOMGdv
   VSkyS05NlHYeS5bN6WCBIytg65881jG6DEwYQNrBCE0Bm/VKmFjxhyqoG
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="188288611"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:48 +0800
IronPort-SDR: RLDvvaiSk9XrSAK1NoeiG1b6xrD6aFVNGTuaeX+1p63u6S81E0OjeVMfc/HVfz0i/ADZ94VLJm
 JwZn/lXCzzOIQq0z+aVT3R4pHAt9C4gR/450p2T5drab6Z0No6mMm4Hp5/UMQP7kFPsU3yamYJ
 deYR9LxZnzHLtPqUxX7M9eMJ5o/A2mRXpvm6yFQzGal4IuchIdDMIKdhldV3W25Ohbja2IFLQf
 1XCsShXgmybK+eYgxCuLR2unlOb41FQ23I/MnnoTMjkCn6uzcZaQEzCDVwu0em/o0m1CYy98wv
 LLVtO6KGwf7EjcctikgA9KC1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:52:30 -0800
IronPort-SDR: BbxGa/Z8swSUtn/ctRlAq5CwP9lp/jMZ2Jyb6kK8N1JwwtGSQpd+EV5PP0qjFqqWR4614ha+ZZ
 DIhGcZx5hXfjkl8M4r/p2mr44Y9BebAJkHOiQxoKg8SE4xB68gVo9fTgkqEI/MG9QFWVhG+ucV
 D75/C8p+qL6cz8Nts0bAGlh8RbtNxJwslArUELP6E0ZpG1Z+T89vuqA0ulSrYP6Q8oMxEp8nOL
 LshMDoeNBd9pJw4S/He718kiZx6RvjJc7ZIPhSL51Oz8TZdyq7XVKNkroIoj7hy1FDKhO3+I8R
 RV4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YMv1sHlz1TF9p
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:17:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443866; x=1641035867; bh=aTuTMZR7mHk5WuMQ4C
        KbLXlaRLZp274pvCDzMBGKakM=; b=PxUsc9wgcmEcf9vF5mvyFSpXC61M2x7fxp
        ELeJocrDtiAGe3zcItH7Rm/ijJaUs3CGnM8ybRAW027y+xGE/WmcTmpeWu6hqhQt
        7PQCd5yBcYUHJxlD2Wy3pw/ouUfjoQmkByryFEScZ6v23yslTcDowt6SpIppoPwH
        rnjv0OHLE+w/SBRTgvRtjWLt5BGOtWpEsjovSCXgRWAS8jfjWbGBsW6NbD6+mp/n
        jZqmQS5irIvOi52pvwlLqpT8511SEH171ZmouIE41Zuj0k80CWABOf7zH6c1DSBj
        7nyGdB1TSvxhvP2zP8EWoR3L8BljPZnyBk0ZOVEgvDj9ZWITZzyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gPcsrHc1tleF for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:46 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YMj2DhFz1Rx0t;
        Thu,  2 Dec 2021 03:17:36 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 4/6] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Thu,  2 Dec 2021 21:16:57 +1000
Message-Id: <20211202111659.2077911-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Using the new __kernel_futex_syscall*() functions let's add support for
32-bit systems with a 64-bit time_t. We can just direclty call the
publically exposed __kernel_futex_syscall_timeout() and
__kernel_futex_syscall_nr_requeue() functions to do this.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 tools/testing/selftests/futex/include/futextest.h           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7..556bf3e74755 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", (long long) ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index c786fffecb8a..1686f94667b1 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/futex_syscall.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +70,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+	return __kernel_futex_syscall_timeout(uaddr, op | opflags, val, timeout=
, uaddr2, val3);
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+	return __kernel_futex_syscall_nr_requeue(uaddr, op | opflags, val, nr_r=
equeue, uaddr2, val3);
 }
=20
 /**
--=20
2.31.1

