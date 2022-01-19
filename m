Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599C04943D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiASXVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344260AbiASXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:21:42 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBBC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:21:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h196-20020a6283cd000000b004bed33745c9so2430289pfe.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R3Y/gOk08NgtXcS6vykPovrhRLCA2DpTaWszWvKKMv8=;
        b=c5zgx/4itJnifU5XQnptwovLjitu5KxUpdScwBHS9ppYLx8ucjI2vrBYnNg7vFwLG7
         VzFrLBx5t7DPwx/PJAna5plHjt7e7TgHwB/G8MXte8rSpYlwAoWRr14WybVs89QLUesC
         pgsTFv1yPQkaCAzYO9fu7jkDmk6hMnMFPUc864hF/qsMPw8X1Jt+FCfsiojcg4ZvbLI8
         102AZ7T1DxZAm95v5nl9qYZeoJWr2IO5mHLblewk4l/t/GU9ST8RtuDlZHyxZZkRdK9Z
         Vfk2b+ssBm7uP69bDqqQQSekf/OqZkeGdNNLY8VgwQdSTBKxSAxeWdSLPREam0I4Tzqy
         FLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R3Y/gOk08NgtXcS6vykPovrhRLCA2DpTaWszWvKKMv8=;
        b=LwN+KWHC5RH153hVo8BQFn4zr6ot3b83yd5qeG2YaX0zZpJHy9rn4RlNvCpi0EjTC4
         WR+JuZsyWWdfhHE069A4w5XEpao5GxfNxTf+soH3+B8wKY6aAjgaT2SMQ8dPxNZJUWnx
         UzSpaRxhT3VIqFcXJ7lp38AQ2hC9tarwn9/akB/vyrX08SI8DugiGsZCZuuxw7lpCdRm
         AywElZ9k7hAUlUXuF1Fd1LOeBEzg9+LUNqNJrM8cq1iMS04jsmzYTHXga1HK8fxIn8sb
         UlgedoZ6qjjkHPqPVo1La2i20o1AM2Xz+sMYzst9mUvVHU+UhMtmOXzzfx5H7e/ZxdZV
         eO0Q==
X-Gm-Message-State: AOAM532t06PMuO470FBged00HINK6AH13UXSfMNAkL6XT1Ex6V/0+EKC
        /0UaJCR2+7zW6syvDIJDYp2zKRAsl9TEtaVe8DRBgcLAWD8/BPusv8Job8BFMps84ZNfGw0M9hw
        xUKwdm+zeEiL8lXqi40Dt7xuMtwBwkIT/ujHNm+n7MrnaTOd3bcMIjEQtCKcTE8sk/fcW6A==
X-Google-Smtp-Source: ABdhPJy0tmrWl2qzWMTzlH8xT25SOYiP2Mzw6nzK3q3lsalSqLQ2INJtAheVNXowbPrtzMsxUnxlwxnh370=
X-Received: from adelva.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b2b])
 (user=adelva job=sendgmr) by 2002:a05:6a00:2408:b0:4c1:e1a1:770 with SMTP id
 z8-20020a056a00240800b004c1e1a10770mr32410337pfh.70.1642634501702; Wed, 19
 Jan 2022 15:21:41 -0800 (PST)
Date:   Wed, 19 Jan 2022 23:21:39 +0000
Message-Id: <20220119232139.1125908-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] remoteproc: Fix count check in rproc_coredump_write()
From:   Alistair Delva <adelva@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        stable@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check count for 0, to avoid a potential underflow. Make the check the
same as the one in rproc_recovery_write().

Fixes: 3afdc59e4390 ("remoteproc: Add coredump debugfs entry")
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: stable@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Cc: linux-remoteproc@vger.kernel.org
Cc: kernel-team@android.com
---
 drivers/remoteproc/remoteproc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b5a1e3b697d9..581930483ef8 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -76,7 +76,7 @@ static ssize_t rproc_coredump_write(struct file *filp,
 	int ret, err = 0;
 	char buf[20];
 
-	if (count > sizeof(buf))
+	if (count < 1 || count > sizeof(buf))
 		return -EINVAL;
 
 	ret = copy_from_user(buf, user_buf, count);
-- 
2.30.2

