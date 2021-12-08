Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABB46CF17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244938AbhLHIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbhLHIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:37:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA2C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:33:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so5990585edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWyoQ03AyiBHBWIuTqdgSeOsB5qpmILnrb6mYHioPfI=;
        b=GK/tVEYgxyUvQFbH1SFaI008Q6trqxRp+nDnHpWJh12YtgZvbGJk7hLGvDKtbMk0zL
         xwxFOvtPy5Xws67MVe0W3I1aNVjzUyGZyPf3+O1fQL3ZgDQjB7hbdqzibnwyeKrAcu0N
         cSC1DwRNG2Bi/kRBZPruIAUWTmK9G9R9L61HhNugyhWORaHFD6KuBK2n54VgavYyRtWX
         xWjRuUE9N4UFyNalIs+WgArU0ULJWBg5CFsNz+up0sQflSRhtjbfTo3eED7zMHqY7CCh
         TxoVqGs1HEsiyMx/GajB/vBzL9/2K0vzgb4+KGOfFP61CG2M2VeinnQQud5jG93QQ3vr
         XM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWyoQ03AyiBHBWIuTqdgSeOsB5qpmILnrb6mYHioPfI=;
        b=rXKmmAGTjGL1v9GbP1cRgSsv+55tln32leXFbQMM2ChwwkM9EkyABUIv9jXjZtezV7
         tzGqe3mCHMzwAMVqDVJ7PynJdhYRCfWummcikBQHYGVia4ctn6P3sQ1USS0bCMnxtDTN
         Elf1xsxszVO4MGNf/ZgfFZIm8enY4PitOUuXUbv3cOPpLDVC/zkfEKkRQ440Nt5pRvPM
         hsmF8K5V923IQsmjXZy4OHu04RObUBP2AyR/87B6wLng0diH1elDVjMdYvSDsczD7hsF
         SFxH4eOUYQC8QgB4jVV3w7wByDYlCTNEiUVVGcwPkFsBJsfY8gKy7QdEfr4UR5S7Um/r
         kcRQ==
X-Gm-Message-State: AOAM532D2FmTynuU2KFSd6o77EB5vDdxU2lKFd2JBTFoCWWF3MRjWig7
        sFaO6Bm+CT8F+c+Tk4XLTlxDNw==
X-Google-Smtp-Source: ABdhPJxuBtI+/+kQ5BUm3igh6ZDVewoV1vYV0z/0/tl6BZ5inncH5WbsQjgaDaLRdh5hJdL1dj1EgA==
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr5897162ejo.538.1638952416319;
        Wed, 08 Dec 2021 00:33:36 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id t5sm1564891edd.68.2021.12.08.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:33:36 -0800 (PST)
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
Subject: [PATCH v2 4/7] connector/cn_proc: Use task_is_in_init_pid_ns()
Date:   Wed,  8 Dec 2021 16:33:17 +0800
Message-Id: <20211208083320.472503-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208083320.472503-1-leo.yan@linaro.org>
References: <20211208083320.472503-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces open code with task_is_in_init_pid_ns() to check if
a task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/connector/cn_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 646ad385e490..ccac1c453080 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -358,7 +358,7 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	 * other namespaces.
 	 */
 	if ((current_user_ns() != &init_user_ns) ||
-	    (task_active_pid_ns(current) != &init_pid_ns))
+	    !task_is_in_init_pid_ns(current))
 		return;
 
 	/* Can only change if privileged. */
-- 
2.25.1

