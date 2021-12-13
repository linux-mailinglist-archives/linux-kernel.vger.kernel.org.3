Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3633472C16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhLMMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhLMMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:13:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73178C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so50545868edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSGFEEK57vZgNj+GJPFHPovuhunjSnX1LTdz3s3nsLA=;
        b=ShuKM7QtQJfbrrEovXJ4uS7mOzRqEUFSdQ7aM7lCo9LkxPZQjIqDKwIOo63kafeBvr
         kQJ+oQFG5qNVMyIRLMlNyZemMrQLCii6MG1ibBiv0x0SYygmdX8N0wtLNT5vdBrtgtpy
         9oorT95681UBLuDX36Qt/2ANtKnW2EdXzvszsioSG4OxP4IDPWdMDEKTGzgHcNBeaiVB
         9uQyopAHfJE+K8ZO9iLOSUWVZU8KnpYUfVUqwLNJGzfo6TtosWDMuWLXsJV93JW0qm+X
         A+rqqF9WSaaMuXyQYmO4M7Q2KIr2tcPUrwqV6jmCRinZtAHaOihmNFs+Rm3VyLT4/J9/
         qnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSGFEEK57vZgNj+GJPFHPovuhunjSnX1LTdz3s3nsLA=;
        b=tKB8SrQUdyOF8p+arlRkrV4XLQuXA12LtqPvMn5/VX/4OJz4hXsP8pr+h1X00A1MtO
         vN0aExrZPT/JE+HB6Hehr/+NikLZDKPBhy/+EqVot6DLI9Az2rwaHSWMa5ee3bi3S59x
         PL1eTZJgD2z0bIDZueTkbw+/Qq2nNDnnjb2EfKZFYenBbHyP8f6bFdSZmDHusmE37Yf3
         pVvLkzNFAJY4zpAOnxmw9Zjsp1R0Gx3MuOOpBfVzFY4SlJt5ZssC5ILZG+lgbQhdIf0N
         GND+8mIbtFsIISBWgU4h3T38j8zV2zRlntZDAFn6bgsFymNC4InJ5lRSVP4HG6NBmXqK
         xDAg==
X-Gm-Message-State: AOAM531vN8frJKG01qcmuKM9CJLz5769vjlxQdrkIn8w6i10uaaOTvdn
        gY3N5hGQ3kEIzBGtZewOYgQDLg==
X-Google-Smtp-Source: ABdhPJy6QhigKx/sG6cyezTv+KNVxOCZGCewaO1EOL4bzSW8lGQxoFkpqUmBkvpQwCmQisQsh4GUKQ==
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr43177666ejc.48.1639397635903;
        Mon, 13 Dec 2021 04:13:55 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id bd12sm6247430edb.11.2021.12.13.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:13:55 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] coresight: etm4x: Don't trace PID for non-root PID namespace
Date:   Mon, 13 Dec 2021 20:13:22 +0800
Message-Id: <20211213121323.1887180-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213121323.1887180-1-leo.yan@linaro.org>
References: <20211213121323.1887180-1-leo.yan@linaro.org>
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
index 86a313857b58..f3eda536267c 100644
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

