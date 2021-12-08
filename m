Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C046D943
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhLHRMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:12:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhLHRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:12:49 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 563F820B7179;
        Wed,  8 Dec 2021 09:09:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 563F820B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638983357;
        bh=S6J5SOX3cdJelkKEW2NY+2jfh80ivSaewOrWnetxz8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=N5GCOodsSU4Z1AEIutVnxZKkK/A2qmj0cQa4dVZG8T1F6IdsfJcfvA9zY3h3TWBdl
         HWDYWUA4gYwfapaVsmmcsnAQYgip9AnTzehy5Fm+JI8rNseGVjiGI+I6AsgEPGuK4C
         yjmLf7+OEd7wCdVITn1OIF3aRp26sgGPpXusz69c=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     dan.carpenter@oracle.com, robh@kernel.org
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, bauerman@linux.ibm.com
Subject: [PATCH] [kexec]: arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn: missing error code 'ret'
Date:   Wed,  8 Dec 2021 09:09:10 -0800
Message-Id: <20211208170910.85364-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return code is not set to an error code in load_other_segments() when
of_kexec_alloc_and_setup_fdt() call returns a NULL dtb. This results
in status success (return code set to 0) being returned from
load_other_segments().

Set return code to -ENOMEM if of_kexec_alloc_and_setup_fdt() returns
NULL dtb.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Patch created in dt/next branch in git repo
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git

 arch/arm64/kernel/machine_kexec_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 63634b4d72c1..04d072885e64 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -149,6 +149,7 @@ int load_other_segments(struct kimage *image,
 					   initrd_len, cmdline, 0);
 	if (!dtb) {
 		pr_err("Preparing for new dtb failed\n");
+		ret = -ENOMEM;
 		goto out_err;
 	}
 
-- 
2.25.1

