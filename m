Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DE4A9A55
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359079AbiBDNvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359062AbiBDNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97974C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k17so5242918plk.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHiD4MZsT86vIRdRdRlX5LZloPcWWK9EQ4fdq/sL1Xw=;
        b=XddfgqU7OpX9vruzWD+1hKmS2fgZLoAmSviJEa6Bt4GOAiLOXFbXNfZWds/PtwoXBI
         zh2aSqxht1r4J7fMsBrYsNgY50Y9PHxe68Kan4djBgizWIdgOjyB9bL2BWmGgIQ79o+T
         VNAXhbeMt8LjP2o56beGyrkiVM7tZNIFwBBNNBCg6TtI3K5AAyIVSz8oUanaTi0hsFbJ
         4UHwbdWdZpBi8hhS48cnbLobfT7xGwVI3fmW19PxsRimm7C5rSE+YjW2uNAQgVbxlklt
         syRtsUGm1KF/9LwBmPUMECk0WkFTK0mPUwpaATSf+Tnoa7XfXzIMsTj3LQuDVd9iqzA7
         iv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHiD4MZsT86vIRdRdRlX5LZloPcWWK9EQ4fdq/sL1Xw=;
        b=f+FHB2zXbPVNdkjxe9J8uFunyiSte5Rcu0Dc1JK2n1Wx2ikFsRiNNa8NdKcvnMncFF
         sPeZc0nsLIOuBEAVGfv+iT/Llp3r/kZJV23x3pYnsL20GKJ6CwCxn2W0YOXX3PRdnVG9
         rhkS0wA9Fz+mn8II+A8ihWld12RtT3CFl5g6zb13GKwFL4RENV51fAiTdnelXdCg8RmS
         XhkjGD6hYdl2i8yZSG3c+eQ9DEH/m6ULIMan5MSm5056NqOb60iHbtBVp9CSIZ2zmyw6
         i0X2T1Q8DIiKh8VE7NXxvck03Ngr68pzBCpIxo0Yw5OYpDhpsebsLjZGweUs9u5i0Psd
         A0wA==
X-Gm-Message-State: AOAM532Kn4b07FhXMXTaFGvDxGGzQZnLemRO+/0vPeVWF5lRZi6F2h4v
        7R4dWttoQVUXcVMP7eJPvSQ0iQ==
X-Google-Smtp-Source: ABdhPJxICqla4E74jvOrFuoYt2TchjK8Wbbi/Rm9tdVZAG7tiXooKMjmsnAOesCdgglSCvqHC/9VIw==
X-Received: by 2002:a17:902:c209:: with SMTP id 9mr3104089pll.119.1643982689012;
        Fri, 04 Feb 2022 05:51:29 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:28 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v4 4/5] audit: Use task_is_in_init_pid_ns()
Date:   Fri,  4 Feb 2022 21:50:50 +0800
Message-Id: <20220204135051.60639-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204135051.60639-1-leo.yan@linaro.org>
References: <20220204135051.60639-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open code with task_is_in_init_pid_ns() for checking root PID
namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7690c29d4ee4..4dfa58865d9a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1056,7 +1056,7 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	case AUDIT_MAKE_EQUIV:
 		/* Only support auditd and auditctl in initial pid namespace
 		 * for now. */
-		if (task_active_pid_ns(current) != &init_pid_ns)
+		if (!task_is_in_init_pid_ns(current))
 			return -EPERM;
 
 		if (!netlink_capable(skb, CAP_AUDIT_CONTROL))
-- 
2.25.1

