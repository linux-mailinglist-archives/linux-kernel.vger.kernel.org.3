Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAD46CF19
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbhLHIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbhLHIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:37:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:33:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so5991654edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/eeez3BcNi8tVHbYa2oBkvP6t/vK4B43HUQensSi3k=;
        b=Orp+rG52g6tM3+l/drNhrh6yzPRKPWZcTew2ozeopfwXTy+KpnrLnl684tWf9cNuId
         90kmKsM3VRgMXWqcqdESh5J1AGweiDOXeVoQTaQS48SQ9Wry/FVDCuCK/RT/pbO9Yob/
         rYfqQQycRbfrii9WQHGS+mEoTkl/Pm0Tfsv/OvzNw9fNjzIwVW42i+23ej2a7xId11CY
         glJ9F28NR3du8wtSsiCXLBpv8IGoJzuKkyjVSUsucqtdae/j7C0GaWmXZErgIOlHL9cD
         +Lqevqy4d/UggetMCsYR27VuZdjK35h10UgFe32dZVb00Uc1/SdZP8CLdokKIY/Etzwk
         Uhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/eeez3BcNi8tVHbYa2oBkvP6t/vK4B43HUQensSi3k=;
        b=ENEqGdlG6iDCFoZWRJYITECjYulYhzNiJ5FcEm+koPMxKrvWGyMZbteET7+N3a2grv
         Vox95ZLC4QL8taX/PZpdABzxU/0jZgtG4yK+mmmdFrYtNbKUuzkA6nyp3jrutbQ/N1dI
         8QU7vu4b/do8RWo17OCFyrosWtIFZ+cYIHsHLK72E6BVKy6L47VpO+abMqBk4HnSk1BP
         HZ06SyrvXS3Mc6qIrWgvLZ3XfBC8aTZ27b2MauKTPSA8CkrcAvSCdZiNMnVXkhJezDqo
         x1fgstXiM/hNKez600OCva1GHjyzDcih4YqrxgYRKPLVlRTCA0cj45oqMVKrBgGrfFnf
         1Gng==
X-Gm-Message-State: AOAM532kqkzrrMzzIqwGMbBbYfap7eu+8s4ZxZpxQY8ZqtP74E7aY8hF
        6uLkzA5+8fNoR5DA4fboLFiaAQ==
X-Google-Smtp-Source: ABdhPJx1gsuPUNsaXFXbyVaebM4oFOMmmWAz5pvxHoEHLYLkpCRym4tCyOQ0c/34zl8r1AV4FxeNkQ==
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr16781811edc.177.1638952424146;
        Wed, 08 Dec 2021 00:33:44 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id h10sm1472866edr.95.2021.12.08.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:33:43 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
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
Subject: [PATCH v2 7/7] taskstats: Use task_is_in_init_pid_ns()
Date:   Wed,  8 Dec 2021 16:33:20 +0800
Message-Id: <20211208083320.472503-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208083320.472503-1-leo.yan@linaro.org>
References: <20211208083320.472503-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open code with task_is_in_init_pid_ns() for checking root PID
namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 kernel/taskstats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..f570d8e1f001 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -284,7 +284,7 @@ static int add_del_listener(pid_t pid, const struct cpumask *mask, int isadd)
 	if (current_user_ns() != &init_user_ns)
 		return -EINVAL;
 
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	if (isadd == REGISTER) {
-- 
2.25.1

