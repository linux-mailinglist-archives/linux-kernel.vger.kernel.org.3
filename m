Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1949C2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiAZFEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiAZFEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:04:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A454C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:04:44 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z5so7490673plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LymW6PUOvmHHk0t/aZG7OwTx34gGDOgM/8aOiJBjMoY=;
        b=bCNMubob4uLUgkxduJa6dIISrtOZ9XCo5RHxWYcZMNmh9pQo8A6uQxpVV3R4o+drU9
         JxYbJEbmewq86YNgOJho3goihYXnv1gQQEOy80l1ECYHbgg60gU+zr7FoqJqhNw4N4hV
         6Eanz0hNrYke+w+ea28Rg/X3qiKD5TdtStq7S3Wv96MPycCk+YzD9P2wUx0hXuMH53z9
         E4kubKpoVBlneakaLfX7JqFChA7PN64aSMwc55HRaS91vuAtnBgY9h3uKmnOeut0YQeu
         JU4pwvPFjSe31pkC47oSrDQFpnr78TYr7rkGzB+WhvdYFDsIorbKQqienIuE3RgFCpnl
         pNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LymW6PUOvmHHk0t/aZG7OwTx34gGDOgM/8aOiJBjMoY=;
        b=Nz6SRGQHQYb0ZT/d521XIwGf6KkG8EM8q9mAhS8C8yqMwCYJc/XWPLfxGCn3D5BcxO
         YPO8u3Y8Vu/rtFvic7qx11db8czL9IZqN6HgonaV/u61zZZG1VT+9+o+gp48MujQThc/
         pspHBg047JVcahti22RpKBwbMCE9vPwSOYSs1bIqz8Zw7biQ+YisTTfwf+pDakOQelAK
         eCTkOgCLbwpa5fWUEi2I+bvoMoUxB9IQYBkm8BpiyPO0XaxIuuZN22x8WdbpGATMF0Aq
         Ed/6kFWBggXQmvruSdf85wU7A8e3dDM6OPVbgDSUBmlx0ePJhnqWbMfUEDLWz/vMDy0D
         jPxQ==
X-Gm-Message-State: AOAM531RNXnJFyJ7RBgAN6JchU8qtxjZShfVhKUJaJU3W7uRxYLsUm2H
        j6SYKu0nsJxmkBCoxqazM7ej3A==
X-Google-Smtp-Source: ABdhPJwJmbw+cC52lHR4HHf99/ag6oVQGs3up2giyXNZXQAanzfb+0gwg2JhZ2zXwgsfpBZqorwobg==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr7011825pjb.120.1643173483499;
        Tue, 25 Jan 2022 21:04:43 -0800 (PST)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id a13sm665441pfv.97.2022.01.25.21.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 21:04:43 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net v3 1/2] pid: Introduce helper task_is_in_init_pid_ns()
Date:   Wed, 26 Jan 2022 13:04:26 +0800
Message-Id: <20220126050427.605628-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126050427.605628-1-leo.yan@linaro.org>
References: <20220126050427.605628-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel uses open code in multiple places to check if a
task is in the root PID namespace with the kind of format:

  if (task_active_pid_ns(current) == &init_pid_ns)
      do_something();

This patch creates a new helper function, task_is_in_init_pid_ns(), it
returns true if a passed task is in the root PID namespace, otherwise
returns false.  So it will be used to replace open codes.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---
 include/linux/pid_namespace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c7e627503d2..07481bb87d4e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -86,4 +86,9 @@ extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
 
+static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
+{
+	return task_active_pid_ns(tsk) == &init_pid_ns;
+}
+
 #endif /* _LINUX_PID_NS_H */
-- 
2.25.1

