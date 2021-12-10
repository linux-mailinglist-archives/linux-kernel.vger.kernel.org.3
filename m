Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF29B46F832
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhLJBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:05:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhLJBFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:05:00 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A682720B7179;
        Thu,  9 Dec 2021 17:01:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A682720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639098085;
        bh=/EvGK3Q5FFfSXMyeMql3XihYjIuKH4bKdyx4YUb6kp4=;
        h=From:To:Cc:Subject:Date:From;
        b=nJ/11WvE0l38FgsHMExecg1nxN3Co9BaHUTHbRglTDzJGhqisdxpBbPq/7WxcpmqZ
         ae6uXR53NOvZXwF4mxrnlEa1ywybC07TlD3eys75fEo2bzk7y+6HkjsqN+jDu5rx0E
         6jkfwD02C55axa8+rGdZw7H3a/9EnrYMxYBjuBoM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     dan.carpenter@oracle.com, robh@kernel.org, catalin.marinas@arm.com,
        will@kernel.org
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bauerman@linux.ibm.com, nramas@linux.microsoft.com,
        qiuguorui1@huawei.com
Subject: [PATCH] arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()
Date:   Thu,  9 Dec 2021 17:01:21 -0800
Message-Id: <20211210010121.101823-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ac10be5cdbfa ("arm64: Use common
of_kexec_alloc_and_setup_fdt()"), smatch reports the following warning:

  arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
  warn: missing error code 'ret'

Return code is not set to an error code in load_other_segments() when
of_kexec_alloc_and_setup_fdt() call returns a NULL dtb. This results
in status success (return code set to 0) being returned from
load_other_segments().

Set return code to -EINVAL if of_kexec_alloc_and_setup_fdt() returns
NULL dtb.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
---
 arch/arm64/kernel/machine_kexec_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 63634b4d72c1..59c648d51848 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -149,6 +149,7 @@ int load_other_segments(struct kimage *image,
 					   initrd_len, cmdline, 0);
 	if (!dtb) {
 		pr_err("Preparing for new dtb failed\n");
+		ret = -EINVAL;
 		goto out_err;
 	}
 
-- 
2.25.1

