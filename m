Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84D48797B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbiAGPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbiAGPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:02:57 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:02:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id y9so5617439pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXuTrO6Ha+huM7qcuvlq7qXNNB9UWgUz+upFeSphi/o=;
        b=WX5TEAkaQFMLbDVoab+XQSLyFMshbrheqtOPJp3AKMLUzvamg/9f4JGtLWoSbQu2tN
         tGxa4Zs4FQKbPEFF2Gyy1rSh+1IeMLLaBSNJ3UVlWqooYrILfII5JXoU79F92zTu/Ohm
         IS7ZQ7yFmEKAoRSFR6UqQsc/aUdVAU2/LpPhRLqNMPGj34zgoDAS5Zl0joX6yQ49Rya3
         N07t9SIWTUCZm4ZGqb3i9NmUdXdHHr1gp0EupLl7hpLh0mLp/2FTc8xctmbap4Cwo3a2
         hKzF9uku1i5C2rpGD3pqBmttlpvtYpXBJhFp1pXbuVBjkUf+suIbbMp9gsE3UqNq7WcP
         zLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXuTrO6Ha+huM7qcuvlq7qXNNB9UWgUz+upFeSphi/o=;
        b=IQAKu9yQ2ja17XAE+eOKjSM9DW8WVTkeSHxPBAB2rP2n4nfZ95axnyPGGUvnAzvKOK
         Exv02TYNAkAA3c+RqHfbUsky9HCb2nld6xG5EyL2d+N8bWfffLodRpNhsgatHLRBcp4+
         Iiij0bTg8m6tZpjEpig4aBBG0dVCCsyGl50avA/ZPGxzbsJWuBh0mHYpH4AiMdP7rduf
         q8uLqCRZ+9e3E8S8utieYlJFLXg2mhy/3a4FSAH9ucFVUme1FEbKf69j+M/Unr2cvAVF
         j4ZGXxL7xOztgRQTSxJLz0VaJZXjX310S+ROzMe69Jvb/Wq2gGvnq7sQlA8muHPAoTHX
         hnmQ==
X-Gm-Message-State: AOAM5334DDT31zx1rsVPoyLS7fZY6S4G7nRnBaCersxRxdfva/Gf/b1G
        h18yv5bpkMLGvA8J99AnTQY=
X-Google-Smtp-Source: ABdhPJxdHRTqcOth/t3EBnwzur31VOzzk0AxU8d3AjuAVfZlODS+uy5drS5cFm9VNuneDa1NdYplKQ==
X-Received: by 2002:a05:6a00:2304:b0:4ba:4cbb:8289 with SMTP id h4-20020a056a00230400b004ba4cbb8289mr64533524pfh.79.1641567776490;
        Fri, 07 Jan 2022 07:02:56 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.108])
        by smtp.gmail.com with ESMTPSA id j8sm6903492pfc.11.2022.01.07.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:02:56 -0800 (PST)
From:   Xiangyang Zhang <xyz.sun.ok@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, xyz.sun.ok@gmail.com
Subject: [PATCH v2] tracing/kprobes: 'nmissed' not showed correctly for kretprobe
Date:   Fri,  7 Jan 2022 23:02:42 +0800
Message-Id: <20220107150242.5019-1-xyz.sun.ok@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'nmissed' column of the 'kprobe_profile' file for kretprobe is
not showed correctly, kretprobe can be skipped by two reasons,
shortage of kretprobe_instance which is counted by tk->rp.nmissed,
and kprobe itself is missed by some reason, so to show the sum.

Fixes: 4a846b443b4e ("tracing/kprobes: Cleanup kprobe tracer code")
Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f8c26ee72de3..3d85323278ed 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1170,15 +1170,18 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
 	struct dyn_event *ev = v;
 	struct trace_kprobe *tk;
+	unsigned long nmissed;
 
 	if (!is_trace_kprobe(ev))
 		return 0;
 
 	tk = to_trace_kprobe(ev);
+	nmissed = trace_kprobe_is_return(tk) ?
+		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
-		   tk->rp.kp.nmissed);
+		   nmissed);
 
 	return 0;
 }
-- 
2.25.1

