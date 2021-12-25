Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3947F2AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhLYIc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 03:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhLYIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 03:32:56 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071EC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 00:32:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q3so5086613pfs.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OvxUrQQkCom57wUVJl60P0MeViWixpOkxhe4s/JMMc=;
        b=RqringsfiLKfKcM47FFkD6KrLPItmi7FABgsNk/148heTtAR1r/ygCEQMT+/2uksHW
         4gdnT0zNnd71ljvF9FZ0ufnsFtJ3ivmBwMaJ/2Xg60m3U/b0n3zKkf3iScJQy3lX4GrL
         wdb1UkwHzAZh/fKs1n9SdhjnjRwCV4ztudLq6nXx2k4n13mddDnzjKrCVktZ6OGhb3FX
         mVrn2rP0ONBRN/imaEfE+gyjFxx3yH0BSm2PPFfnhvmyYMoHo3VlW1FWg40yXh6+nXtv
         IV+Im24G5A1FspoDPx/gcyopsZLL7t2RSJZeJjYMvInTKiQW3aJs5B84PbOkxETbjqkR
         6PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OvxUrQQkCom57wUVJl60P0MeViWixpOkxhe4s/JMMc=;
        b=a6ERwiayn6MUZU4mDui6qFdgPvW2phXkQFZPBXoE/g49R4O1B46M3JqPrR+dPDmoFS
         TDu9Gmcc2HGvgn+wcHgjeZcJpel4S9VYHMOBU58KbxKrQFUb1JtDjfc0UwK36FBNl6LS
         JUpZ0Gk4nyGc06zdQQUaDmOG9pK6dkEUc8Wo94tUqFwpWhX2pNYIGalGmo/YPcNpEhY5
         ADW6DoRuR5aZcwMKvwG5+ZY2j+bs+oIIxBVX6lgQ8hL0k5aiUx7DmQwIg5tcp+8d4zcV
         ToT9vtrg4YaAw9DnjXvKB6b5i8ilXsVTud/LZGAk2zRhTx0mVPujelmU/kG02xLB6Uyx
         JuKw==
X-Gm-Message-State: AOAM532p9IU+/5DxL1YD9B8kXZceZSMjpJemTq0b6wPioxArxCYQHKIt
        2nEjPcjBRAdZ+R185YMml+66Jg==
X-Google-Smtp-Source: ABdhPJznlmyOBW5dwARFvPNmx4v4bpPjIaj+WRiRkAKwfVZTF2LDG1F5Wg2BL3O2dQ3s7Xucyt7aQg==
X-Received: by 2002:a63:6603:: with SMTP id a3mr8460664pgc.578.1640421176186;
        Sat, 25 Dec 2021 00:32:56 -0800 (PST)
Received: from localhost.localdomain ([122.14.229.79])
        by smtp.googlemail.com with ESMTPSA id cx5sm10181713pjb.22.2021.12.25.00.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Dec 2021 00:32:55 -0800 (PST)
From:   Qiang Wang <wangqiang.wq.frank@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        shekairui@bytedance.com
Subject: [PATCH 2/2] libbpf: Support repeated legacy kprobes on same function
Date:   Sat, 25 Dec 2021 16:32:42 +0800
Message-Id: <20211225083242.38498-2-wangqiang.wq.frank@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211225083242.38498-1-wangqiang.wq.frank@bytedance.com>
References: <20211225083242.38498-1-wangqiang.wq.frank@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If repeated legacy kprobes on same function in one process,
libbpf will register using the same probe name and got -EBUSY
error. So append index to the probe name format to fix this
problem.

Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/lib/bpf/libbpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b7d6c951fa09..0c41a45ffd54 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9634,7 +9634,9 @@ static int append_to_file(const char *file, const char *fmt, ...)
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), kfunc_name, offset);
+	static int index = 0;
+	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset
+		 __sync_fetch_and_add(&index, 1));
 }
 
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
-- 
2.20.1

