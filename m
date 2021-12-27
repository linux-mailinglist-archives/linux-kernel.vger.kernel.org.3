Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123EE47FD3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhL0NHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:07:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE0C061757
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:07:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w7so10821600plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jC0+o9svVpcLqYN6/eprxiVlC6uDNNR02B/K2tC0074=;
        b=migVKgNS0KNUOWffTdTdZrUbXpO++chuO63+iVRBa064I02N1Yhf34UtWHeo5NaXwS
         RNR0WCAcL1BtMTMMECQzUQjj7OohBYpnFSxy6irjXmCdTEn4DZu9vt6evcGpAV34Gs5N
         eIqGs2l51H7tK1feBHDER6vPiKKUn1v+nXoVOF5sQVDea9SoIQ/I4PqZlIuX/pwGzFtZ
         d3YBZtDj27Tz0G+YdtbGlPTJkI5OLpXhib9Qqylvl8dQ0YXZDYplNWQ2/JaZXEPhx326
         u/x+PbKj8kbTIpm/2+76v+8mbjpFrXf5g9rWU9dIaUp1Hi8wjrZr2xYRUNMlj1iyU7pF
         PkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jC0+o9svVpcLqYN6/eprxiVlC6uDNNR02B/K2tC0074=;
        b=x3GeIo0Ow5SqzGMA9vQ7H0l8y+PJI+406aDPScCRwry7SDnSFw+Yv1Hg98lFIbrMKq
         EF2XLdWV1SBhecr8OUZeDsr2RlnmfDLcLLHITcw3GuJ0Tdd5bAzqGmg7lavQaXkFiQIm
         UFyNRDQ1e5dyhnYqbKmIMRAqNUf5cgDu8d8tvwfJyyrCxz3phNg1CsTWnELXUmfyluOT
         l3ADXi9s2bveME35iAPGP+E7niVP2+r5qL/LtLzW8LXgyPEwwyQkqf5jt2zleWu6S2mI
         9lLYvniuhjP1SYvhUdF7vjq5wyz7iRrr7Exbqki20QSHugGPZ5G/KoS38UdAzfXVouLg
         forA==
X-Gm-Message-State: AOAM531PZv5Zs0G19wyf3YI1mwzMUR139365DWTp+QgXv9al2MJWb6SS
        s5ulS4o4DeGmyAKzK2KyUA1Csw==
X-Google-Smtp-Source: ABdhPJxoA1W2IgMtSrHBm8VRhCMgZVS/nCAG6QyibAdE+KO2FZpBX0tx0AmxJxJizXpCEvFFjNiIcQ==
X-Received: by 2002:a17:90a:8041:: with SMTP id e1mr20872203pjw.60.1640610461633;
        Mon, 27 Dec 2021 05:07:41 -0800 (PST)
Received: from C02FJ0LUMD6V.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d21sm18060136pfv.45.2021.12.27.05.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Dec 2021 05:07:41 -0800 (PST)
From:   Qiang Wang <wangqiang.wq.frank@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, hengqi.chen@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        shekairui@bytedance.com,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
Subject: [PATCH v2 2/2] libbpf: Support repeated legacy kprobes on same function
Date:   Mon, 27 Dec 2021 21:07:13 +0800
Message-Id: <20211227130713.66933-2-wangqiang.wq.frank@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211227130713.66933-1-wangqiang.wq.frank@bytedance.com>
References: <20211227130713.66933-1-wangqiang.wq.frank@bytedance.com>
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
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b7d6c951fa09..698e8864da02 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9634,7 +9634,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), kfunc_name, offset);
+	static int index = 0;
+
+	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
+		 __sync_fetch_and_add(&index, 1));
 }
 
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
-- 
2.20.1

