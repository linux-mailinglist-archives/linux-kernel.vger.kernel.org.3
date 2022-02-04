Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175114A9A54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359049AbiBDNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359045AbiBDNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5AFC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:24 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13155668pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWkrWIVd0/tR6K54G/x68wI67h0lySobA9zdXOmvIu4=;
        b=ZjDAUHdvFm23PkDB88Y/g/RhqrfOS166LoUKOx5kLqEJVAfTEptWR30Yy2o02xcBjs
         wWzsXg6LJBvz2Eat79+CLZwuDAa5aoD1sDJzsb/MRdCQx2nHa09K5nmMa2HzN9rNEN1y
         J9OzGZ6bq3MFnXpMWCX7R9JFQjyx7xvrQ41jU8/5AdjHE1o5eKyePd3Op9HPm896ducL
         p8AF+I806JejVmLZBkheAgZhisIt4LuDOmBb5FIo7FHALMGh6CxXztZcc6LzBawUefz3
         8zJA0OKFevHfdUBGrMQNdgDBIyMavlG5FwYJk4SmYkq9jrHTLj89FeyKimQ032V1T5Zm
         C2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWkrWIVd0/tR6K54G/x68wI67h0lySobA9zdXOmvIu4=;
        b=OIT2dyxcgdll+Y+SnMv3dfCnieW3mRbMQLGOixurOrPhWvRLGxF7AQDJVib+oxGSOn
         MXXiH4QlvJ5te4dUPDa2R1iAOsi7+1GFmlovze3SZzlx2OsehdJ+C4Ui113NMj9msjot
         C5NKqsgX4Lv8Vot9QHGQSsJxOQt9PIJOjp6P9elTpiLeCsMB5JBHV1tS7SuUgXkZxrXQ
         ZWfAvTQ4CtCYJ6LaS7nttsrLN8Z04GmU/X+u2LAHIRijqsZ4D/jJ4LOLdZsmsmJkGwBD
         TfrguLFVWnsvFq1lfCYe0SlaU+IiUZxdRb6ANvXqe8k32CGYK4n+NppnU+0Jk8WShVOV
         kNsA==
X-Gm-Message-State: AOAM5319XfqzvfN4bzWXovHAl4f12WU1s6zXfWxF5lX/5djLp+mBHEAa
        3RdDSKCQxhMuW0psa3EBJ7uxLQ==
X-Google-Smtp-Source: ABdhPJzzlHgPllMAQLi0+cpFqx1ccciJ1GkPw437Mdlv75oiqnu9xqBhEbHOtdYvZHhrvF3MASLJ0g==
X-Received: by 2002:a17:902:db0b:: with SMTP id m11mr3093004plx.104.1643982684308;
        Fri, 04 Feb 2022 05:51:24 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:23 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/5] coda: Use task_is_in_init_pid_ns()
Date:   Fri,  4 Feb 2022 21:50:49 +0800
Message-Id: <20220204135051.60639-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204135051.60639-1-leo.yan@linaro.org>
References: <20220204135051.60639-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open code with task_is_in_init_pid_ns() for checking root PID
namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 fs/coda/inode.c | 2 +-
 fs/coda/psdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d9f1bd7153df..931f4560fdd0 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -152,7 +152,7 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 	int error;
 	int idx;
 
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	idx = get_device_index((struct coda_mount_data *) data);
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index b39580ad4ce5..73457661fbe8 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -270,7 +270,7 @@ static int coda_psdev_open(struct inode * inode, struct file * file)
 	struct venus_comm *vcp;
 	int idx, err;
 
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	if (current_user_ns() != &init_user_ns)
-- 
2.25.1

