Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A184A6945
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbiBBAdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbiBBAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:33:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27654C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:33:45 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s18so23389730ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JepB/7vXyZQxWCvygSiSQrAo+dG4wBZLbFMfRyPaAg4=;
        b=BYjOOb9hkhtXBfhwGlSCCO509XKcvbv2hf2hjKfopkh4jOXW8O7HhQjDtyYIJa0jl5
         qTtw9X86XWTlwMVzFMnM1PJoeTfB9MsBay3aIwLob3YGE1Oy90CKWlPXcFf5aPf5E+FR
         QnQRAqB7avjTD9AOWkm0wdpaP7ob+3r/RNbW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JepB/7vXyZQxWCvygSiSQrAo+dG4wBZLbFMfRyPaAg4=;
        b=36+8vQOMlDUwus0EsLRllQPesNLet0KVnToDhkFG27HHECpqH9ce5JmGyVgeJGmml6
         fASsXelcKsRPWYY6AWKEyTUJTc8nKpdbYSby9L45aodP6gmFVojiW1MjJiBuPBzVpxiQ
         G6W7Bp37BNoRNU/E6rmHByYxymVUzG/hw+MldmzzHuoKXjkOlP7EPTZOIzXA6jQmWR6O
         bxfuOkmtNK4qDs/f//Da6QqVwWxiEmxTDnOC/6m5HMfYDBLhQWnG++Y3Nn0+x+JEShP9
         kH+hSAYFB1baPIdfKX3KPCpsmxbKQqWg4+98Kil9U0dttypqf0+u5O5yYMyzQx8ICfep
         vpMg==
X-Gm-Message-State: AOAM531bsPW9Fng5ZigxqLWdx/2tf8RbWz0U1s7ipBi0o7hqxx+FhR30
        7oqa++fTN5mI/P9wGEjvpwUnTSAvF7i7Ng==
X-Google-Smtp-Source: ABdhPJyLnuma3ioM5xd1+ADrOhX9jvjTMjYRkEa1l7nl/NLBbTeuZXG1YAA6NxvjtObNkd79ajkSow==
X-Received: by 2002:a02:6248:: with SMTP id d69mr14688442jac.133.1643762024503;
        Tue, 01 Feb 2022 16:33:44 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l13sm5971445ilj.24.2022.02.01.16.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:33:44 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     akpm@linux-foundation.org, shuah@kernel.org, chi.minghao@zte.com.cn
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/vm: Revert "tools/testing/selftests/vm/userfaultfd.c: use swap() to make code cleaner"
Date:   Tue,  1 Feb 2022 17:33:40 -0700
Message-Id: <20220202003340.87195-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change, userfaultfd fails to build with undefined reference
swap() error:

userfaultfd.c: In function ‘userfaultfd_stress’:
userfaultfd.c:1530:17: warning: implicit declaration of function ‘swap’; did you mean ‘swab’? [-Wimplicit-function-declaration]
 1530 |                 swap(area_src, area_dst);
      |                 ^~~~
      |                 swab
/usr/bin/ld: /tmp/ccDGOAdV.o: in function `userfaultfd_stress':
userfaultfd.c:(.text+0x549e): undefined reference to `swap'
/usr/bin/ld: userfaultfd.c:(.text+0x54bc): undefined reference to `swap'
collect2: error: ld returned 1 exit status

Revert the commit to fix the problem.

Fixes: 2c769ed7137a ("tools/testing/selftests/vm/userfaultfd.c: use swap() to make code cleaner")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/vm/userfaultfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index d3fd24f9fae8..2f49c9af1b58 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1417,6 +1417,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
+	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1527,9 +1528,13 @@ static int userfaultfd_stress(void)
 					    count_verify[nr], nr);
 
 		/* prepare next bounce */
-		swap(area_src, area_dst);
+		tmp_area = area_src;
+		area_src = area_dst;
+		area_dst = tmp_area;
 
-		swap(area_src_alias, area_dst_alias);
+		tmp_area = area_src_alias;
+		area_src_alias = area_dst_alias;
+		area_dst_alias = tmp_area;
 
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
-- 
2.32.0

