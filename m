Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0717A48E8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiANLCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbiANLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:02:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F4C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:02:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w16so33543241edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfTpTGejjbs1/IGPoPayvAsK5HXiDgr01tfB1Ox12/o=;
        b=F4kAU5sR4g6LVo0JnWblWrXfyVfC4H454DjEzaz7/ozw0szvs3R1q3Y91nZ1hCi9dh
         zx/WWapKaJ3nGVMZzcVilNc5dPgRr4A8TEK3h9GBFI/m4/LWda1yVgFQg7CmHg8E6XAC
         FdZbhGUyGHbK/UYiDHMZ/o5JHdXDmY1m4WI61dRVsRNfwGyHFDwvsHRuNb4qRiLop0mh
         Y90+yFSHNiyAMKqkCxHKrojCHqVEaCTPG03p5PTnnfVG8w2z8fuh5h9dq3sEjyppfa4o
         9YkZ+snIayxn0AD5clE9HBui221LF9ToMbKcnX0tyMaLkLQ9ht5hph4jwJrQ2dg1NrCJ
         Zx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfTpTGejjbs1/IGPoPayvAsK5HXiDgr01tfB1Ox12/o=;
        b=FM9j4phiE1H6JSJdQJnyHgMi7fZgkZjLxkus+4zB2FRrOgTYW527X3yFHRuUIE4o73
         3s5Z6eQev5+vxWMG6idkd/uHpzBmjl3Qehc8cbQgMBG4t2bx6hVdYxqYFvz/doJnET45
         3/cl4CZxVHczwdZXgXWCd6HqzgzIUiA1TXfEO0q2MaJiA/7cRuWy5vM5YdTaS3/ybb6y
         UJ0Yfvmjr8OgzEolKE112h7mPEcWXokzomDRnAMjMB0htewCVETlcxPG/ad4JGbmv7lr
         XoYZoOVa8Eq8/SEUQSeVqayNAi4mLRrJdE2v4xYFHDjGANP7zC6VwKADcej9z5mes9rp
         lfUg==
X-Gm-Message-State: AOAM5305GxVaNCvLGwWpIgMbbJpX81CnFua9fa7d6IXz63DjzvKrWlZO
        nfpTRBSf105jf4Syx0dO6RSQow==
X-Google-Smtp-Source: ABdhPJxrqLroV1LJ+YyoXVnpa0G8hJgPhVutmPuZ1ZhswksM4KJynfcwHTX4uevBrPH9BDYmLyIFdg==
X-Received: by 2002:a17:906:9b8e:: with SMTP id dd14mr6629836ejc.307.1642158162583;
        Fri, 14 Jan 2022 03:02:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id 21sm1725718ejz.24.2022.01.14.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 03:02:41 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Luca Weiss <luca.weiss@fairphone.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: venus: hfi: avoid null dereference in deinit
Date:   Fri, 14 Jan 2022 12:02:26 +0100
Message-Id: <20220114110226.130380-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114110226.130380-1-luca.weiss@fairphone.com>
References: <20220114110226.130380-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If venus_probe fails at pm_runtime_put_sync the error handling first
calls hfi_destroy and afterwards hfi_core_deinit. As hfi_destroy sets
core->ops to NULL, hfi_core_deinit cannot call the core_deinit function
anymore.

Avoid this null pointer derefence by skipping the call when necessary.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/media/platform/qcom/venus/hfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 4e2151fb47f0..1968f09ad177 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -104,6 +104,9 @@ int hfi_core_deinit(struct venus_core *core, bool blocking)
 		mutex_lock(&core->lock);
 	}
 
+	if (!core->ops)
+		goto unlock;
+
 	ret = core->ops->core_deinit(core);
 
 	if (!ret)
-- 
2.34.1

