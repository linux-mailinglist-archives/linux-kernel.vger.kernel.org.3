Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB39A479220
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhLQQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:58:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhLQQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:58:23 -0500
Date:   Fri, 17 Dec 2021 16:58:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639760301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZaBaSKdDGJVWV49FzuT/zwiUkGg7e5Gp1jvfFM/dtw=;
        b=MVRvAs5QAkAbpLBzTw/lIBmwOFmsvK4NX/RJIWvTPrYMHDGdRgKlsK9S4dr45c7+oPJ+ZT
        B0gmXHj4amBYufFHQ3rdeF7velSIVzUmCPNzKP55MFkmaFJyE5k0sfrOqYwRwUQhnJzaWY
        GmLsKjZeiQsb3D1sZYC0NyQc8Ygss7wQAS4rayG8uYxZTmDGG1Mhju3PCchNQb2QuajnHi
        wF/chEdErZ2EwpMJ/2tB37YR63+jQYJT4Rw9FXe2udHT00hihYFtCoJz7L9DXMD488DH3M
        LH28ep+jbjfZzAjU6x0vgReIkGUCcfoiOcyf4KYlXwdownHuFJUZuuHHWfU7aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639760301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZaBaSKdDGJVWV49FzuT/zwiUkGg7e5Gp1jvfFM/dtw=;
        b=GX9LhBBUAZVxjprgmAfAzDpEIGo9ovQEEdNBPoKZkzThoN/In+EZbrNf3IfBcL8g7SvV4V
        06Xl9nIdmYuPwODg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Fix corrupted cpuid macro invocation
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204202355.23005-1-jarkko@kernel.org>
References: <20211204202355.23005-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <163976030036.23020.8521430577620802322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     572a0a647b9b491729d24c083c8410c55bf16326
Gitweb:        https://git.kernel.org/tip/572a0a647b9b491729d24c083c8410c55bf=
16326
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Sat, 04 Dec 2021 22:23:55 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 17 Dec 2021 08:52:33 -08:00

selftests/sgx: Fix corrupted cpuid macro invocation

The SGX selftest fails to build on tip/x86/sgx:

	main.c: In function =E2=80=98get_total_epc_mem=E2=80=99:
	main.c:296:17: error: implicit declaration of function =E2=80=98__cpuid=E2=
=80=99 [-Werror=3Dimplicit-function-declaration]
	  296 |                 __cpuid(&eax, &ebx, &ecx, &edx);
	      |                 ^~~~~~~

Include cpuid.h and use __cpuid_count() macro in order to fix the
compilation issue.

[ dhansen: tweak commit message ]

Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_ov=
ersubscribed")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211204202355.23005-1-jarkko@kernel.org
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx=
/main.c
index 7e912db..370c499 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
=20
+#include <cpuid.h>
 #include <elf.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -291,9 +292,7 @@ static unsigned long get_total_epc_mem(void)
 	int section =3D 0;
=20
 	while (true) {
-		eax =3D SGX_CPUID;
-		ecx =3D section + SGX_CPUID_EPC;
-		__cpuid(&eax, &ebx, &ecx, &edx);
+		__cpuid_count(SGX_CPUID, section + SGX_CPUID_EPC, eax, ebx, ecx, edx);
=20
 		type =3D eax & SGX_CPUID_EPC_MASK;
 		if (type =3D=3D SGX_CPUID_EPC_INVALID)
