Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308374A9BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359691AbiBDPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359686AbiBDPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:24:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9658C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:24:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7so5918034pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hy+SU5DZKBp2FMkZFvZyRIrItONG8TmUC/aEVKilLA=;
        b=YVYVsFjbL0x1PoSKxlQAP6K1Q8tWbw8Kg/Pjxg2FOF7pQwqBlm4aamWc85meRcLFXn
         huSX7CmPT/037OkXHzkS/nZETc3ByhPzAKCmzUjkSPETbmWO8o6872bcmIHdH+b0JaaI
         wAprJiNghAyI8D7NztOzffdkxld1O/ruTxGaiveeXnEWBQApWyucb85lRhXKfu6rFYk0
         PI/EXMInmwt6Y+y0/c1O34jqK9zW6+TH/rxZs2kWiKmj+z4pVj2QjMKCt2qDU6u0P947
         OY2QmNPun9R49SR4OQ70OU9A4sNH5oiV/QJRf0uNbHp93lgmnyJIvyBJkKiMZQ5Y+/Fn
         Yg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hy+SU5DZKBp2FMkZFvZyRIrItONG8TmUC/aEVKilLA=;
        b=QCcs0x1l2PBZRvfDW2vdqu5aY0N80kjnAVj1WgDMuAGjWD3Nqjew/usTdx2DHn4rs5
         HZ53lmDupRWucc7rCKgLDj8vFyPeH2mzjc2Zp7EQdjyk6zf9TlHDCtw2+drGZVr96Kko
         3TnTYqiIMTPbD2yTI5O/+eQDTG3SliOa1ZjCPx2ZOw0sJU2e/WhgIyYIuK1HtF/hRh0M
         OP6ASIqsQNuFqZbwpj4siILg/782flvobtiOVLd5KP1SO0OB/7M27EzduXEFFs0ycxdB
         iTgmssLmRlH6elUJJ0AVB1h2hj53O8z94h+kqkCyUi5eBPxxMd6aiFQ2jaOkoCxQXjM6
         JkCg==
X-Gm-Message-State: AOAM531Pir59NzaqtS0oq75Yu8ZKteEoskgoBmsJ+pFT1QPbboWE8PtS
        l53AInkQFbq9mv9CyQTGLBaMeQ==
X-Google-Smtp-Source: ABdhPJxlCc5xJ4BQqndpWvQJnjLgf7o0hy2on0zKx3ZCMYmek4gRlokGD7MNBbxdNJYhr24PFAJ6YQ==
X-Received: by 2002:a17:90a:b018:: with SMTP id x24mr3617371pjq.91.1643988273277;
        Fri, 04 Feb 2022 07:24:33 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id me4sm14237079pjb.26.2022.02.04.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:24:32 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 RESEND 3/4] coresight: etm4x: Don't trace PID for non-root PID namespace
Date:   Fri,  4 Feb 2022 23:24:02 +0800
Message-Id: <20220204152403.71775-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204152403.71775-1-leo.yan@linaro.org>
References: <20220204152403.71775-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runs in perf mode, the driver always enables the PID tracing.  This
can lead confusion when the profiling session runs in non-root PID
namespace, whereas it records the PIDs from the root PID namespace.

To avoid confusion for PID tracing, when runs in perf mode, this patch
changes to only enable PID tracing for root PID namespace.

As result, after apply this patch, the perf tool reports PID as '-1' for
all samples:

  # unshare --fork --pid perf record -e cs_etm// -m 64K,64K -a \
	-o perf_test.data -- uname
  # perf report -i perf_test.data --itrace=Zi1000i --stdio

  # Total Lost Samples: 0
  #
  # Samples: 94  of event 'instructions'
  # Event count (approx.): 94000
  #
  # Overhead  Command  Shared Object      Symbol
  # ........  .......  .................  ..............................
  #
      68.09%  :-1      [kernel.kallsyms]  [k] __sched_text_end
       3.19%  :-1      [kernel.kallsyms]  [k] hrtimer_interrupt
       2.13%  :-1      [kernel.kallsyms]  [k] __bitmap_and
       2.13%  :-1      [kernel.kallsyms]  [k] trace_vbprintk
       1.06%  :-1      [kernel.kallsyms]  [k] __fget_files
       1.06%  :-1      [kernel.kallsyms]  [k] __schedule
       1.06%  :-1      [kernel.kallsyms]  [k] __softirqentry_text_start
       1.06%  :-1      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       1.06%  :-1      [kernel.kallsyms]  [k] __update_load_avg_se
       1.06%  :-1      [kernel.kallsyms]  [k] arch_counter_get_cntpct
       1.06%  :-1      [kernel.kallsyms]  [k] check_and_switch_context
       1.06%  :-1      [kernel.kallsyms]  [k] format_decode
       1.06%  :-1      [kernel.kallsyms]  [k] handle_percpu_devid_irq
       1.06%  :-1      [kernel.kallsyms]  [k] irq_enter_rcu
       1.06%  :-1      [kernel.kallsyms]  [k] irqtime_account_irq
       1.06%  :-1      [kernel.kallsyms]  [k] ktime_get
       1.06%  :-1      [kernel.kallsyms]  [k] ktime_get_coarse_real_ts64
       1.06%  :-1      [kernel.kallsyms]  [k] memmove
       1.06%  :-1      [kernel.kallsyms]  [k] perf_ioctl
       1.06%  :-1      [kernel.kallsyms]  [k] perf_output_begin
       1.06%  :-1      [kernel.kallsyms]  [k] perf_output_copy
       1.06%  :-1      [kernel.kallsyms]  [k] profile_tick
       1.06%  :-1      [kernel.kallsyms]  [k] sched_clock
       1.06%  :-1      [kernel.kallsyms]  [k] timerqueue_add
       1.06%  :-1      [kernel.kallsyms]  [k] trace_save_cmdline
       1.06%  :-1      [kernel.kallsyms]  [k] update_load_avg
       1.06%  :-1      [kernel.kallsyms]  [k] vbin_printf

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf18128cf5de..e7fc83a1e188 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -656,7 +656,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		config->cfg |= BIT(11);
 	}
 
-	if (attr->config & BIT(ETM_OPT_CTXTID))
+	/* Only trace contextID when runs in root PID namespace */
+	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
+	    task_is_in_init_pid_ns(current))
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
 
@@ -670,7 +672,11 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		}
-		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
+
+		/* Only trace virtual contextID when runs in root PID namespace */
+		if (task_is_in_init_pid_ns(current))
+			config->cfg |= BIT(ETM4_CFG_BIT_VMID) |
+				       BIT(ETM4_CFG_BIT_VMID_OPT);
 	}
 
 	/* return stack - enable if selected and supported */
-- 
2.25.1

