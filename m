Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2471947FD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhL0NHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:07:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF033C061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:07:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t187so106241pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y24iSF3ID8CUJS4FrvPuWUAAeYS2AO0M/jvrLGgFbaw=;
        b=ZrIbG5bUpVdp4lZFLowZk4DxTKvkx1+CQ12zbAujnzKU/3o/oZliX8SF8mSeKscTIx
         wZlrh6q13r9Wh/coRRafQbspg07tbrhgIf1cHvEksbFr4cda2Nfc6ieTzTE+WNhjN6ie
         0+TPijORNIGlfxHSMgTKcQaLGSmp4HYeCzI0mL7XscBBVlSz5Pmqcw7mehJgFBy7wCUo
         w7CGuRLjHaiw5gzVYbB7+hNUgqfxHLVgZPdB3dPbTA9JLJSGBc5/PH2Ocq8rVmNnD8I8
         vXAwb7WM16/wmi1QohSiej50yB4nKc+99E3uxjEaRTYRPfbtXBvQajRKMV7JJJdg64Tf
         G79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y24iSF3ID8CUJS4FrvPuWUAAeYS2AO0M/jvrLGgFbaw=;
        b=q6u/je6GI+9QLbbeg0xDm8Df44Gwq6sL/OmoqvCX/14swzEY3BMGeV/DeUVa3vWdMM
         GVGabwys7C7RB+jg+q/eGM1qDDH+vCHrhQB2SoX10z03U587NFV7HfV98w1ppIChX5nn
         JJzDPqQbwtdVWTxfRRbBbwHogQp8hy9koNds5gRIrQBcLHxZLDeYtNhY8SjEIqgygW/W
         OqvnpyGR57KwfM9uckhc4L9LV1zyR6BuixpagFdcFgiIRh+Rmhan5tbv9mLiqYmVnIU3
         7wtTv2GjKOQM68K5GWwh8LisSbQlK5j+SwA192ELRbFgz7pISwp6G9p0syg8dc/xCSAI
         Aa7Q==
X-Gm-Message-State: AOAM532s/jI8Bq6bxbUSC3dHbmF6aPNkhIOyKwavGN26RC+D+VLLoyOb
        Sn8a+aMhQCpr9CmVx4VMrXJrAA==
X-Google-Smtp-Source: ABdhPJzKdxOFpsR/ezcVv2IbNLcTNk8WTaCUNsbNZ6DpCtojj8YifP//Qk2WQcO0cr4spwiYuZpXBA==
X-Received: by 2002:a63:3c0c:: with SMTP id j12mr6889915pga.305.1640610455270;
        Mon, 27 Dec 2021 05:07:35 -0800 (PST)
Received: from C02FJ0LUMD6V.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d21sm18060136pfv.45.2021.12.27.05.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Dec 2021 05:07:34 -0800 (PST)
From:   Qiang Wang <wangqiang.wq.frank@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, hengqi.chen@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        shekairui@bytedance.com,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
Subject: [PATCH v2 1/2] libbpf: Use probe_name for legacy kprobe
Date:   Mon, 27 Dec 2021 21:07:12 +0800
Message-Id: <20211227130713.66933-1-wangqiang.wq.frank@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug in commit 46ed5fc33db9, which wrongly used the
func_name instead of probe_name to register legacy kprobe.

Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7c74342bb668..b7d6c951fa09 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9735,7 +9735,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
 					     func_name, offset);
 
-		legacy_probe = strdup(func_name);
+		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-- 
2.20.1

