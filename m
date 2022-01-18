Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7692449208C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbiARHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiARHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:51:23 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342EC061574;
        Mon, 17 Jan 2022 23:51:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u26so8034382qva.7;
        Mon, 17 Jan 2022 23:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UidKo7hCYa0j6KX7wCdHG3uu8L0hYfqcUNzoEu8+6d8=;
        b=PXpfIjazQFVC3iIsZ+DLuV2bkEegja5jS44H78trfb+SkHr6N2teSrrK3UZOz6YQx6
         DfVinYh7nlZw2ghwmmvXOWLNpNiRUiI2jCGt3OOkX4Ep/NY21BDw1b14VWwTS9Cv59eA
         xYqSiWP8yBxYZXetl1Fq/khLPG/zgnVY7dJufxwF37Xbt/AP0Gsax1oahA055/GCf1t8
         aNEeKAkGFy442Lgb2hwCUyKF+t2I+4b1ssWtJzKRlbiSVnfxiYrWsws8G0++yHkc7mFL
         yT4bw2k1N2/8vkLZ/pzFxIMqIYzlWIZxHHNqPBse1TmH98F1k7ucXbZPZmLeArNDZTiY
         xJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UidKo7hCYa0j6KX7wCdHG3uu8L0hYfqcUNzoEu8+6d8=;
        b=ejA1zriFqLdmGKeqaZLhTsZ+pljQqDsAeIvuce37kZ701qJ9/PZ5brNyoDnd5CFc6D
         dElZrnAijyBq7HKSi0rD/sDmPvC4uf5tOo4wJOlwrdP0QzIQjxQ1D77tgSZajE+XFPe9
         ig+qbU+RskCkXF+bCPeO9pmPIAHN+Aem9YkigYqljUgr2Sqe2zPz/sBHDps9JKBlgfzp
         wlApJ9r/q3Ep/1eTVEX6G4g+9yIMvNYDlJuBU/NGGJ9tYwSmx0qIwlEO6S+UTbgLOn6X
         /eCOvjQLq6h8pw7iL2Lvkg2/TB33Ytgz/9HL5rhkHyMgBtoi6LqxqOkZZYbuFVEbsWFK
         n/BQ==
X-Gm-Message-State: AOAM531X1ondZKk+I1Q4mNuTLD+YlYjRgdyvJG88mdXM0djYBY7uPa2m
        gOEp6wSkYAWzg5Rcizxl0tU=
X-Google-Smtp-Source: ABdhPJwbpL7a7Z9np1IShby3+vmuNZvC01FJjtGYp4iZhevM1OoiQqSFuYgz+SxLT+BTmPyiFWpgew==
X-Received: by 2002:a05:6214:626:: with SMTP id a6mr21482019qvx.114.1642492282523;
        Mon, 17 Jan 2022 23:51:22 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c7sm10562605qtx.67.2022.01.17.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:51:22 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     oleg@redhat.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] arch/s390/kernel: remove unneeded rc variable
Date:   Tue, 18 Jan 2022 07:51:15 +0000
Message-Id: <20220118075115.925468-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from user_regset_copyin() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 arch/s390/kernel/ptrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 0ea3d02b378d..2ac936ae7b2b 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1048,16 +1048,13 @@ static int s390_vxrs_high_set(struct task_struct *target,
 			      unsigned int pos, unsigned int count,
 			      const void *kbuf, const void __user *ubuf)
 {
-	int rc;
-
 	if (!MACHINE_HAS_VX)
 		return -ENODEV;
 	if (target == current)
 		save_fpu_regs();
 
-	rc = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				target->thread.fpu.vxrs + __NUM_VXRS_LOW, 0, -1);
-	return rc;
 }
 
 static int s390_system_call_get(struct task_struct *target,
-- 
2.25.1

