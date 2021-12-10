Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE96246F936
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhLJCcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhLJCct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:32:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A272C061746;
        Thu,  9 Dec 2021 18:29:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so7179312pfb.8;
        Thu, 09 Dec 2021 18:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XmLdoK5Jwb4RMxTZ5C0rdUBF+fxXWpgMLPvL0IMihQ=;
        b=HKLrxOGBQvlSUGxq00bPKM1UzuWJulv6Nxb6i50klThNxMnRXlLoLA0CRT+JZD8L71
         wTg13PGQwXFCCxwMxgvmbL79/pU/qID9kAqgqd0SNBhbUjWkazKRHrfYbu/lvEp9lVDW
         wi06WKzeVCCcNeHXAJIZ6my/fEwsUjxx+4OuA1ADQWU7QwV0+y8X8KZnIFTGk3g5xecu
         SZOPzLY9p92SS8A884onIXu5dgbYBbQa9N5lXxeu1qS6MSCKZXGRZQmHcJ0FkG26Z4P5
         ZwwqJ6vWj/48ZgNMxvzJIhAIqozVUWvi3fl/1cffYQrd1JqOj+FOhJD/Szu6Q2oMv5w+
         9eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XmLdoK5Jwb4RMxTZ5C0rdUBF+fxXWpgMLPvL0IMihQ=;
        b=fjrX5i164rs6D/HBu9rQCvmr4UTKhmt7QkYnPdo8+zVh4x6zkGM2GFfNa9mPSTt9hE
         +p4rpS+FIu48cMZwPOhWpUlzEQ4mOmx5HaiSSx22ybxs0qc4nFOOiIU+jWaHHFQPJetZ
         JuJ2QzXmh+VkDW3VuOqwzq8RfqJaVUvGK4TpYXqxqCTnqYVUKsvDDxBuJDM6f4d+ZWhC
         zvLalFfKjQxj3xm6JWn3KUoOetvP4+SYTdK2ho9RlHY0G2I6dv5bwWU7wj2CE1V1mGLt
         QxEfzmFPhA3rDTlfci+Q70603OrAGB1w8M6A1Ty3bf3aXAdnV+t1hwVPVbRmYU/YwIlI
         FttA==
X-Gm-Message-State: AOAM531DwHyf/fuhE27vc3H3xshnj60Pmoqe1oOKNX3mZx0pYVslpC1X
        0A1+U+EFagT7CsMhorIs7FI=
X-Google-Smtp-Source: ABdhPJzPMnsB0DoL1nDQa+0EEm2rBL2w+p+1cUNWl69qi4qoieATnP3FRUsmQx1tuWbPlgNVKegzQA==
X-Received: by 2002:a62:15d0:0:b0:4a0:2dd5:ee4e with SMTP id 199-20020a6215d0000000b004a02dd5ee4emr15463281pfv.14.1639103355101;
        Thu, 09 Dec 2021 18:29:15 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b2sm1067319pfv.198.2021.12.09.18.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:29:14 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, chi.minghao@zte.com.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] tools/perf: remove unneeded variable make code cleaner
Date:   Fri, 10 Dec 2021 02:29:11 +0000
Message-Id: <20211210022911.424512-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 tools/perf/util/callchain.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8e2777133bd9..ed30da7e14ab 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1301,24 +1301,16 @@ int callchain_branch_counts(struct callchain_root *root,
 
 static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
 {
-	int printed;
-
-	printed = scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
-
-	return printed;
+	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
 }
 
 static int count_float_printf(int idx, const char *str, float value,
 			      char *bf, int bfsize, float threshold)
 {
-	int printed;
-
 	if (threshold != 0.0 && value < threshold)
 		return 0;
 
-	printed = scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
-
-	return printed;
+	return scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
 }
 
 static int branch_to_str(char *bf, int bfsize,
-- 
2.25.1

