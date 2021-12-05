Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D2468CEA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhLETHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 14:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhLETHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 14:07:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942A6C061714;
        Sun,  5 Dec 2021 11:04:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so17730912wru.13;
        Sun, 05 Dec 2021 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYSdlyT++8g08GNtRcnS1F1l9EQ63A4A6/NKK5qcx1w=;
        b=qwP7m2t1ZZjhj36REhjJXCmDkbxMAOGxPerP2SU79jXqO11mcBjv35Z3WMBg8mjr+i
         p1NesIpGlWcJv6CG1RINAXBQTnePHmKTA4ppCwBqBC5AS55TEsz6yRjwUxp5Nhsrvr59
         Y4/S700S/pRzGxqzmt8KmWxB0GkCfuBrL6MyqhKU3xv6WtM6+gJ+JNd2DVulCl/E9egQ
         uzBSirEI9RcTThHnqAFjVTulVCyEVLa7ct6ObF5rn7x5lkknQryGWcxaxq6YuPZLh7l/
         H8vRGff1ta4ApEJmpugE5Gt6stzzZQDAXVISX8WYwe3+C/hszlHQ75mq9kJprQurkkUI
         B0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYSdlyT++8g08GNtRcnS1F1l9EQ63A4A6/NKK5qcx1w=;
        b=ZJuOeR25rutLhSLzBhMT7ysfB9/RLjlrbuy6nAGxD7h1OsrWYy7Yy6Ou7vinsEvrHy
         tuiyCrLFbN24CYKevJMoxqIwm344+2tf4hb+YXi9rWx8k+KDLi+Qp98kpabppYyyaNY8
         bzfQtDU6syau5qJF8SF/rgvGBhBz2UmvjGbaejSwt9XS0AYFM12y2fPy+fwlPdFD795v
         H+RMJhvXqVNb03KGES8JmPtAtPyIhRV1TQ4FKWCe9BgJuO4cPbyreIUwsLeWmXMvPNPQ
         th+Hu2D8ZT8XabhvfB53VtZ3b8vpEDHKzgSAyMz5y4qYFYqjJrbGTodyAIGs7zhxyz6z
         4ONA==
X-Gm-Message-State: AOAM53304+NId0ee41da1/nTk8f2sRei0BplWK9sE1LJgWHk/b5wpYsY
        3s4t3T7LvnUkkNGb/xV6qbcPQqWiuwk=
X-Google-Smtp-Source: ABdhPJxuxBgU2liGO8+gEQ7BH+agQm6fEjY6Oiev85d57dAeyFMRQIrVlCm94qbun91lB/Dmsi5qbg==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr37113127wri.382.1638731062166;
        Sun, 05 Dec 2021 11:04:22 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id m3sm8948127wrv.95.2021.12.05.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 11:04:21 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     stanimir.varbanov@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] media: venus: helpers: Fix memory leak in venus_helper_alloc_dpb_bufs
Date:   Sun,  5 Dec 2021 20:04:15 +0100
Message-Id: <20211205190415.19962-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses-Coverity-ID: 1494120 ("Resource leaks")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/media/platform/qcom/venus/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 84c3a511ec31..344a42853898 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -197,6 +197,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 
 		id = ida_alloc_min(&inst->dpb_ids, VB2_MAX_FRAME, GFP_KERNEL);
 		if (id < 0) {
+			kfree(buf);
 			ret = id;
 			goto fail;
 		}
-- 
2.25.1

