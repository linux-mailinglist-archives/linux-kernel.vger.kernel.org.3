Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C947145C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhLKPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLKPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:00:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A0C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 07:00:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x131so11007873pfc.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4OzfNOh9mqp4EATONtMbEtd5LWmkPp1pHnXz+/waGoU=;
        b=d7pMalBdszZritjqD+9G87Yspx/8x7ondD0PFVX7ch0BYr+lxUnn5VMf5FHPLb1Uln
         GBRXOdEP8c+lnVm+TEAXP6qBBTKjFl336LcXkPCgkvbFhaADRTtmDue17Z+dpFKmAc5R
         drMSq9SODiTC1cz67EfOb/lTyZrei2cQQMpJF2HvviDb5mfEPom1cOtRdF2mKietUhvH
         v7RUCQy5LPbXm92feV+nhrPFuIalEzTSbsq2uAzKrDmi8Cu/DfJjj5iC1Y9pfWbTxPbe
         x/769XzkGBuJ9NMb+Ngf+BgnD6MCscyUl4Hk+Zs01wJI2CodVIOLH6hSZlOSlPSBZJK6
         b5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4OzfNOh9mqp4EATONtMbEtd5LWmkPp1pHnXz+/waGoU=;
        b=2i4e7P6m2KuJ0ytZYSZnJQxOzS0X43C9ge7hf4bUaQeDaGnIcgAajf9wwPrBYy3mJj
         grY90SoLLB33PgdXuyobGQwFLbpdz3YrpaIndIMydrO9/quu8YwScpovvywwSUMypi5j
         /R+bnz3ATqm2x1wXf4v4fM86td2ieR5EOSdVcjaMgdmfNDmBefduyqbjuVdjxFZPQgm/
         MZXKKNiAi87NQl9PVuFCKV7eMxcUGFKZrzTRqpbELPqNzNsP3YhulsNhvUmN17BSPLCY
         bAfmnyxMIpaYRhR5OhT+zehm1JuI/5d9+e/g5IuBTQwkOfOpYuZBsoHUmYZjjxYcDoQG
         xsUg==
X-Gm-Message-State: AOAM533fiGbgqe4zeH6PTDRFcdwsmq4r1Gk2yAMZirAOnt04SlQDfiy5
        XRwWGy2MMtqcQ4uKbkt+pZU=
X-Google-Smtp-Source: ABdhPJze0R7lr76h///4f4sEmHK0I6f6IuqzcU6Xve5uO0ilNEsB1mBGIjy+757nHOghYifg7Re0QA==
X-Received: by 2002:a63:6b48:: with SMTP id g69mr10934263pgc.571.1639234850865;
        Sat, 11 Dec 2021 07:00:50 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.105])
        by smtp.gmail.com with ESMTPSA id p8sm7549648pfo.141.2021.12.11.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 07:00:50 -0800 (PST)
From:   Xiangyang Zhang <xyz.sun.ok@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     masami.hiramatsu.pt@hitachi.com, oleg@redhat.com,
        namhyung.kim@lge.com, linux-kernel@vger.kernel.org,
        xyz.sun.ok@gmail.com
Subject: [PATCH] tracing/kprobes: 'nmissed' not showed correctly for kretprobe
Date:   Sat, 11 Dec 2021 23:00:32 +0800
Message-Id: <20211211150032.7568-1-xyz.sun.ok@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'nmissed' column of the 'kprobe_profile' file for kretprobe is
always zero, because 'nmissed' for kretprobe is maintained in
'tk->rp.nmissed' but not in 'tk->rp.kp.nmissed'

Fixes: c31ffb3ff633 ("tracing/kprobes: Factor out struct trace_probe")
Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
---
 kernel/trace/trace_kprobe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d10c01948e68..2b9de6826e94 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1175,15 +1175,17 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
 	struct dyn_event *ev = v;
 	struct trace_kprobe *tk;
+	unsigned long nmissed = 0;
 
 	if (!is_trace_kprobe(ev))
 		return 0;
 
 	tk = to_trace_kprobe(ev);
+	nmissed = tk->rp.handler ? tk->rp.nmissed : tk->rp.kp.nmissed;
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
-		   tk->rp.kp.nmissed);
+		   nmissed);
 
 	return 0;
 }
-- 
2.25.1

