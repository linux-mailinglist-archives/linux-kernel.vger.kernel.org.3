Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41A46F993
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhLJDYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:24:24 -0500
Received: from m12-13.163.com ([220.181.12.13]:10451 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhLJDYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gk3Hz
        w9COTxBd5cWwmZN4fD2l5WjyqPCOClDeuPAhSg=; b=kaWwFXwVgMMAOhjwgTCOg
        B+q11PSufQovP3E2NVXALnNFFzg1snGQeUltj6yTr/ysPQ0abCx6jGuUvKxAjecT
        fX3qgksUjBbr2TOIX59jyj47sfH1JCO+51s6yA4i8YtqNrK8oHWVUZeRSGHM5b93
        HsudZ6L0jNI2+vla2nmcVI=
Received: from localhost.localdomain (unknown [120.243.48.4])
        by smtp9 (Coremail) with SMTP id DcCowAA35Q5lx7JhZSRtAQ--.13133S4;
        Fri, 10 Dec 2021 11:20:32 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        sensor1010@163.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/crash_core.c: No judgment required
Date:   Thu,  9 Dec 2021 19:20:03 -0800
Message-Id: <20211210032003.16278-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA35Q5lx7JhZSRtAQ--.13133S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RRc_TUUUUU
X-Originating-IP: [120.243.48.4]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiuAxlq1QHN8CghQABs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No judgment required ck_cmdline is NULL
its caller has alreadly judged, see __parse_crashkernel
function

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/crash_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c9..9981cf9b9fe4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
 		p = strstr(p+1, name);
 	}
 
-	if (!ck_cmdline)
-		return NULL;
-
 	return ck_cmdline;
 }
 
-- 
2.25.1


