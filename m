Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A2468B7E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhLEOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhLEOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:54:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07296C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 06:51:31 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id m15so7975312pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LDDsH38QkceeUfcUldY6VFRPfPHtJesMGkSHVAh5YM=;
        b=f3fPCDNDHAaSIGPbUYS057ddh5pKujL9XVYkGT4eEig7wCM/t65G2aZKSXTDn/zR5X
         m5T/+pMCCs5rlWOOf+s2ocQZ7V16WVgz4DJ8NP+3yGnRL9TVsJ/ZWKqt3YXTnZMDYyhn
         4lZ0B7y5iKOT/aj6AyagHYHph9TDHQCp1+kMfZ+Bpkv9qNZesc58bui4Kv5lafRwEd5c
         Y4DoyfsSszMrZ2Z/txZNZR/AzVByD905iRTYUkfJlKFC8A4m+j/SWLnjEUZolRYe+jcv
         1zDI/cX8dGGp0oVBtZMmN3R24vooHnabpX22ZHu5jUGt0uh2jvLbgwjDxVongWQE/1gz
         4W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LDDsH38QkceeUfcUldY6VFRPfPHtJesMGkSHVAh5YM=;
        b=zTNZ6M4TmVbw7c+eywew3IGxcmXwfl0oNQ88I9nFlWAf257HzQ9gfIzzc1Nm8dQ2wl
         7RtFZjdF9N5Jb4pwBAj0VjzmRai/a05zsbb3Fuq9b5mABZ3PCNdMka39N0dSQbnp0YKO
         BSK08lRwYseiFXHtlOxoZ+y149Wz9su1U6+joXqIs6qFZOIkDfASCtXfGf7fJ970pIU2
         FErl7oALb+u+Jnayqxft7tATLrZQmF7t7Ik6vbXnPYUrZ7ansZSNCUYiN3Ka7woEqIN0
         z7ZoL2CUBOBlLBWHiTYZNUIUPi0oMAklgCSsrRpe/UXPkQDOo0ZRwphi8SBxfu4XQiWg
         sEOQ==
X-Gm-Message-State: AOAM5326IoeZBU1qREQ1Kuk9F0dAewrOp80AhE2mFAdgntXcKh/CW7pG
        g8VgiZ3ZOG5fWrN1w9Nv1xU+2w==
X-Google-Smtp-Source: ABdhPJyuJmKT3XfC+zhLm/KCB4bWKe9YooU6y1UfwRFRNjjlMVTSdo1heNNLMgTcMpJFMrBsLFPdqw==
X-Received: by 2002:a63:6a83:: with SMTP id f125mr13999908pgc.340.1638715890495;
        Sun, 05 Dec 2021 06:51:30 -0800 (PST)
Received: from localhost ([2602:feda:dd6:6f1c:af3b:f51c:baf0:62a])
        by smtp.gmail.com with ESMTPSA id p124sm9212732pfg.110.2021.12.05.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 06:51:30 -0800 (PST)
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
Subject: [PATCH v1 4/7] connector/cn_proc: Use task_is_in_root_ns() to check PID namespace
Date:   Sun,  5 Dec 2021 22:51:02 +0800
Message-Id: <20211205145105.57824-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205145105.57824-1-leo.yan@linaro.org>
References: <20211205145105.57824-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid open code, this patch uses the helper task_is_in_root_ns() to
check if task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/connector/cn_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 646ad385e490..b8a4fa366b28 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -358,7 +358,7 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	 * other namespaces.
 	 */
 	if ((current_user_ns() != &init_user_ns) ||
-	    (task_active_pid_ns(current) != &init_pid_ns))
+	    !task_is_in_root_ns(current))
 		return;
 
 	/* Can only change if privileged. */
-- 
2.25.1

