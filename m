Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F0468B77
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhLEOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhLEOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:54:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4BC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 06:51:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so6335709pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNiShhLycQhgX5gYnC4y4VBBuFZNS7ZHSY9AFesdrV8=;
        b=CMUN9P+RYDkzOLIKctNBP/6VANWwm6cOuLLsJD3LtQMfK65VWY+CtG+idsfLifL1lM
         Kai4/V2FAJa43SAL6u0ZK9haIclc89AinTlGqu1q6mOC4pS+rnK7mQhFl4kzcOHrSqGd
         M3ZPCvnCUbFiOiY5Ns7QSi3DDuskgjDRdTibTIoHKyNlvHl58PMZ8MZiD6t00CAxJo1Q
         UmuVgW/UDFjyLdXt1a/98lf7eCoHBTQPErjGfMXah86NtZVSSj/XGg0eBOtGJFR8E+Mb
         KDBBBe05Qop9MmT/s/O1jKd5VCY2Ii1kvVsxVxY4c1WMLnbyLHHA/0SrUheLWKYORnBv
         axTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNiShhLycQhgX5gYnC4y4VBBuFZNS7ZHSY9AFesdrV8=;
        b=Ue26uMRQx3UB+qbp/bEUswllFIDW5/ccv6lM7TNUjTXKb4OkPEKzd6JqT1NlN3e1S1
         +JSC/DhqFdYeWi4SLA/Mc/OEAwJiLU5E8dMFDtTxyjERLlrK+3hIVuB88dHHinqe1+gg
         UbTd7aetsENReL5lpwmFYD5fDqZOA3UeQIZMPQOfz5T+YxeIGgNsWmIXQOTzlolhbtUq
         /kdAp+bKuZQ6uNV61PAjvxxLcQ8NZRd27UgHLX6QC4VmFeiZy0Mftsu9FBqzC1npNW9Q
         d+nZ+AgDR2zCK8L/1KtzdgUU9UvjLdg2auGrOo0MQI+KZvRjY5vrPSH2BPPXt7xG66hw
         SJWA==
X-Gm-Message-State: AOAM532gVU1L/NIfFY7elUbryMWHgg871adSUNeqiaU6jg5FtcIeefAH
        atkyzVIUu62dA5r8rZ/lsWHttQ==
X-Google-Smtp-Source: ABdhPJzc9deUn8Xmj0L2AU7C6UVvRT82dukgejEcgPuHYSOcdCGBPFUz1V0TrkJ2f6OtnuKQPz44Jw==
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr29446156pjb.15.1638715878962;
        Sun, 05 Dec 2021 06:51:18 -0800 (PST)
Received: from localhost ([2602:feda:dd1:19c7:f5dc:98c2:a1a4:6c61])
        by smtp.gmail.com with ESMTPSA id o2sm9507666pfu.206.2021.12.05.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 06:51:18 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/7] pid: Introduce helper task_is_in_root_ns()
Date:   Sun,  5 Dec 2021 22:50:59 +0800
Message-Id: <20211205145105.57824-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205145105.57824-1-leo.yan@linaro.org>
References: <20211205145105.57824-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel uses open code in multiple places to check if a
task is in the root PID namespace with the kind of format:

  if (task_active_pid_ns(current) == &init_pid_ns)
      do_something();

This patch creates a new helper function, task_is_in_root_ns(), it
returns true if a passed task is in the root PID namespace, otherwise
returns false.  So it will be used to replace open codes.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 include/linux/pid_namespace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c7e627503d2..bf82b373f022 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -86,4 +86,9 @@ extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
 
+static inline bool task_is_in_root_ns(struct task_struct *tsk)
+{
+	return task_active_pid_ns(tsk) == &init_pid_ns;
+}
+
 #endif /* _LINUX_PID_NS_H */
-- 
2.25.1

